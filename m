Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28093CCABE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 23:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhGRVHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 17:07:10 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:55592 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbhGRVHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 17:07:08 -0400
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 9B5CEB3DDCC;
        Sun, 18 Jul 2021 23:04:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1626642249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9SBJQp9v99Nz1cqI8XQ9MdszYHfx7n6co/WyoJc+JA=;
        b=G++7nIjS025AUyXyf++3lrpb99+IKJkNMHuNCqnadzhQWy0Z+RovWPk1XtYUa4P0+xViHp
        olXHA+PegNLgRsjZL+CKSzDk79At8Vb++OFGTP6EyHjSQWaDheE0rcMMbSC3EiUXaT8vxi
        yc8/NDUQh6JqYeg/4JKxishIXfZA8Gc=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Rankin <rankincj@gmail.com>
Subject: Re: WARN with 5.12.17
Date:   Sun, 18 Jul 2021 23:04:07 +0200
Message-ID: <14659399.kGUakuKLT2@natalenko.name>
In-Reply-To: <CAK2bqVK0Q9YcpakE7_Rc6nr-E4e2GnMOgi5jJj=_Eh_1kEHLHA@mail.gmail.com>
References: <CAK2bqVK0Q9YcpakE7_Rc6nr-E4e2GnMOgi5jJj=_Eh_1kEHLHA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On sobota 17. =C4=8Dervence 2021 13:28:53 CEST Chris Rankin wrote:
> I have noticed this WARNING when running 5.12.17. Rebuilding the
> entire kernel after a "make clean" has not helped.
>=20
> Cheers,
> Chris
>=20
> [  138.553764] ------------[ cut here ]------------
> [  138.553776] WARNING: CPU: 0 PID: 2311 at
> kernel/rcu/tree_plugin.h:297 rcu_note_context_switch+0x2f/0x2b1
> [  138.553799] Modules linked in: uinput hdaps ip6t_REJECT
> nf_reject_ipv6 ip6table_filter ip6_tables xt_state xt_conntrack
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c xt_tcpudp
> ipt_REJECT nf_reject_ipv4 iptable_filter sunrpc coretemp ppdev
> kvm_intel kvm irqbypass snd_seq_dummy snd_seq_oss snd_emu10k1_synth
> snd_emux_synth iwl3945 joydev evdev snd_seq_midi_emul i2c_i801
> snd_seq_virmidi iwlegacy pcspkr i2c_smbus snd_seq_midi
> snd_seq_midi_event mac80211 cfg80211 snd_hda_codec_hdmi
> snd_hda_codec_analog snd_hda_codec_generic snd_emu10k1 snd_hda_intel
> snd_intel_dspcfg snd_util_mem libarc4 snd_hda_codec snd_ac97_codec
> ac97_bus snd_rawmidi snd_hda_core thinkpad_acpi snd_seq snd_hwdep
> snd_seq_device snd_pcm nvram ledtrig_audio snd_hrtimer
> platform_profile snd_timer rfkill tiny_power_button parport_pc ac
> battery snd parport video acpi_cpufreq soundcore button sch_fq_codel
> binfmt_misc fuse ip_tables x_tables usbhid ext4 crc32c_generic crc16
> mbcache jbd2 usb_storage sd_mod sr_mod cdrom
> [  138.554028]  pata_acpi radeon i2c_algo_bit drm_ttm_helper ttm
> pcmcia drm_kms_helper ata_piix ahci libahci syscopyarea sysfillrect
> sysimgblt fb_sys_fops cec libata rc_core drm serio_raw scsi_mod
> uhci_hcd e1000e yenta_socket pcmcia_rsrc pcmcia_core ptp ehci_pci
> ehci_hcd drm_panel_orientation_quirks pps_core 8250 8250_base
> serial_mctrl_gpio serial_core msr sha256_generic sha1_generic ipv6
> crc_ccitt
> [  138.554135] CPU: 0 PID: 2311 Comm: gdbus Not tainted 5.12.17 #2
> [  138.554143] Hardware name: LENOVO 8742C4G/8742C4G, BIOS 7IET38WW
> (1.19 ) 03/22/2011
> [  138.554149] RIP: 0010:rcu_note_context_switch+0x2f/0x2b1
> [  138.554160] Code: 2c 25 00 6d 01 00 41 54 49 c7 c4 80 24 02 00 55
> 53 89 fb 65 4c 03 25 fe d1 f7 7e 40 84 ff 75 0c 41 83 bd 1c 03 00 00
> 00 7e 02 <0f> 0b 65 48 8b 04 25 00 6d 01 00 83 b8 1c 03 00 00 00 0f 8e
> 28 02
> [  138.554167] RSP: 0000:ffffc900028efc80 EFLAGS: 00010002
> [  138.554176] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> 0000000000000102 [  138.554181] RDX: 0000000081c09214 RSI: ffffea0000fa65=
c0
> RDI: 0000000000000000 [  138.554188] RBP: ffffc900028efce0 R08:
> 0000000000000000 R09: ffffea0000fa65c0 [  138.554194] R10: ffffc900028efc=
68
> R11: 0000000000000003 R12: ffff88807dc22480 [  138.554199] R13:
> ffff888056416a00 R14: 0000000000000000 R15: 0000000000000000 [  138.55420=
5]
> FS:  00007f94411ab640(0000) GS:ffff88807dc00000(0000)
> knlGS:0000000000000000
> [  138.554213] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  138.554219] CR2: 00007f9453ea6f78 CR3: 000000005489e000 CR4:
> 00000000000006f0 [  138.554225] Call Trace:
> [  138.554236]  __schedule+0x5e/0x4df
> [  138.554250]  schedule+0x88/0xb5
> [  138.554258]  io_schedule+0xd/0x2f
> [  138.554266]  wait_on_page_bit_common+0x1b6/0x249
> [  138.554277]  ? filemap_get_read_batch+0x133/0x133
> [  138.554286]  __lock_page_or_retry+0x38/0x79
> [  138.554295]  do_swap_page+0x230/0x4c4
> [  138.554306]  __handle_mm_fault+0x40b/0xa30
> [  138.554317]  handle_mm_fault+0x11e/0x1ea
> [  138.554327]  exc_page_fault+0x2bd/0x4cc
> [  138.554335]  ? asm_exc_page_fault+0x8/0x30
> [  138.554344]  asm_exc_page_fault+0x1e/0x30
> [  138.554351] RIP: 0033:0x7f9452a9ea17
> [  138.554359] Code: 89 c2 48 3d 00 f0 ff ff 77 d0 48 83 c4 08 5d 41
> 5c c3 90 f3 0f 1e fa 41 54 49 89 f4 55 89 fd 48 83 ec 08 48 8b 05 29
> b4 0f 00 <48> 8b 80 b8 02 00 00 48 85 c0 74 2d ff d0 48 63 d0 48 81 fa
> 00 f0
> [  138.554367] RSP: 002b:00007f94411aa970 EFLAGS: 00010202
> [  138.554374] RAX: 00007f9453ea6cc0 RBX: 0000000000000000 RCX:
> 00007f94411aa9c0 [  138.554380] RDX: 00007f94411aa9c8 RSI: 00007f94411aa9=
d0
> RDI: 0000000000000001 [  138.554386] RBP: 0000000000000001 R08:
> 00007f94411aa9d0 R09: 0000000000000002 [  138.554392] R10: 00000000000000=
20
> R11: 0000000000000293 R12: 00007f94411aa9d0 [  138.554397] R13:
> 00007f9453c18b60 R14: 00007f9434001410 R15: 000055b519b81690 [  138.55440=
7]
> ---[ end trace 16c264fd475c3beb ]---

There's another report against v5.13.2 [2], I've Cc'ed you there. Let's=20
discuss this matter in that thread.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


