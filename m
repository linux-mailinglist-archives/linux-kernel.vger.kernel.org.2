Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E31C3FD70C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 11:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243742AbhIAJn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 05:43:28 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49626
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243603AbhIAJnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 05:43:24 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2B8823F046
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 09:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630489345;
        bh=Y3RQ54Zm5OFe9AQSuUGmYtHrFrafqN10VZzfx08OW4s=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=ptEwrW+rV4ihnJssfFSdhJjffO4KlZ3CErO5I2fNT3tkhVC/nek8aIRQEP4JMgZOv
         LoreR12QX0VFgQhAw5Ex7ei7zG8yeEPQmYOt7OfColIUPDGIvkpqjyd+2JtcTJFQB4
         UiAMRZ91Jv6ClulUOX3R4vZmXXwlBlS80lnM9yz6/H43onTRYY5GiT5rqyOnLUjeQ0
         hT20eYMNBeRE8MqXRrmv8z7+OHzqWFvaipIlirOgSo3VPvv4YlhcLHYcYqO1EtLWQw
         rFYGztgDiKx4gE1cxvXokwANYTKuaor2ZEkp1g0yXyk5JTLUQL0gpIXRnNreE6MSbF
         h/x52xI7FI/uQ==
Received: by mail-wm1-f72.google.com with SMTP id y24-20020a7bcd98000000b002eb50db2b62so808441wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 02:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y3RQ54Zm5OFe9AQSuUGmYtHrFrafqN10VZzfx08OW4s=;
        b=maEdnpQhkKNmXiEMGrGaq+6Mc4Dx1MXRKZlg+T9G9B29ZMzZ3Q5q4kyAmfNyhlWPIT
         6ZhYb8LnDNDBx4el1m/rEj/KqdeM8IlFOciEEI8w9qzZCKxBW7pdUaXJaTW8wP++phSh
         QFn6WhWecb20GSPUdfClGSrFKAzKGmX82J8dNTEPiDqYQ5Zsl0eBq1gH8sMwG2jeD+Wc
         plvfUkXIBYLjnKn8cmEMua2HCTfHBPfrdNag33a+qBm4zmwB/4clpndBDHUJjRSMom69
         SsEhTWjXdv8FRhUKx9dAOfmMGSLM51o6DsikTvXFFVshJjlwxJeL6m3+E77jX8DtdwXU
         QB0g==
X-Gm-Message-State: AOAM533TlgqjyZCmJIT6xTUdys+4U6B156nxFYg41KGMkrHbMDxUfvKM
        YLmEfpiLau5i7608t95RaQreENL3sxNhgB9z5W+HrBwH8jz9N6aEnoW1D8SjqfvXMtbLJ+W8ITb
        021f4ZNhXZ7sJfMtbQLgQhaW6yYwJ2cU1L9ywpRgGOg==
X-Received: by 2002:adf:d239:: with SMTP id k25mr9005597wrh.314.1630489344171;
        Wed, 01 Sep 2021 02:42:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwR0Z0kzD+pLwVC4xGiQJns7caEYN8rRGrEFZPzMKL7gxFfjGtfCH/P6c84n/PyVciuzn525A==
X-Received: by 2002:adf:d239:: with SMTP id k25mr9005583wrh.314.1630489344007;
        Wed, 01 Sep 2021 02:42:24 -0700 (PDT)
Received: from [192.168.3.211] ([79.98.113.172])
        by smtp.gmail.com with ESMTPSA id y1sm5096157wmq.43.2021.09.01.02.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 02:42:23 -0700 (PDT)
Subject: Re: [PATCH] pwm: samsung: Simplify using devm_pwmchip_add()
To:     zhaoxiao <zhaoxiao@uniontech.com>, thierry.reding@gmail.com,
        lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210901054230.29678-1-zhaoxiao@uniontech.com>
 <79e46f2f-c3ed-d187-2553-e64e0aac4c13@canonical.com>
 <612f43cc.1c69fb81.205fc.d94bSMTPIN_ADDED_BROKEN@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e4d04494-8c49-b1c5-c0f4-165fc59f516a@canonical.com>
Date:   Wed, 1 Sep 2021 11:42:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <612f43cc.1c69fb81.205fc.d94bSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2021 11:11, zhaoxiao wrote:
> Thanks for your advices, This patch is modified with reference to the 
> patch that has been submitted，example:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=66a03c4fd9e95e192c574811a1f4ea8f62992358
> 

The patch there looks correct, but you cannot apply one code pattern to
entirely different code and hope it works.

You reference a patch in a driver not using drvdata and having only
pwmchip_remove() in its remove() callback.

Now you apply it to other drivers and:
1. Remove drvdata even though it is used,
2. Delete additional code from remove() callback.

Especially the point (2) is a proof that you don't understand the
fundamental Linux driver model, so please do not convert code into
devm-like() before learning it.


Best regards,
Krzysztof
