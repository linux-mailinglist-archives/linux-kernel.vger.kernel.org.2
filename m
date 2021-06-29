Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42913B6D23
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 05:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhF2Dul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 23:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26722 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231598AbhF2Duj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 23:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624938493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFV03+4HDnkL3tfyJOERnknmxc7C9FPNcwfdBx8TNo4=;
        b=Q1R5JuLcJ2NcuGvwqn0/nRIerZL6PynN1inrdtBkw5QjvrQW0hC9qlB9z4/PsBXRJunneR
        eURNQTNWj40Nh9cR0woXv4Y+1OhcrLGmcITZLTnTC6gNtrOoIdS87b7HqJXZ2n1+ZT54/s
        YgX+/P/tlwVyDzocv2aITlFTA4qGBh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-2-DC2InYPPWfiO-7YvRFKg-1; Mon, 28 Jun 2021 23:48:09 -0400
X-MC-Unique: 2-DC2InYPPWfiO-7YvRFKg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2452100C622;
        Tue, 29 Jun 2021 03:48:07 +0000 (UTC)
Received: from T590 (ovpn-13-238.pek2.redhat.com [10.72.13.238])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B2BE55C1D0;
        Tue, 29 Jun 2021 03:48:00 +0000 (UTC)
Date:   Tue, 29 Jun 2021 11:47:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Wen Xiong <wenxiong@us.ibm.com>
Cc:     dwagner@suse.de, james.smart@broadcom.com,
        linux-kernel@vger.kernel.org, sagi@grimberg.me,
        wenxiong@linux.vnet.ibm.com
Subject: Re: [PATCH 1/1] block: System crashes when cpu hotplug + bouncing
 port
Message-ID: <YNqX6w8YHO61oqvY@T590>
References: <YNqL+3LDsIPKm1ol@T590>
 <YNp1Bho5yypHkPfW@T590>
 <1624850072-17776-1-git-send-email-wenxiong@linux.vnet.ibm.com>
 <20210628090703.apaowrsazl53lza4@beryllium.lan>
 <YNmdhqd+W3XbJCwd@T590>
 <71d1ce491ed5056bfa921f0e14fa646d@imap.linux.ibm.com>
 <OFE573413D.44652DC5-ON00258703.000DB949-00258703.000EFCD4@ibm.com>
 <OF8889275F.DC758B38-ON00258703.001297BC-00258703.00143502@ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OF8889275F.DC758B38-ON00258703.001297BC-00258703.00143502@ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 03:40:42AM +0000, Wen Xiong wrote:
