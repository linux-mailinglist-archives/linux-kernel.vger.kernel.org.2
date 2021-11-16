Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19475451B27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 00:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349908AbhKOXxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 18:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344289AbhKOTYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:24:25 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617A2C04A195
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:32:44 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id o4so36652557oia.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y1TKddjxKZ5v+j9dZNgjQaGVeBF/kGBo0N15AUsK7L8=;
        b=V6Hux7zvB7lremLUtn3yHu5xFS6Z8EBAqeknZZPnplV4XLP/OE/3HdxArTFWXX6277
         HXygrRfJw8tEueaDPl13ofnLYjXcvpVq9QKVJr2siHWIgDnfKouT4kM/6fHU/3VE0e9K
         YvKxo9x8NonLsCzbR0S9c/9YXkV6rm2Ss2NtVPOLBmrPJNC/U1LrcmZgmKv92Ar5RvfS
         Vx+CdQHPENf99vKCeXJa8rO6sByHj3/NVwi3LyU7sr3siPXpNrKq+W+DRA1ua3RZzHz1
         z5bh+KQ9CmqpxX3Kx+Rhb6UgQEueZAaDpm+BTYFJStfvIHOhY42INnCK0rfl9uMRtozT
         +GUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y1TKddjxKZ5v+j9dZNgjQaGVeBF/kGBo0N15AUsK7L8=;
        b=qFS8YbVgp9E6DVENTRLYvU93UIXmMVcyGmZDdvs6zKnkfxRtnDUMr6g7jecT9iJs2g
         uEaeCGLLs3zNN4Py7Bt5txLekXRUHozuvyqS0OvCj9D92b0hcPPvgPZOg5w2W4Sgx7lI
         cIoXIN3lshNbTRldVzJNTqna+L4lgYhFfeU/TMxI7Fc7WJ6vQXB4Vp1vCnukUKCSnYAN
         Wnc2Z7n89/IPWH5ZPChSV5vcwj5Y+0t76sHY9UY0EAb+gW2cbnX/HGqjy2j0el0SklxV
         ObiZfpIuKx6sOi1obrekHFeK6WilTGZwYEs5FlW+4+tBO6evd9XcrgpGKuXaHwJ53znb
         JeGw==
X-Gm-Message-State: AOAM532Kxdd7h5GYrbnWsR0s/10QOe3Q3HxRTKeoZAgtiYnXrA6Bcq2j
        Pa4unlimN3V9JaQuWSdbEFPNrA==
X-Google-Smtp-Source: ABdhPJx+ctQTPfrO9WziAND3PxHA9yTsBw8L5+tuxONnM43DjPiOhuKuQ66TI40t4uivTyKlYnZp0w==
X-Received: by 2002:a05:6808:2187:: with SMTP id be7mr39151347oib.97.1637001164202;
        Mon, 15 Nov 2021 10:32:44 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w5sm1396878otk.70.2021.11.15.10.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 10:32:43 -0800 (PST)
Date:   Mon, 15 Nov 2021 12:32:40 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        stephan@gerhold.net, Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH v5 19/22] crypto: qce: Add 'sm8250-qce' compatible string
 check
Message-ID: <YZKnyAeIsv44DA9Y@builder.lan>
References: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
 <20211110105922.217895-20-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110105922.217895-20-bhupesh.sharma@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10 Nov 04:59 CST 2021, Bhupesh Sharma wrote:

> Add 'sm8250-qce' compatible string check in qce crypto
> driver as we add support for sm8250 crypto device in the
> device-tree in the subsequent patch.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Both patch 19 and 20 can be squashed with the previous patch adding
sdm845 & ipq6018.

Regards,
Bjorn

> ---
>  drivers/crypto/qce/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index 84ed9e253d5d..a7d7d7d5d02f 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -309,6 +309,7 @@ static const struct of_device_id qce_crypto_of_match[] = {
>  	/* Add compatible strings as per updated dt-bindings, here: */
>  	{ .compatible = "qcom,ipq6018-qce", },
>  	{ .compatible = "qcom,sdm845-qce", },
> +	{ .compatible = "qcom,sm8250-qce", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, qce_crypto_of_match);
> -- 
> 2.31.1
> 
