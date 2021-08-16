Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741E73ED429
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 14:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbhHPMmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 08:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhHPMky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:40:54 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA683C0617AE
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 05:40:16 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z9so23325430wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 05:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YKFV/fGAy+OCvpppPuHuSrc517KYZ+55CkL6GKvlPn8=;
        b=Bg8I2gF+Bjd0AA2MgvkQIB9OYiX7mVstkmhluN50T39ksJg2/uh9xQK+jf+dNlO55A
         7B0MA1bwfApHQTuNrTXkw6tEGf0puionJ3b7fNmsHmIPh0LsmZZBPek9v0v3jxKi9MoO
         esG8UYrpmw1ACW8KUpvri6ESmtZK5ALT2AHXvgadk/VVqB5JMmL5zwRrsmRLfuMbnEqG
         NShztgO+H6uLt/haCuQj5rMddlbb2F8g/QyETxEzamGe3v2LD6tWPGWx7cNkcx5iOlpb
         xlc1mTZ0NjVFTUG41QFiH11JmUF7mUJct2SvzecsP+zKZR2qhuVzMYt8uZhk04Mmelb4
         MpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YKFV/fGAy+OCvpppPuHuSrc517KYZ+55CkL6GKvlPn8=;
        b=iX4fSfI/LvrZDz1WvdMR32+VWBqqWjhDqywTAdfGEX+9TrKLU5/OXHs9O1cdeO0Af8
         b6NXkRUbSLOBS54tHzSHfxq5xP2BWfJZrYnCT0jdkNf3LeL+fZD5PFCMomgXkXjBkNM+
         V1TqAetum6dssKiC8bXAmzlTkR00SPAIODIrjpfZU/ZcWMA8p3SinVhROure4dqli+6i
         yqB7QETFXGykExt0L2itHkLRFEiLjc0+wrAW++wRt3pk7wWoXhoYez8DaBnyoQVUB/Ni
         daLMkYgrTKOfK8RVodnFAYz7lJwr7lRcJRbeXPxUIMGOHUybG+8uXE8pqmNPLnqF3dyq
         7Ylg==
X-Gm-Message-State: AOAM530iexEEHIsQiS9+lV4zkLAh3CkBlWPF+26y3XbwYLaHKq3KD1w0
        KxPc7odVdH91wNf8c592D6HnmnWPzeb+ABae
X-Google-Smtp-Source: ABdhPJxQUhmIDC5n1PtRkioXFL6G/WDM0kRh+2rAEDKPnVa1NppeaOOdt4CyHTscwYW0LGaTuLVY1g==
X-Received: by 2002:adf:f2ca:: with SMTP id d10mr18708071wrp.149.1629117615294;
        Mon, 16 Aug 2021 05:40:15 -0700 (PDT)
Received: from google.com ([2.31.167.59])
        by smtp.gmail.com with ESMTPSA id o14sm1687867wms.2.2021.08.16.05.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 05:40:14 -0700 (PDT)
Date:   Mon, 16 Aug 2021 13:40:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: convert tps65086.txt to YAML
Message-ID: <YRpcrensjNvOfraQ@google.com>
References: <20210727092554.1059305-1-kernel@esmil.dk>
 <20210727092554.1059305-2-kernel@esmil.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210727092554.1059305-2-kernel@esmil.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2021, Emil Renner Berthing wrote:

> This converts the tps65086.txt binding description to YAML schema so
> dts files can be verified automatically.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---
>  .../devicetree/bindings/mfd/ti,tps65086.yaml  | 127 ++++++++++++++++++
>  .../devicetree/bindings/mfd/tps65086.txt      |  54 --------
>  2 files changed, 127 insertions(+), 54 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/tps65086.txt

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
