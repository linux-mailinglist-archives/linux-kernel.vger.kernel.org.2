Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA283D1D43
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 07:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhGVEeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 00:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhGVEeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 00:34:06 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096E0C061757
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 22:14:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id jx7-20020a17090b46c7b02901757deaf2c8so3913178pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 22:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x5SPZyEeIR7cDZy3lUojZmJw7O7Dz9BIOkg7BRhzZ2w=;
        b=bxJGU+QOwf3Ftj9yKJ3uVgM7FcgPQLcl11zYOrXuclg1uwqqHdVkAfbAmbiVMIAzoO
         FTvXRGr7731VeNA7/5RNTiVU5REGvxNLeS4BAPdJKSUKTlQqdrCasSAm1jJyvhtHjykq
         2B0q0XLD5tGB0LNrc5zHzfqJOWYVZKgLBcrBrqikptR0sQyps7KcsZZQZ3Pq7jGZB100
         ILfl+7IC0qiqO50fHamwHcBRRziKZXIJ95Z7utigNFPi9vVUYIyt/8S68hFDAU2/ZYYL
         /q51yoWGYe6nMZwGLfn6Pmn1h9If9SRTUxarGshuq1gJe5HfKD4KoIPaNJae6Iq42HLP
         mVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x5SPZyEeIR7cDZy3lUojZmJw7O7Dz9BIOkg7BRhzZ2w=;
        b=eYSgN7gOfcQuFXXuk3T492I/oE6QfThX0jQyAPDreUNXK2UI0kD1fE13Hk118PRX7H
         R26aJcQDwPbKzmQIthQNBGr32LP8hoF1gZjGNXtGGVLWuv/IE0RwMwqf9Z4gRG9+1rJo
         1fKrc8lRq1I9RDmN7b3nSCGIwxOuP2lkd/2ZYYTz4aqeQyWiFXn9LB3PGSfudajrihpT
         A0tfPREW604aKeNAOca0ulQWhxc8RKjNxO9+HIWhldulJLPDGrGmy2VhwIdNC2YSxf2y
         6BE3I9vmO2haAKYd3PfuJ6QTSHiPU45R8hlWtbPcrm+dp0cvHcfgKoGiS+8TWQInqbCW
         j1NQ==
X-Gm-Message-State: AOAM531y+IdPo39Dqq5Wlt2DyEjPxeTNGHHUyABaGcNapqTYzl7QG3Ld
        NmT7mnIBhwBn5ztbVjnerGjIGw==
X-Google-Smtp-Source: ABdhPJz+c56smMs/30jrQXG0ui77AzZEHDx4M8oXH02LK5FomM1u4knGmr1cv7pcbsAt2Rx58z/TYQ==
X-Received: by 2002:a17:90b:1041:: with SMTP id gq1mr7123687pjb.222.1626930880559;
        Wed, 21 Jul 2021 22:14:40 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id 26sm15414111pjg.8.2021.07.21.22.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 22:14:40 -0700 (PDT)
Date:   Thu, 22 Jul 2021 10:44:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jie Deng <jie.deng@intel.com>, wsa@kernel.org
Cc:     linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, wsa+renesas@sang-engineering.com,
        mst@redhat.com, arnd@arndb.de, jasowang@redhat.com,
        andriy.shevchenko@linux.intel.com, yu1.wang@intel.com,
        shuo.a.liu@intel.com, conghui.chen@intel.com, stefanha@redhat.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v14] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210722051433.3f2ix75wbi5pphp2@vireshk-i7>
References: <984ebecaf697058eb73389ed14ead9dd6d38fb53.1625796246.git.jie.deng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <984ebecaf697058eb73389ed14ead9dd6d38fb53.1625796246.git.jie.deng@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-07-21, 10:25, Jie Deng wrote:
> Add an I2C bus driver for virtio para-virtualization.
> 
> The controller can be emulated by the backend driver in
> any device model software by following the virtio protocol.
> 
> The device specification can be found on
> https://lists.oasis-open.org/archives/virtio-comment/202101/msg00008.html.
> 
> By following the specification, people may implement different
> backend drivers to emulate different controllers according to
> their needs.
> 
> Co-developed-by: Conghui Chen <conghui.chen@intel.com>
> Signed-off-by: Conghui Chen <conghui.chen@intel.com>
> Signed-off-by: Jie Deng <jie.deng@intel.com>
> ---
> Changes v13 -> v14
> 	- Put the headers in virtio_i2c.h in alphabetical order.
> 	- Dropped I2C_FUNC_SMBUS_QUICK support.
> 	- Dropped few unnecessary variables and checks.
> 	- Use "num" everywhere instead of num or nr, to be consistent.
> 	- Added few comments which make the design more clear. 

Wolfram,

Is it still possible to queue this for 5.14 ?

-- 
viresh
