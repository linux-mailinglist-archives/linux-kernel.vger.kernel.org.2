Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C94344E50
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhCVSTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhCVSTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:19:16 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8004AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:19:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id jy13so22848086ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3dtk5n06/qQhu6ya837RSEVImQmWnv5XbUrMmc0aG/E=;
        b=s9pY1UfT+bxHvr42bpqxDHfUnPrPkreIc5+TfeYxz1alPN1FRTe90Sxetz4CCPq9u7
         S79KX8sWDHwXtN8LspPaeoe2e/J9mpglVKCmas6ytFqv78Bej0nB8YoOL8BfhUiPcVvv
         v9Pev7qWVHI1IJqi3/8cGT5S+U3uU3+HdHhoQRFnLJoO5cSBfrLgYAQNPK0/bS/rQUw2
         kDD1d5kgdyl83RcUPq7oRtC5hNMfbbFNOCJ+wDLvXYlSsgwi740yegvxcBs0TxeH3vEb
         xyjaGxaX23d3pweETyEYDUbcFykqsHVPacqy89SgXcbER5YnaUoZ5aXVD5AbPAV6nIy8
         hd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3dtk5n06/qQhu6ya837RSEVImQmWnv5XbUrMmc0aG/E=;
        b=CVhB/6QNnwB8xLakd+5Yib3DEaiRWye2uk6CdsP82xVimzCqEJz4G7Xq6Wk76xWD1D
         x82oUmLQhKWo5dE7TUTtaYTOdilSUUzIgtCvOAjwODGE9cDEgWlwIJUSFQ9H1W79j/S6
         Wsg4PwbqZzcOvOdlTQWQwa7PwvO4OpI0tTy+pm85QTHNhhKTba1D5vU/7m+R2gBNZ1x5
         6/EalClQWhO+DgVNpUZcgdWp0FMZEAAMPR7J47vJx9q6u3w1Xwam+9tgtXVvRIr6WB90
         EclgKSY8E4zEsflYEE6bGz3q9sIbwO7wPNLk+Gy2jCTM7BoEdvE1kc/CAiIcJ+9ZCbuJ
         VxzQ==
X-Gm-Message-State: AOAM531Ki311yTaKzlgzMeBTMkKp7qeTcH6PMJj5KptP4FWkyEmtaWyq
        ZPK0wiuECfNBJFv5tvyEKNc=
X-Google-Smtp-Source: ABdhPJytapzLs5LIfSwUjL6ebzd8f7nSsu32x/FEqta/6tRsFkteYM0gGRFFiyZvZMv0ar2xvcwPOg==
X-Received: by 2002:a17:906:f0d0:: with SMTP id dk16mr1153250ejb.48.1616437152315;
        Mon, 22 Mar 2021 11:19:12 -0700 (PDT)
Received: from agape.jhs ([151.37.41.34])
        by smtp.gmail.com with ESMTPSA id mc10sm9827995ejb.56.2021.03.22.11.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 11:19:11 -0700 (PDT)
Date:   Mon, 22 Mar 2021 19:19:07 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] staging: rtl8723bs: remove argument in
 recv_indicatepkts_pkt_loss_cnt
Message-ID: <20210322181906.GA1443@agape.jhs>
References: <cover.1616422773.git.fabioaiuto83@gmail.com>
 <fb3d6e0ae858738e3213b60d87e70c2f1697f051.1616422773.git.fabioaiuto83@gmail.com>
 <YFjBoZJBnAqDh+jY@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFjBoZJBnAqDh+jY@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 05:11:13PM +0100, Greg KH wrote:
> On Mon, Mar 22, 2021 at 03:31:43PM +0100, Fabio Aiuto wrote:
> > remove debug_priv argument so function prototype can be
> > easily moved away
> > 
> > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/core/rtw_recv.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
> > index 9ef2408ded57..e2a6afed723c 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> > @@ -1983,13 +1983,13 @@ int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl, union rec
> >  
> >  }
> >  
> > -void recv_indicatepkts_pkt_loss_cnt(struct debug_priv *pdbgpriv, u64 prev_seq, u64 current_seq);
> > -void recv_indicatepkts_pkt_loss_cnt(struct debug_priv *pdbgpriv, u64 prev_seq, u64 current_seq)
> > +u64 recv_indicatepkts_pkt_loss_cnt(u64 prev_seq, u64 current_seq);
> 
> But you did not drop the function prototype, why keep it?
> 
> And shouldn't this be static?
> 
> thanks,
> 
> greg k-h

I moved it in a header file in the next patch [6/11]. However is better a
static function when possible and drop the prototype.
