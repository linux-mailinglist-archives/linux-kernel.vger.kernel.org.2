Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA6743B352
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 15:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbhJZNp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 09:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhJZNpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 09:45:24 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE911C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 06:43:00 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b188so20404663iof.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 06:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qTlTd46dRtGZKgQnaFBate7PwykvNlQSoJCu3YoEGrI=;
        b=m3caVgs7454VMuD9t6QOA6F90Hs388L42LRXNKjPounHzakQ/xtoNuUzxoaebh4Gxl
         IV77BJ92W++eGo9OIIBay6zUWMXJRFfESczm83Hy2hq7Htly7pE18XlojFzG8Vy5fVBK
         9dxfuvG7MYuZD/mfk43DSyJ9qDMVBZUyfvCWg7I1riWWBibXDmsk/0ZYVygEZ9jp3Vs7
         G+2Estx7IYbcuIUjv3FO+0qn2jnayc0R3VSpYtBI438uYLj392291TLFochATEMfo5bi
         RhT0Zm8zoQ4aw0yqOfpxWOxpHD3kPYa3SH0O0BukRKblVrUtEDSDvW8WAXUsZfodI3uA
         jMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qTlTd46dRtGZKgQnaFBate7PwykvNlQSoJCu3YoEGrI=;
        b=RBiBxoBIFvXZ9XmP1bnh5bMh0Wb6jAdNAOMlRCmlbfDHbADjo2VkEMoDYo/4PFGfRK
         N7VMxBCY9CYxwViXJYamwdRW5fOlukYRNA7V9Gsb74ZRk6FRu0On+sGk4FWtVQTlKdgP
         X1JyUHYZtD7W6om7j0OoZfUjvmZyplgBygT0nFHO6FEI/tmHsB7dTdkGZOiFOc0kanTt
         qKzAziPkSvDGCeibZ+y0dqOOAgN4G2h++9JcMRCp8vXahQN7qn1Ddw/4PQNsLRFLOY5j
         Xspj+DXPR42PRdgv/Lht7F7s0BwSLovb3LbfKBzU0tOoK5H1S9xC9nmHdccdT6uh7ZGh
         vmfA==
X-Gm-Message-State: AOAM530ahQfUI2Lk4Thf0qmoVx4ZBt3TkXaLFDK/cgs2MG31EcwzSDHS
        GiTRV9RmzaeuLYXkwsXjFq47Lw==
X-Google-Smtp-Source: ABdhPJyynMcY9Qlon9nxLX84kYs/j3RLw3kLJXFR0+d+n2OOjj4m3Ui6RaRh90xC+x5QzSKTq6CcJg==
X-Received: by 2002:a05:6638:2b5:: with SMTP id d21mr7276768jaq.133.1635255780313;
        Tue, 26 Oct 2021 06:43:00 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id k9sm4568557ilo.40.2021.10.26.06.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 06:42:59 -0700 (PDT)
Subject: Re: [PATCH] soc: qcom: qmi: add a prompt to QCOM_QMI_HELPERS
To:     Janusz Dziedzic <janusz.dziedzic@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-soc@vger.kernel.org
References: <20211025163121.2189630-1-janusz.dziedzic@gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <39561c73-732e-bc38-e250-a0bdf51b09f9@linaro.org>
Date:   Tue, 26 Oct 2021 08:42:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211025163121.2189630-1-janusz.dziedzic@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/21 11:31 AM, Janusz Dziedzic wrote:
> From: Alex Elder <elder@linaro.org>
> 
> Add a prompt to the "tristate" attribute in the Kconfig file in
> which QCOM_QMI_HELPERS is defined; I find it doesn't get selected
> without it.

This was a *long* time ago!
   https://lore.kernel.org/all/20180427140358.30839-1-elder@linaro.org/

The discussion that followed indicated that the thing that needs
QCOM_QMI_HELPERS should *select* it rather than *depend on it.

Will this not work for you?

					-Alex

> We need it in OpenWRT project, when using WiFi backports
> and build ath11k driver. While ath11k driver depends on
> QCOM_QMI_HELPERS we need way to enable this option in
> our kernel.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
> ---
>   drivers/soc/qcom/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index fe3c486ae32d..16fb8e286015 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -92,7 +92,7 @@ config QCOM_PDR_HELPERS
>   	select QCOM_QMI_HELPERS
>   
>   config QCOM_QMI_HELPERS
> -	tristate
> +	tristate "Qualcomm QMI Helpers"
>   	depends on NET
>   
>   config QCOM_RMTFS_MEM
> 

