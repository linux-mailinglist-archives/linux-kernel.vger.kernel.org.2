Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02148355811
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345777AbhDFPfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243833AbhDFPdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:33:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59061C0613DD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 08:32:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id n2so16391150ejy.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ngPnB11Rpcpn6j95lYf0RFQG3fh878RPxrpeNe+ppTQ=;
        b=In+em3Cagf76ZFfcAAnRPlOcDr63uCGRsKH+1ZNR9xGyg2hY6L2IgKzMc1DgENfYKc
         PZTHLYIqAJDBRPPrq3mmAZ1M4NehV45GFYzXGsCtNnSiJdosoHNjK3IMNZCx8//heelt
         1squCfmQMPxtLjQo/zMNJDCRjQilbxcvToByhW/93Q35Rgi6OhVBSuRJPMpVA2IcKxBO
         SCjrVaO1EdMsSBaCKwJu+P8IY+atL+bLpgu/FLlCFqceXR4YnbkyxR5eEdOtDxSss213
         /vlg7yRmFS5jNGBNUkHdkua8rQMFE96dEpiIcyYx3lJkFfKoXjL4cLm+2nLP6hbJuBos
         ILgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ngPnB11Rpcpn6j95lYf0RFQG3fh878RPxrpeNe+ppTQ=;
        b=FABoStL/qj7kiD/L+NQ+e8JwSUoXOgG+GMBal7cZHPgsyRY2V6fLuf7xP/WxFNpTKB
         UR5utBevtuggg2rwUcV6yzouBH0S13OziKsx4+ZuveIDlXjZg7i7+AiZjtS0zvYB6vk+
         lRm1YZnpYASrpU+agKOxTbLyR7iwUxLItOL2j4wQb6adPAdZ9j7v2aoNblJEo4aO7CbD
         WuFun2u0GS9hk/d2aoqN5AxJc+qnpOsuuFjNdrhD/Fir8WBNkVKyvFO6wffADOoZraFJ
         27B1YCLHvC17moQdp/3ki6pxWiEcmQgegbDdkxFc/KiU15z8g/xw9dA9pYQoUeKjJpJS
         A5HA==
X-Gm-Message-State: AOAM5319KViwa30FRr85/XfYq+i5CbEVGl4n6b+fUcMbbXyYdHasI6rN
        GeLeYDBypTvJ9WaubDn3zc7hqQ==
X-Google-Smtp-Source: ABdhPJxBTCrBfzzVEuMPpPm6mg4voiraukMpw00AzU44N+vDeOW/nX58Vtb5To6nYmviQM2bZTZSFA==
X-Received: by 2002:a17:906:4d46:: with SMTP id b6mr8437549ejv.262.1617723165958;
        Tue, 06 Apr 2021 08:32:45 -0700 (PDT)
Received: from dell ([91.110.221.193])
        by smtp.gmail.com with ESMTPSA id um13sm4757402ejb.84.2021.04.06.08.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 08:32:45 -0700 (PDT)
Date:   Tue, 6 Apr 2021 16:32:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        drbd-dev@lists.linbit.com,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH 00/11] Rid W=1 warnings from Block
Message-ID: <20210406153243.GV2916463@dell>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
 <33a06c9d-58b6-c9bf-a119-6d2a3e37b955@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33a06c9d-58b6-c9bf-a119-6d2a3e37b955@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Apr 2021, Jens Axboe wrote:

> On 3/12/21 3:55 AM, Lee Jones wrote:
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> 
> Applied 2-11, 1 is already in the my tree.

Superstar, thanks Jens.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
