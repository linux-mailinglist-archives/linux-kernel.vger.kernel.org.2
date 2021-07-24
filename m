Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6623D43F6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 02:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhGWXst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 19:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhGWXss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 19:48:48 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337A4C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:29:20 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id t66so3148166qkb.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qf6d8SRXv1lvTGNIT1Gr1+kbBtlMdmpvy2P7MIdCQCU=;
        b=NotMNJPtiWda/Z83VeqYVn1Tvo3zIyWM28lAJ03A1MtE75FbinSxcoodvtEZK3DPNo
         thZDa0pspMfmbugGk8QbOAzLK5xYC098P7RQXfaT8595umyyC7tlO501YAl9n0AnHW/y
         t2LUf5tWOx3Uq6uxM6qSKVAUu2gPKkFBNtqDDBZfOJiGTbai3n1UZy8rNkGMaX7b9Bwj
         STvudW9XdjlS3CzdLSXed+f0BwOCz1UB64k9V5R/uYF5wH4js11neBvELOCJDMjJuV3w
         IozLJRmet/NK+9joSIgOIvKw83lvXXsmWlJkCUbWDGOFHY4kK1oMqk7+ussjt6rKCVo+
         sZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qf6d8SRXv1lvTGNIT1Gr1+kbBtlMdmpvy2P7MIdCQCU=;
        b=Hz6DobsXKVumhRKKpv5IJfMEnkgM10NoZlinPcFmWoxNknG5PkAjedP0WbiUsvyjo7
         d07YmpB224oXJhuexCUBFQiAgn6QFTi37GL0ASZNpzJ4l9rY8X90He266j2qktUcyqeK
         Eq9VWNxvEj5n/VMYX1xvF5sfy3UnqgOcdDHadmKOT1YoYRMx1cz1+nk5Bpk58DrB7fBn
         OwnKSlbP7FzLNCcQowZ/muGbScBC4Au/HaStEpbXHe9OFREF8idklvmx65F3s6Hgv06G
         F2zFSP3egI04gaiVfNNalnjh2Lu38uB2nFda0PWR2sFvfdC817tFXelHd05wp2kDj1lM
         RQ0w==
X-Gm-Message-State: AOAM531UHr1hElk9wWPVWqQFAKUuS2qU0cgpkqvmTh9eBGSgAbox9JZG
        MbfZcShRswZCX2pscvN8htM=
X-Google-Smtp-Source: ABdhPJyMLqR3nayBDmkd63sKrmioXTMGScqttjDSlSqS/KFNaC/c42XefEHO1dentzlT5yAG7r/yVA==
X-Received: by 2002:a05:620a:2fb:: with SMTP id a27mr7121715qko.279.1627086559400;
        Fri, 23 Jul 2021 17:29:19 -0700 (PDT)
Received: from fedora ([130.44.160.152])
        by smtp.gmail.com with ESMTPSA id x23sm1041976qkf.36.2021.07.23.17.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 17:29:19 -0700 (PDT)
Sender: Konrad Rzeszutek Wilk <konrad.r.wilk@gmail.com>
Date:   Fri, 23 Jul 2021 20:29:16 -0400
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Claire Chang <tientzu@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 0/4] Fix restricted DMA vs swiotlb_exit()
Message-ID: <YPte3K+4PPjGAQt/@fedora>
References: <20210720133826.9075-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720133826.9075-1-will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 02:38:22PM +0100, Will Deacon wrote:
> Hi again, folks,
> 
> This is version two of the patch series I posted yesterday:
> 
>   https://lore.kernel.org/r/20210719123054.6844-1-will@kernel.org
> 
> The only changes since v1 are:
> 
>   * Squash patches 2 and 3, amending the commit message accordingly
>   * Add Reviewed-by and Tested-by tags from Christoph and Claire (thanks!)
> 
> I'd usually leave it a bit longer between postings, but since this fixes
> issues with patches in -next I thought I'd spin a new version immediately.

Thank you!

I put them in devel/for-linus-5.15 and linux-next.
