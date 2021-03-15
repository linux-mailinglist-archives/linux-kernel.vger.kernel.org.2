Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D56B33A9E3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 04:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhCODSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 23:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhCODRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 23:17:47 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC1FC061574;
        Sun, 14 Mar 2021 20:17:46 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d23so11373504plq.2;
        Sun, 14 Mar 2021 20:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=A3oSUi/UHyvODn2iAEgaYMBdI8ZfE1MGKpYHvzVlBD8=;
        b=Mcz2Kz/8NugpP2eOCFKYqqihaLdnfTlrIToa2jAfUAFtK8nF+8b5+HMC0iZWV7WwH9
         /gxJ460YRfAVfGqYFc+Cy8cMBcaQNN5n3Olq2FT95PiriNijtQPNgWARGlZQssZ/MvOA
         dI8d45hy7m5c/ryJv6ydeStBb9t9tjMczP0qgqFsuNMn0oBSUYk+EvQrJfvXQ1abJkdD
         D6f3SD25UB8Qqw6rzjgAmmdwxDCzXf/tn+1qCE2A109GgnOGnMgeG40JMkkLE7s56ywi
         pAmNRIYxEYIQ9D4DCKoaTBzNxhmjTg8F3iOkXfb3fP1Sq2Ka4AVhUqaKNUpkfeXX7TXU
         1kmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=A3oSUi/UHyvODn2iAEgaYMBdI8ZfE1MGKpYHvzVlBD8=;
        b=fBxdIOl1+XZ/vQYunfa304eHnvBpFG4NPie35jWJeDKIj7ReaEIoOncn4w2WXnyYBW
         ATaBehslVjXsHlLVhndTr1oUxU2qonKlLhZEop2OpMaYP43GI1teU5eGGNCSXWGuFlr4
         VSsGEDNXepXaVJVqlpgkCzOdy1O8blbMpH4MDP/PDoOpk6iiSkwAZGxfLCeDAujdvois
         ItOtiueET70tQhTZlW528thRsRi0oER3ebEmi0I2zfJSrxoqytVfHOxTovXFqzWn0aEs
         JXDczhIhBwTVQhkrn0AI/QQvtg7EwhwRuVVaNKkBZ9TGE1qL+pDbH6hI7Px0y1zoSwKw
         RGCA==
X-Gm-Message-State: AOAM530A5SlweLUtzqzDOB4pGRtnz0eGtCdf6VNRFx0ZfFRE26abAfwM
        3+Pb5pk+4Rd9DTuVqjrJFty8Qc1kaAwF7A==
X-Google-Smtp-Source: ABdhPJw8csEJ+/wV3Fc9v2//Qr1oJRddD+wFWsM0q5sBkVsiD35ZB1Yido7lA7a3WSDEcn6yYgIKZA==
X-Received: by 2002:a17:90a:ea96:: with SMTP id h22mr10351284pjz.24.1615778265901;
        Sun, 14 Mar 2021 20:17:45 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id k15sm11855229pgt.23.2021.03.14.20.17.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Mar 2021 20:17:45 -0700 (PDT)
Date:   Sun, 14 Mar 2021 20:15:31 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     joro@8bytes.org, thierry.reding@gmail.com, will@kernel.org,
        vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/tegra-smmu: Add pagetable mappings to debugfs
Message-ID: <20210315031530.GA15245@Asurada-Nvidia>
References: <20210314080653.29374-1-nicoleotsuka@gmail.com>
 <e1d3eef7-3d7e-b26d-79d2-f87969ac11f8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1d3eef7-3d7e-b26d-79d2-f87969ac11f8@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 06:08:00PM +0300, Dmitry Osipenko wrote:
> 14.03.2021 11:06, Nicolin Chen пишет:
> > +	for (pd_index = 0; pd_index < SMMU_NUM_PDE; pd_index++) {
> > +		struct page *pt_page;
> > +		u32 *addr;
> > +		int i;
> 
> unsigned int
> 
> and then printf specifiers also should be %u

Fixing it, using your previous changes too. Thanks!
