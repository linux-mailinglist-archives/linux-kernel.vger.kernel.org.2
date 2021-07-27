Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B503D74A0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 13:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhG0Lzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 07:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbhG0Lzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:55:45 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD889C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 04:55:44 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id c18so12025042qke.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 04:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xGmRZzizcfQYFWuVgpIlcNdw/vWl+k7h2lbS4vofnJw=;
        b=Ni4l0KC28YLJ0zBw4u5zCVT+a0uTq1NH0NX62EZdIAcRxNlVDKkSFtuxBISrSsV2qh
         LMpneYo5qc3DDIvftUiLHYCPBnxnxtTmdreqSCM0yUKYPY/0pgOvq2zUn09d6N0fc5Cm
         bhqQXSrXCXWE+GkrWyF17Zh0mdUMjxPmDr2LgGOMKuNz5bRUFPOEjXyOq0+9b7Dav1cE
         e1vj3HWYddD3EQ8J9DpKYImJheQH8FlLujgHc4r63ggQgvGx9jxszU2TcSARFEDLYD8s
         k/MAe/n/xSSZfft0KE80hVZL/0K1VBzEBeE/0Chf/UbwYimioAmIODew4HbT5td5qNWZ
         RLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xGmRZzizcfQYFWuVgpIlcNdw/vWl+k7h2lbS4vofnJw=;
        b=BQxfdt9yMPC+KgL1P3VJHSaG34XX8nnVi+i4Vz3NIoet82lpTcwxxbIfIGdo6u+iUJ
         2seukzVFYEkfj+ph+0FZ3+IpY647ADVtrLGNAqlt+28TC0EDyp7VDdC5HPqyPxmn2U2v
         CVQX/CQpAc9XH5cUk5n4V7Q607F7cI+7J4u4zMT5Nsx9WPcF8mj1Z06yzSiMESPmNrfg
         V+gD4ByutDt0tZ+pJjsdS/oMLJB8cul3EnK78wjqNLEOP0oTWgNnYauk/W52KoU03TbG
         wNUjpbCJ7v4zgdgc6aAZidPWcC+F95ICtdhoj/tk6sk7jDQhFGGx4YTwpYSLSQBkYg7J
         fAyg==
X-Gm-Message-State: AOAM531V8vRbUxkehcTdHe2RXP+psziNh8uG2CuYnh0nyvbF+Q4HXj1F
        bqv2qRfc9YHiWGQq0s8VvkowxQ==
X-Google-Smtp-Source: ABdhPJw+PgC1kl0T4uKspJqLwiD15ss6avKnjHT9BcvPyOnHJWMe0AyIYsLL7GC8glfwyTedjvmJmA==
X-Received: by 2002:a37:9986:: with SMTP id b128mr22397903qke.485.1627386944024;
        Tue, 27 Jul 2021 04:55:44 -0700 (PDT)
Received: from ziepe.ca ([142.162.113.129])
        by smtp.gmail.com with ESMTPSA id u19sm1215976qtx.48.2021.07.27.04.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 04:55:43 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1m8LgU-0090AO-LY; Tue, 27 Jul 2021 08:55:42 -0300
Date:   Tue, 27 Jul 2021 08:55:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        zhenyuw@linux.intel.com, swee.yee.fonn@intel.com,
        hkallweit1@gmail.com, fred.gao@intel.com, mjrosato@linux.ibm.com,
        yi.l.liu@intel.com, mgurtovoy@nvidia.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: use "ssize_t" as a return value instead of
 "size_t"
Message-ID: <20210727115542.GD543798@ziepe.ca>
References: <20210727032433.457-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727032433.457-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 11:24:33AM +0800, Cai Huoqing wrote:
> should use ssize_t when it returns error code and size_t
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/vfio/pci/vfio_pci_igd.c     | 4 ++--
>  drivers/vfio/pci/vfio_pci_private.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

This is a dup of this patch:

https://lore.kernel.org/kvm/0-v3-5db12d1bf576+c910-vfio_rw_jgg@nvidia.com/

Jason
