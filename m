Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183FB40B5BC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhINROi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 13:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhINROh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:14:37 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABFBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 10:13:19 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id z12so74593qvx.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 10:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bbnco7tVZttTiVHevv9Xt1I1fHW3axEITBc8rJrCa/w=;
        b=Shvajud6QYbTM2sviB0SEQ32NJUKczdFWtfTdTp1RaEP506Xq0+3ue1NhbAOVLPO6y
         9sgIQHT0vOx+9gNACsLxYqZdLQNes7cj2xJ/Km1kvUUCSPvcGIg06+5JR7UGVP1mIwJ0
         FxrvUvBqsR4kEEdgpmlvuSXelgYxd/ZxrDLfyLQ/QQ5iMkk42xqcRfARqaSGV3JwKZrA
         SEHieCwNBXwC2OduaVfaBxllg6eCH2eWPfNs2eCLDTHTqFJ3rA/AKPPq+nM9lRovpFdU
         mhJe4LET28PvOYlKo283pRXT3v+g0SO0GQzNO1vB4w2np3DVvPf+Pmd80uPl7iCVBb8o
         h7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bbnco7tVZttTiVHevv9Xt1I1fHW3axEITBc8rJrCa/w=;
        b=2bE0qFtfyng0Zg99jhYgpQyHgE0ssn0lOwCCz6/z/cLTsumMQOkZ21uVsaJvssHw08
         e2YLMhbEh+Cy/injvlXF1dNltk1V6w1clOpFJpLZthxsd/qkSF8KLnwldu/cgHHCAfc5
         N/xNeiB/jSTcEHUTrxQWGyfV5/g2xTxwdOpf727/Xnk0nDy2EvYtEYb72qbDHHPUqFUg
         9kEYMD3l1XBzLp0sAcRGYh49+5Cy0+H3VoJGa/AlBuPkyM4a1GT7QqGPI3dSuPpDX14Z
         7/sTaDX66oCNLdr+AePcmO42uW0/pEeUOw884RKp7S+mUpUorGuLRHtW5jvLYO5ojMWc
         23xw==
X-Gm-Message-State: AOAM531d1f7V13LdAnefwDQEi5RwFfGBrkqLKbMn5Bw/rcRp9u6kSnH9
        c6vIR967ebHUdP5JgUW08JAs1Kp2fDEwVA==
X-Google-Smtp-Source: ABdhPJw9OLyImsITOs3vQXeqzfyvcNKfYnpWj06FRYMOnA8ztNhA+35jxsPV8fyKXUvDUM6vdi6dpw==
X-Received: by 2002:a05:6214:2e4:: with SMTP id h4mr6551287qvu.3.1631639599017;
        Tue, 14 Sep 2021 10:13:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id z186sm8101157qke.59.2021.09.14.10.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 10:13:18 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mQBzh-000XMK-Li; Tue, 14 Sep 2021 14:13:17 -0300
Date:   Tue, 14 Sep 2021 14:13:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/29] ABI: sysfs-class-infiniband: use wildcards on
 What definitions
Message-ID: <20210914171317.GG3544071@ziepe.ca>
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
 <df195c1204a56a9a83926e6a1a38fb91a7221869.1631629496.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df195c1204a56a9a83926e6a1a38fb91a7221869.1631629496.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 04:32:28PM +0200, Mauro Carvalho Chehab wrote:
> An "N" upper letter is not a wildcard, nor can easily be identified
> by script, specially since the USB sysfs define things like.
> bNumInterfaces. Use, instead, <N>, in order to let script/get_abi.pl
> to convert it into a Regex.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../ABI/stable/sysfs-class-infiniband         | 64 +++++++++----------
>  1 file changed, 32 insertions(+), 32 deletions(-)

Acked-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
