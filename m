Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41BB414C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 16:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbhIVOgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 10:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhIVOgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 10:36:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE37C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 07:35:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d21so7357720wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 07:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2NJK1BOwBrTlg+LaxeUr9d3+1h5bYyiDunFM4CImyw0=;
        b=LLpCOOy7hsr8DH8XB+RbXza9ahQvsE5kbyzmWjgBr1E4QCeUCYSldEPo/68JxU68z5
         mP4/3ah/hIWjSTaRfs7cqb0wXuqbgPd4vjnH5XlSrJathduOUjx0v07+Dzrx7YEuEp4x
         IUB0BA0dBxsHdQ05MEb/4qljzUORdRnahdjJROiulpopcJzS2ESiqNThVWr1zQriIIuN
         5QgJOZZS2eSnFxyibl40ie0xWUjJjpFRT6aJzmsuKVMXVoUk6kUWoNTNvHcbRu2Nk2v7
         CacykHQ/XIuhfkXz70CjUWN5H5QrYerewITagdtfFWiGAUlhlzhwPi7ezZawWxszj2LI
         IXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2NJK1BOwBrTlg+LaxeUr9d3+1h5bYyiDunFM4CImyw0=;
        b=ivCpcDq6sX+NPrDpt4MjhkLo2NlULcd+GIME8eNl/xDCgOaZc9Qmf6kvOn9bb0aTO4
         aVonnilm+LR6p0Pi9YnHK4/cJzVC1oc+Cexgy7nc3GnW4u1o3nMui9m1GruYAJL8SfCz
         qi6ATraKp70Urt/GpBbVnD8C9kWJac+6PvGCBQ6BCeUCYVvAv2IsrDXKT2+FkP7rvQ69
         K9dQMX79Avt5NcDMQcT40pGhHnH1ntWQ3aybMW+loYmZEhvfFZw6/aLl0/KUhWpXNWKh
         aonCAaP0mPVLwPMvxjBQGcVu+XlvRdYX6zEIIVvFd0bHI0h+CDwpIoWA9q2ERko4hVoc
         P1qQ==
X-Gm-Message-State: AOAM5307b2b4LymsEAQxaqzoqKNJQh96261GST5xHkle0jkiTlQKH+Du
        RAUl5KmcYXF300S41DkiNdxmmax83ROfBQ==
X-Google-Smtp-Source: ABdhPJxWD5dpCNMx31RKKu1hT+srFe/2qS8wdHLbbkEHNrVYo6ZddomY8wb0bz6G52ygBeErtwctPw==
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr10971157wmh.3.1632321304291;
        Wed, 22 Sep 2021 07:35:04 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id v10sm2545804wri.29.2021.09.22.07.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 07:35:03 -0700 (PDT)
Date:   Wed, 22 Sep 2021 15:35:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: fixed typo in Kconfig from AD5520 to ADP5520
Message-ID: <YUs/FmigITjkV9Og@google.com>
References: <20210915104016.16947-1-ramona.nechita@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210915104016.16947-1-ramona.nechita@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021, Ramona Alexandra Nechita wrote:

> The description mentioned AD5520, which is a different device.
> Fixed the typo.
> 
> Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
> ---
>  drivers/mfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
