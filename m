Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50FD30B3AB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 00:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhBAXpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 18:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhBAXpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 18:45:06 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91D7C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 15:44:26 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id n8so5353846qtp.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 15:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hd15FyljMQNb+uHNxQHOyHL+pJdt7H/rF6CqnCRNxkk=;
        b=k2UK7o8wQKpImEwvMcIofjhqZsF1yjn8WEus+jyV+wEKwNI6Pdakb/8qDqgA9xjczP
         2vPN1SEc50w2MpyQ7LD+ynXBrNS0ZUMPypuqH73q3LZlHiLudFcbUX2YEdbVreK9GYci
         hvcm6XoNqV/208cemLwAqA8+PAHjy3gR92TFTOvBBJo7+cm3ioe3aJ52NRp9dC77mPPw
         oDjDm0ZwCbl0N5JT1o7/W7KfF4QzaCcJx0mZ8QBXv8kRecO95ouX8OEHg3EnsSZjoY8b
         iZ3BuClJKbypxdM6+deF5MQjc1yclCNHXNUNBUtjO3Rt+RPjmfdltzBcWVgFq5Wf8gYo
         bQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hd15FyljMQNb+uHNxQHOyHL+pJdt7H/rF6CqnCRNxkk=;
        b=WfrViVDmW8w09CyQt4wlfcO+VND4VunItHdksdFW3QrCQSYvPGWdxkCrMWKvPv1fzW
         Hv8H1MT5USW5bVSExR22GhB1VxEfMsqo7rb12n9MzgPSZCucSHUoiZry710q1zJ0Div5
         KEyMb1d8694MJKLP4cXJfr1ErBRzYBVCJanYxKFN+MiKG3eAHLHLvC2lekW2ec/47oyP
         JVy70xphjM04nVvSEP0/j4BRaTDxnkcL9NaZiFpzluAzQ1gKAdAm+e/SdtvSThWD3im9
         suTbfDBRX4dFYM/kP045syuZr/Lob4H4q6qVrzy3QHw8Xxsfggwps46sXWJtBTrixcQ6
         +6RQ==
X-Gm-Message-State: AOAM53249Z8scFJ05DLJJyKvNJ0XU3YksRZTby8aWwVpwYdlh14FSpX4
        11qzOwuv1sGX2XEn+JftlcCnU8+GzWJ89rrl
X-Google-Smtp-Source: ABdhPJxOk/Gr3FI8hipqpO78EuQbpqBCvzEwZtZKwnaYmY8JYjMc8WYuBvCPpUv8lB3nlvifrKdI9g==
X-Received: by 2002:ac8:6c48:: with SMTP id z8mr17373676qtu.252.1612223065836;
        Mon, 01 Feb 2021 15:44:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id p22sm15466415qkk.128.2021.02.01.15.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 15:44:25 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l6iro-002MnI-P8; Mon, 01 Feb 2021 19:44:24 -0400
Date:   Mon, 1 Feb 2021 19:44:24 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "chensihang (A)" <chensihang1@hisilicon.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>
Subject: Re: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Message-ID: <20210201234424.GI4718@ziepe.ca>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
 <20210125154717.GW4605@ziepe.ca>
 <96b655ade2534a65974a378bb68383ee@hisilicon.com>
 <20210125231619.GY4605@ziepe.ca>
 <5f64a68042c64f37b5cba74028bd2189@hisilicon.com>
 <20210126011304.GZ4605@ziepe.ca>
 <d7fce136c3644755a7aea5794bddf453@hisilicon.com>
 <MWHPR11MB1886DC78C5FBA3636B94F2578CB99@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886DC78C5FBA3636B94F2578CB99@MWHPR11MB1886.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 10:09:03AM +0000, Tian, Kevin wrote:
> > SVA is not doom to work with IO page fault only. If we have SVA+pin,
> > we would get both sharing address and stable I/O latency.
> 
> Isn't it like a traditional MAP_DMA API (imply pinning) plus specifying 
> cpu_va of the memory pool as the iova? 

I think their issue is the HW can't do the cpu_va trick without also
involving the system IOMMU in a SVA mode

It really is something that belongs under some general /dev/sva as we
talked on the vfio thread

Jason
