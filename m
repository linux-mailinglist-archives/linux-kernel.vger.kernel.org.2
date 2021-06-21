Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F6A3AF523
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhFUSfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbhFUSfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:35:38 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B676BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 11:33:22 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id s19so10465884ioc.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 11:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V9hTO10AkNz8NRDJWAaxrXe+AlagCaKGWm4tEECSYRg=;
        b=yiXtXAzlb4wbA8t2j0hNxLCiK5efN1SEnHiBQzR7+K0B9zbyixWOKByBVG73D2piQP
         2XeOBjk980BAYHfMfE8p72st1chv05CtjA8LtIgvTO6WluaOD0dNKKZEBsiy/aK51mBR
         BdAVnVoxNJbmnW3ET99wtdr4bG+SHWw79Q6rdDssenLMXbZ9fWA7v4rVz/7jhJNnKYLz
         MhCivhxFTJxq/3IRknpK8q677q5uKUlgZwlpvwdPdS4m8jDlLHOYkqLjTrnTE9DxK18p
         25O3+dmct1dQh+MOnHpo1FTFxff/aFsqmi5/ULI1HwjJSRoX2IDaOf+dT0BDjGky5LRl
         0rIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V9hTO10AkNz8NRDJWAaxrXe+AlagCaKGWm4tEECSYRg=;
        b=mtyz0U88H9mQgE5491aZ5m24AQyaLrDbrDB1TCjQ+xC49WuJt9CAMNRf6aS69w2qTS
         0Tl6yZ9ibD7uJI9EboX5q/NZV4QMB7PTaVW03q0HNq4zpDZKq8J7g2WVshaUsJJinP8g
         vMu1Z3mps1DRAJwUunufX7AwbcIMXlGSptPhsXZdY3VuLewxigVDN8NAnKC2hBHO3u6R
         Lxw23CLFfVfSu29+nDI9htk1eEcMvobU9ZPy8ak+h+csmmpW0uBgYLWMR9xOqyAMVY74
         BSnKHwMhL0tTraO6rnZjTT7xm2OzQlK5Owm21c/elL42T9Z1GoAUSUpC/DOoN7EzA6Yk
         Jy/A==
X-Gm-Message-State: AOAM530FQJWYMd0fk0eQUk1K0HGZOuwLG7Ep5Kx5bkbWJzthGZjn3s/u
        K1YcciujbakEjq2oy/QOxGNuOg==
X-Google-Smtp-Source: ABdhPJxHPtD+U7QA8wTOaOI9pyA4MlOVjpkqq7Pezj+/1WT2M8nspzMlMdHNi8VVzd3Uh3JQJGbBXA==
X-Received: by 2002:a02:1988:: with SMTP id b130mr19249583jab.44.1624300402089;
        Mon, 21 Jun 2021 11:33:22 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l11sm9395611ios.8.2021.06.21.11.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 11:33:21 -0700 (PDT)
Subject: Re: [PATCH] coccinelle: api: remove kobj_to_dev.cocci script
To:     Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Denis Efremov <efremov@linux.com>,
        Julia Lawall <Julia.Lawall@inria.fr>
References: <20210621174808.1489111-1-kbusch@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1587ee8a-c963-5004-cea4-19fe998a1cf4@kernel.dk>
Date:   Mon, 21 Jun 2021 12:33:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210621174808.1489111-1-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/21 11:48 AM, Keith Busch wrote:
> Using kobj_to_dev() instead of container_of() is not universally
> accepted among maintainers as an improvement. The warning leads to
> repeated patch submissions that won't be accepted. Remove the script.

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

