Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C892C402C90
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243369AbhIGQGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:06:41 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44162
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234430AbhIGQGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:06:40 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AE43C3F329
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 16:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631030727;
        bh=YP2/VludKZxfn7ZssReTEMfvwdfhQuuxVwCMuWtoV0M=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Fs2YRvOcn/BctAwceIZqchGYape29RpADQvv64lARV9w+nDFV24K0PQuruAgoTP7H
         rvYtOlKCc0bEuz1wrGk8FC/Yi5/NEVmsGeEE5r4pCm3ZyZUnJHipCCtSa+yZrD34BQ
         H2I9y5WdaX/MZubeUIXrI0cVNPerIIxONZNhwx2QcW0QO+7J+wwIdN82SORV1TC9kQ
         vZm1LDM1pDxnlnUZk6H9Xt4bkW5k2K6l7tvy+E77tp7nx6yk8z0OKmrTa+auxWMoab
         EBUKCe3PTmVARbVFWt/HHMGtdm3MENpWv2rCOTnTIDMPxM2Q8YukHl6hIAnG+N7M80
         JwA9IXlKVkd4Q==
Received: by mail-wr1-f69.google.com with SMTP id p18-20020a5d4e12000000b0015940dc586aso2274089wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 09:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YP2/VludKZxfn7ZssReTEMfvwdfhQuuxVwCMuWtoV0M=;
        b=IJ4jenLXE1yMqPxkGHtNQV1khB93ygVZJ2N3DGhsc1MVOWLLcNjQ8epJ6D+dQfmsDJ
         2Erp5OHd6K1BZVwRk/+OXta4x6MIeaRmSVkgGMtCRW+0+5kyvVuiTv+o0WzpZwrzkLjd
         LqR6iHhFePaAZDH7OEvqx93lds4rTntLbzidFJzSrJezzNV0FKRzDoN2ctfyREQNTg+b
         G7RRQT4SKV8aPBbPZmvj2662cecbvq7ganJeLvMqgqmfJJx38ssiK9cTzYs0ZOVSuwL7
         iGIgsMtkdwxwymVwc7OGEA5c5K10sIA5ds3mVtAEvuxJlZPddIMxyYdclovaFWcyD5Np
         VMww==
X-Gm-Message-State: AOAM531hq0LpoGRx7faxY2Tfrof5jq/3YXKKajWND95JhITKCokUPceP
        909d31qgOzmWJT+Sjs3j7Vy/J1izZgl+JapeNmjeXTxFNen8oZyq0p418OR41uD9WARRFSnR9w3
        4nzG1jAqwN6AcUWg5jkbgVF7nXTxKJyQ9t/m1QUABoQ==
X-Received: by 2002:adf:e606:: with SMTP id p6mr19733179wrm.231.1631030727412;
        Tue, 07 Sep 2021 09:05:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2vXes2sOGaOH/wZ20TblF6w1HjcLY8vGDnXm94khUXSoLOVYKf88pEQi2Y8AMLrFkz7eqTg==
X-Received: by 2002:adf:e606:: with SMTP id p6mr19733161wrm.231.1631030727289;
        Tue, 07 Sep 2021 09:05:27 -0700 (PDT)
Received: from [192.168.3.211] ([79.98.113.63])
        by smtp.gmail.com with ESMTPSA id u25sm2772784wmj.10.2021.09.07.09.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 09:05:26 -0700 (PDT)
Subject: Re: [PATCH 05/15] nfc: pn533: drop unneeded debug prints
To:     Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
References: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
 <20210907121816.37750-6-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <35626061-ff2e-cb01-21ff-87a6f776dc28@canonical.com>
Date:   Tue, 7 Sep 2021 18:05:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907121816.37750-6-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2021 14:18, Krzysztof Kozlowski wrote:
> ftrace is a preferred and standard way to debug entering and exiting
> functions so drop useless debug prints.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/nfc/pn533/i2c.c   | 1 -
>  drivers/nfc/pn533/pn533.c | 2 --
>  2 files changed, 3 deletions(-)
> 
> diff --git a/drivers/nfc/pn533/i2c.c b/drivers/nfc/pn533/i2c.c
> index e6bf8cfe3aa7..91d4a035eb63 100644
> --- a/drivers/nfc/pn533/i2c.c
> +++ b/drivers/nfc/pn533/i2c.c
> @@ -138,7 +138,6 @@ static irqreturn_t pn533_i2c_irq_thread_fn(int irq, void *data)
>  	}
>  
>  	client = phy->i2c_dev;

This line should also be removed (reported by kbuild robot).

I will send a v2.


Best regards,
Krzysztof
