Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1086435008
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhJTQWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhJTQWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:22:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3F8C061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:20:27 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so2807370pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tnB/QQzcC22l3IN8budKrGGj08EL9XypVRufUs5Tyi8=;
        b=QLFKRvq1sgEeMx9Z6Ccvn2LeiivXDXsGusg910lUeu2W4kHbfynYtsCmIv9MdYTtdW
         QtYeKkNek3BBIKrObN/rioT4IGmtB444IHORFEJUa2DpykpLOucx8nDmjZb+6/QGbKgY
         37+CXGa0I8g4L9GWayF1IxNESN0XNWEHD6PkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tnB/QQzcC22l3IN8budKrGGj08EL9XypVRufUs5Tyi8=;
        b=JdV/N1YnK+W7JQSQ3XjHSMPf4BcdliuLUdLkkGFmGcKSv0Q82AXRlyiXw+hpSugWly
         mlo+CCdwk3f0IiKEcWtOS74VjB5Q0VWdzmpNxhqWGZhupv8lQ8Q27H6FsauT0aet/IaP
         XLfeNfshTBKQB3+DnV8mrEGC0hiDPei9Pv8jG/kC1lAg3ZGl4+yCG4jvsu30HLmTZlqG
         h+xOVI7x16cJrNk+C0Qczl35jEuH6CrW40+AhKxhyv80LMLcZHu5Ygoy2KzouK6C8hgu
         gUffIwllWXhAyULdYwcXVh9FC4f47ZO3kooHBRajMAf3IvKvWC6mtcyvraHpx2LP9/T7
         q65w==
X-Gm-Message-State: AOAM533+KJjMunBk/Y2PtQVaS4F+8N52hjfIooq5J1Pm2r/dMY/5BnDa
        3PQK8I+piJaJxjA9thnEbyvyYNrkTNVYEg==
X-Google-Smtp-Source: ABdhPJzh1TARm9M6zcGOqtmNaeJOF9SPhCLcMdMuukRzcWDiqukWDF1YthsJ14MJEWgw/V9jioN6Ow==
X-Received: by 2002:a17:90b:1649:: with SMTP id il9mr951512pjb.167.1634746827188;
        Wed, 20 Oct 2021 09:20:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g11sm2734771pgn.41.2021.10.20.09.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 09:20:26 -0700 (PDT)
Date:   Wed, 20 Oct 2021 09:20:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp-gustavo tree
Message-ID: <202110200920.8B67A8A6@keescook>
References: <20211018193048.14517460@canb.auug.org.au>
 <20211020161851.GA1297326@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020161851.GA1297326@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 11:18:51AM -0500, Gustavo A. R. Silva wrote:
> Hi Stephen,
> 
> On Mon, Oct 18, 2021 at 07:30:48PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the kspp-gustavo tree, today's linux-next build (sparc64
> > defconfig) failed like this:
> > 
> > sparc64-linux-gcc: error: unrecognized command line option '-Wcast-function-type'; did you mean '-Wbad-function-cast'?
> > 
> > $ sparc64-linux-gcc --version
> > sparc64-linux-gcc (Custom f51944395b6aa154) 7.3.1 20180130
> 
> I think this should work just fine with GCC 8.x

Does -Wcast-function-type need to be used via cc-option ?

-Kees

> 
> Thanks
> --
> Gustavo
> 
> > 
> > Caused by commit
> > 
> >   21078041965e ("Makefile: Enable -Wcast-function-type")
> > 
> > I have reverted that commit for today.
> > 
> > -- 
> > Cheers,
> > Stephen Rothwell
> 
> 

-- 
Kees Cook
