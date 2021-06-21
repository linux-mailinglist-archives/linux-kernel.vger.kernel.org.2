Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6453AECE0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFUP6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhFUP6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:58:11 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81AAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:55:57 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id o5so14593765iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xoGOR6bNmxcId/Ee4H0L3QqG5xTZcJdVQzkm9X75obA=;
        b=cLyyjm85xcRaukag+4YfWF05RrRrM5THsTgk3lgojaD9eyyXlB02Y878yEtdIDexBH
         C9PMEfIV9i0GgVpmn6kvkkXhw0pXGt+Altx9T7p620NH3gaf2/+R8ymXrc5WnPbPFEdl
         yQIDceu8yNer6gLKy2Q+WZGWv9IbYztvTy9LPqzy53df3Yiwj+Wilr1OPQScNkq6mHFG
         n/E8xwAKpsjkvV/Q70gd5/TwWf4oppLGjPYzeDeqljmbME4JtiSw0x5nyNgmdUyjrGgm
         1HwWn7I3kcBILp5LbsStc8bjJ7sUildTpo6PbCJA5+6OadcY7PQ4YLv+QIqhTRFYzxy7
         NnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xoGOR6bNmxcId/Ee4H0L3QqG5xTZcJdVQzkm9X75obA=;
        b=lsF9TLgcBxoMYlBszgfKiiUUQhzn+ahlyCXrCSpJbJBIeQ2/AyeRACoGW5YseCcHrV
         wgJOosTErJcCIHrnLmWPpjqoytIHDNdnFwFlXdMv4auHFmRLrnaTnS0vcJ3tHTvaDfV2
         7pgNnH1F3XCzobB5Awy92wAxusnScqyacQ7HmZS1gJvFUv+mHa87oeq+MS0Vb0Ou8WGD
         MjdazdxX97Yw+d9vXHtELSZ7BjtrTrVKnJxBFsPSZNg/dlcPjkEa4Z5lNTa0l8r57Cj2
         NcNke5vWvs31mvDceqDThiX7J9Wl4a4Wd6Q0b+Yby+HD0GiR4KDSV0pHx/Y89Ev12mUJ
         kKlA==
X-Gm-Message-State: AOAM531xmsRGfXjtyAGCoepvlrVxMDwgO4c5DHn5nmrfIor10/emsS6+
        0tw84aE235xWmTilZVJa35WB7g==
X-Google-Smtp-Source: ABdhPJyjeB+QKOUeOmsHQDOPSMxVdqE8D40OUJJzhCP0YyuywJf0TJyUhYLoz9IlAS5JaNIltvUcfw==
X-Received: by 2002:a5d:9059:: with SMTP id v25mr20266419ioq.113.1624290957096;
        Mon, 21 Jun 2021 08:55:57 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x9sm10378909iol.2.2021.06.21.08.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 08:55:56 -0700 (PDT)
Subject: Re: [PATCH] block: Include mm_types.h instead of mm.h
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20210621122407.3116975-1-willy@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <490a7c73-74ce-6a17-b16d-629d433d0de1@kernel.dk>
Date:   Mon, 21 Jun 2021 09:55:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210621122407.3116975-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/21 6:24 AM, Matthew Wilcox (Oracle) wrote:
> There's no need to include all of mm.h in bvec.h.  It only needs a few
> things like the definition of struct page, PAGE_SIZE, PAGE_MASK and so
> on, all of which are provided by mm_types.h.

Applied, thanks.

-- 
Jens Axboe

