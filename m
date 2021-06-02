Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D5F398F47
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhFBPyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:54:12 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:35664 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhFBPyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:54:09 -0400
Received: by mail-pg1-f174.google.com with SMTP id 133so2603607pgf.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oF6/N3I0BnYwJig6qcwJ/w6aAKl3cofxM0gH7J7TQng=;
        b=oNCLE/dYrN2W97TfgOY1jahv77KVMVBl1EeHAjX2ln+lKk9KMM3o8XHFngXEgkSBO7
         ZZgtSv0i6fFQ+ksZscLb8OO/RZl9qY3foD9AL7rquncskc5gbG8/phSKmRbJdmr17cKi
         /9X16zCewdxnanr9ZEaN2wUgnQWU1DNcRobxeYEUiZ//tNoJ5+kSsLFCjvsiFC5gDdRl
         Y8AODqXEqRJMiBiVjNmM7EuRO91vG6akdOYIRnkhcqUkIQWdkM6Uo07XRGr2OTfhRrhK
         TRPr03I00lODZkp/GHJZj84E6hAx7rtZrrxznBoFt8X2JVR4Z3h5l5Ej7okh1YAys4yS
         uHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oF6/N3I0BnYwJig6qcwJ/w6aAKl3cofxM0gH7J7TQng=;
        b=HobaRM89K2ZigWDD/MnavGslfdZ3zxBCnva/0lIw7Wcx5fraJE+zlAzCLKwigVWXzU
         sAHwQe3Gs6lrjZQeyp9zb6FmaeO1UBU/FJFRsS3c8F+b6k+M1toG2uJdnazBpbNSwFNi
         whsc0PDJPcE090oHB/trT8wfs2DnVPOxwrqtmt4VfR82WqNRr4xoIXuPiOqPO5S/36mM
         Qr+eB0nQ2rtmCU+j7o3hKIAkZI3vv3fO5aFtypJ33MBIlIuDIR7h5GLjxblBp80gv+Tc
         8KMopgeCTc8OcZvEv01V/ZnNM6N+ScJC8d6p0xSbFBZv92BASYQxI68yg6siZjgxtCUz
         KJ8g==
X-Gm-Message-State: AOAM530PfeWcOG7jj3bmzNWQW5P/7toycqeTD3+MLmMhxUO9V4NPIzI7
        78h7zO29x80eWrheFbde/duvM/XDhVVJ4TdWj/cYuw==
X-Google-Smtp-Source: ABdhPJxAP5+aRH6gW49Cn41r1Wc2u4HHl4Yqer/ewOrWLjM+KkeIPdA4gzq4/MIil06jw5XNRYCpA/Qr0x+w7Utr+44=
X-Received: by 2002:a63:4706:: with SMTP id u6mr34190722pga.152.1622649072285;
 Wed, 02 Jun 2021 08:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210326151159.128534163@infradead.org> <20210326151300.320177914@infradead.org>
 <20210329163826.anuqkv5ahvoyus5c@treble>
In-Reply-To: <20210329163826.anuqkv5ahvoyus5c@treble>
From:   Lukasz Majczak <lma@semihalf.com>
Date:   Wed, 2 Jun 2021 17:51:01 +0200
Message-ID: <CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com>
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        jgross@suse.com, mbenes@suse.com, linux-kernel@vger.kernel.org,
        upstream@semihalf.com,
        =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>,
        =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>,
        Guenter Roeck <groeck@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

This patch seems to crash on Tigerlake platform (Chromebook delbin), I
got the following error:

