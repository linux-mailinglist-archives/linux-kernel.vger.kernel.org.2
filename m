Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B4632AA8A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839639AbhCBTn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579859AbhCBRLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:11:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB653C061224
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 09:03:15 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w11so20631732wrr.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 09:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mX1oQEPcKVJjYx1zxGJSjbh+RBHjVv/IIai4iQJ5tb0=;
        b=G7rX3blcrB/6KfZenlUjPYCPO5X0w05gQzR1UCbZc6vBDui9uSgMSXMcSrXMjhfvcU
         60gRDupf7y5PAwUERWOG31jRjDOxuosZi33meXOabswREznANwpSeOiRgRxrskttUxxr
         j94u+xYz4nsR6rUnuC8Sw9gHA/0iszvd3jLqE0ozeHW2jyuSrqW4Q/sGjd2NtYJtZbIv
         OzzfF4LFd3XWa7cte3e7UmETKmTYyOGHvxbfV3wum1msqWJHDkSI2eculZcsRKuiXI3G
         H4LibHfQFT5Pp26CaoH4y6yc86A0Jo8Fyl3xGzAeYdvK2kDRLlV1jez/qWfOZGM9ZME2
         ZBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mX1oQEPcKVJjYx1zxGJSjbh+RBHjVv/IIai4iQJ5tb0=;
        b=lLOVqMXs8neT9KzUTAwyf1L0PUE2EAUFHgPLfJ3H2WNb7AZqR7wFF5aVTgDB7oIVZI
         uoqsthbmLokI00dBWo4WubIiL0O8fzDoo3HRn+59YkXhqLkCo1YSElvDeuLufda+9q8q
         T5vKjN+zuU+XpmNRxhYAQHO1bfdSwqBR+tR4vigDN2lAiyb8RndkJbN9uWN1J0GfPpca
         gzWNyGKQcxwTjJs4vllIgydRQ9hje8JZsF3qEVhN+5aZecjnHQu7PFv7Ghf+UftwKzja
         +V1/yEB1QOkcdEXMexoQlGbvu+v6CbD3KVLbZ2WGFlpD85cz7NjKOOBE4kN/QtJ0/0+u
         WQ5A==
X-Gm-Message-State: AOAM5329bnUDsq+8zU/gsg+fOhtLKcOpymirBk6VZ9gbd57+achbt1fJ
        iYJX56SEVHQ4wpUL9IBCdLZcOw==
X-Google-Smtp-Source: ABdhPJw6o6JhRDb7uIriZcofKK/xBbS5KQXksPFDjOwmNZoxBzfpbV54NnGWtm9BySRL8EVrTr9qfw==
X-Received: by 2002:adf:f848:: with SMTP id d8mr22887378wrq.64.1614704594533;
        Tue, 02 Mar 2021 09:03:14 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id u63sm3160870wmg.24.2021.03.02.09.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 09:03:14 -0800 (PST)
Subject: Re: [PATCH v2 8/9] mtd/drivers/nand: Use HZ macros
To:     Miquel Raynal <miquel.raynal@bootlin.com>, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        "open list:NAND FLASH SUBSYSTEM" <linux-mtd@lists.infradead.org>
References: <20210302163143.22998-1-miquel.raynal@bootlin.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ad7da99c-5385-02dc-5fbc-c9ae31903802@linaro.org>
Date:   Tue, 2 Mar 2021 18:03:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210302163143.22998-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2021 17:31, Miquel Raynal wrote:
> On Wed, 2021-02-24 at 14:42:18 UTC, Daniel Lezcano wrote:
>> HZ unit conversion macros are available in units.h, use them and
>> remove the duplicate definition.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Actually, I was expecting to have it merged through linux-pm as this
patch depends on 1/9



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
