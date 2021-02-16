Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639D631C792
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 09:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBPIrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 03:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhBPIpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 03:45:25 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74AFC061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 00:44:44 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id o7so5824775pgl.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 00:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1+qOuzSJ2I30OlNgk6NN9L+F/X13B2BWknpOjyHby5g=;
        b=T+Q4IfGD3IotPXUkB43SRV9D9aLhkkPxORMY+WD0KYjXdsdDlC58a5xs6Xg/bHSqxT
         v1d2oFQpipXHYQr7UUWLJs13RmBa/+WOY4R2PZOazi68f7cjyTo6bf3JW68LxsPA9a4S
         PAzk0kM8ejagVW8g82MduAIR7j2OWGN6twW3zFj7mUfYo/Nc/hjhC8/EJ2t93knNFdU0
         ++W0iiPUhaxMWLpTauEnwOCIZJE1Q0gM8mU/xnlajlhIlWPE1j6hxR+K00KBCeDm5LhC
         XziaoAiYxxupXs+1/mwqQoHgZieFlpuz3Fuw7bRXknEAfX5Y00qL5LwFAVDHtyHFaa93
         sz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1+qOuzSJ2I30OlNgk6NN9L+F/X13B2BWknpOjyHby5g=;
        b=Izcs9NNJdeE7TWEx0fnnlfF6sIVbNj3x1RSiVTbW5HreF4D1XNeZlsrzAZ2wAyMRZI
         NRJ3bHuOajRaRwqPTCKXwtqcH28GlGoSyFL3/feKPCSElbxWfYL2pISbIjVfMhfoHG5a
         fGX5Wmyv1opkJIOoRatvIsjwuILP8b2+OpuvcsN74UTfSQOCVpO6pLiRZ8Pfs77cETxL
         cU9LmEh0peWuKWG7r6MDLIWsI++oN7gPV0cWK9tRWXQ+cdTrwMEwHWWnm50E15XHKlJe
         paj4bExKvBtR4AHCq5wH37PdsMM2ZuPtF5ZIpht2GojT7vZNlfOMRH2dGKUFsLIIRG6m
         6Wvw==
X-Gm-Message-State: AOAM531LsMvDEsFfjjDoIeD+oPWigtfIzyJ1uj5PPx3LhV/p7HxWiccv
        o2FKN7Ehj02/OWoqOtesetMT09ahX4HEDbXN
X-Google-Smtp-Source: ABdhPJxp+g23iEGA+ms4IUBVeMZYZ67TKql35m1iM1Y6dZ3B43NYoBWRxZaxDHYwvYvjNIEw6Q80Kw==
X-Received: by 2002:aa7:808b:0:b029:1ce:8a32:f5e8 with SMTP id v11-20020aa7808b0000b02901ce8a32f5e8mr18870050pff.34.1613465083914;
        Tue, 16 Feb 2021 00:44:43 -0800 (PST)
Received: from glados.. ([2601:647:6000:3e5b::a27])
        by smtp.gmail.com with ESMTPSA id z12sm1980061pjz.16.2021.02.16.00.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 00:44:43 -0800 (PST)
From:   Thomas Hebb <tommyhebb@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Hebb <tommyhebb@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>, linux-mm@kvack.org
Subject: [RFC PATCH] z3fold: prevent reclaim/free race for headless pages
Date:   Tue, 16 Feb 2021 00:44:40 -0800
Message-Id: <8c4f1cb7c51b03d2b2cd451a6404db8e269d94b7.1613465062.git.tommyhebb@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ca0246bb97c2 ("z3fold: fix possible reclaim races") introduced
the PAGE_CLAIMED flag "to avoid racing on a z3fold 'headless' page
release." By atomically testing and setting the bit in each of
z3fold_free() and z3fold_reclaim_page(), a double-free was avoided.

