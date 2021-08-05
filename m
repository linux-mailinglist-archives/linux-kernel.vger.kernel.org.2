Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A953E14A5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbhHEMXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhHEMX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:23:29 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAFAC0613C1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 05:23:14 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 190so5969354qkk.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 05:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S4zS+s1qVPIzTO0H85R2WuDkxmB2UlVm9z/KPt196HA=;
        b=gp1H1Kzu98qgl2JIh9eTpxSNNmyA04LWKuZuMpDS+Lb3EPFLVquROPmsgbu4VZW0/g
         2jppRAXJYrnyb3MhnBRIck40kopbFuXU7EPzz7naWo7ScJuIF3jaftVPI5KUyM4JIemt
         wOHrKalIV0dzkH0x16xndWc7NuRnPraMNxpRCCxrw7N5zi3/dLTN776SJxHy5EcIAMOA
         51GhF4K4pXsVb6HRR+IvqpTPvkitX76Ue4VRqBfFtqZ4au5/2TthkzsHM04k13kVFJYt
         Xad67ihS1wXfF+8xpHlllgFuEy5G0dlaYijKkKlsO7+5mjs0tTezay46BKWtfV3QCQk1
         0Osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S4zS+s1qVPIzTO0H85R2WuDkxmB2UlVm9z/KPt196HA=;
        b=npK9V9QnU8cI1UNkr4281aZi0eu/Gas4CIdutkV4ebufQ/UVAJkC7s8tZi4AdEWwiX
         he1cNjGaH+WN140EdI3LlChdwcHKr7s9jxHvpLjXkGGtwwQWTdiicH/8ROvSb992dthR
         vKbFJl5f0JPfEcnmhVEAJb6Nv3Bdi/KZQiyjHxnIi3kos19B+D9p2SBZhV1qtKMpoq82
         8aCrESxIwd9GAL/f8cTfgkr89BELwOQdBDGxVIOjQUoYzkoYIokfNkswdaWLqW52cCnf
         FOJS3DZV0uKXkFbNPbdRmfiErxsnHTs28YyLuLeM5GqfBFZnSM9sT5g3Mo6n5jF+pNZF
         gRYw==
X-Gm-Message-State: AOAM530LVBTMIZ7VIrCHLucZJuFanCxgj2rrkvbTjt5TMjQKuY+OtuPh
        4sgeGcGIpP/hBwZK+OBs/RM4Kw==
X-Google-Smtp-Source: ABdhPJxPIESMe5yJCgv2TXoZZfltC98kYkOgvO1xmCb/FWPcCG+PZuA3W3UuQqsJ9qs5i04epGgJCg==
X-Received: by 2002:a05:620a:4441:: with SMTP id w1mr4556493qkp.272.1628166193934;
        Thu, 05 Aug 2021 05:23:13 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id g26sm2886229qkm.122.2021.08.05.05.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 05:23:13 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mBcP1-00DJR7-IM; Thu, 05 Aug 2021 09:23:11 -0300
Date:   Thu, 5 Aug 2021 09:23:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, liangwenpeng@huawei.com,
        liweihang@huawei.com, dledford@redhat.com, chenglang@huawei.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/hns: Fix return in hns_roce_rereg_user_mr()
Message-ID: <20210805122311.GJ543798@ziepe.ca>
References: <20210804125939.20516-1-yuehaibing@huawei.com>
 <YQqb0U43eQUGK641@unreal>
 <f0921aa3-a95d-f7e4-a13b-db15d4a5f259@huawei.com>
 <YQtdswHgMXhC7Mf5@unreal>
 <974d3309-3617-6413-5a8d-c92b1b2f8dfe@huawei.com>
 <YQvEbUp9cE5G535E@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQvEbUp9cE5G535E@unreal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 01:58:53PM +0300, Leon Romanovsky wrote:

> > IMO, if ibv_rereg_mr failed, the mr is in undefined state, user
> > needs to call ibv_dereg_mr in order to release it, so there no
> > need to recover the original state.
> 
> The thing is that it undefined state in the kernel.  What will be if
> user will change access_flags and try to use that "broken" MR
> anyway? Will you catch it?

rereg is not atomic, if the rereg fails in the middle the mr should be
left in some safe state.

Jason
