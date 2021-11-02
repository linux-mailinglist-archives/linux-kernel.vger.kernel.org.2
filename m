Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A11A442EC4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 14:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhKBNHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 09:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhKBNG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 09:06:58 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94964C061766
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 06:04:20 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id ay20so4203417qkb.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 06:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dn4BqaMm8E/Ym9b6CTx4iFhLLdRskhG8/BnMWQZMYiA=;
        b=CV7GUn5h7t+R98AniHQ+e3FbXFOMEsvZSd1hvuNMLgjeEftTO6nejnTl8CX3JEks84
         BrapEDNZbfWvf92QCz0OUemnwTATzFp37+VH//NuzccwImZ92esGMPDXXoqCuNIynyNX
         nyo3+OojZlZreduNyWOMdGQjy6xy2QhhQBbv10q8vmkX0R6az/sP1MXcB89v7TeiMEss
         2cKH6f+rR5UqoGtizvM0KK/8l1nLerqgDl2QbZ6ozhAF9GREznf2k99QroLvyvq7si5W
         kzi7SJOc/AObDiez/X8TwMNpd05WjseQc8SLwlzFMBH1kqlL3Z6P6cqVkzIuVl56U+of
         AzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dn4BqaMm8E/Ym9b6CTx4iFhLLdRskhG8/BnMWQZMYiA=;
        b=VSYac7RPwYPP0Eo3lJc0rFmFpROSW6LbmtXLQK10BICgIzlwt50U8lIjKBK/c7D9Vl
         Qu53oIkbcgvPK6fHzpLd1d0vFRmVzmVwF+XOQxScjFsjhpiHZQCTjvgcF36CYgqSCb5n
         j+NwZjnjwEbiwesewaxN0L1Ngu6VGcvMd1F1L4r8SVKRPwctrn+PRBteiIMfA7KEAHxE
         tpFdsW2HigOI794YP1/KU6u69O+CE8nX6PwHutFjj/SS03h6AO8t09eSvl61UUgQ+Og2
         f/+CloVAhWwCc6rMRWTk+qJW/TtzstXRjQMGm8g9q80uYm6NO/q2+z5QvQbjE6CYKTEp
         0TDA==
X-Gm-Message-State: AOAM531E4PhcoUMf/wdlbzfh3Bdh+e11n3OmMdICf1dhTt5AwVCJqTIx
        kwx41YXKQ5FPTDIzRZLiXQ1zYg==
X-Google-Smtp-Source: ABdhPJwM+zF/tlJ4BLYeH2ZKxc5LHh/BOCcEJcjNkHrZZDYjDhcr8F0U+JBW/PrHDJZEppOhOYYJqg==
X-Received: by 2002:a05:620a:4015:: with SMTP id h21mr28584785qko.300.1635858259569;
        Tue, 02 Nov 2021 06:04:19 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u185sm11980615qkd.48.2021.11.02.06.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 06:04:19 -0700 (PDT)
Date:   Tue, 2 Nov 2021 09:04:16 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Ye Bin <yebin10@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v4 0/4] Fix hungtask when nbd_config_put and sanity
 check for first_minor
Message-ID: <YYE3UK//36MbVzC3@localhost.localdomain>
References: <20211102015237.2309763-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102015237.2309763-1-yebin10@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 09:52:33AM +0800, Ye Bin wrote:
> This patchset include two patchsets as follows:
> 1. Fix hungtask when nbd_config_put
> https://patchwork.kernel.org/project/linux-block/list/?series=573381
> 2. nbd: fix sanity check for first_minor
> https://lore.kernel.org/linux-block/20211021122936.758221-1-yukuai3@huawei.com/
> 
> I have consulted with Yu Kuai, and his modification has also been confirmed by him.
> 
> Ye Bin (2):
>   nbd: Fix incorrect error handle when first_minor is illegal in
>     nbd_dev_add
>   nbd: Fix hungtask when nbd_config_put
> 
> Yu Kuai (2):
>   nbd: fix max value for 'first_minor'
>   nbd: fix possible overflow for 'first_minor' in nbd_dev_add()
> 
>  drivers/block/nbd.c | 42 +++++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 23 deletions(-)
> 

Perfect, thanks guys, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series,

Josef
