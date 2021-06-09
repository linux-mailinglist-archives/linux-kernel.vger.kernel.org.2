Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FBB3A15BB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbhFINgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbhFINg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:36:28 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE30C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 06:34:33 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id s70-20020a1ca9490000b02901a589651424so3241317wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 06:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4saDlChR+RuvHPGRsi4z0xuOYFPQYvYKCEMLsyCqzts=;
        b=mT8xmEwsva2RWOzg9GTBeuJ4HZupNdWelO0n8QJg+EU9VEOZ2CGcwVBkrdigkGIswq
         yUTV+H8x2P8BeRwEnGAIo0shA3xuNheHLaWAv7w1sBfVkhG47vxYmI7b76Z6/DpvQ0vX
         aUp9wkl1YP0YdLW+NrRkj32B9yVHPnPh/L5MwrvJCN7R1VXZ9+RTuc1WIGEvuirQkKzg
         0ZrhbLCyDcao7O/gmpwGwIEl/Kol4c8oRMjviylBoSFDJiBrWCP16stXJcseE7vfvi11
         wP5RsapFMxJu8EbSZ2IOt2gLZipP7jpfSKMxwQOu9LVqUhfiTyp6igYkujhdPq4ihZA2
         9kyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4saDlChR+RuvHPGRsi4z0xuOYFPQYvYKCEMLsyCqzts=;
        b=C8GJQQ9uLkQVjIadnmyba1356F1NO1Bvgea+n+i9DAHoaWEm3JS6xSHzhOk+nXftuM
         ndw+fqmFW8mlY9f70j2rBxnT9CkQJTbZ8k6SqeqV5OWQL05U0WkmEtTK9LUTstn9Yo6s
         tIuAhtwjm2qVpmF1mron5WSPUGZy4oWUO2P+KSGkJ0B/12tTtwdpjo8qqGdocndDg1cT
         2M3q/RRJc8Iwpr1ix5NfHitgcYvBwflsw8wH9oilhzH19H+JbSsVc1C0lGQ44R2MOyo5
         L4scJ/etU9KXW3gjjrc/okr1wACT5tu6QUzclH4x6BtgHbrk+RYSLgaa15A19YxtXnfn
         MONQ==
X-Gm-Message-State: AOAM533bHJ2m9ABX2zCdRpyyrnDgkiRcMYMKif8zunqTDeEjaTWUBhXN
        /UBNwlnGgB7GRg9c9e65xa3ogA==
X-Google-Smtp-Source: ABdhPJwYtQRehX/ldUS18MDWwYYZ27ctlbQ1XpeEyR3fN4K2ALfBatOJhZqCN/XBWhZpl9xlA5By/Q==
X-Received: by 2002:a05:600c:ad2:: with SMTP id c18mr27456842wmr.93.1623245671854;
        Wed, 09 Jun 2021 06:34:31 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.73.197])
        by smtp.gmail.com with ESMTPSA id b62sm22153441wmh.47.2021.06.09.06.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 06:34:31 -0700 (PDT)
Subject: Re: [PATCH] tools/bpftool: Fix error return code in do_batch()
To:     Zhihao Cheng <chengzhihao1@huawei.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kuba@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
References: <20210609115916.2186872-1-chengzhihao1@huawei.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <7883956d-4042-5f6b-e7dd-de135062a2ef@isovalent.com>
Date:   Wed, 9 Jun 2021 14:34:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210609115916.2186872-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021-06-09 19:59 UTC+0800 ~ Zhihao Cheng <chengzhihao1@huawei.com>
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: 668da745af3c2 ("tools: bpftool: add support for quotations ...")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thank you for the fix.
Quentin
