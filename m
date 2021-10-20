Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EEF4341DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 00:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhJSXA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 19:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhJSXAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 19:00:55 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1FBC061746
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 15:58:41 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m42so14874623wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 15:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4HwbWBH225HUegq6mrkFmlBuKIdIZ25jayh+Q4kqZ0U=;
        b=belqAhkm2UmhptLkjinblyXyn7KKIVal2VvTUhoGDaJgu+R/CbvNlJRBLYYDOl+hfK
         khohVEJMt01PB56ofv8ssfh32VmXOeYKyJXcn/RLnz9uC4jio1YJDAGWNR6cResDomWv
         J3WrvGHwvyJBDjzKR/zWuFQn/6QZGF8Ju9Eutlr3ca55xgKmuS2ZUJEgCd9P+zKUyceq
         Gtw9Cz5JMSK1TE795qwj898v371GS7khCoGe6rFMdmIvzTIb3wRz3cUpYvexOu028P2s
         w8ITW18UK+1B4NxAO2cpnhpJQrv9gLTlmQApTyQmo/jN/1FaWGcFxAMiiXjvBoUM0Wg7
         bNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4HwbWBH225HUegq6mrkFmlBuKIdIZ25jayh+Q4kqZ0U=;
        b=DkugftGlRUWuVedB7EUUFaPpiaEiUX53rz6P6UzotxHTslrIrGhHKR4Lf46CDJmlCj
         Qke2yt2D9Rn8S74yjd3vRC3zWZ+xwgF+faWeVhvYPbv6rLp9LLLY3cVsWukPomdIOtfi
         r/vnK3DL5tHEnWA+RFleuOZv9nUuHvRiJ8BIhbRRPFaOG6PlxIXvJTABQRTVHd8s/ddW
         X7jn+rGBC5c6UjIARzGUdxLmMo5++cbA/dPzWTBhhzzzqMPmL4xN3Zn3JiDeJQwSUu6n
         4i4HfTUsrcEhaYSp5URrf/KRs8OCSMB4dB/AnF0lWud5nWMMdh6P+XfFtLjMf0UCAHBh
         ZJZw==
X-Gm-Message-State: AOAM532eJ3ZTRb3XxFkhYbTjY+p/NeR2Lm9eoXCSQT8fHPJyvX3CONQQ
        RQkhMr8dOiFM3LX250C4NS94XA2ZPZw66g==
X-Google-Smtp-Source: ABdhPJzSFjbS7MYurq/B1EWMO7XAyz1tVlukSLB4j3ZSsuxt88CjWo9079Rw2KtENGSYD6CCwXf4zA==
X-Received: by 2002:a7b:c447:: with SMTP id l7mr9453917wmi.56.1634684320531;
        Tue, 19 Oct 2021 15:58:40 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id n7sm273042wra.37.2021.10.19.15.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 15:58:40 -0700 (PDT)
Date:   Tue, 19 Oct 2021 23:58:38 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     luo.penghao@zte.com.cn
Cc:     cgel.zte@gmail.com, linux-kernel@vger.kernel.org,
        zealci@zte.com.cn, linux-block@vger.kernel.org
Subject: Re: [PATCH linux-next] cdrom: Remove redundant variable and its
 assignment.
Message-ID: <YW9NnuSZ5aWZrcm2@equinox>
References: <YW4C4A5S+mjHzKN2@KernelVM>
 <202110191004079619787@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202110191004079619787@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 10:04:07AM +0800, luo.penghao@zte.com.cn wrote:
> > We no longer need the inner-most set of parentheses now, as we are> checking the result of the expression:> cdi->ops->generic_packet(cdi, &cgc)> rather than the result of the assignment expression:> (ret = cdi->ops->generic_packet(cdi, &cgc))> Please resubmit with this change and I'd be happy to approve the patch.> Many thanks.>Regards,> Phil
> 
> 
> Thans for your response. Actually I have found several such writings, 
> 
> 
> when I looked at the kernel code.such as
> 
> 
> > (drivers/video/fbdev/sis/sis_main.c  2498)
> 
> >       if((result = SISDoSense(ivideo, svhs, 0x0604))) {
> 
> >           if((result = SISDoSense(ivideo, cvbs, 0x0804))) {
> 
> > 	     printk(KERN_INFO "%s %s YPbPr component output\n", stdstr, tvstr);
> 
> > 	     SiS_SetRegOR(SISCR, 0x32, 0x80);
> 
> > 	  }
> 
> >        }
> 
> 
> I thought the doubel parentheses was a special expression，which I cannot understand(just for me).
> 
> 
> So I didn't modify it easily.

Dear Penghao,

So the reason assignment expressions are wrapped like this when used as
if conditions is that compilers will often by default issues warnings
otherwise - the compiler will warn to check that you didn't mean:
if (x == y)

rather than:
if (x = y)

which is a common mistake. Using the extra parentheses lets the compiler
know we really did mean to do an assignment, not an equality check.

Semantically however, there is no difference between:
if (x = y)

and:
if ((x = y))

in terms of the ultimate evaluation of the expression.

Another reason for wrapping in my opinion is good practice, as later on
one may wish to add additional operators to the condition. For example,
if we wanted to check if the result was less than another value:
if ((x = y) < z)

has a very different meaning to:
if (x = y < z)

due to the assignment operator having a much lower precedence than other
operators. The extra parentheses therefore enforce precedence here, and
add clarity as well. Hope this helps.

Since your change removes the assignment entirely, the extra
parentheses are therefore not required. Hope this helps. As mentioned,
by all means resubmit with this tweak and I will happily accept the
patch.

Regards,
Phil
