Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7477333EEC5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhCQKu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:50:26 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:43761 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230433AbhCQKtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:49:55 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Mar 2021 06:49:55 EDT
Received: from cust-3a8def63 ([IPv6:fc0c:c1c9:903d:e9b4:326e:d2bd:718e:17cc])
        by smtp-cloud9.xs4all.net with ESMTPSA
        id MTdQlABuVGEYcMTdRlNA8I; Wed, 17 Mar 2021 11:42:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1615977767; bh=wRN/sAzpgNLiAXrQ4jtqD6y/vMrDu8E+D0w/yGNeGt8=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From:
         Subject;
        b=j8/Do3ggVxTyvLGjFXZmhNn7SxZj4dtr5KI6gg7UtAI5UWHFY5Yni8tQ/EY1dcP2e
         ts6Sw2OD6aKnYu7Pdrs1+pg9WSbYrF6bbbMIbBO5C2E3YnlVoLb3DQPrWa9aXS7wjv
         wLL5l/9Rh8CyQmLX2XYtQh8/mC3E4LgTEBSr+1P3QRYtgMSQtdw2V5KvevAJ/ROo3J
         mxm2MU/FfMri+2UtF6xlWP3xU2n9CrhDPo7Mk1fE9gAOY/i8JdnsFabV9iSQak26/s
         8nm81V8Beo36YfUnBgrnSV4Raw/V3u8Sy3x7hoToxg6EenPB0Nqt9Rle4LGxO2qp2U
         C9qF/9PBDZJBg==
Date:   Wed, 17 Mar 2021 11:42:35 +0100
From:   Jeroen Roovers <jer@xs4all.nl>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     James.Bottomley@HansenPartnership.com, deller@gmx.de,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] parisc: math-emu: Few spelling fixes in the file fpu.h
Message-ID: <20210317114235.033dc0ef@del.jer>
In-Reply-To: <20210317103251.3526940-1-unixbhaskar@gmail.com>
References: <20210317103251.3526940-1-unixbhaskar@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfN0yrNPvjFE3tBN6Tm5UhhDrjwOGiWf8N3qfO7gdo6ftzNoN56hjcqdrPKl71MXdxW7QC2A9q6RHNXpSVpvJOVgZmv3q4oviMhLBQmztl9oCXiXomoK7
 QUCB68u90DmJfFBn0mTN7Ayms9m1JmINzCvZInencJ4qjAxk39CVxXVJJiQkm3TUDVXEHmev1WTMZxageaEB0pTO4MPGR7LwlIcRH8GlInrWU+uybgCLYgAJ
 EPsUSMEDKOyQydd64ojTti2CvIH0/K1+xj4Mnu7yyJSm4DzW3uPrR4mwgNFTRoSvHw68rrJeaemYDDvc//AaHqJARjx2cHqnG1UBKicZoZVuYdm4LaxB9a7D
 zyfcbTTZDI2DlYjfYDctdoDLLqxpMw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 16:02:51 +0530
Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

> s/synopis/synopsis/
> s/differeniate/differentiate/
> s/differeniation/differentiation/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  arch/parisc/math-emu/fpu.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/parisc/math-emu/fpu.h b/arch/parisc/math-emu/fpu.h
> index 853c19c03828..1f313bc38beb 100644
> --- a/arch/parisc/math-emu/fpu.h
> +++ b/arch/parisc/math-emu/fpu.h
> @@ -12,7 +12,7 @@
>   *      @(#)	pa/fp/fpu.h		$Revision: 1.1 $
>   *
>   *  Purpose:
> - *      <<please update with a synopis of the functionality provided
> by this file>>
> + *      <<please update with a synopsis of the functionality
> provided by this file>> *
>   *
>   * END_DESC
> @@ -50,9 +50,9 @@
>  #define EMULATION_VERSION 4
> 
>  /*
> - * The only was to differeniate between TIMEX and ROLEX (or PCX-S
> and PCX-T)
> + * The only was to differentiate between TIMEX and ROLEX (or PCX-S
> and PCX-T)

Might as well fix "only [change] was to" here.

>   * is thorough the potential type field from the PDC_MODEL call.  The
> - * following flags are used at assist this differeniation.
> + * following flags are used at assist this differentiation.
>   */
> 
>  #define ROLEX_POTENTIAL_KEY_FLAGS	PDC_MODEL_CPU_KEY_WORD_TO_IO
> --
> 2.30.2
> 


Kind regards,
     jer
