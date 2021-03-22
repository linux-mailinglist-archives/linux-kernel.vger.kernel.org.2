Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C952344E6D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhCVSXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhCVSWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:22:52 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5856C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:22:51 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id e7so20481016edu.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=asL2ZZdtkm66EuwKx1Rl/XrY+7M28qzFVlOOJDLrX1Q=;
        b=jKJvrSeRF6WQqvVAhseT8JuAeNVVKu5BVHgSK5zf55N/aCZZMavPrcVmTO6k2s4y6R
         M28a6saDUEFEzuei1dG/wxw71JTuTWaTklTZp8dxzQAS8EsLE2tbS6mBsOJe5MG8kEsG
         ptlcs01Z1gxqievx+csQxXG4RhSATpkzo0hTAK6wc3MZ/J4AfBzWc7t/GxbZjA6cMBbC
         Lu0za++wqkBLJf914TLR/vCydahGRWYz0lCPzorsE3JBOtFv1KKmtEiJ8JV4gXAfxecf
         gGkGuzipWzdTnARJWMxhniq2ER3gQEossUtqCZbfd3HZnb3OTXA6Q665eT7ndcbanrlX
         6WDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=asL2ZZdtkm66EuwKx1Rl/XrY+7M28qzFVlOOJDLrX1Q=;
        b=kFwYdIlLzPhJB9kMCoyxXzsZ8xrGoYXHrjnPGStcY92UGT8HcBA+skRv8SaYsfCKXm
         4ahQfI+HbW0AB5VWi0HNp1opKjCAdvSsU3FaWyUf0nHsxor+1nRTYrhtgsA4T/o09gFV
         Sj2ZNxEFeW+mM9KKtlTuOZouS2hUsBc8ksHG9j07z8ZhbzgAYFQZJxzVFc6EW2Evif0W
         HgZPtR156DB+Ipm/jNKhRJx1N9XHygF2D6r06OPzXVjoFFH65/1oF6GUwdtKegUda5Zh
         7vY6sklvY8/1fqxyr7Z7HV5dRW07lN+HdruqVjcdhdsOVfnUtEoyfq/BB5x6Sa8c+jVk
         NcbA==
X-Gm-Message-State: AOAM533Xn4gO8tTcUgdE8m6/tF0U2xrSW/C7QkdoVGXEG/41jG4zYp0A
        HrPLS30MFb6js97XvRCoHdc=
X-Google-Smtp-Source: ABdhPJzdlnMnhcI11rqCVdKyiJ4uKdceNJbkp7h+h/nHy3QamkCbfqong+uG+lmxdK0+gA5sf51O4Q==
X-Received: by 2002:aa7:d4cb:: with SMTP id t11mr946836edr.202.1616437370465;
        Mon, 22 Mar 2021 11:22:50 -0700 (PDT)
Received: from agape.jhs ([151.37.41.34])
        by smtp.gmail.com with ESMTPSA id e26sm12663906edj.29.2021.03.22.11.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 11:22:50 -0700 (PDT)
Date:   Mon, 22 Mar 2021 19:22:46 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] staging: rtl8723bs: moved function prototypes out
 of core/rtw_efuse.c
Message-ID: <20210322182245.GB1443@agape.jhs>
References: <cover.1616422773.git.fabioaiuto83@gmail.com>
 <c46e7d7a686988bb6aaea9bc24b15188136e0aed.1616422773.git.fabioaiuto83@gmail.com>
 <YFjA2XhxhJE/iN4j@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFjA2XhxhJE/iN4j@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 05:07:53PM +0100, Greg KH wrote:
> On Mon, Mar 22, 2021 at 03:31:40PM +0100, Fabio Aiuto wrote:
> > fix the following checkpatch issues:
> > 
> > WARNING: externs should be avoided in .c files
> > 35: FILE: drivers/staging/rtl8723bs/core/rtw_efuse.c:35:
> > +bool
> > 
> > moved two function prototypes in include/rtw_efuse.h
> > 
> > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/core/rtw_efuse.c    | 10 ----------
> >  drivers/staging/rtl8723bs/include/rtw_efuse.h |  3 +++
> >  2 files changed, 3 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
> > index 32ca10f01413..0772397738d4 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
> > @@ -32,11 +32,6 @@ u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
> >  #define REG_EFUSE_CTRL		0x0030
> >  #define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */
> >  
> > -bool
> > -Efuse_Read1ByteFromFakeContent(
> > -	struct adapter *padapter,
> > -	u16 	Offset,
> > -	u8 *Value);
> >  bool
> >  Efuse_Read1ByteFromFakeContent(
> >  	struct adapter *padapter,
> > @@ -53,11 +48,6 @@ Efuse_Read1ByteFromFakeContent(
> >  	return true;
> >  }
> >  
> > -bool
> > -Efuse_Write1ByteToFakeContent(
> > -	struct adapter *padapter,
> > -	u16 	Offset,
> > -	u8 Value);
> >  bool
> >  Efuse_Write1ByteToFakeContent(
> >  	struct adapter *padapter,
> > diff --git a/drivers/staging/rtl8723bs/include/rtw_efuse.h b/drivers/staging/rtl8723bs/include/rtw_efuse.h
> > index 5bae46ecd9de..1f304df8c421 100644
> > --- a/drivers/staging/rtl8723bs/include/rtw_efuse.h
> > +++ b/drivers/staging/rtl8723bs/include/rtw_efuse.h
> > @@ -103,6 +103,9 @@ extern u8 fakeBTEfuseInitMap[];
> >  extern u8 fakeBTEfuseModifiedMap[];
> >  /*------------------------Export global variable----------------------------*/
> >  
> > +bool Efuse_Read1ByteFromFakeContent(struct adapter *padapter, u16 Offset, u8 *Value);
> > +bool Efuse_Write1ByteToFakeContent(struct adapter *padapter, u16 Offset, u8 Value);
> 
> No, there's no need for this to be in a .h file, it is only called from
> one .c file.
> 
> Make the thing static and all should be fine, right?
> 
> thanks,
> 
> greg k-h

ok, better static function when possibile. 

Thank you Greg,

fabio
