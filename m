Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DDC3994C1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 22:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhFBUpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 16:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229552AbhFBUpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 16:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622666642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OkHNiAD4B9tLTy7xZTNyeTqGaPB3NZ2dH7ouXspLnvY=;
        b=B0hdBQyeh/fFcy1h4F/H4T2n3CWVNe/8dL4jhiwB4PIAZESOUGG39TNpbbjZn37LwegZaE
        PU4JH9WNgRabEdIcei8m4LKk2L+kY1h3D4oRSUW+THADGdmUeDDteVpga1wxVuF3K7HWYT
        1LYJsjNWVY/oGZ0SMytjqhPvIRGvuUw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-8Q9DKAWEMwG4dfBw2vmQlw-1; Wed, 02 Jun 2021 16:44:01 -0400
X-MC-Unique: 8Q9DKAWEMwG4dfBw2vmQlw-1
Received: by mail-qv1-f71.google.com with SMTP id k6-20020a0cd6860000b029021936c6e8ffso2746872qvi.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 13:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OkHNiAD4B9tLTy7xZTNyeTqGaPB3NZ2dH7ouXspLnvY=;
        b=bd4AWvyT+9fnAlyNpGdkkDm1BOWuZ4LZ5aFy+2wAQMM+COOTcropK7kBLwO/SfJPuw
         cByRgkDrLPzF8ragJBG3cfXwSKNM5PnJhFbdvayH1lVdT7oA26hVbg3XPkER18/bSrNg
         vKYsNzYv/7rC2+Q1UHLXvEEDRFCAJ4e9sXFzsySWU1dCT86iy/Cl5XV65KLLHj9HdWCM
         W3ScL2et3QhTi0Ck+mWVC68R4JuDj4ZZVaEtpJJf1l35i7QcbleBwyhfB6RAz2jUTjXi
         VhLwT4Jq3TRC8DMpM/bgvy500GUsiw/zLm8jb2UVOw9a2rB62tswq/8Z6Tn83WkkcjNG
         emGw==
X-Gm-Message-State: AOAM532S/slJWmkCdZqnjlFpu3MecCoMaSYi4bVr1oj2bD/K5YEZ5Vph
        /omYEHcaPHdvpNB0mgxke2Pvvvz89ka5Eiw9kOmPelsr+HzmlYZyx83vtFrQ6nCvk0r6xS1IjLm
        87uGGqgBfyaLVzE2P3xeNW1vt
X-Received: by 2002:a37:2c47:: with SMTP id s68mr9162149qkh.16.1622666640036;
        Wed, 02 Jun 2021 13:44:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9DmxGJijf+tZr1JHPuNxXrGLuOLFd5XCzqXZCrYg42fjCTrLRu7A2TaENxKK4ZHAixnX6UA==
X-Received: by 2002:a37:2c47:: with SMTP id s68mr9162133qkh.16.1622666639733;
        Wed, 02 Jun 2021 13:43:59 -0700 (PDT)
Received: from treble ([68.52.236.68])
        by smtp.gmail.com with ESMTPSA id k23sm639247qkk.71.2021.06.02.13.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 13:43:59 -0700 (PDT)
Date:   Wed, 2 Jun 2021 15:43:57 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Lukasz Majczak <lma@semihalf.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        jgross@suse.com, mbenes@suse.com, linux-kernel@vger.kernel.org,
        upstream@semihalf.com,
        =?utf-8?B?UmFkb3PFgmF3?= Biernacki <rad@semihalf.com>,
        =?utf-8?Q?=C5=81ukasz?= Bartosik <lb@semihalf.com>,
        Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <20210602204357.fq2yahccehf6cqjh@treble>
References: <20210326151159.128534163@infradead.org>
 <20210326151300.320177914@infradead.org>
 <20210329163826.anuqkv5ahvoyus5c@treble>
 <CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 05:51:01PM +0200, Lukasz Majczak wrote:
> Hi Peter,
> 
> This patch seems to crash on Tigerlake platform (Chromebook delbin), I
> got the following error:
> 
> [    2.103054] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
> [    2.110148] pcieport 0000:00:1c.0: pciehp: Slot #7 AttnBtn-
> PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+
> IbPresDis- LLActRep+
> [    2.126754] pcieport 0000:00:1d.0: PME: Signaling with IRQ 123
> [    2.133946] ACPI: \_SB_.CP00: Found 3 idle states
> [    2.139708] BUG: kernel NULL pointer dereference, address: 000000000000012b
> [    2.140704] #PF: supervisor read access in kernel mode
> [    2.140704] #PF: error_code(0x0000) - not-present page
> [    2.140704] PGD 0 P4D 0
> [    2.140704] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [    2.140704] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G     U
>   5.13.0-rc1 #31
> [    2.140704] Hardware name: Google Delbin/Delbin, BIOS
> Google_Delbin.13672.156.3 05/14/2021
> [    2.140704] RIP: 0010:cpuidle_poll_time+0x9/0x6a
> [    2.140704] Code: 44 00 00 85 f6 78 19 55 48 89 e5 48 8b 05 16 44
> 44 01 4c 8b 58 40 4d 85 db 5d 41 ff d3 66 90 00 c3 0f 1f 44 00 00 55
> 48 89 e5 <48> 8b 46 20 48 85 c0 75 56 4c 63 87 28 04 00 00 b8 24 f49
> [    2.140704] RSP: 0000:ffffffff9cc03ea8 EFLAGS: 00010282
> [    2.140704] RAX: 0000000000008e7d RBX: ffffffff9cc1c5fd RCX: 000000007f894e5a
> [    2.140704] RDX: 000000007f894d4f RSI: 000000000000010b RDI: 0000000002fa1cf6
> [    2.140704] RBP: ffffffff9cc03ea8 R08: 0000000000000000 R09: 00000000ca948246
> [    2.140704] R10: 0000000000000000 R11: ffffffff9bf132cb R12: 0000000000000003
> [    2.140704] R13: ffffbbfdffc21960 R14: 0000000000000000 R15: ffffffff9cdba638
> [    2.140704] FS:  0000000000000000(0000) GS:ffff928280000000(0000)
> knlGS:0000000000000000
> [    2.140704] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.140704] CR2: 000000000000012b CR3: 000000027e414001 CR4: 0000000000770ef0
> [    2.140704] PKRU: 55555554
> [    2.140704] Call Trace:
> [    2.140704]  do_idle+0x175/0x1f6
> [    2.140704]  cpu_startup_entry+0x1d/0x1f
> [    2.140704]  start_kernel+0x3be/0x420
> [    2.140704]  secondary_startup_64_no_verify+0xb0/0xbb

Assuming I'm looking at the right code, this is weird.

cpuidle_poll_time()'s only caller is poll_idle(), which isn't even
listed in the stack trace.  Maybe the function before
cpuidle_poll_time() fell through into it somehow.  Or execution got
otherwise hosed.  That would also explain the bad function argument.

In addition to the data Peter requested, it would also be interesting to
see the disassembly of do_idle() with objdump -dr, to see which function
got called before it went off the rails.

-- 
Josh