>    >>Can you provide the dmesg log after applying Daniel's patches?
>     
>    Below is crash kernel stack with Daniel's patches(I got this last week). I
>    can get full dmesg for you tomorrow(late here)
>     
> 
>  root @ ltcfleet1-lp8: /root
>  # [  596.448859] Oops: Kernel access of bad area, sig: 11 [#1]
>  [  596.448871] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
>  [  596.448879] Modules linked in: rpadlpar_io(E) rpaphp(E) xsk_diag(E) tcp_diag(E) udp_diag(E) raw_diag(E) inet_diag(E) unix_diag(E) af_packet_diag(E) netlink_diag(E) xt_tcpudp(E) iptable_filter(E) ip_tables(E) x_tables(E) af_packet(E) rfkill(E) xfs(E) dm_service_time(E) ibmveth(E) vmx_crypto(E) gf128mul(E) crct10dif_vpmsum(E) uio_pdrv_genirq(E) uio(E) rtc_generic(E) drm(E) fuse(E) drm_panel_orientation_quirks(E) backlight(E) agpgart(E) btrfs(E) blake2b_generic(E) libcrc32c(E) xor(E) raid6_pq(E) sd_mod(E) ibmvscsi(E) scsi_transport_srp(E) lpfc(E) nvmet_fc(E) nvmet(E) configfs(E) nvme_fc(E) nvme_fabrics(E) crc32c_vpmsum(E) nvme_core(E) t10_pi(E) scsi_transport_fc(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E)
>  [  596.448973] CPU: 2 PID: 2665 Comm: kworker/u32:5 Kdump: loaded Tainted: G            E     5.13.0-rc6-50-default+ #11
>  [  596.448982] Workqueue: nvme-wq nvme_fc_connect_ctrl_work [nvme_fc]
>  [  596.448990] NIP:  c000000000747690 LR: c000000000747a80 CTR: c0000000008451f0
>  [  596.448997] REGS: c000000034ad3510 TRAP: 0380   Tainted: G            E      (5.13.0-rc6-50-default+)
>  [  596.449004] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 48002224  XER: 00000000
>  [  596.449021] CFAR: c000000000747a7c IRQMASK: 0
>  [  596.449021] GPR00: c000000000747a80 c000000034ad37b0 c000000001982900 c00000002d39b280
>  [  596.449021] GPR04: 8009fff80c295c00 0000000000000000 0000000000000000 0000000000000001
>  [  596.449021] GPR08: 00000007faf50000 0000000000000000 0000000000000000 0000000000000001
>  [  596.449021] GPR12: 0000000000002000 c000000007fcd680 c000000000188608 c0000007ffa9b200
>  [  596.449021] GPR16: 0000000000000190 0000000000000600 0000000000001f00 0000000000000000
>  [  596.449021] GPR20: 0000000000000004 0700000048000000 c00000002abe0460 0000000000000000
>  [  596.449021] GPR24: c00000002cd45400 0000000000000400 0000000000000000 c00000002d39b280
>  [  596.449021] GPR28: fffffffffffffff5 c00000002d39b2d8 0000000000000000 c000000034ad38c0
>  [  596.449097] NIP [c000000000747690] blk_mq_put_tag+0x20/0x90
>  [  596.449104] LR [c000000000747a80] blk_mq_get_tag+0x380/0x3b0
>  [  596.449111] Call Trace:
>  [  596.449114] [c000000034ad37b0] [c000000000746e64] __blk_mq_get_tag+0x44/0x160 (unreliable)
>  [  596.449124] [c000000034ad37d0] [c000000000747a80] blk_mq_get_tag+0x380/0x3b0
>  [  596.449132] [c000000034ad3860] [c00000000073e24c] blk_mq_alloc_request_hctx+0x1bc/0x240
>  [  596.449140] [c000000034ad3920] [c0080000003945c8] __nvme_submit_sync_cmd+0xa0/0x350 [nvme_core]
>  [  596.449154] [c000000034ad39c0] [c0080000004117b0] nvmf_connect_io_queue+0x148/0x1f0 [nvme_fabrics]
>  [  596.449164] [c000000034ad3ab0] [c008000000377ab0] nvme_fc_connect_io_queues+0x2d8/0x36c [nvme_fc]
>  [  596.449174] [c000000034ad3b90] [c00800000037666c] nvme_fc_connect_ctrl_work+0xa44/0xc30 [nvme_fc]
>  [  596.449183] [c000000034ad3c60] [c00000000017d914] process_one_work+0x2f4/0x610
>  [  596.449191] [c000000034ad3d00] [c00000000017dcb8] worker_thread+0x88/0x6a0
>  [  596.449199] [c000000034ad3da0] [c00000000018879c] kthread+0x19c/0x1b0
>  [  596.449207] [c000000034ad3e10] [c00000000000d6ec] ret_from_kernel_thread+0x5c/0x70
>  [  596.449215] Instruction dump:
>  [  596.449220] e8010030 38210020 7c0803a6 4e800020 3c4c0124 3842b290 7c0802a6 60000000
>  [  596.449233] 7c0802a6 7ca92b78 f8010010 f821ffe1 <80a40080> 80830004 7f892040 419c0044
>  [  596.449246] ---[ end trace c4525398a0ebf111 ]---
>  [  596.470968]
>  [    0.000000] hash-mmu: Page sizes from device-tree:
>  [    0.000000] hash-mmu: base_shift=12: shift=12, sllp=0x0000, avpnm=0x00000000,
> 
>    >>data.ctx = __blk_mq_get_ctx(q, cpu);
>    cpu=2048 if hctx_idx = 4

Yeah, that is the issue I mentioned, any CPU in hctx->cpumask becomes
offline, please try the following patch and see if it makes a
difference:


diff --git a/block/blk-mq.c b/block/blk-mq.c
index df5dc3b756f5..74632f50d969 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -494,7 +494,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	data.hctx = q->queue_hw_ctx[hctx_idx];
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
-	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
+	cpu = cpumask_first(data.hctx->cpumask);
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	if (!q->elevator)
@@ -2570,6 +2570,10 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
 	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
 		return 0;
 
+	/* Controller doesn't use managed IRQ, no need to deactivate hctx */
+	if (hctx->flags & BLK_MQ_F_NOT_USE_MANAGED_IRQ)
+		return 0;
+
 	/*
 	 * Prevent new request from being allocated on the current hctx.
 	 *
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 256e87721a01..c563a2b6e9fc 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2876,7 +2876,8 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
 	ctrl->tag_set.reserved_tags = NVMF_RESERVED_TAGS;
 	ctrl->tag_set.numa_node = ctrl->ctrl.numa_node;
-	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
+		BLK_MQ_F_NOT_USE_MANAGED_IRQ;
 	ctrl->tag_set.cmd_size =
 		struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
 			    ctrl->lport->ops->fcprqst_priv_sz);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 21140132a30d..600c5dd1a069 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -403,6 +403,7 @@ enum {
 	 */
 	BLK_MQ_F_STACKING	= 1 << 2,
 	BLK_MQ_F_TAG_HCTX_SHARED = 1 << 3,
+	BLK_MQ_F_NOT_USE_MANAGED_IRQ = 1 << 4,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
 	BLK_MQ_F_NO_SCHED	= 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,

Thanks,
Ming

