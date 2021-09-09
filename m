Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B399E4058F7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346605AbhIIOZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344364AbhIIOZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:25:51 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A2AC120D7B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 05:58:16 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id m11so2127448ioo.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 05:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xtXEmCkgLjj2ICcn/5G5ZZlK2SnZW1IcakfDyVuInEA=;
        b=hB6xV2U22F35EshU9H4Y6s6DCeylbHAC/VYNgUqb5P03tlfg8suiMyms6Ulz+KWw7o
         PGzgv8eA5+p9RnyJctVqWIv2Xyf++kBehqOOaYe34EIRSDjYzfjAwYE3HiYVyhQ9rHGU
         boS/wzrrgtIefOtlhcfW/UrPgIZFc0qHYbxhFQF1HmcbKBGk5vTqPQBtLqHXV0Pd45IC
         niqe22DM+7zzFfTjKljcBcDwdfJq1boitMqFKRGjL+tVpI8xaH8VYiHRnMcbSrt3Fj7g
         ALLEfHozSHiTTSc6fvxJNa/e/ifhwub0NnAkAsAT1DcOUWiLPQW+vaBKX8V1oNghIb+5
         90cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xtXEmCkgLjj2ICcn/5G5ZZlK2SnZW1IcakfDyVuInEA=;
        b=K3+2S7i7PkkZATolP7ysLwXnTfhDL/U7AYq6xV64Z46E2O7kh3PQo7ZlUbpvL524ga
         JU3EU9YrDyf4OUWYYlxJLiWbk3hjOeE114iCifWl1OEeF9jfQqNIF8lXVSaBXAuQgeX8
         DJeJnvfG9NLupoEuicYGynErWoE+tbswUfBMwR7XsEvA1ugo0bM4ITIqqgOf6YkQe81P
         7srWeeHwzxJZiX3vjciyHju8bg3IkRdM8fd2XhV6aX5A3obra2VA2Z/NkJRDpuRqCjLn
         A12kucicAZDAKccbQ3s98rnByN65dlGFmV0yktFayVo3EwbzSKR+empV5f2ZaLaFraYt
         nJpw==
X-Gm-Message-State: AOAM532FJUhaXEUf5KEIfkqTwNRUl88v8EzCVqaUPYeoEEn9k2KkgWJX
        GGBq2IMff0bK1a6Owslm8oRNeQ==
X-Google-Smtp-Source: ABdhPJyC9BpbGwDqu0GxL7mOtDLS4R168asvGRVWOhfSos1bWN9ugSXqhGImveQTNEcWGV/AFqBQZg==
X-Received: by 2002:a6b:905:: with SMTP id t5mr2566323ioi.209.1631192296197;
        Thu, 09 Sep 2021 05:58:16 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id a4sm837736ioe.19.2021.09.09.05.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 05:58:15 -0700 (PDT)
Subject: Re: [PATCH -next] io-wq: Fix memory leak in create_io_worker
To:     Bixuan Cui <cuibixuan@huawei.com>, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, john.wanghui@huawei.com
References: <20210909084919.29644-1-cuibixuan@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2a63f105-c2a9-7c57-3101-ba7779cccb6d@kernel.dk>
Date:   Thu, 9 Sep 2021 06:58:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210909084919.29644-1-cuibixuan@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/21 2:49 AM, Bixuan Cui wrote:
> If io_should_retry_thread is false, free the worker before goto fails.

This one is incomplete, see other postings.

-- 
Jens Axboe

