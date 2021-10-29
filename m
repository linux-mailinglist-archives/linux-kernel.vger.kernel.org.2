Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A484D43FF2A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 17:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhJ2PPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 11:15:15 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:37613 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJ2PPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 11:15:15 -0400
Received: by mail-ot1-f44.google.com with SMTP id v40-20020a056830092800b0055591caa9c6so5735920ott.4;
        Fri, 29 Oct 2021 08:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZZSpWdFgx8Hgo/Rq6arEnNWNm4ib749ZogQ0cBAczDI=;
        b=UFsZvnB0ukPqhcvsnpgbuxuJhmzQFvFPBzB5rTxgCSjBDad+0JYKJS915dT0p9jPfv
         c9ZV6sxtNl4icQ4jOHFwqJlNOQySMj9nkRgnB+/NhgOAgsBkh7NizaXSZ2Qmfy7dPVTa
         XIMW5RyAQpHXBhbJGSOq4vH+KVUS4xaqSwRzF/PRpGZY3XhN3sKEGlSDuOd90wK1Hmsf
         l0F0IPb6dDEzzr7brWDFUtn+YukeLrq9ptkDzr1y5E511SscH0GEqKShCjGF8abd8lfs
         uC+z8RktSPnZ/R9mP11KT9g/UqETCSMyrL86KZXpoEJq+BCuRoMbGG+UroQ6rgeWKUSA
         0MSQ==
X-Gm-Message-State: AOAM533ps49iHQgNCYCrSpbbzGcXuOAYR2VEQM1TwJKnnU6QdeSPqTmp
        rjZMU5zn/1adXWb4X04Lmg==
X-Google-Smtp-Source: ABdhPJw/InUKSHtIwQ4KNhn0YRbv5vjm4jOtePHF35Iv/etb0zSEzjTPqexHPbblOF+eN4+rGO8goA==
X-Received: by 2002:a05:6830:3155:: with SMTP id c21mr9245999ots.93.1635520366076;
        Fri, 29 Oct 2021 08:12:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w16sm1922398oti.3.2021.10.29.08.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 08:12:45 -0700 (PDT)
Received: (nullmailer pid 2414810 invoked by uid 1000);
        Fri, 29 Oct 2021 15:12:44 -0000
Date:   Fri, 29 Oct 2021 10:12:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] of: unittest: fix EXPECT text for gpio hog errors
Message-ID: <YXwPbDiP0zc1cHHy@robh.at.kernel.org>
References: <20211029013225.2048695-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029013225.2048695-1-frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 20:32:25 -0500, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> The console message text for gpio hog errors does not match
> what unittest expects.
> 
> Fixes: f4056e705b2ef ("of: unittest: add overlay gpio test to catch gpio hog problem")
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/unittest.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Applied, thanks!
