Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814C843ACB7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 09:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhJZHM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 03:12:59 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:47512
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232658AbhJZHM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 03:12:57 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D97BB3FE01
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635232231;
        bh=bAjnGbbToGkMJN6qgH/QciqH0NHDxLWtaKjqkfWGonE=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=KjKA0cP2miRqPqU7vAveeZD6JF4f0i0N0CSOJjj10DfV4z1HdVbsjAnSxrxjAy5FZ
         ZvdGNoIiMtzbTsn+28rXwXHlc0Mwu0e2xT12K8XnXFkXa9W2+QEh8sEm6e2ZS7kuRZ
         hezQe3FyKu+Z3RHjxPIfwPXfWbDowx0n9Vr1tYp7rfFNiU64h8zMKVfX8uxxvmUsCt
         HziT7kYXUF65NSOyQeiBSzz7Zp5JS5hRoaOj4JT4hy9UTcJsNa3yWygTVGhZNSviXU
         4Fw67674mTW0IFrFhdXm4OsgFBs4P94J82qY/7QytrXh1119ogstLUQv4bbbS0lZJl
         AisF7huYbgtOg==
Received: by mail-lf1-f72.google.com with SMTP id x17-20020a0565123f9100b003ff593b7c65so5899267lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 00:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bAjnGbbToGkMJN6qgH/QciqH0NHDxLWtaKjqkfWGonE=;
        b=3D2WH+DB84XltKZLPg34DyiWr80EZsX03/eehsDvj1M2GdC8S+v+LW5LTeVaqUBLZt
         ++J2lhxJ1KvLfVlQHJjbA8+rxeENOg9idocy1rlHy8b5LctQX3JiCieOlbKv7u3ULQqZ
         Jyq9lta2AE4AZuEE1+oYUfTOZf0Y/slzg73zdu8U8Bb+SeLu/Z2Fi/CZVIGgNZd2HePp
         /VTpHWHBv8FQ1V5t9E8CwV+9qS9EbWjrrlucTQkD+jwGSrk9OkO11thibTD7/HlACLz7
         WCGX6GmX6vAnBI/P8sq0LTtwrzDT5iBE822xE+cqdTQikbZLFNNqLBrWwRORnTA9PyLu
         cjdg==
X-Gm-Message-State: AOAM530go/tXXyndLL9ypPdRxd6HiqE8JdzohrzRICcBDFx4o5JTPqxJ
        /ls0xj2s/cNm80HE0wLVpaFaPQhI8FhACmYdz/QVluT17NjWeuGMApvSVsfuE9+Pws6Ha6QG+c5
        vIZRKKdYVexnXleyEiywDdgsTYVKr8GqRxP+feEhmgQ==
X-Received: by 2002:a05:651c:324:: with SMTP id b4mr23570298ljp.498.1635232231045;
        Tue, 26 Oct 2021 00:10:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNVTNy3VIoyfsIQL5Y7AWvNrJ9Noboo205abbTkvscX0/E8rvfX/DldfhT2wIn7EKnMbu30A==
X-Received: by 2002:a05:651c:324:: with SMTP id b4mr23570285ljp.498.1635232230874;
        Tue, 26 Oct 2021 00:10:30 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id x14sm368235lfq.232.2021.10.26.00.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 00:10:29 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] clocksource/drivers/exynos_mct_v2: introduce
 Exynos MCT version 2 driver for next Exynos SoC
To:     Youngmin Nam <youngmin.nam@samsung.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, pullip.cho@samsung.com,
        hoony.yu@samsung.com, hajun.sung@samsung.com,
        myung-su.cha@samsung.com
References: <20211021061804.39118-1-youngmin.nam@samsung.com>
 <CGME20211021055112epcas2p278145beb21cd6cc4217813a41c1e1407@epcas2p2.samsung.com>
 <20211021061804.39118-2-youngmin.nam@samsung.com>
 <0c5dcdab-7aa3-a98f-e615-acbe98489935@canonical.com>
 <20211021082650.GA30741@perf>
 <1b93aaf3-ed64-b105-dec4-07b6f27b385b@canonical.com>
 <20211022042116.GA30645@perf>
 <da83de3a-e7a2-f9b2-80f2-25c39717c3e4@canonical.com>
 <20211026014732.GA45525@perf>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <91e926c4-9a3a-196d-1451-d3e7d38fc132@canonical.com>
Date:   Tue, 26 Oct 2021 09:10:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211026014732.GA45525@perf>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2021 03:47, Youngmin Nam wrote:
>> If everyone added a new driver to avoid integrating with existing code,
>> we would have huge kernel with thousands of duplicated solutions. The
>> kernel also would be unmaintained.
>>
>> Such arguments were brought before several times - "I don't want to
>> integrating with existing code", "My use case is different", "I would
>> need to test the other cases", "It's complicated for me".
>>
>> Instead of pushing a new vendor driver you should integrate it with
>> existing code.
>>
> Let me ask you one question.
> If we maintain as one driver, how can people who don't have the new MCT test the new driver?

I assume you talk about a case when someone else later changes something
in the driver. Such person doesn't necessarily have to test it. The same
as in all other cases (Exynos MCT is not special here): just ask for
testing on platform one doesn't have.

Even if you submit this as separate driver, there is the exact same
problem. People will change the MCTv2 driver without access to hardware.

None of these differ for Exynos MCT from other drivers, e.g. mentioned
Samsung PMIC drivers, recently modified (by Will and Sam) the SoC clock
drivers or the ChipID drivers (changed by Chanho).



Best regards,
Krzysztof
