Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC3A33906F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhCLOza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:55:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:41420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231407AbhCLOzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:55:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E41A64FDD;
        Fri, 12 Mar 2021 14:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615560908;
        bh=e/TE1ISXgR+JIC238rr6EJprxAZ/CC0wvJ+krqGRLZM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JWNnT25tovsUyGUWqpeVf6ojxIaXVhm5aOvTEB3KbFPiHG9jj2SZTyPsFng0YZg+i
         dYW7VbLBhBHS2CVzB5cCfs5Lx58nEM+dtaUXpRUTdPV1tSFCYZiPpp7Ohy1O5+IYvb
         mE9jT0w3TUzyZl1Qofm/Sq+ohtG5S+R3ZFtqY/EbnFm5FOocD0Lr4q4ZCSh5E3L+I9
         a7Vg0nctXWJHPNlFxqumuiJehgR7MDYOzruzvh9uFrHmsZz/EiRfwwdm/PfXa7OQA0
         Fb7rM16jCduSgNEtZDUDh9AoQQEDSugoc8Uf+1+QEIAlmKB7QSHznt8I9TnMp6bYzA
         Knvl4l618CmdA==
Received: by mail-ed1-f47.google.com with SMTP id j3so8356571edp.11;
        Fri, 12 Mar 2021 06:55:08 -0800 (PST)
X-Gm-Message-State: AOAM531+ATJX88tK9+1mQ8HNAR6QpUZwYltwWF1ERrM/BQX+qfp3Yf0n
        84o+jAVl3+Q/HUYF2mNzHFh4FjIdf2GVbi2LuA==
X-Google-Smtp-Source: ABdhPJzWEv1hlgu2dk/9CjJiF3+m46LIYDOygQ1RN+rEVibmzwubiCOnZ6Pk0bDlaq2jO9aEzB1hLkaqoijJZLZC+tQ=
X-Received: by 2002:a05:6402:c0f:: with SMTP id co15mr14375431edb.373.1615560907054;
 Fri, 12 Mar 2021 06:55:07 -0800 (PST)
MIME-Version: 1.0
References: <20210312110758.2220959-1-lee.jones@linaro.org> <20210312110758.2220959-2-lee.jones@linaro.org>
In-Reply-To: <20210312110758.2220959-2-lee.jones@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 12 Mar 2021 07:54:54 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKfK2AHdcDKbAQqTiDHTMTH5RiChZGrVhtwj=hed6syNg@mail.gmail.com>
Message-ID: <CAL_JsqKfK2AHdcDKbAQqTiDHTMTH5RiChZGrVhtwj=hed6syNg@mail.gmail.com>
Subject: Re: [PATCH 01/10] of: device: Fix function name in header and demote
 kernel-doc abuse
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 4:08 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/of/device.c:72: warning: expecting prototype for of_dma_configure(). Prototype was for of_dma_configure_id() instead
>  drivers/of/device.c:263: warning: Function parameter or member 'dev' not described in 'of_device_modalias'
>  drivers/of/device.c:263: warning: Function parameter or member 'str' not described in 'of_device_modalias'
>  drivers/of/device.c:263: warning: Function parameter or member 'len' not described in 'of_device_modalias'
>  drivers/of/device.c:280: warning: Function parameter or member 'dev' not described in 'of_device_uevent'
>  drivers/of/device.c:280: warning: Function parameter or member 'env' not described in 'of_device_uevent'
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/of/device.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 6cb86de404f1c..64ee363abde24 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -53,7 +53,7 @@ int of_device_add(struct platform_device *ofdev)
>  }
>
>  /**
> - * of_dma_configure - Setup DMA configuration
> + * of_dma_configure_id - Setup DMA configuration
>   * @dev:       Device to apply DMA configuration
>   * @np:                Pointer to OF node having DMA configuration
>   * @force_dma:  Whether device is to be set up by of_dma_configure() even if
> @@ -256,7 +256,7 @@ int of_device_request_module(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(of_device_request_module);
>
> -/**
> +/*

We should fix the kerneldoc on public functions. Demoting is fine on
static or internal to the DT code.

>   * of_device_modalias - Fill buffer with newline terminated modalias string
>   */
>  ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len)
> @@ -273,7 +273,7 @@ ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len)
>  }
>  EXPORT_SYMBOL_GPL(of_device_modalias);
>
> -/**
> +/*
>   * of_device_uevent - Display OF related uevent information
>   */
>  void of_device_uevent(struct device *dev, struct kobj_uevent_env *env)
> --
> 2.27.0
>
