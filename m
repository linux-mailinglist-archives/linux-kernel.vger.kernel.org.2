Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197CD45325A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 13:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhKPMrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 07:47:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25163 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234412AbhKPMrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 07:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637066643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=EhX57vTRHjQSI9UGDs3HZ8AxGDff1NgicPFZJaWuo1M=;
        b=TnCZ7n1fO3qoWyQV8id6Byl5ETLj0VZZXjTHg7hbDVkEbkPxDqXyFovzCegzyi8zEgdT1L
        UQ93LWzP72z7rfwooo/3JP6C5fOlG3JHjbrxY1dhaWPuDudcb2pYioRyl2ffBm93HSpiqo
        6Lm/t4EYWFsRRAtA5XHK4H5qS65BiUc=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-rH7NBu83NtOSvTNc4lwNXw-1; Tue, 16 Nov 2021 07:44:01 -0500
X-MC-Unique: rH7NBu83NtOSvTNc4lwNXw-1
Received: by mail-oo1-f71.google.com with SMTP id y9-20020a4a2d09000000b002c600da5eb9so545688ooy.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 04:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EhX57vTRHjQSI9UGDs3HZ8AxGDff1NgicPFZJaWuo1M=;
        b=eiObCrRQRX7CF08CMu8wfQAh/ZvXj+x/xTgRjF/NRyZcOX/tyAcJ8gvnC3y9U2A8t6
         zfbHgklG/iC6GTn3f+BI36CPjcIhyPecIsap3hMg41vJ8ruYSHV+hTJwl2XmwPPeJR+y
         epeg4WuY05MehBbxl/Qxb4ejPwXn6+q3R7n0niz4EU6++aIfQi1LM+Tl2YDu23FeaG5s
         kSMlGJXqYEKMe9BcUodjHDfyH0vLkLshPkRC9hqovBAh0fXP83TGzBUmFJiox+OXK0Di
         EJsVmM8ROfOASclb6X+0Bp1MDYIfHjWBeQr0LGP9geKXK5AvOWLk5HkE9tEPf9q4wTa7
         W8kw==
X-Gm-Message-State: AOAM532w3UhNUiXFOEtX24FgdLnHh0g3cJSO1VmhIzR3G33v6pfrzRm1
        zGh9rRTVxAAbtsuTwtD3C+YJ4sZW7GI+UBAqFx/blZuWFafVUDbnIpOOLNJH4+Xa5AAaBxs0hyF
        QzxS5XzHdUtVintB22tU9rPvXdrf1yO1wuSx2muzj
X-Received: by 2002:a05:6830:4cf:: with SMTP id s15mr5881566otd.219.1637066640920;
        Tue, 16 Nov 2021 04:44:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPjc2HdrreSOHOSS28//X13YUKP48n6//0MJE7e0iPHrQ6BrIC9XzDyIgy4/3uDWGRs/o8P6kYxnLkEpKPF6w=
X-Received: by 2002:a05:6830:4cf:: with SMTP id s15mr5881547otd.219.1637066640669;
 Tue, 16 Nov 2021 04:44:00 -0800 (PST)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Tue, 16 Nov 2021 13:43:49 +0100
Message-ID: <CA+QYu4rKUobW5LRKgijLviKjEPAFZ_428Dhin44_Hq2KtWzM+A@mail.gmail.com>
Subject: Boot issue on x86_64: kernel 5.15.2 - RIP: 0010:__unwind_start+0x10b/0x1e0
To:     linux-kernel@vger.kernel.org
Cc:     CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We've started to see the issue below when booting on x86_64 on recent
kernel builds from linux-stable-rc. More logs can be found on [1] and
cki tracker issue [2].

