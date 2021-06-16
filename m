Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CC83AA4C8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 21:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhFPT4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 15:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbhFPT4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 15:56:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BE5C061768
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 12:54:13 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ltbby-007kEQ-5U; Wed, 16 Jun 2021 21:54:06 +0200
Message-ID: <8a61ecda99843307018e3e71a5540682436443fc.camel@sipsolutions.net>
Subject: lockdep issue with trig->leddev_list_lock again/still?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Righi <andrea.righi@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 16 Jun 2021 21:54:04 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boqun, all,

I've been reading the threads at 

https://lore.kernel.org/lkml/20201101092614.GB3989@xps-13-7390/

and

https://lore.kernel.org/lkml/20201102104152.GG9930@xps-13-7390/

as well as the previous fix commit 27af8e2c90fb ("leds: trigger: fix
potential deadlock with libata"), but I cannot make sense of this.


I'm getting a report - on 5.10.27, which has that fix backported - that
says we have a chain with leddev_list_lock involved in it, but I don't
really understand it.

FWIW, I have the following patch, that Peter gave me some time ago but
said you (Boqun) wrote, applied to the tree as well:

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 48d736aa03b2..9de9ae8a4ae0 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2667,8 +2667,18 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	 * Step 3: we found a bad match! Now retrieve a lock from the backward
 	 * list whose usage mask matches the exclusive usage mask from the
 	 * lock found on the forward list.
+	 *
+	 * Note, we should only keep the LOCKF_ENABLED_IRQ_ALL bits, considering
+	 * the follow case:
+	 *
+	 * When trying to add A -> B to the graph, we find that there is a
+	 * hardirq-safe L, that L -> ... -> A, and another hardirq-unsafe M,
+	 * that B -> ... -> M. However M is **softirq-safe**, if we use exact
+	 * invert bits of M's usage_mask, we will find another lock N that is
+	 * **softirq-unsafe** and N -> ... -> A, however N -> .. -> M will not
+	 * cause a inversion deadlock.
 	 */
-	backward_mask = original_mask(target_entry1->class->usage_mask);
+	backward_mask = original_mask(target_entry1->class->usage_mask & LOCKF_ENABLED_IRQ_ALL);
 
 	ret = find_usage_backwards(&this, backward_mask, &target_entry);
 	if (bfs_error(ret)) {


Without the patch, the lockdep report makes no sense at all, so thanks
for that. :-)


With that patch, I'm getting the following report from our driver vs.
libata vs. LED triggers:

[  498.399434] =====================================================
[  498.399481] WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
[  498.399523] 5.10.27-dev-lockdep-fix2+ #1 Tainted: G           OE    
[  498.399565] -----------------------------------------------------
[  498.399608] ip/364 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[  498.399650] ffff8880310fa438 (&iwl_txq_cmd_queue_lock_class){+.-.}-{2:2}, at: iwl_pcie_gen2_enqueue_hcmd+0x2c5/0x2100 [iwlwifi]
[  498.399749] 
[  498.399749] and this task is already holding:
[  498.399789] ffff88800558b5b8 (&trig->leddev_list_lock){.-.-}-{2:2}, at: led_trigger_event+0x34/0xd0
[  498.399845] which would create a new lock dependency:
[  498.399884]  (&trig->leddev_list_lock){.-.-}-{2:2} -> (&iwl_txq_cmd_queue_lock_class){+.-.}-{2:2}
[  498.399938] 
[  498.399938] but this new dependency connects a HARDIRQ-irq-safe lock:
[  498.399984]  (&host->lock){-.-.}-{2:2}
[  498.399992] 
[  498.399992] ... which became HARDIRQ-irq-safe at:
[  498.400077]   lock_acquire+0x1b8/0x720
[  498.400121]   _raw_spin_lock_irqsave+0x4d/0x70
[  498.400165]   ata_bmdma_interrupt+0x21/0x5a0
[  498.400208]   __handle_irq_event_percpu+0x25e/0x630
[  498.400250]   handle_irq_event+0x10e/0x290
[  498.400290]   handle_edge_irq+0x1f7/0xbb0
[  498.400332]   asm_call_irq_on_stack+0x12/0x20
[  498.400374]   common_interrupt+0xfb/0x1a0
[  498.400415]   asm_common_interrupt+0x1e/0x40
[  498.400456]   _raw_spin_unlock_irq+0x2f/0x40
[  498.400497]   ata_sff_flush_pio_task+0xa0/0x170
[  498.400537]   ata_exec_internal_sg+0xbe0/0x1840
[  498.400577]   ata_dev_read_id+0x8cd/0xcb0
[  498.400617]   ata_dev_reread_id+0xef/0x1c0
[  498.400658]   ata_dev_revalidate+0xcb/0x1f0
[  498.400698]   ata_do_set_mode+0x126b/0x2410
[  498.400741]   ata_set_mode+0x305/0x3e0
[  498.400786]   ata_eh_recover+0x268c/0x4110
[  498.400828]   ata_do_eh+0x7a/0xe0
[  498.400866]   ata_sff_error_handler+0x263/0x360
[  498.400906]   ata_bmdma_error_handler+0x295/0x580
[  498.400945]   ata_scsi_port_error_handler+0x7c1/0x17b0
[  498.400986]   ata_scsi_error+0x1f8/0x410
[  498.401027]   scsi_error_handler+0x29b/0x14a0
[  498.401077]   kthread+0x370/0x440
[  498.401119]   ret_from_fork+0x22/0x30
[  498.401158] 
[  498.401158] to a HARDIRQ-irq-unsafe lock:
[  498.401197]  (&iwl_txq_cmd_queue_lock_class){+.-.}-{2:2}
[  498.401204] 
[  498.401204] ... which became HARDIRQ-irq-unsafe at:
[  498.401277] ...
[  498.401282]   lock_acquire+0x1b8/0x720
[  498.401359]   _raw_spin_lock_bh+0x38/0x50
[  498.401418]   iwl_pcie_hcmd_complete+0x1c7/0x12b0 [iwlwifi]
[  498.401481]   iwl_pcie_rx_handle+0xe56/0x27e0 [iwlwifi]
[  498.401543]   iwl_pcie_napi_poll_msix+0xa3/0x240 [iwlwifi]
[  498.401591]   net_rx_action+0x3dd/0xea0
[  498.401628]   __do_softirq+0x1bc/0x899
[  498.401668]   asm_call_irq_on_stack+0x12/0x20
[  498.401711]   do_softirq_own_stack+0x8b/0xb0
[  498.401756]   do_softirq+0xab/0xd0
[  498.401797]   __local_bh_enable_ip+0xf3/0x110
[  498.401854]   iwl_pcie_irq_rx_msix_handler+0x26e/0x4e0 [iwlwifi]
[  498.401901]   irq_thread_fn+0x92/0x160
[  498.401940]   irq_thread+0x244/0x4a0
[  498.401980]   kthread+0x370/0x440
[  498.402022]   ret_from_fork+0x22/0x30
[  498.402061] 
[  498.402061] other info that might help us debug this:
[  498.402061] 
[  498.402101] Chain exists of:
[  498.402101]   &host->lock --> &trig->leddev_list_lock --> &iwl_txq_cmd_queue_lock_class
[  498.402101] 
[  498.402153]  Possible interrupt unsafe locking scenario:
[  498.402153] 
[  498.402199]        CPU0                    CPU1
[  498.402239]        ----                    ----
[  498.402278]   lock(&iwl_txq_cmd_queue_lock_class);
[  498.402320]                                local_irq_disable();
[  498.402358]                                lock(&host->lock);
[  498.402398]                                lock(&trig->leddev_list_lock);
[  498.402437]   <Interrupt>
[  498.402473]     lock(&host->lock);
[  498.402515] 
[  498.402515]  *** DEADLOCK ***
[  498.402515] 
[  498.402555] 3 locks held by ip/364:
[  498.402594]  #0: ffffffff9cf45f08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x319/0x910
[  498.402654]  #1: ffff8880055885e8 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: ieee80211_open+0x165/0x230 [mac80211]
[  498.402782]  #2: ffff88800558b5b8 (&trig->leddev_list_lock){.-.-}-{2:2}, at: led_trigger_event+0x34/0xd0
[  498.402837] 
[  498.402837] the dependencies between HARDIRQ-irq-safe lock and the holding lock:
[  498.402888]  -> (&host->lock){-.-.}-{2:2} {
[  498.402934]     IN-HARDIRQ-W at:
[  498.402977]                       lock_acquire+0x1b8/0x720
[  498.403020]                       _raw_spin_lock_irqsave+0x4d/0x70
[  498.403065]                       ata_bmdma_interrupt+0x21/0x5a0
[  498.403109]                       __handle_irq_event_percpu+0x25e/0x630
[  498.403162]                       handle_irq_event+0x10e/0x290
[  498.403208]                       handle_edge_irq+0x1f7/0xbb0
[  498.403248]                       asm_call_irq_on_stack+0x12/0x20
[  498.403290]                       common_interrupt+0xfb/0x1a0
[  498.403331]                       asm_common_interrupt+0x1e/0x40
[  498.403378]                       _raw_spin_unlock_irq+0x2f/0x40
[  498.403420]                       ata_sff_flush_pio_task+0xa0/0x170
[  498.403461]                       ata_exec_internal_sg+0xbe0/0x1840
[  498.403501]                       ata_dev_read_id+0x8cd/0xcb0
[  498.403541]                       ata_dev_reread_id+0xef/0x1c0
[  498.403582]                       ata_dev_revalidate+0xcb/0x1f0
[  498.403623]                       ata_do_set_mode+0x126b/0x2410
[  498.403664]                       ata_set_mode+0x305/0x3e0
[  498.403706]                       ata_eh_recover+0x268c/0x4110
[  498.403749]                       ata_do_eh+0x7a/0xe0
[  498.403790]                       ata_sff_error_handler+0x263/0x360
[  498.403831]                       ata_bmdma_error_handler+0x295/0x580
[  498.403870]                       ata_scsi_port_error_handler+0x7c1/0x17b0
[  498.403911]                       ata_scsi_error+0x1f8/0x410
[  498.403951]                       scsi_error_handler+0x29b/0x14a0
[  498.403991]                       kthread+0x370/0x440
[  498.404030]                       ret_from_fork+0x22/0x30
[  498.404070]     IN-SOFTIRQ-W at:
[  498.404110]                       lock_acquire+0x1b8/0x720
[  498.404150]                       _raw_spin_lock_irqsave+0x4d/0x70
[  498.404190]                       ata_bmdma_interrupt+0x21/0x5a0
[  498.404232]                       __handle_irq_event_percpu+0x25e/0x630
[  498.404272]                       handle_irq_event+0x10e/0x290
[  498.404312]                       handle_edge_irq+0x1f7/0xbb0
[  498.404363]                       common_interrupt+0xad/0x1a0
[  498.404414]                       asm_common_interrupt+0x1e/0x40
[  498.404455]                       __do_softirq+0x173/0x899
[  498.404495]                       asm_call_irq_on_stack+0x12/0x20
[  498.404539]                       do_softirq_own_stack+0x8b/0xb0
[  498.404578]                       irq_exit_rcu+0x12c/0x1c0
[  498.404619]                       sysvec_apic_timer_interrupt+0x4f/0xb0
[  498.404661]                       asm_sysvec_apic_timer_interrupt+0x12/0x20
[  498.404703]                       _raw_spin_unlock_irqrestore+0x31/0x50
[  498.404744]                       ata_scsi_queuecmd+0xd5/0x190
[  498.404786]                       scsi_queue_rq+0x12ff/0x2c50
[  498.404848]                       blk_mq_dispatch_rq_list+0x367/0x2050
[  498.404889]                       __blk_mq_do_dispatch_sched+0x35f/0xa10
[  498.404930]                       __blk_mq_sched_dispatch_requests+0x305/0x4b0
[  498.404970]                       blk_mq_sched_dispatch_requests+0xd8/0x130
[  498.405012]                       __blk_mq_run_hw_queue+0x116/0x2c0
[  498.405052]                       blk_mq_run_work_fn+0x48/0x60
[  498.405094]                       process_one_work+0x7cc/0x1410
[  498.405135]                       worker_thread+0x583/0xf70
[  498.405174]                       kthread+0x370/0x440
[  498.405215]                       ret_from_fork+0x22/0x30
[  498.405253]     INITIAL USE at:
[  498.405295]                      lock_acquire+0x1b8/0x720
[  498.405336]                      _raw_spin_lock_irqsave+0x4d/0x70
[  498.405376]                      ata_dev_init+0x19c/0x3d0
[  498.405416]                      ata_link_init+0x1a6/0x310
[  498.405462]                      ata_port_alloc+0x4d7/0x5c0
[  498.405502]                      ata_host_alloc+0x1d2/0x260
[  498.405542]                      ata_host_alloc_pinfo+0x21/0x580
[  498.405583]                      ata_pci_sff_prepare_host+0x41/0xc0
[  498.405623]                      ata_pci_bmdma_prepare_host+0x14/0x60
[  498.405661]                      piix_init_one+0x41b/0xbe0
[  498.405703]                      local_pci_probe+0xde/0x170
[  498.405743]                      pci_device_probe+0x351/0x6d0
[  498.405787]                      really_probe+0x222/0xcc0
[  498.405827]                      driver_probe_device+0x1fe/0x390
[  498.405868]                      device_driver_attach+0x1e9/0x250
[  498.405909]                      __driver_attach+0xfb/0x270
[  498.405949]                      bus_for_each_dev+0x123/0x1c0
[  498.405988]                      driver_attach+0x3d/0x50
[  498.406028]                      bus_add_driver+0x35c/0x580
[  498.406068]                      driver_register+0x219/0x380
[  498.406108]                      __pci_register_driver+0x185/0x240
[  498.406150]                      piix_init+0x1e/0x2e
[  498.406190]                      do_one_initcall+0xcb/0x410
[  498.406232]                      kernel_init_freeable+0x627/0x6bc
[  498.406273]                      kernel_init+0x12/0x127
[  498.406313]                      ret_from_fork+0x22/0x30
[  498.406351]   }
[  498.406393]   ... key      at: [<ffffffff9ea0afc0>] __key.6+0x0/0x40
[  498.406432]   ... acquired at:
[  498.406479]    _raw_read_lock_irqsave+0x89/0x93
[  498.406522]    led_trigger_blink_oneshot+0x3f/0xe0
[  498.406564]    ledtrig_disk_activity+0x79/0xf0
[  498.406602]    ata_qc_complete+0x69/0xd80
[  498.406641]    ata_do_link_abort+0x1a4/0x360
[  498.406681]    ata_port_freeze+0x69/0x80
[  498.406719]    ata_hsm_qc_complete+0x1da/0x240
[  498.406758]    ata_sff_hsm_move+0x39a/0x1e10
[  498.406797]    ata_sff_pio_task+0x397/0x4a0
[  498.406837]    process_one_work+0x7cc/0x1410
[  498.406877]    worker_thread+0x583/0xf70
[  498.406917]    kthread+0x370/0x440
[  498.406957]    ret_from_fork+0x22/0x30
[  498.406992] 
[  498.407029] -> (&trig->leddev_list_lock){.-.-}-{2:2} {
[  498.407075]    IN-HARDIRQ-R at:
[  498.407117]                     lock_acquire+0x1b8/0x720
[  498.407168]                     _raw_read_lock_irqsave+0x59/0x93
[  498.407212]                     led_trigger_blink_oneshot+0x3f/0xe0
[  498.407252]                     ledtrig_disk_activity+0x79/0xf0
[  498.407291]                     ata_qc_complete+0x69/0xd80
[  498.407331]                     ata_hsm_qc_complete+0x1c1/0x240
[  498.407371]                     ata_sff_hsm_move+0x39a/0x1e10
[  498.407411]                     __ata_sff_port_intr+0x1d2/0x3e0
[  498.407450]                     ata_bmdma_port_intr+0x96/0x330
[  498.409897]                     ata_bmdma_interrupt+0x1fd/0x5a0
[  498.409940]                     __handle_irq_event_percpu+0x25e/0x630
[  498.409980]                     handle_irq_event+0x10e/0x290
[  498.410018]                     handle_edge_irq+0x1f7/0xbb0
[  498.410057]                     asm_call_irq_on_stack+0x12/0x20
[  498.410098]                     common_interrupt+0xfb/0x1a0
[  498.410141]                     asm_common_interrupt+0x1e/0x40
[  498.410182]                     _raw_spin_unlock_irq+0x2f/0x40
[  498.410222]                     ata_sff_flush_pio_task+0xa0/0x170
[  498.410262]                     ata_exec_internal_sg+0xbe0/0x1840
[  498.410301]                     ata_dev_read_id+0x8cd/0xcb0
[  498.410340]                     ata_dev_reread_id+0xef/0x1c0
[  498.410381]                     ata_dev_revalidate+0xcb/0x1f0
[  498.410421]                     ata_do_set_mode+0x126b/0x2410
[  498.410461]                     ata_set_mode+0x305/0x3e0
[  498.410502]                     ata_eh_recover+0x268c/0x4110
[  498.410542]                     ata_do_eh+0x7a/0xe0
[  498.410580]                     ata_sff_error_handler+0x263/0x360
[  498.410618]                     ata_bmdma_error_handler+0x295/0x580
[  498.410658]                     ata_scsi_port_error_handler+0x7c1/0x17b0
[  498.410700]                     ata_scsi_error+0x1f8/0x410
[  498.410739]                     scsi_error_handler+0x29b/0x14a0
[  498.410779]                     kthread+0x370/0x440
[  498.410819]                     ret_from_fork+0x22/0x30
[  498.410858]    IN-SOFTIRQ-R at:
[  498.410909]                     lock_acquire+0x1b8/0x720
[  498.410948]                     _raw_read_lock_irqsave+0x59/0x93
[  498.410987]                     led_trigger_event+0x34/0xd0
[  498.411029]                     kbd_bh+0x199/0x220
[  498.411070]                     tasklet_action_common.constprop.0+0x260/0x300
[  498.411110]                     tasklet_action+0x22/0x30
[  498.411159]                     __do_softirq+0x1bc/0x899
[  498.411200]                     run_ksoftirqd+0x3f/0x70
[  498.411243]                     smpboot_thread_fn+0x356/0x810
[  498.411283]                     kthread+0x370/0x440
[  498.411321]                     ret_from_fork+0x22/0x30
[  498.411358]    INITIAL USE at:
[  498.411400]                    lock_acquire+0x1b8/0x720
[  498.411440]                    _raw_write_lock_irqsave+0x4d/0x70
[  498.411481]                    led_trigger_set+0x47a/0xd80
[  498.411522]                    led_trigger_set_default+0x16e/0x1f0
[  498.411562]                    led_classdev_register_ext+0x596/0x7e0
[  498.411603]                    input_leds_connect+0x35a/0x649 [input_leds]
[  498.411645]                    input_attach_handler.isra.0+0x10b/0x160
[  498.411685]                    input_register_handler+0x139/0x1e0
[  498.411724]                    0xffffffffc02d8015
[  498.411762]                    do_one_initcall+0xcb/0x410
[  498.411802]                    do_init_module+0x1d8/0x770
[  498.411842]                    load_module+0x9eec/0xa9d0
[  498.411881]                    __do_sys_finit_module+0x131/0x1c0
[  498.411928]                    __x64_sys_finit_module+0x73/0xb0
[  498.411968]                    do_syscall_64+0x38/0x90
[  498.412010]                    entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  498.412048]    INITIAL READ USE at:
[  498.412088]                         lock_acquire+0x1b8/0x720
[  498.412129]                         _raw_read_lock_irqsave+0x89/0x93
[  498.412169]                         led_trigger_event+0x34/0xd0
[  498.412213]                         rfkill_global_led_trigger_worker+0xbe/0xf0
[  498.412253]                         process_one_work+0x7cc/0x1410
[  498.412293]                         worker_thread+0x583/0xf70
[  498.412333]                         kthread+0x370/0x440
[  498.412373]                         ret_from_fork+0x22/0x30
[  498.412410]  }
[  498.412452]  ... key      at: [<ffffffff9ea17c40>] __key.0+0x0/0x40
[  498.412491]  ... acquired at:
[  498.412530]    lock_acquire+0x1b8/0x720
[  498.412572]    _raw_spin_lock_irqsave+0x4d/0x70
[  498.412631]    iwl_pcie_gen2_enqueue_hcmd+0x2c5/0x2100 [iwlwifi]
[  498.412692]    iwl_trans_txq_send_hcmd+0x191/0xf20 [iwlwifi]
[  498.412751]    iwl_trans_send_cmd+0x1b4/0x410 [iwlwifi]
[  498.412834]    iwl_mvm_send_cmd+0xf1/0x1d0 [iwlmvm]
[  498.412896]    iwl_mvm_led_set+0x1df/0x270 [iwlmvm]
[  498.412954]    iwl_led_brightness_set+0x1f/0x30 [iwlmvm]
[  498.413001]    led_set_brightness_nosleep+0xd4/0x1a0
[  498.413041]    led_set_brightness+0x108/0x150
[  498.413088]    led_trigger_event+0x73/0xd0
[  498.413170]    ieee80211_led_radio+0x6e/0x90 [mac80211]
[  498.413253]    ieee80211_do_open+0x896/0x1fa0 [mac80211]
[  498.413333]    ieee80211_open+0x176/0x230 [mac80211]
[  498.413383]    __dev_open+0x260/0x450
[  498.413423]    __dev_change_flags+0x4c9/0x750
[  498.413464]    dev_change_flags+0x87/0x160
[  498.413504]    do_setlink+0x7a3/0x3160
[  498.413543]    __rtnl_newlink+0xbdd/0x15a0
[  498.413588]    rtnl_newlink+0x64/0xa0
[  498.413627]    rtnetlink_rcv_msg+0x36a/0x910
[  498.413670]    netlink_rcv_skb+0x140/0x3d0
[  498.413710]    rtnetlink_rcv+0x15/0x20
[  498.413748]    netlink_unicast+0x465/0x7a0
[  498.413788]    netlink_sendmsg+0x7b4/0xcf0
[  498.413830]    sock_sendmsg+0xec/0x120
[  498.413870]    ____sys_sendmsg+0x696/0x9f0
[  498.413909]    ___sys_sendmsg+0x101/0x190
[  498.413948]    __sys_sendmsg+0xc8/0x160
[  498.413986]    __x64_sys_sendmsg+0x78/0xb0
[  498.414026]    do_syscall_64+0x38/0x90
[  498.414067]    entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  498.414105] 
[  498.414142] 
[  498.414142] the dependencies between the lock to be acquired
[  498.414145]  and HARDIRQ-irq-unsafe lock:
[  498.414228] -> (&iwl_txq_cmd_queue_lock_class){+.-.}-{2:2} {
[  498.414275]    HARDIRQ-ON-W at:
[  498.414316]                     lock_acquire+0x1b8/0x720
[  498.414357]                     _raw_spin_lock_bh+0x38/0x50
[  498.414414]                     iwl_pcie_hcmd_complete+0x1c7/0x12b0 [iwlwifi]
[  498.414473]                     iwl_pcie_rx_handle+0xe56/0x27e0 [iwlwifi]
[  498.414533]                     iwl_pcie_napi_poll_msix+0xa3/0x240 [iwlwifi]
[  498.414579]                     net_rx_action+0x3dd/0xea0
[  498.414636]                     __do_softirq+0x1bc/0x899
[  498.414676]                     asm_call_irq_on_stack+0x12/0x20
[  498.414717]                     do_softirq_own_stack+0x8b/0xb0
[  498.414756]                     do_softirq+0xab/0xd0
[  498.414795]                     __local_bh_enable_ip+0xf3/0x110
[  498.414851]                     iwl_pcie_irq_rx_msix_handler+0x26e/0x4e0 [iwlwifi]
[  498.414896]                     irq_thread_fn+0x92/0x160
[  498.414935]                     irq_thread+0x244/0x4a0
[  498.414974]                     kthread+0x370/0x440
[  498.415014]                     ret_from_fork+0x22/0x30
[  498.415051]    IN-SOFTIRQ-W at:
[  498.415091]                     lock_acquire+0x1b8/0x720
[  498.415131]                     _raw_spin_lock_bh+0x38/0x50
[  498.415195]                     iwl_pcie_hcmd_complete+0x1c7/0x12b0 [iwlwifi]
[  498.415254]                     iwl_pcie_rx_handle+0xe56/0x27e0 [iwlwifi]
[  498.415314]                     iwl_pcie_napi_poll_msix+0xa3/0x240 [iwlwifi]
[  498.415360]                     net_rx_action+0x3dd/0xea0
[  498.415406]                     __do_softirq+0x1bc/0x899
[  498.415445]                     asm_call_irq_on_stack+0x12/0x20
[  498.415484]                     do_softirq_own_stack+0x8b/0xb0
[  498.415524]                     do_softirq+0xab/0xd0
[  498.415565]                     __local_bh_enable_ip+0xf3/0x110
[  498.415620]                     iwl_pcie_irq_rx_msix_handler+0x26e/0x4e0 [iwlwifi]
[  498.415665]                     irq_thread_fn+0x92/0x160
[  498.415705]                     irq_thread+0x244/0x4a0
[  498.415744]                     kthread+0x370/0x440
[  498.415783]                     ret_from_fork+0x22/0x30
[  498.415820]    INITIAL USE at:
[  498.415860]                    lock_acquire+0x1b8/0x720
[  498.415899]                    _raw_spin_lock_irqsave+0x4d/0x70
[  498.415956]                    iwl_pcie_gen2_enqueue_hcmd+0x2c5/0x2100 [iwlwifi]
[  498.416016]                    iwl_trans_txq_send_hcmd+0x3fc/0xf20 [iwlwifi]
[  498.416074]                    iwl_trans_send_cmd+0x1b4/0x410 [iwlwifi]
[  498.416133]                    iwl_dbg_tlv_send_hcmds.isra.0+0x18f/0x240 [iwlwifi]
[  498.416192]                    _iwl_dbg_tlv_time_point+0x261/0x2ca0 [iwlwifi]
[  498.416248]                    iwl_run_unified_mvm_ucode+0x1fe/0x760 [iwlmvm]
[  498.416303]                    iwl_run_init_mvm_ucode+0x5ef/0xb80 [iwlmvm]
[  498.416359]                    iwl_mvm_start_get_nvm+0x1ee/0x7d0 [iwlmvm]
[  498.416413]                    iwl_op_mode_mvm_start+0x2082/0x3280 [iwlmvm]
[  498.416470]                    _iwl_op_mode_start.isra.0+0xef/0x1f0 [iwlwifi]
[  498.416528]                    iwl_opmode_register+0x13f/0x210 [iwlwifi]
[  498.416572]                    0xffffffffc055803f
[  498.416617]                    do_one_initcall+0xcb/0x410
[  498.416658]                    do_init_module+0x1d8/0x770
[  498.416697]                    load_module+0x9eec/0xa9d0
[  498.416736]                    __do_sys_finit_module+0x131/0x1c0
[  498.416775]                    __x64_sys_finit_module+0x73/0xb0
[  498.416814]                    do_syscall_64+0x38/0x90
[  498.416854]                    entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  498.416893]  }
[  498.416949]  ... key      at: [<ffffffffc0a85bc0>] iwl_txq_cmd_queue_lock_class.89285+0x0/0xfffffffffff99440 [iwlwifi]
[  498.416993]  ... acquired at:
[  498.417030]    lock_acquire+0x1b8/0x720
[  498.417069]    _raw_spin_lock_irqsave+0x4d/0x70
[  498.417126]    iwl_pcie_gen2_enqueue_hcmd+0x2c5/0x2100 [iwlwifi]
[  498.417182]    iwl_trans_txq_send_hcmd+0x191/0xf20 [iwlwifi]
[  498.417240]    iwl_trans_send_cmd+0x1b4/0x410 [iwlwifi]
[  498.417298]    iwl_mvm_send_cmd+0xf1/0x1d0 [iwlmvm]
[  498.417356]    iwl_mvm_led_set+0x1df/0x270 [iwlmvm]
[  498.417412]    iwl_led_brightness_set+0x1f/0x30 [iwlmvm]
[  498.417457]    led_set_brightness_nosleep+0xd4/0x1a0
[  498.417498]    led_set_brightness+0x108/0x150
[  498.417537]    led_trigger_event+0x73/0xd0
[  498.417615]    ieee80211_led_radio+0x6e/0x90 [mac80211]
[  498.417695]    ieee80211_do_open+0x896/0x1fa0 [mac80211]
[  498.417775]    ieee80211_open+0x176/0x230 [mac80211]
[  498.417823]    __dev_open+0x260/0x450
[  498.417873]    __dev_change_flags+0x4c9/0x750
[  498.417913]    dev_change_flags+0x87/0x160
[  498.417950]    do_setlink+0x7a3/0x3160
[  498.417988]    __rtnl_newlink+0xbdd/0x15a0
[  498.418027]    rtnl_newlink+0x64/0xa0
[  498.418066]    rtnetlink_rcv_msg+0x36a/0x910
[  498.418105]    netlink_rcv_skb+0x140/0x3d0
[  498.418143]    rtnetlink_rcv+0x15/0x20
[  498.418191]    netlink_unicast+0x465/0x7a0
[  498.418229]    netlink_sendmsg+0x7b4/0xcf0
[  498.418267]    sock_sendmsg+0xec/0x120
[  498.418307]    ____sys_sendmsg+0x696/0x9f0
[  498.418345]    ___sys_sendmsg+0x101/0x190
[  498.418383]    __sys_sendmsg+0xc8/0x160
[  498.418421]    __x64_sys_sendmsg+0x78/0xb0
[  498.418459]    do_syscall_64+0x38/0x90
[  498.418499]    entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  498.418535] 
[  498.418572] 
[  498.418572] stack backtrace:
[  498.418620] CPU: 3 PID: 364 Comm: ip Tainted: G           OE     5.10.27-dev-lockdep-fix2+ #1
[  498.418666] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.2-0-g5f4c7b1-prebuilt.qemu-project.org 04/01/2014
[  498.418709] Call Trace:
[  498.418754]  dump_stack+0xb3/0xed
[  498.418798]  check_irq_usage.cold+0x4e1/0x66d
[  498.419100]  __lock_acquire+0x2b0e/0x5460
[  498.419239]  lock_acquire+0x1b8/0x720
[  498.419618]  _raw_spin_lock_irqsave+0x4d/0x70
[  498.419737]  iwl_pcie_gen2_enqueue_hcmd+0x2c5/0x2100 [iwlwifi]
[  498.420081]  iwl_trans_txq_send_hcmd+0x191/0xf20 [iwlwifi]
[  498.420245]  iwl_trans_send_cmd+0x1b4/0x410 [iwlwifi]
[  498.420305]  iwl_mvm_send_cmd+0xf1/0x1d0 [iwlmvm]
[  498.420365]  iwl_mvm_led_set+0x1df/0x270 [iwlmvm]
[  498.423581]  iwl_led_brightness_set+0x1f/0x30 [iwlmvm]
[  498.423627]  led_set_brightness_nosleep+0xd4/0x1a0
[  498.423668]  led_set_brightness+0x108/0x150
[  498.423709]  led_trigger_event+0x73/0xd0
[  498.423789]  ieee80211_led_radio+0x6e/0x90 [mac80211]
[  498.423869]  ieee80211_do_open+0x896/0x1fa0 [mac80211]
[  498.424028]  ieee80211_open+0x176/0x230 [mac80211]
[  498.424076]  __dev_open+0x260/0x450
[  498.424249]  __dev_change_flags+0x4c9/0x750
[  498.424339]  dev_change_flags+0x87/0x160
[  498.424382]  do_setlink+0x7a3/0x3160
[  498.425060]  __rtnl_newlink+0xbdd/0x15a0
[  498.425697]  rtnl_newlink+0x64/0xa0
[  498.425739]  rtnetlink_rcv_msg+0x36a/0x910
[  498.425938]  netlink_rcv_skb+0x140/0x3d0
[  498.426137]  rtnetlink_rcv+0x15/0x20
[  498.426177]  netlink_unicast+0x465/0x7a0
[  498.426384]  netlink_sendmsg+0x7b4/0xcf0
[  498.426556]  sock_sendmsg+0xec/0x120
[  498.426597]  ____sys_sendmsg+0x696/0x9f0


