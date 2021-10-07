Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01E2424DED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 09:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240403AbhJGHM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 03:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240290AbhJGHMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 03:12:22 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BB3C061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 00:10:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v18so19301591edc.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 00:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7o7olDwHwdK5/Ab9HY2xquuMz0Q2unNj/qL+rAvTIwU=;
        b=MPiVJ/BF+xU4JgazGBkQUR9Fvke/QadJGvaQKcfTp1q3dNCCQYexxPlqAu2YSYK/66
         sK+E48UcTflM/KO8l+qkdM3QiQWKKAYgbCKsb4UDRrtv9k0XgiR5/X8XIQzRqWX7GXCG
         1cC6YqWFV3fW/vdnZXVywBmv9Is5fjQO8lDKWHvxJGVIJ+Ougc7lPvGTyMqZqzMsbYDS
         3pZOH9b1N2rpfcxmCXJpjbXJhfGAsDlfGZZVMyPRZZZSUQHyDx1UmFa/o2+Qer36/Pyp
         X7PIHQFzp5eAAYUZLUOl/7cImpyNXf1u+ltO3CFHCDYE8jG73+9RSBXaLGHb9+Pnpp6j
         UtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7o7olDwHwdK5/Ab9HY2xquuMz0Q2unNj/qL+rAvTIwU=;
        b=Q80z6f2Q9HCRrUFMfqDDX3fRdq0LbnHbLRG17lJIpwXao+9WeYed4A66ILxpeL82rD
         Kf7yc324NwOkOklJKrLN+Uv8QjAq6KJpTGGwCVNH9A2jMcfP6y2hnWoLfKtHRBlvC8PQ
         blBb7TJzVIX9GaTu/Rrx/Sp7Hm1fd4oE6AuxcUFjcncYCz0vOtAdmh22VLh1UUkpR+0R
         Mm5pv0s3PZmEqSJ9kkFw3hq2nI07+0AQV6VBVoRxO5mFnyWfnTiuMf1J+geUKok2yAeN
         7bjZHNfBWKHC4QSSKTE3SYKfj3UftdkLebG3hxVJno5G0p/rV6Z7QaJHAhKPoz0CORrP
         TlqQ==
X-Gm-Message-State: AOAM531AK9Zt2AM3/e2UKpNJ1HHT3W4dcP8GAfw+lXAv3a7uLSRw2GVp
        ulAvWOw2x6hB1Kk2hiPVrnM=
X-Google-Smtp-Source: ABdhPJzMzHSWg3H+huLcRx4zvg6jVlCs9hQepjt9bK4P6g2YBaW2g2NvTFBW0Tm77YaVgB2mLzUwpg==
X-Received: by 2002:a17:907:330e:: with SMTP id ym14mr2905201ejb.417.1633590627450;
        Thu, 07 Oct 2021 00:10:27 -0700 (PDT)
Received: from tom-desktop (net-2-42-54-217.cust.vodafonedsl.it. [2.42.54.217])
        by smtp.gmail.com with ESMTPSA id u2sm10521492edb.6.2021.10.07.00.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 00:10:26 -0700 (PDT)
Date:   Thu, 7 Oct 2021 09:10:24 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Yujia Qiao <rapiz@foxmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] staging: vt6655: fix camelcase in bShortSlotTime
Message-ID: <20211007071024.GA3113@tom-desktop>
References: <20211005205702.14029-1-tomm.merciai@gmail.com>
 <20211005205702.14029-2-tomm.merciai@gmail.com>
 <20211006080956.GY2048@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006080956.GY2048@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 11:09:56AM +0300, Dan Carpenter wrote:
> Looks okay.  Thanks!
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

  Thanks for review Dan!

  Tommaso
> 
> regards,
> dan carpenter
> 
