Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16831436125
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 14:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhJUMP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 08:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbhJUMPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:15:25 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432DCC061749
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 05:13:09 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u8-20020a05600c440800b0030d90076dabso7106044wmn.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 05:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=owYFM55aP56rDs5EWvgoXTHHvnZP3ih1QEcPV9bvrhs=;
        b=ldx+vWNYbkgie7M5aaF/195y7BkfcqHpNSlAHho9tOMXzsKxFshah8V9OjRxVzKvWA
         vBNn9W7oGV39i+NR9FsmME+88hdpmpKfRP3fq8qtf6BnhQ0zKN7ut5SmO9/ySmFY12r5
         yJyfaqbiwChqViLbch3/uWw2/vvHKxt/aoB1nVXjY4jD/Sj5fYvk8ne7nb6Ni/k9wolk
         EUkYZ9q1yArClmK9+RYdatWAP9JHUX3uZOgm6RybnLk4wacwgMGx9uHc7GoXmx7Nnh4m
         BMGGCvu2p7mP5iyhnOXOyI7TqtrbiNftNDIv5+n2GmAEoIoGzJr1/l5np5BkyoaL0yeg
         bE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=owYFM55aP56rDs5EWvgoXTHHvnZP3ih1QEcPV9bvrhs=;
        b=QHc+/EuMbd9Q746pDuH8KUqMWhRV5TmnzAmLTn7N3p8XFR9Ct3WRpFLUIigzUloMyn
         2a69anktDw9xJSPxCe8aItMAnXTQZoNhgoaWUEfG3RvPUpfBeNUAqfYlq2W5+kR8YZBY
         6CgjGHxTdQPJuNVrnFpoWcvRa+5H6zPIwKkeuCvS7olgU/H9XiGiWJelC6ijv2O+SPw0
         iApzkc7cXGt/dEUU117FpG+lgnDbM517SDubFPVFXNrGRauG0ZvyRYOqB+/KUprSIZeQ
         WC6Qo2VL4OBRPQfiY9d9d6f2MmgaMMDbhxGz3dvJwzvK8W054V1nERU4AZJ5CHD1/NQG
         R3aQ==
X-Gm-Message-State: AOAM531yV9vleU835tC5gwcf2NYHvHycr9TsWbERPAiH1yRquFSigrvf
        yop52aKCCpoeVGvfz4t9xLGf8A==
X-Google-Smtp-Source: ABdhPJzL/H7g1S4PgfSqOGhhgqxYnCklysw/apV7GI7zZ1gsUA2IRIdf3lO7BsVrtf05AOuVQnsvIg==
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr6253430wmc.117.1634818387845;
        Thu, 21 Oct 2021 05:13:07 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id k8sm7519770wms.41.2021.10.21.05.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 05:13:07 -0700 (PDT)
Date:   Thu, 21 Oct 2021 13:13:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <skakit@codeaurora.org>,
        ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: qcom: pm8xxx: add pm8018 compatible
Message-ID: <YXFZUcVFOg0uQRSv@google.com>
References: <20211020231646.278706-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211020231646.278706-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021, David Heidelberg wrote:

> Add missing compatible for the PM8018 model.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
