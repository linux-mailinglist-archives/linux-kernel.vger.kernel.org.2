Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6366640E893
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354735AbhIPRkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:40:33 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:32858 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348245AbhIPRcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:32:18 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:43190)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mQvDp-004zIZ-KB; Thu, 16 Sep 2021 11:30:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:46146 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mQvDn-007umD-58; Thu, 16 Sep 2021 11:30:53 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-mm\@kvack.org" <linux-mm@kvack.org>,
        "legion\@kernel.org" <legion@kernel.org>,
        "containers\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch>
        <87ee9pa6xw.fsf@disp2133>
        <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch>
        <U6ByMUZ9LgvxXX6eb0M9aBx8cw8GpgE1qU22LaxaJ_2bOdnGLLJHDgnLL-6cJT7dKdcG_Ms37APSutc3EIMmtpgpP_2kotVLCNRoUq-wTJ8=@protonmail.ch>
Date:   Thu, 16 Sep 2021 12:30:44 -0500
In-Reply-To: <U6ByMUZ9LgvxXX6eb0M9aBx8cw8GpgE1qU22LaxaJ_2bOdnGLLJHDgnLL-6cJT7dKdcG_Ms37APSutc3EIMmtpgpP_2kotVLCNRoUq-wTJ8=@protonmail.ch>
        (Jordan Glover's message of "Wed, 15 Sep 2021 23:47:20 +0000")
Message-ID: <878rzw77i3.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mQvDn-007umD-58;;;mid=<878rzw77i3.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/sElGzO56fJv9259r8XB1mBA4jHnhtuUY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,LotsOfNums_01,
        T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_12,XMSubLong,XM_B_SpammyWords,
        XM_Body_Dirty_Words autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XM_Body_Dirty_Words Contains a dirty word
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Jordan Glover <Golden_Miller83@protonmail.ch>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1806 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (0.6%), b_tie_ro: 10 (0.5%), parse: 1.39
        (0.1%), extract_message_metadata: 23 (1.3%), get_uri_detail_list: 7
        (0.4%), tests_pri_-1000: 7 (0.4%), tests_pri_-950: 1.69 (0.1%),
        tests_pri_-900: 1.33 (0.1%), tests_pri_-90: 356 (19.7%), check_bayes:
        349 (19.3%), b_tokenize: 25 (1.4%), b_tok_get_all: 14 (0.7%),
        b_comp_prob: 6 (0.3%), b_tok_touch_all: 299 (16.6%), b_finish: 1.49
        (0.1%), tests_pri_0: 1386 (76.7%), check_dkim_signature: 0.84 (0.0%),
        check_dkim_adsp: 13 (0.7%), poll_dns_idle: 4.5 (0.2%), tests_pri_10:
        3.3 (0.2%), tests_pri_500: 11 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: linux 5.14.3: free_user_ns causes NULL pointer dereference
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Glover <Golden_Miller83@protonmail.ch> writes:

> On Wednesday, September 15th, 2021 at 10:42 PM, Jordan Glover <Golden_Miller83@protonmail.ch> wrote:
>>
>> I had about 2 containerized (flatpak/bubblewrap) apps (browser + music player) running . I quickly closed them with intent to shutdown the system but instead get the freeze and had to use magic sysrq to reboot. System logs end with what I posted and before there is nothing suspicious.
>>
>> Maybe it's some random fluke. I'll reply if I hit it again.
>
> Heh, it jut happened again. This time closing firefox alone had such
> effect:

Ok. It looks like he have a couple of folks seeing issues here.

I thought we had all of the issues sorted out for the release of v5.14,
but it looks like there is still some little bug left.

If Alex doesn't beat me to it I will see if I can come up with a
debugging patch to make it easy to help track down where the reference
count is going wrong.   It will be a little bit as my brain is mush at
the moment.

Eric

> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 351 at kernel/ucount.c:253 dec_ucount+0x43/0x50
> Modules linked in: nft_ct nft_fib_ipv4 nft_fib wireguard curve25519_x86_64 libcurve25519_generic libchacha20poly1305 chacha_x86_64 poly1305_x86_64 udp_tunnel libblake2s blake2s_x86_64 libblake2s_generic libchacha ccm algif_aead des_generic libdes ecb algif_skcipher cmac md4 algif_hash af_alg hid_sensor_custom_intel_hinge hid_sensor_als hid_sensor_gyro_3d hid_sensor_accel_3d hid_sensor_rotation hid_sensor_magn_3d hid_sensor_trigger industrialio_triggered_buffer hid_sensor_iio_common kfifo_buf industrialio hid_sensor_custom hid_sensor_hub cros_ec_ishtp cros_ec intel_ishtp_loader intel_ishtp_hid intel_rapl_msr nft_counter xt_mark ipt_REJECT nf_reject_ipv4 mei_hdcp intel_rapl_common xt_LOG nf_log_syslog intel_tcc_cooling x86_pkg_temp_thermal think_lmi wmi_bmof xt_addrtype firmware_attributes_class xt_tcpudp intel_powerclamp xt_conntrack nf_conntrack nf_defrag_ipv4 snd_hda_codec_hdmi nft_compat intel_wmi_thunderbolt nf_tables libcrc32c coretemp iwlmvm snd_ctl_led nfnetlink
>  snd_hda_codec_conexant mac80211 snd_hda_codec_generic libarc4 vfat snd_hda_intel kvm_intel fat iwlwifi snd_intel_dspcfg rapl intel_cstate joydev snd_hda_codec mousedev intel_uncore snd_hwdep snd_hda_core psmouse snd_pcm snd_timer cfg80211 mei_me wacom ucsi_acpi typec_ucsi mei intel_pch_thermal intel_xhci_usb_role_switch intel_ish_ipc roles intel_ishtp typec wmi thinkpad_acpi ledtrig_audio platform_profile snd soundcore tpm_crb rfkill i2c_hid_acpi tpm_tis tpm_tis_core i2c_hid mac_hid acpi_pad pkcs8_key_parser fuse zram ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 usbhid dm_crypt cbc encrypted_keys trusted asn1_encoder tee tpm rng_core dm_mod rtsx_pci_sdmmc mmc_core serio_raw atkbd libps2 crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd cryptd rtsx_pci xhci_pci xhci_pci_renesas i8042 serio kvmgt mdev vfio_iommu_type1 vfio i915 i2c_algo_bit intel_gtt ttm agpgart video drm_kms_helper syscopyarea sysfillrect sysimgblt
>  fb_sys_fops cec drm kvm irqbypass
> CPU: 1 PID: 351 Comm: kworker/1:3 Not tainted 5.14.3 #1 c719caf0c6c208968387ed83e3061ac05d0faf2f
> Workqueue: events free_user_ns
> RIP: 0010:dec_ucount+0x43/0x50
> Code: 14 01 48 8b 02 48 89 c6 48 83 ee 01 78 1c f0 48 0f b1 32 75 f0 48 8b 41 10 48 8b 88 e8 01 00 00 48 85 c9 75 d9 e9 0d fd ff ff <0f> 0b eb e7 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 f8 48
> RSP: 0018:ffffaa06c08bbe60 EFLAGS: 00010297
> RAX: 0000000000000000 RBX: ffff894ecb0c35a0 RCX: ffff894e25cdfcc0
> RDX: ffff894e25cdfce0 RSI: ffffffffffffffff RDI: ffff894e25cdfcc0
> RBP: ffff894ee393d380 R08: 0000000000000020 R09: ffff894ee393d5f0
> R10: ffff894f617fd000 R11: 0000000000031678 R12: ffff894e25cdfcc0
> R13: 00000000ffffffff R14: 0000000000000000 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff894f59680000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000056ffceff6b10 CR3: 0000000147a0e005 CR4: 00000000003706e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  free_user_ns+0x73/0x110
>  process_one_work+0x1e1/0x380
>  worker_thread+0x50/0x3a0
>  ? rescuer_thread+0x360/0x360
>  kthread+0x127/0x150
>  ? set_kthread_struct+0x40/0x40
>  ret_from_fork+0x22/0x30
> ---[ end trace ff45ac39689f43c1 ]---
> BUG: kernel NULL pointer dereference, address: 00000000000001e8
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> Oops: 0000 [#1] SMP PTI
> CPU: 1 PID: 351 Comm: kworker/1:3 Tainted: G        W         5.14.3 #1 c719caf0c6c208968387ed83e3061ac05d0faf2f
> Workqueue: events free_user_ns
> RIP: 0010:dec_ucount+0x32/0x50
> Code: 74 34 89 f6 48 89 f9 4c 8d 04 f5 20 00 00 00 4a 8d 14 01 48 8b 02 48 89 c6 48 83 ee 01 78 1c f0 48 0f b1 32 75 f0 48 8b 41 10 <48> 8b 88 e8 01 00 00 48 85 c9 75 d9 e9 0d fd ff ff 0f 0b eb e7 66
> RSP: 0018:ffffaa06c08bbe60 EFLAGS: 00010297
> RAX: 0000000000000000 RBX: ffff894ecb0c35a0 RCX: ffff894e25cdfcc0
> RDX: ffff894e25cdfce0 RSI: ffffffffffffffff RDI: ffff894e25cdfcc0
> RBP: ffff894ee393d380 R08: 0000000000000020 R09: ffff894ee393d5f0
> R10: ffff894f617fd000 R11: 0000000000031678 R12: ffff894e25cdfcc0
> R13: 00000000ffffffff R14: 0000000000000000 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff894f59680000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000001e8 CR3: 0000000147a0e005 CR4: 00000000003706e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  free_user_ns+0x73/0x110
>  process_one_work+0x1e1/0x380
>  worker_thread+0x50/0x3a0
>  ? rescuer_thread+0x360/0x360
>  kthread+0x127/0x150
>  ? set_kthread_struct+0x40/0x40
>  ret_from_fork+0x22/0x30
> Modules linked in: nft_ct nft_fib_ipv4 nft_fib wireguard curve25519_x86_64 libcurve25519_generic libchacha20poly1305 chacha_x86_64 poly1305_x86_64 udp_tunnel libblake2s blake2s_x86_64 libblake2s_generic libchacha ccm algif_aead des_generic libdes ecb algif_skcipher cmac md4 algif_hash af_alg hid_sensor_custom_intel_hinge hid_sensor_als hid_sensor_gyro_3d hid_sensor_accel_3d hid_sensor_rotation hid_sensor_magn_3d hid_sensor_trigger industrialio_triggered_buffer hid_sensor_iio_common kfifo_buf industrialio hid_sensor_custom hid_sensor_hub cros_ec_ishtp cros_ec intel_ishtp_loader intel_ishtp_hid intel_rapl_msr nft_counter xt_mark ipt_REJECT nf_reject_ipv4 mei_hdcp intel_rapl_common xt_LOG nf_log_syslog intel_tcc_cooling x86_pkg_temp_thermal think_lmi wmi_bmof xt_addrtype firmware_attributes_class xt_tcpudp intel_powerclamp xt_conntrack nf_conntrack nf_defrag_ipv4 snd_hda_codec_hdmi nft_compat intel_wmi_thunderbolt nf_tables libcrc32c coretemp iwlmvm snd_ctl_led nfnetlink
>  snd_hda_codec_conexant mac80211 snd_hda_codec_generic libarc4 vfat snd_hda_intel kvm_intel fat iwlwifi snd_intel_dspcfg rapl intel_cstate joydev snd_hda_codec mousedev intel_uncore snd_hwdep snd_hda_core psmouse snd_pcm snd_timer cfg80211 mei_me wacom ucsi_acpi typec_ucsi mei intel_pch_thermal intel_xhci_usb_role_switch intel_ish_ipc roles intel_ishtp typec wmi thinkpad_acpi ledtrig_audio platform_profile snd soundcore tpm_crb rfkill i2c_hid_acpi tpm_tis tpm_tis_core i2c_hid mac_hid acpi_pad pkcs8_key_parser fuse zram ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 usbhid dm_crypt cbc encrypted_keys trusted asn1_encoder tee tpm rng_core dm_mod rtsx_pci_sdmmc mmc_core serio_raw atkbd libps2 crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd cryptd rtsx_pci xhci_pci xhci_pci_renesas i8042 serio kvmgt mdev vfio_iommu_type1 vfio i915 i2c_algo_bit intel_gtt ttm agpgart video drm_kms_helper syscopyarea sysfillrect sysimgblt
>  fb_sys_fops cec drm kvm irqbypass
> CR2: 00000000000001e8
> ---[ end trace ff45ac39689f43c2 ]---
> RIP: 0010:dec_ucount+0x32/0x50
> Code: 74 34 89 f6 48 89 f9 4c 8d 04 f5 20 00 00 00 4a 8d 14 01 48 8b 02 48 89 c6 48 83 ee 01 78 1c f0 48 0f b1 32 75 f0 48 8b 41 10 <48> 8b 88 e8 01 00 00 48 85 c9 75 d9 e9 0d fd ff ff 0f 0b eb e7 66
> RSP: 0018:ffffaa06c08bbe60 EFLAGS: 00010297
> RAX: 0000000000000000 RBX: ffff894ecb0c35a0 RCX: ffff894e25cdfcc0
> RDX: ffff894e25cdfce0 RSI: ffffffffffffffff RDI: ffff894e25cdfcc0
> RBP: ffff894ee393d380 R08: 0000000000000020 R09: ffff894ee393d5f0
> R10: ffff894f617fd000 R11: 0000000000031678 R12: ffff894e25cdfcc0
> R13: 00000000ffffffff R14: 0000000000000000 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff894f59680000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000001e8 CR3: 0000000147a0e005 CR4: 00000000003706e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
