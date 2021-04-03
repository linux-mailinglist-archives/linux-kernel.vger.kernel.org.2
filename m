Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD84353598
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 23:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbhDCVhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 17:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbhDCVha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 17:37:30 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E583C061756
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 14:37:26 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gv19-20020a17090b11d3b029014c516f4eb5so2299727pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 14:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0pyulBQT42IIN7dRsVl/51XubTD3TLWON0kNbxutpX8=;
        b=O8xL1Hz4M+gt3P4i3IUiIWWJru4S2gC3rgZdf8bupMX1Tj9xJSBDcxCusBbmnWyrQo
         7+I6jL4uhHU8cnrhb4+34EGGk5PJvO84lYBUY7xn61M33J25+t5TzYNPtsKBtIEXjys0
         TEaJNC0l2L3XO8OMLCuhgdRp8OtGBesZDUxS6G1LgQmj5AS3kaZQ38RHK1q47PB0U2uT
         Ktsaa7jgD0UklJu9UBS+Td+BzsKi6WYW0VuArxNZ9gfvoiTsbhPzjyxnchFJl1fNZjiP
         V4s120MZqcPIgIv9SKdDQVLevajwiIkMJEXyySqLJ4CJ7k9cI/DMihJcxHaND/MLAqeB
         sAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0pyulBQT42IIN7dRsVl/51XubTD3TLWON0kNbxutpX8=;
        b=dBaCfOmxlQZRpfC5rO9vtFvxk1Y6XDxfA/V1HwMS0BfWBh7xOGbnjfyqum6y5+hQF3
         dvJT4dg3Wxt7wFdUhhwJiOtqGoEyDNp2eQmmAyaJ3zyRKCwBIfbA7LOqtWyIdbgqDKBF
         VEPN1WB+VjSspVG2Ke1cD56QmpLkEx2z2/JnFocr9AXJMFW0JVmitOd+lsw0pnSyeXow
         8usZTVLdujgryo+uHvSmbWXWF4sBI6dY1erAqq2NkGgNRW8wp+yo+XKHxXs9Fw/NXp3x
         VcblahsHPcviQHra0kpqhGLftsoq6AFUdceypoIOIWTv1FpM8s0lCl9gYpv+PqM12uW9
         9nQw==
X-Gm-Message-State: AOAM530TJ2NtaxPbdWg/BCbJ+Sjmxrs4FZ0g4oWghMGKim7reBFKhyCc
        CeYbYm4Bd8TFOJz1oEI0bY8=
X-Google-Smtp-Source: ABdhPJwr1GWqgKYIBwCw4QHof9jXbh+SvEh/H8yrh4qVmKfX3QJJzgmXBRytAxFp72PBEI0jukcwOA==
X-Received: by 2002:a17:903:2309:b029:e7:1063:e6aa with SMTP id d9-20020a1709032309b02900e71063e6aamr18215297plh.52.1617485845616;
        Sat, 03 Apr 2021 14:37:25 -0700 (PDT)
Received: from djbComp (S0106ac202ecb0523.gv.shawcable.net. [70.67.120.89])
        by smtp.gmail.com with ESMTPSA id b10sm11668439pgm.76.2021.04.03.14.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 14:37:25 -0700 (PDT)
Date:   Sat, 3 Apr 2021 14:37:24 -0700
From:   Deborah Brouwer <deborahbrouwer3563@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        insafonov@gmail.com, martin@kaiser.cx, simon.fodin@gmail.com,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8188eu: core: add comma
 within a comment
Message-ID: <20210403213724.GA18745@djbComp>
References: <20210403210930.17781-1-deborahbrouwer3563@gmail.com>
 <alpine.DEB.2.22.394.2104032315200.7875@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2104032315200.7875@hadrien>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2021 at 11:16:16PM +0200, Julia Lawall wrote:
> 
> 
> On Sat, 3 Apr 2021, Deborah Brouwer wrote:
> 
> > Add a comma to separate repeated words in a comment. The comma preserves
> > the meaning of the comment while also stopping the checkpatch warning:
> > WARNING: Possible repeated word: 'very'.
> 
> Thanks.  That is more understandable.  Isn't this a v2?  If so, there
> should be v2 after PATCH and an explanation of the change under the ---
> 
> julia
Hi Julia, no this is not a v2.  I found the same comment, generating the same
error, in a different file.  Since I changed it in
rtl8723bs/core/rtw_xmit.c [1], I thought I should be consistent and change
it here as well.  

[1] https://lore.kernel.org/r/2944d1a0e8769edb489bb336423625a61d314d05.1617229359.git.deborahbrouwer3563@gmail.com

> 
> 
> >
> > Signed-off-by: Deborah Brouwer <deborahbrouwer3563@gmail.com>
> > ---
> >  drivers/staging/rtl8188eu/core/rtw_xmit.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> > index ed81cbc5e191..99e44b2c6f36 100644
> > --- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
> > +++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> > @@ -1243,7 +1243,7 @@ s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
> >   * If we turn on USE_RXTHREAD, then, no need for critical section.
> >   * Otherwise, we must use _enter/_exit critical to protect free_xmit_queue...
> >   *
> > - * Must be very very cautious...
> > + * Must be very, very cautious...
> >   *
> >   */
> >
> > --
> > 2.17.1
> >
> > --
> > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20210403210930.17781-1-deborahbrouwer3563%40gmail.com.
> >
