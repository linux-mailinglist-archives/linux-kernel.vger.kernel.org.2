Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863143C8B68
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 21:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240083AbhGNTHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 15:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbhGNTHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:07:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B00C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 12:05:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i94so4532377wri.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 12:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yZxgDbkz/wK/8pAt9zmxGsfsC4FQ0CTK14inhloUOtg=;
        b=VjAbEYiuI4OYqkqtTeTjCMnbSYYv7dMyhPllFLPr/eotqYiekLbYQca1Xan34vq17T
         AUz/x3xk8Gjoy4oo9AY8SOawu3TMoXXwQ+PMybQ/++nrwZ/8kGxO23t8vOPKrtfuGzHp
         7wvq7PP569kYUWJvCwe0nIZ/r4AHeAjK7pmQfTtzYKHU3enD0/mFdzoQvrKQp72uybWI
         j65j/FEScl633ra64t0Vu3oBqLXb8YLEyfujK8HgLiiXGBTPkPgOg+TuH/7s34INxmAC
         0brmF7pLTHSaC/XNQrC6puUtt+BfhPgf65Lk9sFxvPSjgdTZ90Zm2oLqngp9Xq3/wNOJ
         JPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yZxgDbkz/wK/8pAt9zmxGsfsC4FQ0CTK14inhloUOtg=;
        b=kAiYPO95ApyU19xlAO5NFFfJN184lBDajlgzyir2omcqQm0lozTxn85Mm8WIVB7BRo
         onHERM7TrXkCAQ3ujc/ipMF6KVT4d5K6w3l4YlZiMcwffbw1e7I6RZbHz+PI0RWN2TO5
         GGEVAGpOU+kNBNHd46hL6KBDqlWvM4vR3rCVzOxYUPe337CTExhWyP/fF8PQ2GN/Datm
         SDZ9Ka9wVHtrx/AsqRXx50Zl1F/v/mhFsQbPSFZh0k47ueKgW7vrCc67eYWxwFXIoKu6
         VE0PAwzfP10Kr0iv8Z0WpkljRQmRLdao1pL3VG5OVhqyEjr9treKI84sIDd33VQ1K4Wq
         qQoQ==
X-Gm-Message-State: AOAM533A85k8t72hg3oUJepp+AXLXKxouaCPGxhN3G29IVXmSfpFvSNs
        MrZDwzkcgYRocRjSMucdOKHpe5kO6mE=
X-Google-Smtp-Source: ABdhPJzLVD38+GgK9W+4LhvLLeVJU+GLxXbtOsjDwu00SylAXFgbPiLjxEEst1ye1L8In6S4l8u64w==
X-Received: by 2002:a5d:5642:: with SMTP id j2mr14994057wrw.194.1626289500277;
        Wed, 14 Jul 2021 12:05:00 -0700 (PDT)
Received: from agape.jhs ([5.171.72.231])
        by smtp.gmail.com with ESMTPSA id p11sm3569952wrw.53.2021.07.14.12.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:05:00 -0700 (PDT)
Date:   Wed, 14 Jul 2021 21:04:57 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: rtl8723bs: fix camel case issue
Message-ID: <20210714190456.GA1402@agape.jhs>
References: <cover.1626275102.git.fabioaiuto83@gmail.com>
 <a708b2b9902bedf5bd0466b05516a4c5b4f43723.1626275102.git.fabioaiuto83@gmail.com>
 <20210714152605.GK1931@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714152605.GK1931@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dan,

On Wed, Jul 14, 2021 at 06:26:05PM +0300, Dan Carpenter wrote:
> On Wed, Jul 14, 2021 at 05:11:14PM +0200, Fabio Aiuto wrote:
> > fix following post commit hook checkpatch issue:
> > 
> > CHECK: Avoid CamelCase: <NetType>
> > 45: FILE: drivers/staging/rtl8723bs/include/ieee80211.h:170:
> > +#define is_supported_ht(NetType) (((NetType)
> > 	& (WIRELESS_11_24N)) ? true : false)
> > 
> > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/include/ieee80211.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
> > index 8eb0557a077a..b2c1a7dafcee 100644
> > --- a/drivers/staging/rtl8723bs/include/ieee80211.h
> > +++ b/drivers/staging/rtl8723bs/include/ieee80211.h
> > @@ -167,7 +167,7 @@ enum network_type {
> >  
> >  #define IsSupportedTxCCK(NetType) (((NetType) & (WIRELESS_11B)) ? true : false)
> >  #define IsSupportedTxOFDM(NetType) (((NetType) & (WIRELESS_11G) ? true : false)
> 
> These are the same.
> 
> > -#define is_supported_ht(NetType) (((NetType) & (WIRELESS_11_24N)) ? true : false)
> > +#define is_supported_ht(net_type) (((net_type) & (WIRELESS_11_24N)) ? true : false)
> >  

NetType -> net_type, or did you mean something else?

> 
> regards,
> dan carpenter

thank you,

fabio