However, commit 746d179b0e66 ("z3fold: stricter locking and more careful
reclaim") appears to have unintentionally broken this behavior by moving
the PAGE_CLAIMED check in z3fold_reclaim_page() to after the page lock
gets taken, which only happens for non-headless pages. For headless
pages, the check is now skipped entirely and races can occur again.

I have observed such a race on my system:

    page:00000000ffbd76b7 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x165316
    flags: 0x2ffff0000000000()
    raw: 02ffff0000000000 ffffea0004535f48 ffff8881d553a170 0000000000000000
    raw: 0000000000000000 0000000000000011 00000000ffffffff 0000000000000000
    page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
    ------------[ cut here ]------------
    kernel BUG at include/linux/mm.h:707!
    invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
    CPU: 2 PID: 291928 Comm: kworker/2:0 Tainted: G    B             5.10.7-arch1-1-kasan #1
    Hardware name: Gigabyte Technology Co., Ltd. H97N-WIFI/H97N-WIFI, BIOS F9b 03/03/2016
    Workqueue: zswap-shrink shrink_worker
    RIP: 0010:__free_pages+0x10a/0x130
    Code: c1 e7 06 48 01 ef 45 85 e4 74 d1 44 89 e6 31 d2 41 83 ec 01 e8 e7 b0 ff ff eb da 48 c7 c6 e0 32 91 88 48 89 ef e8 a6 89 f8 ff <0f> 0b 4c 89 e7 e8 fc 79 07 00 e9 33 ff ff ff 48 89 ef e8 ff 79 07
    RSP: 0000:ffff88819a2ffb98 EFLAGS: 00010296
    RAX: 0000000000000000 RBX: ffffea000594c5a8 RCX: 0000000000000000
    RDX: 1ffffd4000b298b7 RSI: 0000000000000000 RDI: ffffea000594c5b8
    RBP: ffffea000594c580 R08: 000000000000003e R09: ffff8881d5520bbb
    R10: ffffed103aaa4177 R11: 0000000000000001 R12: ffffea000594c5b4
    R13: 0000000000000000 R14: ffff888165316000 R15: ffffea000594c588
    FS:  0000000000000000(0000) GS:ffff8881d5500000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 00007f7c8c3654d8 CR3: 0000000103f42004 CR4: 00000000001706e0
    Call Trace:
     z3fold_zpool_shrink+0x9b6/0x1240
     ? sugov_update_single+0x357/0x990
     ? sched_clock+0x5/0x10
     ? sched_clock_cpu+0x18/0x180
     ? z3fold_zpool_map+0x490/0x490
     ? _raw_spin_lock_irq+0x88/0xe0
     shrink_worker+0x35/0x90
     process_one_work+0x70c/0x1210
     ? pwq_dec_nr_in_flight+0x15b/0x2a0
     worker_thread+0x539/0x1200
     ? __kthread_parkme+0x73/0x120
     ? rescuer_thread+0x1000/0x1000
     kthread+0x330/0x400
     ? __kthread_bind_mask+0x90/0x90
     ret_from_fork+0x22/0x30
    Modules linked in: rfcomm ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter ccm algif_aead des_generic libdes ecb algif_skcipher cmac bnep md4 algif_hash af_alg vfat fat intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel iwlmvm hid_logitech_hidpp kvm at24 mac80211 snd_hda_codec_realtek iTCO_wdt snd_hda_codec_generic intel_pmc_bxt snd_hda_codec_hdmi ledtrig_audio iTCO_vendor_support mei_wdt mei_hdcp snd_hda_intel snd_intel_dspcfg libarc4 soundwire_intel irqbypass iwlwifi soundwire_generic_allocation rapl soundwire_cadence intel_cstate snd_hda_codec intel_uncore btusb joydev mousedev snd_usb_audio pcspkr btrtl uvcvideo nouveau btbcm i2c_i801 btintel snd_hda_core videobuf2_vmalloc i2c_smbus snd_usbmidi_lib videobuf2_memops bluetooth snd_hwdep soundwire_bus snd_soc_rt5640 videobuf2_v4l2 cfg80211 snd_soc_rl6231 videobuf2_common snd_rawmidi lpc_ich alx videodev mdio snd_seq_device snd_soc_core mc ecdh_generic mxm_wmi mei_me
     hid_logitech_dj wmi snd_compress e1000e ac97_bus mei ttm rfkill snd_pcm_dmaengine ecc snd_pcm snd_timer snd soundcore mac_hid acpi_pad pkcs8_key_parser it87 hwmon_vid crypto_user fuse ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 dm_crypt cbc encrypted_keys trusted tpm rng_core usbhid dm_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper xhci_pci xhci_pci_renesas i915 video intel_gtt i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm agpgart
    ---[ end trace 126d646fc3dc0ad8 ]---

To fix the issue, re-add the earlier test and set in the case where we
have a headless page.

Fixes: 746d179b0e66 ("z3fold: stricter locking and more careful reclaim")
Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
---
I have NOT tested this patch yet beyond compiling it. If the approach
seems good, I'll test it on my system for a period of several days and
see if I can reproduce the crash before sending a v1.

 mm/z3fold.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 0152ad9931a8..8ae944eeb8e2 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1350,8 +1350,22 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			page = list_entry(pos, struct page, lru);
 
 			zhdr = page_address(page);
-			if (test_bit(PAGE_HEADLESS, &page->private))
+			if (test_bit(PAGE_HEADLESS, &page->private)) {
+				/*
+				 * For non-headless pages, we wait to do this
+				 * until we have the page lock to avoid racing
+				 * with __z3fold_alloc(). Headless pages don't
+				 * have a lock (and __z3fold_alloc() will never
+				 * see them), but we still need to test and set
+				 * PAGE_CLAIMED to avoid racing with
+				 * z3fold_free(), so just do it now before
+				 * leaving the loop.
+				 */
+				if (test_and_set_bit(PAGE_CLAIMED, &page->private))
+					continue;
+
 				break;
+			}
 
 			if (kref_get_unless_zero(&zhdr->refcount) == 0) {
 				zhdr = NULL;
-- 
2.30.0

