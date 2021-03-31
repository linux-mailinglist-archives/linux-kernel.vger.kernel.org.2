Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C8034F695
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 04:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbhCaCXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 22:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbhCaCX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 22:23:28 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1D8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 19:23:27 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v10so13064258pgs.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 19:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Su8WygcebzFTKKCHgifUWkq3uQwHLbGcTbD/6QzhQFA=;
        b=Y9JiokHr5v35wkiv4jph4u8VPmOxHEinZssITTfyCCs0Lt/OnSRwzk1QcVs5oZn7Fl
         ULuUJWk+qSvXs6lLC2DDi+zocNiwfQCkaJWZUftdpxg8NV8bfzwXfT8hQwLeIyYCSKmO
         5eOCOh1MnfxJnn1arPbXS91+qAnoHqWYP8Zw1bIoLOPpObfLjtKQeeahkxOxfN5ZVKAz
         4CgtcEpHLBWQal9HaxfS3pwVvF9BZXo6z2QZ3+XDxCcMI7oTwHfPOxJtG1UlLbU+/goU
         jTgeY1TZtgLaBkKInJgwewhTwQxQviKsRuD60jZappGyBcwtBz3d1wUWr2TuLYJqAs20
         aANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Su8WygcebzFTKKCHgifUWkq3uQwHLbGcTbD/6QzhQFA=;
        b=R6usG9IScfiIAMSbR7oqQ73V5NIUKPzJNoqWbOr2RJO+rS7jHLnNXy9qzx9RQX1u17
         6jCo8CkGsRkXpMpzFos97CUDqTtFUrW8MI8ky0/otpiXHNPy9owcdGu02vDjnf5UA0sJ
         uKs9LdH1QALY26vbYRmlLM7Ao9avzLpKY/8kA8e72cmQgHkfFPWgyfUROScGNCLZw9wU
         xjj5W3JndpoeM8nwsjqa1wKFTV+MTuUKeMl2RKlm9j7UO9DT6Cz8V1wCHhw7sDYCyUTp
         AMNFEb+EpBahmYaDZ2pdg4rv1ul6ISIExvmHgrMhvOmSGaNPQHqXcz73vOer1j98iFis
         wYFA==
X-Gm-Message-State: AOAM5321cVvj9MbHxb6rOeCkNNScY40B1rIm7k4hSvIWlt35aASZKp9n
        Ybjr1s2V1k/FMm76ke/6SuUsbAGu43wEuQ==
X-Google-Smtp-Source: ABdhPJwuluuksfxHeEyLVs+MJP7emXaOY3QaGlTQNaveL0nFvokNM9H5dHQUv+3wpcbdUZItgxTNRw==
X-Received: by 2002:a63:e5d:: with SMTP id 29mr1001171pgo.450.1617157407002;
        Tue, 30 Mar 2021 19:23:27 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y26sm295633pfq.187.2021.03.30.19.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 19:23:26 -0700 (PDT)
Subject: Re: [PATCH] sata_mv: add IRQ checks
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>,
        linux-ide@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <51436f00-27a1-e20b-c21b-0e817e0a7c86@omprussia.ru>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <885d2384-79df-f2d4-0adc-5b6be48e1943@kernel.dk>
Date:   Tue, 30 Mar 2021 20:23:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <51436f00-27a1-e20b-c21b-0e817e0a7c86@omprussia.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/21 3:13 PM, Sergey Shtylyov wrote:
> The function mv_platform_probe() neglects to check the results of the
> calls to platform_get_irq() and irq_of_parse_and_map() and blithely
> passes them to ata_host_activate() -- while the latter only checks
> for IRQ0 (treating it as a polling mode indicattion) and passes the
> negative values to devm_request_irq() causing it to fail as it takes
> unsigned values for the IRQ #...
> 
> Add to mv_platform_probe() the proper IRQ checks to pass the positive IRQ
> #s to ata_host_activate(), propagate upstream the negative error codes,
> and override the IRQ0 with -EINVAL (as we don't want the polling mode).

Applied, thanks.

-- 
Jens Axboe

