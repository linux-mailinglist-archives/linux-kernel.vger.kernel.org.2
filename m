Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E5C39EA4D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 01:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhFGXrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 19:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFGXq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 19:46:59 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5F9C061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 16:44:51 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id w9so9833695qvi.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 16:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6XCJpSEDadig6sMG+TdcRvTIObt8/yYhSTOVOPCPdvU=;
        b=VbzBYubaVD4swOTb4rPS7L/p9xMaRhJuFVItELtgYh/ORMf1g5fvVelhNSA48Bh89A
         ZJVGc5N0mxVB5nqlpQkReCPPpCHrW0yUYV4VpEKpwFHVuyOihAx84mzKbflnNLCSZE1W
         rzp4ulkMUi20iRcF6psMlPxSVBmZ6gi67TWvm9p0bFUApzq5nkqtLzT0inK+W7E9M9H4
         5wWUImQ77qqlkwOQ/kcjdZ/bJebSkWWWus8q9qwJjTt/+z05cXbb/nYa3DK5wPmyaBvY
         HZ8VikomV53UDTlFWq0zVWjZrHN/Tvwor1m9O+4+7qcXEr6tirya8ogvTi48m4xtTDLt
         FWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6XCJpSEDadig6sMG+TdcRvTIObt8/yYhSTOVOPCPdvU=;
        b=VtrNqwhd3YbDBTf69mKi7gf9z2xEmqfAak7BVAeTuzCSoazuDGUSuxG08bG89rLW8t
         BUAg2ddtBgUN0LZirfNHtWUkj1F45B60ShLNQ79EFOesFzdoH+CBgSgJ8PobRsbbFm//
         iuFMXIxIePWYuWm45IAu9fFxwhdBy9QG4gqTQ37na3Gp/TY/PLcsMXDcVCAgHrCCBDNz
         19o/QaioZEFfRyGwlFaqu0eJjmrOSTOU0ydGlrOeCEx2vqhJZbi97k+1tspUdODacMPN
         mL5EmXNosk/91cB0XQmOmlex0CdNE498MPfHnfxcer/MXK7ZivOcTx8UqQXx/JPTxXGo
         OJGw==
X-Gm-Message-State: AOAM533uG1eNl58wt5ArCKtGWJwn1cFUWO+0X7VFxPlkv1bygu4PSKKU
        Vn1SKEPSt2PJFe5QKNjJT29RfQ==
X-Google-Smtp-Source: ABdhPJzZ7oHyaAgt7NfSCX9DX96GkWdRACUbNIvX+6PkpVmenL2OTjkGxU4L0pCUImVKNUN/0Ug2cw==
X-Received: by 2002:ad4:4783:: with SMTP id z3mr20454991qvy.43.1623109490775;
        Mon, 07 Jun 2021 16:44:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id w3sm10991844qkb.13.2021.06.07.16.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 16:44:50 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lqOvJ-003WaD-9Z; Mon, 07 Jun 2021 20:44:49 -0300
Date:   Mon, 7 Jun 2021 20:44:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Pavel Skripkin <paskripkin@gmail.com>, dledford@redhat.com,
        shayd@nvidia.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] infiniband: core: fix memory leak
Message-ID: <20210607234449.GP1096940@ziepe.ca>
References: <20210605202051.14783-1-paskripkin@gmail.com>
 <YLxbbwcSli9bCec6@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLxbbwcSli9bCec6@unreal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 08:21:51AM +0300, Leon Romanovsky wrote:
 
> I think that better fix is:
> https://lore.kernel.org/linux-rdma/f72e27d5c82cd9beec7670141afa62786836c569.1622956637.git.leonro@nvidia.com/T/#u

Can you resend that with the bug report in the comment?
 
What is the issue? Some error path missed a restrack_del? which one?

And I still dislike that patch for adding restrack_del and undoing the
previous patch which was trying to get rid of it, but if it actually
fixes a bug...

Jason
