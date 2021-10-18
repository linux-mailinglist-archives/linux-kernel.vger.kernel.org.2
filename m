Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BDB431F47
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 16:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhJROSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 10:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhJROSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:18:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91907C08EBB4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 07:02:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 63-20020a1c0042000000b0030d60716239so10492876wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 07:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xu0wFpMnPTWg2SgsHyUSQQQ2dykx7iBeuhvTdw0+bPo=;
        b=t/0sng+l7qoH421kLSngqcTkeSOzBBBbnACXXIPA5Z6nT1d4ZWQozmAPjq0iwdttZP
         XOGwm57RDENxODAcRQIdJEZt/m95DpFS2cWnIOSQnOP5enZT6ZUEPSIrCUIorahfoSQH
         AV/SmpIbdya/7JKFhP5zBDHS4vNP3PvjW86wCZELjop6s1t/Oq7NDXX7z4q3PU5WIRmY
         Mjngrm24M7FUDMq9nHRl5CfNv0RcUoHDfy1DBI+7VjT5GpoFUn47Dg3vBaaFvdhoyajk
         jEYrtS7LKFu7LeZTNN5T+j9EQsI2t5rp/0rNxEFxVq85IKukvasEl4OIPkrL+L7QLzyP
         QdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xu0wFpMnPTWg2SgsHyUSQQQ2dykx7iBeuhvTdw0+bPo=;
        b=m6WocGcOyO3oA7q3429rtXROIgCnETqY88Fs2xZG7KglFAToiZVhWgUxlc+4izsfx4
         LVnJnhydfX3HgHsm+p01o1KRBZ+q3+QFSOjXlBGWrQ94Ik/v7Yol/ETzcwGTJbN3MsOz
         L1g2CfQ0cqWpbuZYybvBYG66hhnD5gtpF8Xq2urjh5id82LqUtIxRpqagU0UfRZGpehs
         eQsJ1ZIlZYg+FUeOR/yiSeAyDGjbhOkYBujsvmG1Tl27zksZdW599iF5rh285bz1kSr9
         Ft39Dz1qdEQ8nc55yl/2DQEErPrseXzPuZBj0qz50LWrJB5uqlaUy8rRcLelHkONCXFc
         Rc2g==
X-Gm-Message-State: AOAM5324pn8usCt+saxPPu9YdJn5uKqiRUCwR4X50b1/Xkwx2fGtXJ4w
        IHO6FQlsuHdKc0FbqHyJ+1D+aw==
X-Google-Smtp-Source: ABdhPJy+DNjWEsIk9DPKxeraLdCuiMO0FGqV387zfb6YutR2yGNBgTNIzmn5PPAv2wFmoTUEHVFqwA==
X-Received: by 2002:a05:600c:2109:: with SMTP id u9mr30496641wml.68.1634565758047;
        Mon, 18 Oct 2021 07:02:38 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id y5sm12210314wrq.85.2021.10.18.07.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 07:02:37 -0700 (PDT)
Date:   Mon, 18 Oct 2021 15:02:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kai Song <songkai01@inspur.com>
Cc:     thor.thayer@linux.intel.com, zou_wei@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: altera-sysmgr: Fix a mistake caused by
 resource_size function
Message-ID: <YW1+eiaWZDRTet21@google.com>
References: <20211006141926.6120-1-songkai01@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211006141926.6120-1-songkai01@inspur.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Oct 2021, Kai Song wrote:

> Fixes: d12edf9661a4 ("mfd: altera-sysmgr: Use resource_size function on resource object")
> 
> The resource_size defines that:
> 	res->end - res->start + 1;
> The origin original code is:
> 	sysmgr_config.max_register = res->end - res->start - 3;
> 
> So, the correct fix is that:
> 	sysmgr_config.max_register = resource_size(res) - 4;
> 
> Signed-off-by: Kai Song <songkai01@inspur.com>
> ---
>  drivers/mfd/altera-sysmgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
