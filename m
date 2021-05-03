Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C510237121D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 09:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhECHnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 03:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhECHnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 03:43:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878ECC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 00:42:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r9so6466437ejj.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 00:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LqHlFIPmIy5Y2GPoZMM4D4gWHV/H7PW4NUYS7qLOhnw=;
        b=UdSeCPDt3We7RwRVFupSdzP9ifzoXef1CfB5AzVXHF+ZU+BUfyjZWrRAx30bVN68a7
         HbCmk0RYFb+7XnKxCCYjgzIpjWp71f4QHS3ceFlJY2dWjVJBtQs0fDKB70sXG7fqD8y8
         pjeG4TOb62tMxx6o23FZLcLrTpwqrVdAK9TnbLn7mo7BLwPLuZW5g1lxVy1l/r7HSj24
         lIb/O/DP++jLFIlA0ubUFIhhsPwZaAHSuHJVLo4cCXq8aRGPfDPovPLe1S39bFuC7vrr
         SWWBWyKjoC3JYrR01Onm+ts8bYt/vA39QlcPI0ER2ymeYcGqYeXJmA4Hf4JjeC+I18sV
         WvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LqHlFIPmIy5Y2GPoZMM4D4gWHV/H7PW4NUYS7qLOhnw=;
        b=ihL3gwc5z6pLqc53GtL3ewSuWadF5Ut69kZNTXXbQnqKjjvtfYRSsFFL0kQGnKgFhO
         4t0rO5S/JtcCZWzDa916E2Uz10NLgU/Sx/jE3N5crYcw8aE5jpWloXXC8RSI/V1QjCFv
         TsCaGH9B8RbK3SifvFCzOvJmeC0fii1nr3uGE3dSK2iCHrdk/3AQ/5YoJ0KNPbN0OHPD
         Bx0c0BBO9F4cVfL/yJHpYlnwlZ4NxDI94YO60dvOEcBy/DODLbJ6ZIjg3E7ikMSw6lbq
         omxtFga7cwxxTvtdLPG+ePVBq5lSAt/rXshYjAqYyVAKRkigo7hadiJl3Z2pyGZHFnwL
         1zrw==
X-Gm-Message-State: AOAM531BCkZ8NE0ryA1yhFqHn7UsGQhKuucliwPBNuDRkdL7uTYNxff+
        dPywW+pO96XokICB0kGIQYU=
X-Google-Smtp-Source: ABdhPJyz3qtLFhc7LlfWEHR+4Fi4UL9VY3uRkcPUcSLJo7wKJt6V4t374Ixvx6xzf8b8Sb2XldZH2Q==
X-Received: by 2002:a17:906:5203:: with SMTP id g3mr15079739ejm.95.1620027742314;
        Mon, 03 May 2021 00:42:22 -0700 (PDT)
Received: from agape.jhs ([5.171.72.252])
        by smtp.gmail.com with ESMTPSA id a24sm9912641edr.74.2021.05.03.00.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 00:42:22 -0700 (PDT)
Date:   Mon, 3 May 2021 09:42:18 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/43] staging: rtl8723bs: remove if-else blocks left
 empty by ODM_RT_TRACE deletion
Message-ID: <20210503074217.GA1557@agape.jhs>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
 <0e1196ebf56787f62dcbfbcba1fcbc2ed37a65ce.1619794331.git.fabioaiuto83@gmail.com>
 <20210503072710.GL1981@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503072710.GL1981@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 10:27:11AM +0300, Dan Carpenter wrote:
> On Fri, Apr 30, 2021 at 04:56:24PM +0200, Fabio Aiuto wrote:
> > @@ -1533,13 +1529,10 @@ static void phy_IQCalibrate_8723B(
> >  				result[t][6] = (PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_Before_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
> >  				result[t][7] = (PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_After_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
> >  				break;
> > -			} else {
> >  			}
> >  		}
> >  
> >  /* Allen end */
> 
> This comment doesn't mean anything.  It feels like it was supposed to
> go with the code that you deleted so it should have been deleted as part
> of deleting the empty block.  But it's fine to me if you delete it in
> a later patch.

Hi Dan,

ok I will.

> 
> > -		if (0x00 == PathBOK) {
> > -		}
> >  	}
> >  
> >  	/* Back to BB mode, load original value */
> 
> regards,
> dan carpenter
> 

thank you,

fabio
