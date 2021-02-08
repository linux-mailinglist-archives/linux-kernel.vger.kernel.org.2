Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD68C3131DB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhBHMLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbhBHLuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:50:11 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41D0C061756
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 03:49:18 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id 7so16762779wrz.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 03:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3mciRa7cMGw+89JwLiOf5wQ63ZdZhqloXYBNXacQTd0=;
        b=ele/Op1LikFpIE/w29roSL53XhNUf3kIRgIdQqW3tbl5jFLqFst1m6oGfeYiQxY2NY
         6dsfmulUO9gmkugKj6fvubsZ2RkcVTO7wGDlSmhapc/GnJCnOhCapfcP1bMCg0Yd5aQo
         XXg2fZDHb771UA2ycvKcWlFciLR7UwaGFzODJiDA/cJUfUyUefzWdcC1/imhuLhErq48
         WG3WbYo3AvbnQL3WOLRU3VpYGRtDxXHD1UlH7/fuCQlKa97uKLx9BUiozUh/W7PvLXyJ
         67ZzS/+LpBN/axZHXRZ45tROjM0OP7Wp+rpjWVXHW+ArGiNdVoYcT1MKaN2cGHjlQZJ+
         C4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3mciRa7cMGw+89JwLiOf5wQ63ZdZhqloXYBNXacQTd0=;
        b=RBtNblnhXevM2Uv5n+K/WgQE5GCNw5FZaw/PNGq3UsujHbsqRWptitVQk2Jui4TIwy
         amQ9mpDzgJu+9wFjmd1v2wFmgKDdrVAOAudEhrC8XSix8KQKIIgDcP6gfVOnlywlomy6
         IqnyPnTcBvB7kcq/kT43Iyqd2VY1tjxB1BDckvPu0BjFmWVCpc+01Z5i6weT65mdK1Ti
         M7zNTfm8XhyM6NvQEUjTGtyxf0L/sC/MKBAQwxKlXpyIw9RVbRyjhJkVSk+IqYK5ckNx
         n5O56ZnEr02kp8OtzgkgfdAmc3MgB2GIL2RUluZiBAAQFnItSB+8CXKjurxenfdWZ0ow
         7mRg==
X-Gm-Message-State: AOAM5336QL4HuzCoYMazCj6jpIR7+stPvx/+66lwofndRSCgOt6w6idv
        fHoSxQCCAApyc0/0ahK+LkIaOg==
X-Google-Smtp-Source: ABdhPJxwtYMJ43K6RSTiqi5dsGPmexEEWZSFirxDQkCQbvlx5dufhtRQG6MbTfDCgtvW5SGHuvST2w==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr6413679wrw.96.1612784957392;
        Mon, 08 Feb 2021 03:49:17 -0800 (PST)
Received: from kernelvm (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id z8sm27563113wrh.83.2021.02.08.03.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 03:49:16 -0800 (PST)
Date:   Mon, 8 Feb 2021 11:49:14 +0000
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com, andrew@lunn.ch, davem@davemloft.net,
        chris.packham@alliedtelesis.co.nz, gregkh@linuxfoundation.org
Subject: Re: [PATCH] staging: octeon: remove braces from single-line block
Message-ID: <20210208114914.GA115411@kernelvm>
References: <20210206201701.5273-1-phil@philpotter.co.uk>
 <51bab7d2-2f37-b4de-71b5-47cfe8857f02@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51bab7d2-2f37-b4de-71b5-47cfe8857f02@nokia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 08:14:02AM +0100, Alexander Sverdlin wrote:
> Hi!
> 
> On 06/02/2021 21:17, Phillip Potter wrote:
> > This removes the braces from the if statement that checks the
> > physical node return value in cvm_oct_phy_setup_device, as this
> > block contains only one statement. Fixes a style warning.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> 
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 

Thank you Alexander.

> > ---
> >  drivers/staging/octeon/ethernet-mdio.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/octeon/ethernet-mdio.c b/drivers/staging/octeon/ethernet-mdio.c
> > index 0bf545849b11..b0fd083a5bf2 100644
> > --- a/drivers/staging/octeon/ethernet-mdio.c
> > +++ b/drivers/staging/octeon/ethernet-mdio.c
> > @@ -146,9 +146,8 @@ int cvm_oct_phy_setup_device(struct net_device *dev)
> >  		goto no_phy;
> >  
> >  	phy_node = of_parse_phandle(priv->of_node, "phy-handle", 0);
> > -	if (!phy_node && of_phy_is_fixed_link(priv->of_node)) {
> > +	if (!phy_node && of_phy_is_fixed_link(priv->of_node))
> >  		phy_node = of_node_get(priv->of_node);
> > -	}
> >  	if (!phy_node)
> >  		goto no_phy;
> >  
> 
> -- 
> Best regards,
> Alexander Sverdlin.

Regards,
Phil Potter
