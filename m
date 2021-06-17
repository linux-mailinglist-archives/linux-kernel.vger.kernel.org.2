Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3BD3ABD14
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhFQTs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbhFQTsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:48:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184F0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:46:45 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h1so3504177plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mLMovYIS5wutKY2giDQVw91ffLZtZ5xk7cMLtNk1wWs=;
        b=CDwjpD1m8l6rzkJJVXYXwxmirxd5y9t5OchOdaVxeXIpxlv0IzhtgFv1IvvR00hSsP
         vTBZl9ZEsIu/YfWoKwtyPMWUx81M/vrE58QB66pmHvsd4IyvraYpjHgspnN+eImt+98S
         nC/Kh8b3uXo9gp4HRHBLNpTCFivRKl26wUv+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mLMovYIS5wutKY2giDQVw91ffLZtZ5xk7cMLtNk1wWs=;
        b=Pss7gGDU2MiKcF4fSwCOLcdGAhe2oOSts9KuUxjRGZeArGhT1h7jBRPZXxcYrmO8Uq
         j2lrO3SlS7WPfaz6RpjknePp8nKTrLyS8w9XdmT5q3hkptTCnCoWWKkxMAakQ1iPPTEu
         b8R37oZPtrZTMRiLaYScJUxW8DPAgC45fKSpvxAYvRz5mBXkqGDgfapZJUQ4zx0IkEn4
         XibslKS54oo23ZSP5kjFnIx0ZAAOXKsV2/cCW1p7lpsO/epn+NL7HLlzVoOl+GwpeYsb
         LtLZg6242esIflMnee8cr3xleLuDJRcbs2fpkXv2vQsWCjTcScSIFPyamZO8fH+oFnc0
         jH0Q==
X-Gm-Message-State: AOAM532+eZDbunPm70MA/Z0gct759ydIihNFyOoWnDbi53QBj7BLm905
        nAykAVA8pw0MCZGHHbggpZDvzg==
X-Google-Smtp-Source: ABdhPJx7A1V5hUtyXJ2RGi3Cdv7bj/EHxPhVbb1JmsGrLlHgSwDHgOKn++g2VIYAKFQNIhmNSkxNhg==
X-Received: by 2002:a17:90a:4217:: with SMTP id o23mr18255367pjg.110.1623959204558;
        Thu, 17 Jun 2021 12:46:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s16sm5934637pfc.33.2021.06.17.12.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 12:46:44 -0700 (PDT)
Date:   Thu, 17 Jun 2021 12:46:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Morgenstein <jackm@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] IB/mlx4: Avoid field-overflowing memcpy()
Message-ID: <202106171239.C425161E8@keescook>
References: <20210616203744.1248551-1-keescook@chromium.org>
 <YMr4ypsh7D3q1R5+@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMr4ypsh7D3q1R5+@unreal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 10:24:58AM +0300, Leon Romanovsky wrote:
> On Wed, Jun 16, 2021 at 01:37:44PM -0700, Kees Cook wrote:
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memcpy(), memmove(), and memset(), avoid
> > intentionally writing across neighboring array fields.
> > 
> > Use the ether_addr_copy() helper instead, as already done for smac.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/infiniband/hw/mlx4/qp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
> > index 2ae22bf50016..4a2ef7daaded 100644
> > --- a/drivers/infiniband/hw/mlx4/qp.c
> > +++ b/drivers/infiniband/hw/mlx4/qp.c
> > @@ -3144,7 +3144,7 @@ static int build_mlx_header(struct mlx4_ib_qp *qp, const struct ib_ud_wr *wr,
> >  		mlx->sched_prio = cpu_to_be16(pcp);
> >  
> >  		ether_addr_copy(sqp->ud_header.eth.smac_h, ah->av.eth.s_mac);
> > -		memcpy(sqp->ud_header.eth.dmac_h, ah->av.eth.mac, 6);
> > +		ether_addr_copy(sqp->ud_header.eth.dmac_h, ah->av.eth.mac);
> >  		memcpy(&ctrl->srcrb_flags16[0], ah->av.eth.mac, 2);
> >  		memcpy(&ctrl->imm, ah->av.eth.mac + 2, 4);
> 
> I don't understand the last three lines. We are copying 6 bytes to
> ah->av.eth.mac and immediately after that overwriting them.

I'm not following (the memcpy() is replaced by ether_addr_copy()). I only
see ah->av.eth.mac being read from (not written to). And the destinations
are {s,d}mac_h:

ah->av.eth.s_mac   -> sqp->ud_header.eth.smac_h (s_mac to smac_h: 6 bytes)
ah->av.eth.mac     -> sqp->ud_header.eth.dmac_h (mac to dmac_h: 6 bytes)

after that I see:

ah->av.eth.mac     -> &ctrl->srcrb_flags16[0] (2 bytes)
ah->av.eth.mac + 2 -> ctrl->imm (4 bytes)

The last two copies mac again in pieces, but I don't know what any of
this is actually used for, which I what I assume you're asking about. :)

> Jack, 
> 
> Do you remember what you wanted to achieve in commit
> 6ee51a4e866b ("mlx4: Adjust QP1 multiplexing for RoCE/SRIOV")
> 
> Thanks

-Kees

-- 
Kees Cook
