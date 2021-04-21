Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0374C366848
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbhDUJjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238604AbhDUJjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:39:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AC9C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:39:15 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id d21so28465875edv.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7vTQYtCuzSqSD01xdETGY8hGY6vgkDP6vbFro/3X7+o=;
        b=Fpp/OTXrg0aYSbMjwVz7FJ8stCIQzJoKnLJwKaRJRkWmxUOa1eqEubMr+wMVartk01
         HOqI/p0RFJtp9B42b8hq6IPr+kvKLYRkhBAIywS0pWl8tY4JhObmdyq8MXDRR7verm+I
         I7/AsCWlD14e5OnCURQGIbLfoL8cxOJWHbPYepGxXZhflBDPXNInZpYdprYyYJuzeCvc
         B+XhlPfrXf5YMn2dZafwVcAzDXRebaI8P9Yer5vR6s5Q51WjffgFlIMxnjPLdSCAUHgV
         uwKZkqSf2wIhhRnGk5OZCfxv9BR6ZKaXCepNkHYay6PbtBEnzT/0S59jgrNHIW7CI+q1
         1pmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7vTQYtCuzSqSD01xdETGY8hGY6vgkDP6vbFro/3X7+o=;
        b=gb6XkvscdbePzf7uQQJ/toZnsA4abYEFrLP4LBny5pB7JBfJpdcTt9RIrGf81sXUcI
         CJEqfV1R5+9/wM368yDdgSEzdCyI6o3Y7Wb2/+pO32craCOr2S8g3mbemCV0tFryYYck
         Mb6XtPY7HUCX62ENInlkgyuln2B+ODec4ArxdiSBauzmZ2l/LOVPHAsjW/EdYH7B1Hhy
         AQO8i5NClYu4AsWoLc2KgKZOeJ2ZrZDj0UhAd+5+QcHVPeA4fUszx/wO45hANyaa5Wx2
         uTHmNAL0vVpP8tFVeHtbUoWAhsSpFPeyoYpdf+Op/LE+PCighLd9l5PIHyXuIHf9xc06
         jgnA==
X-Gm-Message-State: AOAM533jvsZrON2pAu2wvfWWyFFw6Kx26E/AGoTaZ7fU4bghti5isKZH
        E5GrnvEuIBdRsXoTE+7kcQZCVQ==
X-Google-Smtp-Source: ABdhPJyqmSuXvxpzw7E8oxviPPUGHeFncPI7x/UT+mwZN/gqeOoEGBTZgfIrnK8OUBSp+FRq/JHfSA==
X-Received: by 2002:a05:6402:46:: with SMTP id f6mr37754221edu.252.1618997954103;
        Wed, 21 Apr 2021 02:39:14 -0700 (PDT)
Received: from netronome.com ([2001:982:7ed1:403:9eeb:e8ff:fe0d:5b6a])
        by smtp.gmail.com with ESMTPSA id d1sm2423853ede.31.2021.04.21.02.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 02:39:13 -0700 (PDT)
Date:   Wed, 21 Apr 2021 11:39:12 +0200
From:   Simon Horman <simon.horman@netronome.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, oss-drivers@netronome.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [oss-drivers] Re: [PATCH RESEND][next] nfp: Fix fall-through
 warnings for Clang
Message-ID: <20210421093911.GA15091@netronome.com>
References: <20210305094937.GA141307@embeddedor>
 <20210305121949.GF8899@netronome.com>
 <b4fd4c37-ccd6-3cbb-a127-3b2ad9516871@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4fd4c37-ccd6-3cbb-a127-3b2ad9516871@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 03:23:39PM -0500, Gustavo A. R. Silva wrote:
> On 3/5/21 06:19, Simon Horman wrote:
> > On Fri, Mar 05, 2021 at 03:49:37AM -0600, Gustavo A. R. Silva wrote:
> >> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> >> by explicitly adding a break statement instead of letting the code fall
> >> through to the next case.
> >>
> >> Link: https://github.com/KSPP/linux/issues/115
> >> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > 
> > Thanks Gustavo,
> > 
> > this looks good to me.
> > 
> > Acked-by: Simon Horman <simon.horman@netronome.com>
>
> Hi all,
> 
> Friendly ping: who can take this, please?

Hi Jakub, Hi David,

I'm happy to repost this patch if it would help with your processes.

> >> ---
> >>  drivers/net/ethernet/netronome/nfp/nfp_net_repr.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
> >> index b3cabc274121..3b8e675087de 100644
> >> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
> >> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.c
> >> @@ -103,6 +103,7 @@ nfp_repr_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
> >>  	case NFP_PORT_PF_PORT:
> >>  	case NFP_PORT_VF_PORT:
> >>  		nfp_repr_vnic_get_stats64(repr->port, stats);
> >> +		break;
> >>  	default:
> >>  		break;
> >>  	}
> >> -- 
> >> 2.27.0
> >>
