Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA16337998
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCKQjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhCKQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:38:47 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF3EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:38:46 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id 7so2708497wrz.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yFCLdkcIPHEXVl9nfC7LpMBjtxC1zgi+0L0v4BFgsLM=;
        b=iCsNhwwEc5OoPVgWe9+Kpqa8J8Ft05CaYrxBkCYKDCMSaLF5MKCxUEC41tYzRK4FcR
         DFYIwCovhedVKusycW0XQ5VG6xVjNbfSdrzWURhrarHCO8/28t554XshJY8Tb0QyVBKo
         GLUHW0Sl0C9r6JEVaXK6v+jx5yrwzAsCbIRXW5RYDh0dyY5CrjoYqkB3p45DbsufYfj5
         frMgpS1MZaLpoQlRhTCUZrAfuBM7Ydi5o6rDUtwJyMxLbhgCftXh6gcEhWitlT4RiFjJ
         pGmyc9xuP8BApBQD9dz+F6ZTUq8xMmjjx8vj53rb/cCfHmIPh+fSx9norfrcKabe47mw
         nVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yFCLdkcIPHEXVl9nfC7LpMBjtxC1zgi+0L0v4BFgsLM=;
        b=Ouslpoxib4gLW4n/o4k3fIHh0i+X0vQglAAAT0RX+A0xV6ZPrhu7+JCEVK3+vDShG5
         YfuFNS2/mg26tBzwPJsAr6ep51TXG7qW2Mg8ak4GXnofVnjYgqBjay+IuKbZAE+jzgPc
         yuzZLKeJgh0wrZLWZkeYjzxysy2iRcgLDtlRRp4jfrJ9KQmEL2p0jlMdePjLTosc2e1Y
         us75q6FojG4Rv8TY2lAkYKeLJHQirgLJHZq75PD8X3m6DGLKrGLzreu2CZ1zqZQq60V9
         8Wmc5ROheLatwh/zXKg97V2leAfbtNtiU4J1AGECvn0wT//+BwXpaqeZ+/qbWJ7f7Bxd
         S8nQ==
X-Gm-Message-State: AOAM530b9JfYQrajYGzMSiRENQZts09qZuCmtlF7J4Ai0i7UZbf5Qox9
        Unn4p4uWf5Ka0z5N+uzUX9E=
X-Google-Smtp-Source: ABdhPJykPVwshBFk1M6SppKQ42T8P9hCwYZqH30RCS8pk7Rm4YErHGOQX4YXMIhhF00hIOMuWP9wSQ==
X-Received: by 2002:adf:cf0b:: with SMTP id o11mr9905486wrj.310.1615480725568;
        Thu, 11 Mar 2021 08:38:45 -0800 (PST)
Received: from agape.jhs ([151.46.184.30])
        by smtp.gmail.com with ESMTPSA id l8sm4743382wrx.83.2021.03.11.08.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 08:38:45 -0800 (PST)
Date:   Thu, 11 Mar 2021 17:38:40 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: align comments
Message-ID: <20210311163838.GA5244@agape.jhs>
References: <20210310153717.GA5741@agape.jhs>
 <20210310174830.GM2087@kadam>
 <379d4b58d82be1f871924c89e0db7bab367564fb.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <379d4b58d82be1f871924c89e0db7bab367564fb.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 01:15:34AM -0800, Joe Perches wrote:
> On Wed, 2021-03-10 at 20:48 +0300, Dan Carpenter wrote:
> > You need to have a space character after the '*'.
> 
> Perhaps YA checkpatch test...
> ---
>  scripts/checkpatch.pl | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index f42e5ba16d9b..0de553d52605 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3876,6 +3876,21 @@ sub process {
>  			}
>  		}
>  
> +# Independent comment lines should have a space after the comment initiator
> +		if ($line =~ /^\+[ \t]*($;+)/) {		#leading comment
> +			my $comment = trim(substr($rawline, $-[1], $+[1] - $-[1]));
> +			if ($comment =~ m{^(/\*|\*/|\*|//)(.*)}) {
> +				my $init = $1;
> +				my $rest = $2;
> +				if ($init =~ m{^(?:/\*|\*|//)$} &&
> +				    $rest ne '' &&
> +				    $rest !~ /^[\s\*=\-]/) {
> +					WARN("COMMENT_STYLE",
> +					     "Comments generally use whitespace after the comment initiator\n" . $herecurr);
> +				}
> +			}
> +		}
> +
>  # check for missing blank lines after struct/union declarations
>  # with exceptions for various attributes and macros
>  		if ($prevline =~ /^[\+ ]};?\s*$/ &&
> 

Thank you Joe, it works fine. I've just tested it for my particular need but 
I hope it's going to be merged in the mainline if other people will find it useful:)