[    2.103054] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
[    2.110148] pcieport 0000:00:1c.0: pciehp: Slot #7 AttnBtn-
PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+
IbPresDis- LLActRep+
[    2.126754] pcieport 0000:00:1d.0: PME: Signaling with IRQ 123
[    2.133946] ACPI: \_SB_.CP00: Found 3 idle states
[    2.139708] BUG: kernel NULL pointer dereference, address: 000000000000012b
[    2.140704] #PF: supervisor read access in kernel mode
[    2.140704] #PF: error_code(0x0000) - not-present page
[    2.140704] PGD 0 P4D 0
[    2.140704] Oops: 0000 [#1] PREEMPT SMP NOPTI
[    2.140704] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G     U
  5.13.0-rc1 #31
[    2.140704] Hardware name: Google Delbin/Delbin, BIOS
Google_Delbin.13672.156.3 05/14/2021
[    2.140704] RIP: 0010:cpuidle_poll_time+0x9/0x6a
[    2.140704] Code: 44 00 00 85 f6 78 19 55 48 89 e5 48 8b 05 16 44
44 01 4c 8b 58 40 4d 85 db 5d 41 ff d3 66 90 00 c3 0f 1f 44 00 00 55
48 89 e5 <48> 8b 46 20 48 85 c0 75 56 4c 63 87 28 04 00 00 b8 24 f49
[    2.140704] RSP: 0000:ffffffff9cc03ea8 EFLAGS: 00010282
[    2.140704] RAX: 0000000000008e7d RBX: ffffffff9cc1c5fd RCX: 000000007f894e5a
[    2.140704] RDX: 000000007f894d4f RSI: 000000000000010b RDI: 0000000002fa1cf6
[    2.140704] RBP: ffffffff9cc03ea8 R08: 0000000000000000 R09: 00000000ca948246
[    2.140704] R10: 0000000000000000 R11: ffffffff9bf132cb R12: 0000000000000003
[    2.140704] R13: ffffbbfdffc21960 R14: 0000000000000000 R15: ffffffff9cdba638
[    2.140704] FS:  0000000000000000(0000) GS:ffff928280000000(0000)
knlGS:0000000000000000
[    2.140704] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.140704] CR2: 000000000000012b CR3: 000000027e414001 CR4: 0000000000770ef0
[    2.140704] PKRU: 55555554
[    2.140704] Call Trace:
[    2.140704]  do_idle+0x175/0x1f6
[    2.140704]  cpu_startup_entry+0x1d/0x1f
[    2.140704]  start_kernel+0x3be/0x420
[    2.140704]  secondary_startup_64_no_verify+0xb0/0xbb
[    2.140704] Modules linked in:
[    2.140704] CR2: 000000000000012b
[    2.140704] ---[ end trace d15839e2bd509f00 ]---
[    2.140704] RIP: 0010:cpuidle_poll_time+0x9/0x6a
[    2.140704] Code: 44 00 00 85 f6 78 19 55 48 89 e5 48 8b 05 16 44
44 01 4c 8b 58 40 4d 85 db 5d 41 ff d3 66 90 00 c3 0f 1f 44 00 00 55
48 89 e5 <48> 8b 46 20 48 85 c0 75 56 4c 63 87 28 04 00 00 b8 24 f49
[    2.140704] RSP: 0000:ffffffff9cc03ea8 EFLAGS: 00010282
[    2.140704] RAX: 0000000000008e7d RBX: ffffffff9cc1c5fd RCX: 000000007f894e5a
[    2.140704] RDX: 000000007f894d4f RSI: 000000000000010b RDI: 0000000002fa1cf6
[    2.140704] RBP: ffffffff9cc03ea8 R08: 0000000000000000 R09: 00000000ca948246
[    2.140704] R10: 0000000000000000 R11: ffffffff9bf132cb R12: 0000000000000003
[    2.140704] R13: ffffbbfdffc21960 R14: 0000000000000000 R15: ffffffff9cdba638
[    2.140704] FS:  0000000000000000(0000) GS:ffff928280000000(0000)
knlGS:0000000000000000
[    2.140704] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.140704] CR2: 000000000000012b CR3: 000000027e414001 CR4: 0000000000770ef0
[    2.140704] PKRU: 55555554
[    2.140704] Kernel panic - not syncing: Fatal exception
[    2.140704] Kernel Offset: 0x1a600000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    2.140704] ACPI MEMORY or I/O RESET_REG.

Git bisect pointed to this commit:

9bc0bb50727c8ac69fbb33fb937431cf3518ff37 is the first bad commit
commit 9bc0bb50727c8ac69fbb33fb937431cf3518ff37
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Fri Mar 26 16:12:15 2021 +0100

    objtool/x86: Rewrite retpoline thunk calls

If there is anything I could do to help debug this issue (additional
debugs, logs etc.), please let me know.
Best regards,
Lukasz
