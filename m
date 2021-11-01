Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E53441B62
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 13:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhKAM45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 08:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhKAM44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 08:56:56 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727F5C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 05:54:23 -0700 (PDT)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mhWpR-00024G-VB; Mon, 01 Nov 2021 13:54:22 +0100
Message-ID: <ef02dfde-a3af-af65-2749-eae9f4b1e367@leemhuis.info>
Date:   Mon, 1 Nov 2021 13:54:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Thorsten is tracking regression again and could need a little
 help (was: Re: Linux 5.15)
Content-Language: en-BS
To:     Idzibear <Idzibear@kaputniks.org>
Cc:     linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        torvalds@linux-foundation.org
References: <a365ffb9-a4d2-b1d7-7cd7-dd9d7039e04e@leemhuis.info>
 <c11d94b4-1701-4e26-efd1-42038342c4aa@kaputniks.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <c11d94b4-1701-4e26-efd1-42038342c4aa@kaputniks.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1635771263;8841dc75;
X-HE-SMSGID: 1mhWpR-00024G-VB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.11.21 12:46, Idzibear wrote:
> https://www.reddit.com/r/linux/comments/qjyxso/the_515_kernel_has_been_released/hitiykt/
> 
> I just noticed something strange. I'm experimenting with some repurposed
> Desktop-PC to make it maybe into a homelab server.
> 
> I ran Kernel 5.14.10, and I had an idle usage of 19-22 watts. Updated to
> 5.15 and it went to 27-29 watts. Went back to 5.14.10 and it went down
> to 19-22 watts again. WTF?

thx for the report, yeah, sound like a regression. With that much of a
difference I'd suspect it's something that can consume a lot of power if
not sleeping properly, for example the CPU or the GPU. But that's just a
shot in the dark and it's hard to help here with debugging from a
distance (especially without a list of hardware components). With a bit
of luck tools like powertop might be able to debug this (check if the
CPU is sleeping well). But a 'git bisect', like already suggested
Gregkh, would be really the best to find the change that's causing this.

Ciao, Thorsten

#regzbot ^introduced: v5.14..v5.15
#regzbot title: idle power increased from ~20 to ~28 watts
