Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C353DFD8F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 11:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbhHDJAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 05:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbhHDJAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 05:00:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCFBC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 02:00:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id p21so2553579edi.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 02:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z4l8UKBHFl733XkApxjN+RwM5wCVVn3XT2rD4WcVZ34=;
        b=C0JyUPdPZQ0vaBPxYcLmU7w7lGAHp8rXN59zisPk/hc3LGpkILEtfzXdHKp/+moiMn
         Nm8gSTrv50IbojdKAD1E6gME3VP9nxen3gCiZJP6pFO34mQcwrCxTEPhp3FSFFqY1nVj
         /vm6S4LiFiCeKUaWcWuFMTPwnQVjbQQnUPScsCeJgdKuYFzaAtNCx20AIAg7SuwjAbEL
         XBFm5ih4uc55nyMUYpONO6VSEvI0adziUJ0u6I9F+27VswlBudmZfdgh9WvUXoRbegEo
         zUXMrSiq6ZuB8IWKsTTLm+BcRKUCRf8l1JUreDneOiUieC1n+ox5pUwwiitopImD8W9m
         4t6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z4l8UKBHFl733XkApxjN+RwM5wCVVn3XT2rD4WcVZ34=;
        b=RHtvu/Y91bVgMsa0wdNEWnron102r1ofY0n3x1g4L3+3pUXH3gsEiCZ6E6S89/WEDy
         fSbOA/S/KhyYDHsb58b0zS6YG1SXI6fiqX+t3AfofKAgBPX8ITiklbSaztn8KxGMD43Y
         a5Ej+B0GDUt+AwLSIiHmBuEvn70YP7SgZ3biaYGshms++4D8fFSn0yLBPr591LcLtlYf
         kHGorhTdf6cbwCpm80er16WkPITjJbYDiEeG6cyvcOhgulVzWxOQCjfde67Agrt7+wzL
         6Te/GLwASpaeMgO2zzQEbsOVktdaRNyyT5rBFeE23iHEiMkQ6rEQOz0MA31B9Zg9EFOx
         NkJA==
X-Gm-Message-State: AOAM531yehag2e3wFHzRazmprN5/4GcOLgut8dxCaoegikJ/KrXBbZpP
        UofK4sdaY+Jl0VDJfHUCCfg=
X-Google-Smtp-Source: ABdhPJw0sI/s4GsRa8/Ii2zPBhn2K+6hhAUNO4hteg0yrx7ZChLg331KshhoHJWSBO2hN0iTN4a/Ig==
X-Received: by 2002:aa7:c816:: with SMTP id a22mr8875648edt.202.1628067627082;
        Wed, 04 Aug 2021 02:00:27 -0700 (PDT)
Received: from localhost.localdomain (host-82-51-42-96.retail.telecomitalia.it. [82.51.42.96])
        by smtp.gmail.com with ESMTPSA id ha26sm467528ejb.87.2021.08.04.02.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 02:00:26 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Fix different base types in assignments and parameters
Date:   Wed, 04 Aug 2021 11:00:25 +0200
Message-ID: <4550286.edLFIWPnRF@localhost.localdomain>
In-Reply-To: <20210804075930.GD1931@kadam>
References: <20210730181452.23062-1-fmdefrancesco@gmail.com> <20210804075930.GD1931@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 4, 2021 9:59:30 AM CEST Dan Carpenter wrote:
> On Fri, Jul 30, 2021 at 08:14:52PM +0200, Fabio M. De Francesco wrote:
> >  static inline void __nat25_generate_ipx_network_addr_with_socket(unsigned 
char
> >  *networkAddr,> 
> > -				unsigned int *ipxNetAddr, 
unsigned short *ipxSocketAddr)
> >
> > [...]
> >
> Here is another bug which was obscured/caused by the union.
> 
> 	addr.f0 = be16_to_cpu(*ipxSocketAddr);
> 
> The addr.f0 variable is an int.  On big endian systems only the last two
> bytes are set:
> 
> 	memcpy(networkAddr+5, addr.f1, 2);
> 
> So this is the equivalent of:
> 
> 	memset(networkAddr+5, 0, 2);
> 
> regards,
> dan carpenter

Dear Dan,

Thanks, for pointing me to one more bug I introduced with this patch. The most 
of them were due to me forgetting that memcpy() takes pointers. For some 
reason I was thinking it takes values, therefore I put in it a lot of 
unnecessary and faulty complications.

I'd like to make a new patch, a better one (I hope), without unneeded unions 
without the other wrong lines that are in the commit 56febcc2595e.

However, I see that Greg hasn't yet had the time to revert the above commit, 
so I don't know how to make a new patch.

I mean: I could (1) either wait for Greg to revert it and then to fix the 
sparse warnings with a new patch, or (2) I could fix the bugs I made in 
56febcc2595e without having it reverted. I would prefer the solution (2) with 
a "Fixes: 56febcc2595e (...)" and a "Reported-by: Dan Carpenter <...>" tags.

What is the best solution between the two above?

Thanks,

Fabio



