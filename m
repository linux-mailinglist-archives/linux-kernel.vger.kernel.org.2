Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD73C40CE84
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhIOVER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:04:17 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:38778 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhIOVEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:04:16 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:45432)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mQc3S-009Uud-4x; Wed, 15 Sep 2021 15:02:54 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:43060 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mQc3Q-005gPt-QL; Wed, 15 Sep 2021 15:02:53 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-mm\@kvack.org" <linux-mm@kvack.org>,
        "legion\@kernel.org" <legion@kernel.org>,
        "containers\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch>
Date:   Wed, 15 Sep 2021 16:02:19 -0500
In-Reply-To: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch>
        (Jordan Glover's message of "Wed, 15 Sep 2021 19:49:31 +0000")
Message-ID: <87ee9pa6xw.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mQc3Q-005gPt-QL;;;mid=<87ee9pa6xw.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18iG/Y+rnWvet9XpIvn9RVjal8RV5j/qco=
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
        *      [sa06 1397; Body=1 Fuz1=1]
        *  1.0 XM_Body_Dirty_Words Contains a dirty word
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 
X-Spam-Combo: ****;Jordan Glover <Golden_Miller83@protonmail.ch>
X-Spam-Relay-Country: 
X-Spam-Timing: total 769 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 15 (1.9%), b_tie_ro: 12 (1.6%), parse: 1.55
        (0.2%), extract_message_metadata: 17 (2.2%), get_uri_detail_list: 4.5
        (0.6%), tests_pri_-1000: 7 (0.9%), tests_pri_-950: 1.57 (0.2%),
        tests_pri_-900: 1.14 (0.1%), tests_pri_-90: 95 (12.4%), check_bayes:
        93 (12.1%), b_tokenize: 13 (1.7%), b_tok_get_all: 12 (1.6%),
        b_comp_prob: 4.0 (0.5%), b_tok_touch_all: 59 (7.7%), b_finish: 1.21
        (0.2%), tests_pri_0: 550 (71.5%), check_dkim_signature: 1.05 (0.1%),
        check_dkim_adsp: 5 (0.7%), poll_dns_idle: 0.39 (0.1%), tests_pri_10:
        2.5 (0.3%), tests_pri_500: 73 (9.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: linux 5.14.3: free_user_ns causes NULL pointer dereference
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Glover <Golden_Miller83@protonmail.ch> writes:

> Hi, recently I hit system freeze after I was closing few containerized apps on my system. As for now it occurred only once on linux 5.14.3. I think it maybe be related to "Count rlimits in each user namespace" patchset merged during 5.14 window
>
> https://lore.kernel.org/all/257aa5fb1a7d81cf0f4c34f39ada2320c4284771.1619094428.git.legion@kernel.org/T/#u

So that warning comes from:

void dec_ucount(struct ucounts *ucounts, enum ucount_type type)
{
	struct ucounts *iter;
	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
		long dec = atomic_long_dec_if_positive(&iter->ucount[type]);
		WARN_ON_ONCE(dec < 0);
	}
	put_ucounts(ucounts);
}

Which certainly looks like a reference count bug.  It could also be a
memory stomp somewhere close.

Do you have any idea what else was going on?  This location is the
symptom but not the actual cause.

Eric



>
> Logs below:
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 26546 at kernel/ucount.c:253 dec_ucount+0x43/0x50
> Modules linked in: nft_ct nft_fib_ipv4 nft_fib wireguard curve25519_x86_64 libcurve25519_generic libchacha20poly1305 chacha_x86_64 poly1305_x86_64 udp_tunnel libblake2s blake2s_x86_64 libblake2s_generic libchacha ccm algif_aead des_generic libdes ecb algif_skcipher cmac md4 algif_hash af_alg hid_sensor_custom_intel_hinge hid_sensor_als hid_sensor_magn_3d hid_sensor_rotation hid_sensor_accel_3d hid_sensor_gyro_3d hid_sensor_trigger industrialio_triggered_buffer hid_sensor_iio_common kfifo_buf industrialio hid_sensor_custom hid_sensor_hub cros_ec_ishtp cros_ec intel_ishtp_loader nft_counter intel_ishtp_hid snd_hda_codec_hdmi intel_rapl_msr xt_mark ipt_REJECT nf_reject_ipv4 snd_ctl_led xt_LOG snd_hda_codec_conexant nf_log_syslog snd_hda_codec_generic xt_addrtype xt_tcpudp xt_conntrack nf_conntrack nf_defrag_ipv4 mei_hdcp snd_hda_intel nft_compat wmi_bmof nf_tables intel_rapl_common libcrc32c think_lmi intel_tcc_cooling snd_intel_dspcfg firmware_attributes_class nfnetlink iwlmvm
>  intel_wmi_thunderbolt mac80211 x86_pkg_temp_thermal snd_hda_codec intel_powerclamp coretemp libarc4 vfat fat kvm_intel rapl intel_cstate snd_hwdep intel_uncore iwlwifi snd_hda_core mousedev joydev snd_pcm psmouse cfg80211 snd_timer mei_me ucsi_acpi wacom intel_ish_ipc intel_xhci_usb_role_switch mei intel_pch_thermal typec_ucsi roles typec intel_ishtp wmi thinkpad_acpi ledtrig_audio platform_profile snd soundcore rfkill tpm_crb i2c_hid_acpi i2c_hid acpi_pad tpm_tis mac_hid tpm_tis_core pkcs8_key_parser fuse zram ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 usbhid dm_crypt cbc encrypted_keys trusted asn1_encoder tee tpm rng_core dm_mod rtsx_pci_sdmmc mmc_core serio_raw atkbd libps2 crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd cryptd xhci_pci rtsx_pci xhci_pci_renesas i8042 serio kvmgt mdev vfio_iommu_type1 vfio i915 i2c_algo_bit intel_gtt ttm agpgart video drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec
>  drm kvm irqbypass
> CPU: 1 PID: 26546 Comm: kworker/1:1 Not tainted 5.14.3 #1 c719caf0c6c208968387ed83e3061ac05d0faf2f
> Workqueue: events free_user_ns
> RIP: 0010:dec_ucount+0x43/0x50
> Code: 14 01 48 8b 02 48 89 c6 48 83 ee 01 78 1c f0 48 0f b1 32 75 f0 48 8b 41 10 48 8b 88 e8 01 00 00 48 85 c9 75 d9 e9 0d fd ff ff <0f> 0b eb e7 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 f8 48
> RSP: 0018:ffffa82cc2bd7e60 EFLAGS: 00010297
> RAX: 0000000000000000 RBX: ffffa2f53298ee50 RCX: ffffa2f3c0061000
> RDX: ffffa2f3c0061020 RSI: ffffffffffffffff RDI: ffffa2f3c0061000
> RBP: ffffa2f53298ebe0 R08: 0000000000000020 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: ffffa2f3c0061000
> R13: 00000000ffffffff R14: 0000000000000000 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffffa2f599680000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000628f892be9f8 CR3: 000000002880e004 CR4: 00000000003706e0
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
> ---[ end trace eb7a8d38b64b2d3a ]---
> BUG: kernel NULL pointer dereference, address: 00000000000001e8
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> Oops: 0000 [#1] SMP PTI
> CPU: 1 PID: 26546 Comm: kworker/1:1 Tainted: G        W         5.14.3 #1 c719caf0c6c208968387ed83e3061ac05d0faf2f
> Workqueue: events free_user_ns
> RIP: 0010:dec_ucount+0x32/0x50
> Code: 74 34 89 f6 48 89 f9 4c 8d 04 f5 20 00 00 00 4a 8d 14 01 48 8b 02 48 89 c6 48 83 ee 01 78 1c f0 48 0f b1 32 75 f0 48 8b 41 10 <48> 8b 88 e8 01 00 00 48 85 c9 75 d9 e9 0d fd ff ff 0f 0b eb e7 66
> RSP: 0018:ffffa82cc2bd7e60 EFLAGS: 00010297
> RAX: 0000000000000000 RBX: ffffa2f53298ee50 RCX: ffffa2f3c0061000
> RDX: ffffa2f3c0061020 RSI: ffffffffffffffff RDI: ffffa2f3c0061000
> RBP: ffffa2f53298ebe0 R08: 0000000000000020 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: ffffa2f3c0061000
> R13: 00000000ffffffff R14: 0000000000000000 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffffa2f599680000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000001e8 CR3: 000000002880e004 CR4: 00000000003706e0
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
