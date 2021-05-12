Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A43C37EFE4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350335AbhELXgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 19:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350615AbhELXHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 19:07:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEC5C061247
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 16:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Wus+uDq6d9uOGlWVOipz3i3wnOeWL+33/iETe3h8tcc=; b=ffUTIErUC5IZUdOlJ3vOqCBqhk
        wHm7f4vgLkydNAewoQ76SuyeYYaWxWaAIAIe6KlnnWihVIE3M8pQJuom6mxN5IiF/uP6lF9LiapyM
        IZtJ4X2TCH2DY5anX7fULW05A2SYyKWUwefczteBvLgb0bwret+oxhaAS2g3uLv6bFY4DTsuUhWaN
        rI+Spq5q/JL2EVhv4o1Nbfr4l+xU88XYlPefAQ8kWsR9L8oTzTCg1A/u28cxMtAo5rokQyV01y000
        6/PrRwHnAkWDPbPT9eh/rbel80T//w9PNYVtZ9uHVpCoXV27Lfcq4e8nAuRaqOI6G4dAHfbCYj6LW
        KO7xhdXA==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgxq3-00AtXk-Os; Wed, 12 May 2021 23:00:23 +0000
Subject: Re: [PATCH v2] init: Print out unknown kernel parameters
To:     Andrew Halaney <ahalaney@redhat.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@suse.de>
References: <20210511211009.42259-1-ahalaney@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cbd3c07e-9dae-44b2-761e-653bd8d0e930@infradead.org>
Date:   Wed, 12 May 2021 16:00:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210511211009.42259-1-ahalaney@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/21 2:10 PM, Andrew Halaney wrote:
> It is easy to foobar setting a kernel parameter on the command line
> without realizing it, there's not much output that you can use to
> assess what the kernel did with that parameter by default.
> 
> Make it a little more explicit which parameters on the command line
> _looked_ like a valid parameter for the kernel, but did not match
> anything and ultimately got tossed to init. This is very similar to the
> unknown parameter message received when loading a module.
> 
> This assumes the parameters are processed in a normal fashion, some
> parameters (dyndbg= for example) don't register their
> parameter with the rest of the kernel's parameters, and therefore
> always show up in this list (and are also given to init - like the
> rest of this list).
> 
> Another example is BOOT_IMAGE= is highlighted as an offender, which it
> technically is, but is passed by LILO and GRUB so most systems will see
> that complaint.
> 
> An example output where "foobared" and "unrecognized" are intentionally
> invalid parameters:
> 
>   Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.12-dirty debug log_buf_len=4M foobared unrecognized=foo
>   Unknown command line parameters: foobared BOOT_IMAGE=/boot/vmlinuz-5.12-dirty unrecognized=foo

Hi Andrew,
What order is the list of unknown command line parameters listed in?


> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> 
> It's my first time sending a v2 via email, please let me know if I've
> messed that up in anyway. I decided it wasn't worth the effort to do
> "autocorrect" functionality Borislav was pondering about, feel free to
> disagree on that if you have a strong opinion.
> 
> v2: make output on a single line, make function static and __init,
>     include example output in commit message
> 
>  init/main.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)


Thanks.
-- 
~Randy