[   24.006329] zram: Added device: zram0
[   25.075694] systemd[1]:
/usr/lib/systemd/system/restraintd.service:8: Standard output type
syslog+console is obsolete, automatically updating to journal+console.
Please update your unit file, and consider removing the setting
altogether.
[   25.342129] BUG: unable to handle page fault for address: ffffb57143fb7de0
[   25.376757] #PF: supervisor read access in kernel mode
[   25.402135] #PF: error_code(0x0000) - not-present page
[   25.426507] PGD 100000067 P4D 100000067 PUD 1001e2067 PMD 31b1c3067 PTE 0
[   25.461485] Oops: 0000 [#1] SMP PTI
[   25.477997] CPU: 4 PID: 1 Comm: systemd Tainted: G          I       5.15.2 #1
[   25.512982] Hardware name: HP ProLiant SL390s G7/, BIOS P69 07/02/2013
[   25.548041] RIP: 0010:__unwind_start+0x10b/0x1e0
[   25.570958] Code: af fb ff 85 c0 75 d2 eb c0 65 48 8b 04 25 c0 bb
01 00 48 39 c6 0f 84 86 00 00 00 48 8b 86 98 23 00 00 48 8d 78 38 48
89 7d 38 <48> 8b 50 28 48 89 55 40 48 8b 40 30 48 89 45 48 48 3d 80 43
00 81
[   25.668824] RSP: 0018:ffffb5714313bc18 EFLAGS: 00010083
[   25.695397] RAX: ffffb57143fb7db8 RBX: ffffb57143fb7db8 RCX: 0000000000000000
[   25.733090] RDX: 0000000000000000 RSI: ffff924d03534d00 RDI: ffffb57143fb7df0
[   25.769626] RBP: ffffb5714313bc38 R08: 0000000000000040 R09: 0000000000001000
[   25.808015] R10: 8000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   25.841524] R13: ffff924d03535974 R14: 0000000000000155 R15: 0000000000000001
[   25.878031] FS:  00007f49ec409340(0000) GS:ffff924f0ba80000(0000)
knlGS:0000000000000000
[   25.916770] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   25.946918] CR2: ffffb57143fb7de0 CR3: 00000001039ae005 CR4: 00000000000206e0
[   25.988907] Call Trace:
[   26.001096]  <TASK>
[   26.013087]  __get_wchan+0x35/0x80
[   26.031979]  get_wchan+0x65/0x80
[   26.047218]  do_task_stat+0xcd9/0xde0
[   26.064584]  proc_single_show+0x4d/0xb0
[   26.083925]  seq_read_iter+0x120/0x4b0
[   26.103266]  seq_read+0xed/0x120
[   26.118507]  ? security_inode_notifysecctx+0x30/0x50
[   26.142094]  vfs_read+0x95/0x190
[   26.158829]  ksys_read+0x4f/0xc0
[   26.175927]  do_syscall_64+0x3b/0x90
[   26.194142]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   26.220169] RIP: 0033:0x7f49ecf992e2
[   26.239468] Code: c0 e9 b2 fe ff ff 50 48 8d 3d ea 2e 0a 00 e8 95
e9 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75
10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89
54 24
[   26.336968] RSP: 002b:00007ffc3fedf998 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[   26.376294] RAX: ffffffffffffffda RBX: 000055fd5a6a1f30 RCX: 00007f49ecf992e2
[   26.410402] RDX: 0000000000000400 RSI: 000055fd5a7f2e90 RDI: 0000000000000010
[   26.447213] RBP: 00007f49ed06d300 R08: 0000000000000010 R09: 0000000000000001
[   26.481089] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f49ec4090f8
[   26.517502] R13: 0000000000000d68 R14: 00007f49ed06c700 R15: 0000000000000d68
[   26.551484]  </TASK>
[   26.561812] Modules linked in: zram ip_tables xfs radeon
i2c_algo_bit drm_ttm_helper ttm drm_kms_helper crct10dif_pclmul
crc32_pclmul crc32c_intel cec ata_generic ghash_clmulni_intel
serio_raw drm pata_acpi hpwdt
[   26.657383] CR2: ffffb57143fb7de0
[   26.673063] ---[ end trace d486977d124663a0 ]---


[1] https://datawarehouse.cki-project.org/kcidb/tests/1872788
[2] https://datawarehouse.cki-project.org/issue/747

Thanks,
Bruno

