Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D6C440630
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 02:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhJ3AKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 20:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJ3AKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 20:10:24 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CC0C061570;
        Fri, 29 Oct 2021 17:07:55 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id s1so9312591qta.13;
        Fri, 29 Oct 2021 17:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qERu0voFr9suiiWnQnSGc4TpiaTJ1ubRw/T4rhUUEPI=;
        b=ivGMDFI435kbxGVOiM/mRzp9xBPVeFXNCEaTVAjKfBP2o/363zLH68vJTBu44B4zIF
         Dbu2/pA4gb8IgfntswVbl6UCARhM8EjTogG7SSxbwGGrAACSTZK/MrgXsJdF1zOONTWd
         drOVxoilbYwzfhI3wPgbXUKuJoO7P3zZcZL7F5pQOIbmQJVmNxxjjkRHfHULixJCmlBx
         KNZ95j9XD9BgmqrCuufcZfNPo8P2dAOJ1+YgFSo7CMYSbIOkn5MjF87mEMGXu5XekV05
         S7e160dMQ+GyfI5FJBSg5Q1RDj2eDjVJdnuPNP/XOfGJqJJ3Uebt03H0pbWAdW2XM2hh
         ypxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qERu0voFr9suiiWnQnSGc4TpiaTJ1ubRw/T4rhUUEPI=;
        b=KV8a/4qctUZmtvTWWk7+9+zDR/Y/06VgIuBNJqTaAiHzDPe88t2Np0c9xfG6S44crV
         bIKa1itEPu1qNHJvsgq1OWQJBn9DI2YqJ1CprOhFnc93MdgFl412SLY6cGWhoNWZqS90
         VfwWVRSvwtwUVKo/qT3eZNJ2KKtbpELpCEGOfWS8Ad5qejUfKroRIKvqr5fhXMGQPNkh
         mbmnqtujhJMGjDaAfhiTsMR41q8/CqXniFw0mRSVPBK4SoU4S9UsHDRIiUk9ygiW0gMb
         EokMT1H5Xd10rbaSDE6rpEqFBx21X+Bcn2DAzA6oATFPekQhcD2BeIrghOLR7hmv3FOO
         UUXw==
X-Gm-Message-State: AOAM531pdIDPisQ3lyhIssQySx+Iyx0ucJ6DJhLXE7AS5Ck2efTp/pyM
        xM4uqKTKqmRjLIYhWjKoJxM=
X-Google-Smtp-Source: ABdhPJz3TVx3XLNS0Gzsr/FLZvzDSL7+0sRDMUf0+A2HSgJc09gW5kHG2q+4Dr1tAVvLmaTrNx1ylw==
X-Received: by 2002:ac8:10a:: with SMTP id e10mr15181091qtg.406.1635552474549;
        Fri, 29 Oct 2021 17:07:54 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id g11sm5812614qko.31.2021.10.29.17.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 17:07:54 -0700 (PDT)
Subject: Re: Fwd: [Bug 214867] New: UBSAN: shift-out-of-bounds in
 drivers/of/unittest.c:1933:36
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Erhard F." <erhard_f@mailbox.org>
References: <bug-214867-211671@https.bugzilla.kernel.org/>
 <c474a371-b524-1da8-4a67-e72cf8f2b0f7@gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <a83c3242-acc9-03da-d559-04e4baba75ca@gmail.com>
