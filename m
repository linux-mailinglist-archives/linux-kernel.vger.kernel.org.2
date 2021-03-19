Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D2A34252D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhCSSqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhCSSpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:45:22 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B9DC061765
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:45:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ce10so11308157ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=piEZSb3bJhSqagMYdxkJ6f3yXeKXOaHvDayc4eqtmSs=;
        b=oAu4xKRlxm7KvMgfehT6w//vi8f7Nr1txBGZaqZtohYw/8/YPOw9K6D7DFS65A/pCA
         0IY2g9cubIOHu8HzIeqrrAg6EXRvNxXvocS6hto88TdIEHQEdWFdT5pGGqizIqq8AfzQ
         fHC9lKgOvVKqdWyjyTzBeh4vxjJntfC5WmXzw3AGCI2CeX7e0v737nldtrfTB8o7PAFg
         ZfYshlloBVmEr3Rx8Ol7/bI/5Usy3EkEuxZGBnfUTzghkQbWvWOLsk7sX7BgiDPFhgvT
         RnHb40jFpVlZc3evZB5ZZZKRQfDJeD3VeLmGPToVTbWXYoyjwf46GdkcRXzRp94092+D
         NUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=piEZSb3bJhSqagMYdxkJ6f3yXeKXOaHvDayc4eqtmSs=;
        b=QPro/5bqYXPBgua+GLaUYdpZNUUG2NyrEesCiBytAVpMBJFIXx5lrExVoOtzRVv/8m
         16WKfDyXfiZR86gkdcunX+9hwNBcItjEjx2PJ0eVVlt7BaKusuq+ppufvlNCbzzIBLbl
         HxhA/zoJZpXuq4KyDNPrJPl83mWKI8qQ1XQuKysc7KORI4xJc+4kfKQKz8fuTPZ7jokU
         ZMj30ekSwmAQijH0xF9Xz+h+lg5f+QnNzjGeeE9+Mg0Y01M6+P0NFsnB8RTwFC19PWwU
         quHjlZD7BvUtnHVnYThTixYDkb+rWWGdWGaHRCFoxmNbLAEJYolJoYZL3guYLg0Z/Yn3
         hE2Q==
X-Gm-Message-State: AOAM5327yfpxSCJNAwm+DIIAoeamRSznyBarFpVCgYTKlSE0z8Nl8+Ci
        AgT627dMpN5ch3H9y3hwK5A=
X-Google-Smtp-Source: ABdhPJwL9+gs3KO6fS3nMfoxUk5+m+YcvO+kmFt7YDMEpsjSaaroX9uDSwwaBmhNV4xA1mkiGpmuqQ==
X-Received: by 2002:a17:907:9863:: with SMTP id ko3mr5989956ejc.543.1616179515766;
        Fri, 19 Mar 2021 11:45:15 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-34-220-97.business.telecomitalia.it. [79.34.220.97])
        by smtp.gmail.com with ESMTPSA id m9sm4086461ejo.65.2021.03.19.11.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:45:15 -0700 (PDT)
Date:   Fri, 19 Mar 2021 19:45:13 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] clang-format: Update ColumnLimit
Message-ID: <YFTxOcf56lPBi2sb@Ansuel-xps.localdomain>
References: <20210319183714.8463-1-ansuelsmth@gmail.com>
 <20210319184234.jsudy6solmtrq6vz@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319184234.jsudy6solmtrq6vz@archlinux-ax161>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 11:42:34AM -0700, Nathan Chancellor wrote:
> On Fri, Mar 19, 2021 at 07:37:14PM +0100, Ansuel Smith wrote:
> > Update ColumnLimit value, changed from 80 to 100.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .clang-format | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/.clang-format b/.clang-format
> > index c24b147cac01..3212542df113 100644
> > --- a/.clang-format
> > +++ b/.clang-format
> > @@ -52,7 +52,7 @@ BreakConstructorInitializersBeforeComma: false
> >  #BreakConstructorInitializers: BeforeComma # Unknown to clang-format-4.0
> >  BreakAfterJavaFieldAnnotations: false
> >  BreakStringLiterals: false
> > -ColumnLimit: 80
> > +ColumnLimit: 100
> >  CommentPragmas: '^ IWYU pragma:'
> >  #CompactNamespaces: false # Unknown to clang-format-4.0
> >  ConstructorInitializerAllOnOneLineOrOnePerLine: false
> > -- 
> > 2.30.2
> > 
> 
> Not sure how opinions have changed since but this has come up before:
> 
> https://lore.kernel.org/r/20200610125147.2782142-1-christian.brauner@ubuntu.com/
> 

Sorry, didn't notice that. Considering that checkpatch complains and
some reviewers actually state that 100 is the new limit, I think it's
time to update the file.

> Cheers,
> Nathan
