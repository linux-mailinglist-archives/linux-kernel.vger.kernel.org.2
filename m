Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962C04405F5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 01:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhJ2X7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 19:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhJ2X7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 19:59:54 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB7BC061570;
        Fri, 29 Oct 2021 16:57:25 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id bl14so10984274qkb.4;
        Fri, 29 Oct 2021 16:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:references:to:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3KbvN+2PJvSq+0CefMz33c78Os83xV0bDXtnD0xUFVU=;
        b=iOd0SRqmW8ANsZwlIQEPEi3y9OMrzCaajPqCmCNkRSkVNxVsP795J0OziZOoMck81H
         56dysg0e6c+5LI2KRhskLmYWX+xyYSH9UbgBxYdJBFc5qpoO1l2QwpCHkhaceni4K+M6
         asqARqiI8fUsigiy+tLbwuVF8wDl8qoMR9/RtDryan42u7yKrrSnt5MBxmqwSxhoX9xb
         8kzNnMX40+08pEIeVPPat2395v/gCfallrM6v1/Cqq89bRuHRqJ2m3TOaUxca5kzzG2P
         /KT8eIDfuEfAC8q05QQJ2log3c8tmATwZdQCA5oYUCPQU08BCLlWFWvI7LO/2MhN1ySi
         bVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:references:to:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3KbvN+2PJvSq+0CefMz33c78Os83xV0bDXtnD0xUFVU=;
        b=7sx1n+0nL0EY9zUbD0Flg1kvZP5WitHK7VLyUjP8/Iyi56rN1GbepbAEY6TyTOTyrg
         n+HdhD7MrhA9spJBBwGwj0++9uMwFSCNWuKIwcuaUZTo0WeqYZi3zH7MROcGaei5O/6V
         3McbfBPSXrOKwYHTDWlj5FbbvZ36yaFfS+80anElowG4f+0m/jH8NXN3nAyZqRryf7sC
         wm6XKEsLdhUE7d3SVVRp2e5/IaeQnQx0Wz1JcKiP9lMr2EZIDEZJhGOVbA8iFco3eh75
         F6p76SjRlB4W/meLzUviJxtDAQQUZgS72ZYupTQ8ryUmK25BlzvT37M8M7JMlzabFIKE
         pZjQ==
X-Gm-Message-State: AOAM531yL3sRb4r+ReMaagrJskPMI4HvT+Uql6p8YV60pIgoNVI9cIfo
        IbkN7mpS5gvragL5Z3zkRMZfryWALBs=
X-Google-Smtp-Source: ABdhPJyrwtsQ+tLDumVxBeeMbR3YLW4VuguFkggMI1LT3xtaiPYxO0+0RKoNi09siq4/1uNnf5KjNg==
X-Received: by 2002:a37:88c2:: with SMTP id k185mr11789362qkd.227.1635551844368;
        Fri, 29 Oct 2021 16:57:24 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id g1sm4006810qtb.4.2021.10.29.16.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 16:57:24 -0700 (PDT)
Subject: Fwd: [Bug 214867] New: UBSAN: shift-out-of-bounds in
 drivers/of/unittest.c:1933:36
References: <bug-214867-211671@https.bugzilla.kernel.org/>
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Erhard F." <erhard_f@mailbox.org>
From:   Frank Rowand <frowand.list@gmail.com>
X-Forwarded-Message-Id: <bug-214867-211671@https.bugzilla.kernel.org/>
Message-ID: <c474a371-b524-1da8-4a67-e72cf8f2b0f7@gmail.com>
Date:   Fri, 29 Oct 2021 18:57:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <bug-214867-211671@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Reported in bugzilla, forwarding to the mail lists and maintainers.

-Frank


-------- Forwarded Message --------
Subject: [Bug 214867] New: UBSAN: shift-out-of-bounds in drivers/of/unittest.c:1933:36
Date: Fri, 29 Oct 2021 13:59:02 +0000
From: bugzilla-daemon@bugzilla.kernel.org


https://bugzilla.kernel.org/show_bug.cgi?id=214867

            Bug ID: 214867
           Summary: UBSAN: shift-out-of-bounds in
                    drivers/of/unittest.c:1933:36
           Product: Platform Specific/Hardware
           Version: 2.5
    Kernel Version: 5.15-rc7
          Hardware: PPC-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PPC-64
          Assignee: platform_ppc-64@kernel-bugs.osdl.org
          Reporter: erhard_f@mailbox.org
                CC: bugzilla.kernel.org@frowand.com
        Regression: No

Created attachment 299361
  --> https://bugzilla.kernel.org/attachment.cgi?id=299361&action=edit
kernel dmesg (kernel 5.15-rc7, Talos II)

UBSAN catches this at boot on my Talos II.

[...]
### dt-test ### EXPECT / : GPIO line <<int>> (line-C-input) hogged as input
================================================================================
UBSAN: shift-out-of-bounds in drivers/of/unittest.c:1933:36
shift exponent -1 is negative
CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc7-TalosII #1
Call Trace:
[c000000004163700] [c0000000008ffaa8] .dump_stack_lvl+0xa4/0x100 (unreliable)
[c000000004163790] [c0000000008fb46c] .ubsan_epilogue+0x10/0x70
[c000000004163800] [c0000000008fb270]
.__ubsan_handle_shift_out_of_bounds+0x1f0/0x34c
[c000000004163910] [c000000000ad94a0] .of_unittest_untrack_overlay+0x6c/0xe0
[c0000000041639a0] [c000000002098ff8] .of_unittest+0x4c50/0x59f8
[c000000004163b60] [c000000000011b5c] .do_one_initcall+0x7c/0x4f0
[c000000004163c50] [c00000000200300c] .kernel_init_freeable+0x704/0x858
[c000000004163d90] [c000000000012730] .kernel_init+0x20/0x190
[c000000004163e10] [c00000000000ce78] .ret_from_kernel_thread+0x58/0x60
================================================================================
### dt-test ### EXPECT \ : OF: overlay: WARNING: memory leak will occur if
overlay removed, property: /testcase-data-2/substation@100/status
[...]

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.
