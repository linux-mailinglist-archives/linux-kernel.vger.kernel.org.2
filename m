Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359844410E9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 22:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhJaVEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 17:04:41 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35016
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229974AbhJaVEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 17:04:35 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 455C83F1A5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 21:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635714122;
        bh=QbKbnaoV2KXGBM6TzkEibB/CEZ4oJ69i89CznmqAF6U=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=JTeq7pLNMPmxZ1OvFzeNXPVr0Lflu8YzDGp6zon7iA00LJ8b5BM+K4hqe5EJiADIn
         Kfog8OF74BSecGGXV1Yg9BJrSemDWljrt3XKCAadSAcK2Z4U9l6Pc8ZT4zd3MRxZ1K
         wr2ukWyeRrrqqy4tavAwaaEnyk0SmRlXorbVPyluItRwTBUqpBSEF2fT14ZbV+8qZz
         3awOrlaRkVGZnLO5YLmZ4cbAWJ1/tmswYLPv12SZCJjKssBLIAsPDppHMkt+MHZuTO
         0hxocVpukJke3XSwaMCGsmgnIq7XQ189XKWgqUvVZS6mlXDq5fFSOZ0S68e6HDTvsf
         uS0wPIpK8IZlA==
Received: by mail-lj1-f198.google.com with SMTP id p19-20020a2e8053000000b002119ff434a2so5103700ljg.11
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 14:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QbKbnaoV2KXGBM6TzkEibB/CEZ4oJ69i89CznmqAF6U=;
        b=u3agIME8M04gs/QTuN2PR499uq3uEH5cChOQf6cSW/9L0affCcIURbAN+1Uvuy17EY
         BLIscXMqHctqRI8UkH1y3jqNKkx8lPbzdMvOW+3nXR6CULsytyveMCKz9OXvL63KU9BE
         JrhjTmuYnA9zxZdZS3JsPhPyHkNviSMPZTWHnkJoJR1CP6xNQUUMgYhKB1Mboeaj9agr
         z0mk02Dp5HUQmQFomjqvrbd+ui8phh/1GAlvV6Q5u+yl+P5LSz0yhQ6WO7NeofnuJNgv
         piaf+HY25KCOCYRWI6f6PIykUafIgR6N9dPyotwUMNemhp7aazpfg8/GoFfxU26iO6on
         zUFA==
X-Gm-Message-State: AOAM531U2vTLLiWiUINbRTcScTh6FwlbRmacgN2AFwWdDwO8giESRpKf
        WM/r78MZX0Imc4TmV7hRX9tEqDyqskDwwHYHgHu51uhGi/lLPAsZ43XBhvdag8N2X3+IxVe4OR2
        KCVRs89ZU8figKMU2WloCIxiIbEe1pTbUCe7qmMMjKQ==
X-Received: by 2002:a2e:9d8a:: with SMTP id c10mr19135171ljj.87.1635714121728;
        Sun, 31 Oct 2021 14:02:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxW2R5HvD0SE2FYyrFy/3wQVAELnRelZMvlWsCFqGLWCrouWi+Gss03AKNkEEgXDI0wAJKyaw==
X-Received: by 2002:a2e:9d8a:: with SMTP id c10mr19135156ljj.87.1635714121574;
        Sun, 31 Oct 2021 14:02:01 -0700 (PDT)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id p17sm1236619lfu.209.2021.10.31.14.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 14:02:01 -0700 (PDT)
Message-ID: <19c8e1e3-0958-afbf-a22d-47dd56da4485@canonical.com>
Date:   Sun, 31 Oct 2021 22:02:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH] ARM: dts: exynos/i9100: Fix Bluetooth node
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211030121410.65834-1-paul@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211030121410.65834-1-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2021 14:14, Paul Cercueil wrote:
> The reset GPIO was marked active-high, which is against what's specified
> in the documentation. Mark the reset GPIO as active-low. With this
> change, Bluetooth can now be used on the i9100.
> 
> Also switch away from using the deprecated 'host-wakeup-gpios' property,
> and use a 'host-wakeup' interrupt instead.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Thanks for the patch, but please split it into two commits and add a
"Fixes" tag for the "reset-gpios" one.

All rest looks good, nice patch!

Best regards,
Krzysztof
