Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E1D34A0B2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 05:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhCZEuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 00:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhCZEu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 00:50:29 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4D2C0613A5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 21:50:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so1909893pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 21:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=doRNGBmntoEt/PlYOTFeUHiq3lxYF7WmCHXEbxgxplc=;
        b=PYhjRCwhYOYFwxnGcPf6k4f8kIBP3W1dsdySyPWBEodIFqO2jn6stlVjCBye46d8zo
         Cw1nIH47FC1jmapmPDR/2VqJHuZOK7otY6Pi+GV7K0tjjmfIi6H5Ozmk+a48LRa6cqTT
         8Kq+CFBgl7wIIIcGJV+AhJwrkDrlmUbOZOcmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=doRNGBmntoEt/PlYOTFeUHiq3lxYF7WmCHXEbxgxplc=;
        b=e7AjtZTZ5EvW2n6Ly7T/e9LdS3lDjmXXOjM1PwceTaVnYeTwsokMZjN0Qsq0gFNjN2
         bq0LVYd8xKbVYbnB6x8DaQ9Ejq2TpxJgfDy3ssxKPKFYF7a8jZJDMvhlIRoOYg/6kw4C
         8U1jBLc9oYUgdm4nMFJydXyPETLyXPgDFb6gSqYPnAwdpegQjXyIe+dzoyftkMAKEoe/
         DDCwhFjx3ipDPAoSYzwSXhDEXRVd9LVXO3+rh4Lh/Xj+W+D9dzkwQRlR7XpzdlUCe39d
         /WOpp0XYVyRBcBv6Z1VX3FAno4UhgjLw0uB0vDyJTtXEguAW0/bteEe76C6HaiUHxtxw
         ewZQ==
X-Gm-Message-State: AOAM532rKtMUdzsJIp9yeG1atifghBw32Wm27PF77aFocv27xhsXOvHW
        Ito/OLmdi2XPDXz2ECRAJJ73FP2mP2qV1g==
X-Google-Smtp-Source: ABdhPJxG+9GcTlXyCus5/cjAO0dCGJpxpz5BNInn21i8CJC3rmBGaJXJbxB5E3UvkNLeJzseuoMzmA==
X-Received: by 2002:a17:902:a610:b029:e6:5eda:c39e with SMTP id u16-20020a170902a610b02900e65edac39emr13600572plq.11.1616734228886;
        Thu, 25 Mar 2021 21:50:28 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-39c5-e677-fdb8-5d64.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:39c5:e677:fdb8:5d64])
        by smtp.gmail.com with ESMTPSA id y8sm7988457pfp.140.2021.03.25.21.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 21:50:28 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] selftests: powerpc: unmark non-kernel-doc comments
In-Reply-To: <20210325200820.16594-1-rdunlap@infradead.org>
References: <20210325200820.16594-1-rdunlap@infradead.org>
Date:   Fri, 26 Mar 2021 15:50:25 +1100
Message-ID: <87a6qq8qni.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Drop the 'beginning of kernel-doc' notation markers (/**)
> in places that are not in kernel-doc format.

This looks good to me. Arguably we don't need the comments at all, but
it doesn't seem to hurt to keep them.

checkpatch is OK with the entire file, so there's nothing else we'd
really want to clean up while you're doing cleanups.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel

>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  tools/testing/selftests/powerpc/tm/tm-trap.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- linux-next-20210323.orig/tools/testing/selftests/powerpc/tm/tm-trap.c
> +++ linux-next-20210323/tools/testing/selftests/powerpc/tm/tm-trap.c
> @@ -66,7 +66,7 @@ void trap_signal_handler(int signo, sigi
>  	/* Get thread endianness: extract bit LE from MSR */
>  	thread_endianness = MSR_LE & ucp->uc_mcontext.gp_regs[PT_MSR];
>  
> -	/***
> +	/*
>  	 * Little-Endian Machine
>  	 */
>  
> @@ -126,7 +126,7 @@ void trap_signal_handler(int signo, sigi
>  		}
>  	}
>  
> -	/***
> +	/*
>  	 * Big-Endian Machine
>  	 */
>  
