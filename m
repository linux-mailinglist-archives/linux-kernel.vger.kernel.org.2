Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA65346243
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhCWPEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbhCWPDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:03:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2A3C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:03:48 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h13so23826516eds.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8xYD4W2to8YNMxc8Ry+TNMg8q3DctPf14vLGSQq4wP4=;
        b=apNo1ijMYNhH/3CKh0/ZOYu1IqVyhkghmRn+cVi4LdSQorKw90ziEYARjMm/S2IjkV
         0ammeIhmJuCazv0Xr+a6TaWkC4JIR5uIcYb2B2ugpjj/T4EMlpVdhWc6jhGYJ0SqPzzW
         ZpYqtHUA8/6Le1/HnwFNgLHoyF1QlPTVgiSsCNVuSHdfhjuy6mTYZM6jxzvQIiHIy2yD
         tOjD6qWn+HBKzqqhGmayVrSz970fRlzoJrRxFugL+eZj+3cPT2KTBGyqmzxZXEjx3hdP
         xHCLC1BU7BxrbB/r5Gv4xNae1u+/gzdH8BNPKq2dnae6JQVg1WPppw5katdqk3eqxfUZ
         WgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8xYD4W2to8YNMxc8Ry+TNMg8q3DctPf14vLGSQq4wP4=;
        b=X0XdDKs0SQaZY+9/b7tV57msFnmdQbC1Ph/2orMkXLxWt/Rz81ZQMwndAUchWV1YM+
         tdz1w+sgC5aJ8bbG+OQBwYIrbJfAqOyzUfSAsD1PSHelBETfcy8HJRe8iyHKLeGXrRUK
         c9hA6TSe39h4lt9VPxMaSGLkT/czLGEqlRVE84gIOd0iIERLBQ782nxlpTEPo29W8Mzm
         Vb5tT8USfSsmjXn/TbMewJy/1Bn24JaBxOLCZwA0qh5oYh69MvMAJUi5La2Zf5NC5KLt
         S0YSDsonBK9wyqj9WNfoenCmGwOUT98nKQXs09NQl1L6/oGAQyy/j6SXgYoQQ2kb8Gt3
         PZyQ==
X-Gm-Message-State: AOAM531quvqILcVSJ8ezUMqY9koqZylX2LS99KKW+7QCOsgbX7EGAPtE
        AV0Nq9fuogJyx+iysczKFJLoJg==
X-Google-Smtp-Source: ABdhPJyk9Gm/FP9veTdcBorBoeii7WdvJMX9EkinwCyeKErdn1rJ50Tl4LQ9OQbKRmBbVQhBfFes7g==
X-Received: by 2002:aa7:dc04:: with SMTP id b4mr4951936edu.221.1616511826732;
        Tue, 23 Mar 2021 08:03:46 -0700 (PDT)
Received: from enceladus (ppp-94-64-113-158.home.otenet.gr. [94.64.113.158])
        by smtp.gmail.com with ESMTPSA id v25sm12692609edr.18.2021.03.23.08.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 08:03:46 -0700 (PDT)
Date:   Tue, 23 Mar 2021 17:03:43 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     David Ahern <dsahern@gmail.com>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Saeed Mahameed <saeed@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 0/6] page_pool: recycle buffers
Message-ID: <YFoDT90swFCXpYLB@enceladus>
References: <20210322170301.26017-1-mcroce@linux.microsoft.com>
 <f5ef2e4f-fcba-2e06-86ec-17522744b6a8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5ef2e4f-fcba-2e06-86ec-17522744b6a8@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, 

On Tue, Mar 23, 2021 at 08:57:57AM -0600, David Ahern wrote:
> On 3/22/21 11:02 AM, Matteo Croce wrote:
> > From: Matteo Croce <mcroce@microsoft.com>
> > 
> > This series enables recycling of the buffers allocated with the page_pool API.
> > The first two patches are just prerequisite to save space in a struct and
> > avoid recycling pages allocated with other API.
> > Patch 2 was based on a previous idea from Jonathan Lemon.
> > 
> > The third one is the real recycling, 4 fixes the compilation of __skb_frag_unref
> > users, and 5,6 enable the recycling on two drivers.
> 
> patch 4 should be folded into 3; each patch should build without errors.
> 

Yes 

> > 
> > In the last two patches I reported the improvement I have with the series.
> > 
> > The recycling as is can't be used with drivers like mlx5 which do page split,
> > but this is documented in a comment.
> > In the future, a refcount can be used so to support mlx5 with no changes.
> 
> Is the end goal of the page_pool changes to remove driver private caches?
> 
> 

Yes. The patchset doesn't currently support that , because all the >10gbit
interfaces split the page and we don't account for that. We should be able to 
extend it though and account for that.  I don't have any hardware
(Intel/mlx) available, but I'll be happy to talk to anyone that does and
figure out a way to support those cards properly.


Cheers
/Ilias