Note that the iwlwifi module was a newer version, not necessarily
matching the 5.10(.27) version, especially wrt. the locking of the txq-
>lock (which is represented here by iwl_txq_cmd_queue_lock_class due to
us separating the lock classes for different types of queues).


Clearly, the scenario lockdep outputs isn't really an issue at all,
since that will just continue to make progress on CPU1, finish, and then
the interrupt on CPU0 can make progress.

I tried thinking about adding write_lock() to the scenario as you
(Boqun) did in the thread I linked to above, but even then I don't see
how it could deadlock since the write_lock() for leddev_list_lock is
always write_lock_irqsave(), so it can't get stuck on any of the other
locks involved here due to interrupts, I think?


All of the bits here that lockdep is reporting seem correct, but I can't
figure out how this chain matters?

&host->lock --> &trig->leddev_list_lock -->  &iwl_txq_cmd_queue_lock_class

Yes, obviously we take leddev_list_lock under host->lock, and we also
take the iwl lock under leddev_list_lock. No argument there. But the
argument seems to be that we can have the iwl lock taken without
disabling interrupts (which we do), and that's a different code path
unrelated to the leddev_list_lock?

Basically, I don't think I understand how a read-lock in the middle can
cause this chain to be a problem?

Can anyone help me decode this?

Thanks,
johannes

