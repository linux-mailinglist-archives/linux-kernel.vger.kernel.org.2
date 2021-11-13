Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6F544F245
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 10:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbhKMJTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 04:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhKMJT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 04:19:29 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D49C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 01:16:37 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id m14so47959625edd.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 01:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VfAYhPiwiwiyvWNQSEKAcTZOlquJvGTWd5nN82HonzY=;
        b=OVYHPNyZQS4RAhJEu5In/BmBPAq2bL60W3U0uzA9hwqeKqzykSGLHOVPGJrWwcFxWM
         Z4kyIsqfW48FsgvE9bc2vQWAncYeaDjiwM9C9eioXkCJcaNH6Sudf57eRUWPBr4oyfMV
         0q1EazDu3swCwOhOmoozGcokrawI/agIvjPGi2gkqanFT6Bs08oi29xGMJdHojXfIh5R
         9IZDbsux96ItRjB2ZbyV0NfYDB6dCknBqipHhubOQrIVLA1yiB0jDWTIRpE47DB8OlUs
         AEH3QK8rpPXChun5pOZWqfDMd5G1uSnLCKxLvE533za4hXmpNaSJHLWwuavpTrTXa2HL
         jLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VfAYhPiwiwiyvWNQSEKAcTZOlquJvGTWd5nN82HonzY=;
        b=hepCWyOQd8BJFLEJVhF1oj18X/F8TEWDMqMIeNSX2b2dDncXeg7ogsHjc/K6fM2Akb
         5Imq6T7LlNWuMmzeQasfbbqroUMmcxANGo83rOgy35N8OpgjLW/Q4qlYyMSkBBcd3NnP
         42x9VMpLBBpb+isXGkt6JM0WK7CZG6NwVAm8BmtJcmj1qdDHqlvzWZgNxWi2+ZQTWmS0
         4vTFddGfy8nD04Lrcff36uiKhcNcQtgSWBOgmXLP7XzfFNuD1pZvA3bzTzOav9cjb/Um
         mGYQ91mljVN+JHBV6W+RCp4ObZVx/XuPcCoDdLEUS+EwXxPtQchoR60B8OolgkwqFY6j
         5p/A==
X-Gm-Message-State: AOAM532BGI3xZyuIansRIOB+VFGRT+q5jsd14+0eC7zBDXszdvJB/Wr/
        2uKEQWFe3XG9tlhkLaTZOBQ=
X-Google-Smtp-Source: ABdhPJycnBdI30jFWyXBWYhK2yOWovViuMMV3gucOqpnXhqXIKcibg3kN66CzbX1mmxbxRmMetfP8w==
X-Received: by 2002:a17:906:4fc8:: with SMTP id i8mr27483703ejw.342.1636794996097;
        Sat, 13 Nov 2021 01:16:36 -0800 (PST)
Received: from tom-desktop (net-93-150-197-192.cust.vodafonedsl.it. [93.150.197.192])
        by smtp.gmail.com with ESMTPSA id cw20sm3443714ejc.32.2021.11.13.01.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 01:16:35 -0800 (PST)
Date:   Sat, 13 Nov 2021 10:16:33 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: fix camelcase byData in card.c
Message-ID: <20211113091633.GA16307@tom-desktop>
References: <20211106184822.24242-1-tomm.merciai@gmail.com>
 <dfa9d7734dfc64263b30f29b4d23aab7d0683089.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa9d7734dfc64263b30f29b4d23aab7d0683089.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2021 at 12:06:30PM -0700, Joe Perches wrote:
> On Sat, 2021-11-06 at 19:48 +0100, Tommaso Merciai wrote:
> > Replace camelcase variable "byData" into linux kernel coding style
> > equivalent variable "data" in card.c.
> > "by" prefix in hungarian notation stands for byte or unsigned char
> []
> > diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
> []
> > @@ -194,15 +194,15 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
> >  			priv->abyBBVGA[0] = 0x20;
> >  			priv->abyBBVGA[2] = 0x10;
> >  			priv->abyBBVGA[3] = 0x10;
> > -			bb_read_embedded(priv, 0xE7, &byData);
> > -			if (byData == 0x1C)
> > +			bb_read_embedded(priv, 0xE7, &data);
> 
> It might be nice to figure out what these register values are
> and use #defines instead of hard coded values like 0xE7
  
  Hi Joe,
  Thanks, I'm going to investigate these numbers.

  tommaso
> 
> > +			if (data == 0x1C)
> >  				bb_write_embedded(priv, 0xE7, priv->abyBBVGA[0]);
> 
> etc...
> 