Date:   Fri, 29 Oct 2021 19:07:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c474a371-b524-1da8-4a67-e72cf8f2b0f7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/21 6:57 PM, Frank Rowand wrote:
> 
> Reported in bugzilla, forwarding to the mail lists and maintainers.
> 
> -Frank
> 
> 
> -------- Forwarded Message --------
> Subject: [Bug 214867] New: UBSAN: shift-out-of-bounds in drivers/of/unittest.c:1933:36
> Date: Fri, 29 Oct 2021 13:59:02 +0000
> From: bugzilla-daemon@bugzilla.kernel.org
> 
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=214867
> 
>             Bug ID: 214867
>            Summary: UBSAN: shift-out-of-bounds in
>                     drivers/of/unittest.c:1933:36
>            Product: Platform Specific/Hardware
>            Version: 2.5
>     Kernel Version: 5.15-rc7
>           Hardware: PPC-64
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PPC-64
>           Assignee: platform_ppc-64@kernel-bugs.osdl.org
>           Reporter: erhard_f@mailbox.org
>                 CC: bugzilla.kernel.org@frowand.com
>         Regression: No
> 
> Created attachment 299361
>   --> https://bugzilla.kernel.org/attachment.cgi?id=299361&action=edit
> kernel dmesg (kernel 5.15-rc7, Talos II)
> 
> UBSAN catches this at boot on my Talos II.
> 
> [...]
> ### dt-test ### EXPECT / : GPIO line <<int>> (line-C-input) hogged as input
> ================================================================================
> UBSAN: shift-out-of-bounds in drivers/of/unittest.c:1933:36
> shift exponent -1 is negative
> CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc7-TalosII #1
> Call Trace:
> [c000000004163700] [c0000000008ffaa8] .dump_stack_lvl+0xa4/0x100 (unreliable)
> [c000000004163790] [c0000000008fb46c] .ubsan_epilogue+0x10/0x70
> [c000000004163800] [c0000000008fb270]
> .__ubsan_handle_shift_out_of_bounds+0x1f0/0x34c
> [c000000004163910] [c000000000ad94a0] .of_unittest_untrack_overlay+0x6c/0xe0
> [c0000000041639a0] [c000000002098ff8] .of_unittest+0x4c50/0x59f8
> [c000000004163b60] [c000000000011b5c] .do_one_initcall+0x7c/0x4f0
> [c000000004163c50] [c00000000200300c] .kernel_init_freeable+0x704/0x858
> [c000000004163d90] [c000000000012730] .kernel_init+0x20/0x190
> [c000000004163e10] [c00000000000ce78] .ret_from_kernel_thread+0x58/0x60
> ================================================================================
> ### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if
> overlay removed, property: /testcase-data-2/substation@100/status
> [...]
> 

Further comment in Bugzilla are:

----------  comment 1:

 Erhard F. 2021-10-29 14:00:20 UTC

Created attachment 299363 [details]
kernel .config (kernel 5.15-rc7, Talos II)

 # lspci 
0000:00:00.0 PCI bridge: IBM POWER9 Host Bridge (PHB4)
0000:01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Turks XT [Radeon HD 6670/7670]
0000:01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Turks HDMI Audio [Radeon HD 6500/6600 / 6700M Series]
0001:00:00.0 PCI bridge: IBM POWER9 Host Bridge (PHB4)
0001:01:00.0 Non-Volatile memory controller: Phison Electronics Corporation Device 5008 (rev 01)
0002:00:00.0 PCI bridge: IBM POWER9 Host Bridge (PHB4)
0003:00:00.0 PCI bridge: IBM POWER9 Host Bridge (PHB4)
0003:01:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB 3.0 xHCI Host Controller (rev 02)
0004:00:00.0 PCI bridge: IBM POWER9 Host Bridge (PHB4)
0004:01:00.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0004:01:00.1 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0005:00:00.0 PCI bridge: IBM POWER9 Host Bridge (PHB4)
0005:01:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge (rev 04)
0005:02:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 41)
0030:00:00.0 PCI bridge: IBM POWER9 Host Bridge (PHB4)
0031:00:00.0 PCI bridge: IBM POWER9 Host Bridge (PHB4)
0032:00:00.0 PCI bridge: IBM POWER9 Host Bridge (PHB4)
0033:00:00.0 PCI bridge: IBM POWER9 Host Bridge (PHB4)


----------  comment 2:

[reply] [−] Comment 2 Arnd Bergmann 2021-10-29 14:06:48 UTC

This is the function that triggers it:

static void of_unittest_untrack_overlay(int id)
{
        if (overlay_first_id < 0)
                return;
        id -= overlay_first_id;
        if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS))
                return;
        overlay_id_bits[BIT_WORD(id)] &= ~BIT_MASK(id);
}

My guess is that 'id' is negative here, which means it fails to tigger the
WARN_ON() but ends up still being out of range.

Can you try changing it to 'unsigned int id'?


----------  More info from me, but I did not comment in bugzilla

line 1933 is the final line of of_unittest_untrack_overlay()
(see comment 2 for context):

1933         overlay_id_bits[BIT_WORD(id)] &= ~BIT_MASK(id);
