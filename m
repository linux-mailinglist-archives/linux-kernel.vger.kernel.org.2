Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF4A3907E9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbhEYRir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbhEYRif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:38:35 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5530C061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:37:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id t21so16735389plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FqZUbjadb1B4THcGJT5sMXZ3kEFu1j12y+rBCLr87MY=;
        b=T27uSRQxNqy9fkkvryO31BKVXnZBIeoDoL6szDZylEtfWg6MbZYdZxgeQUiU3FFx7G
         v4PTXry4wDjPXAQH6mXluKz9vO/m6Vdqn7HWF1Quznl4lvCQpi/GXgj3ml/xec0/xdFn
         74AoX2s+Ry4EG+rYyODpoPWeB97Iq7VURotSVUJGYZ9DlowL6e3kL7Z80LCQKdNeeQaD
         clM347VjOrzbATocIcWn7oSnlrwiXZxUD0mQHigG83IxsnyekS8DqeaNK9l48XUh0EF+
         9I0/QGqKpt2o/IdsRNT46/RvVifTtRaY7T/MqkBEMSFMx3SZHLBCU3l5PQYaCSBM2hCn
         uH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FqZUbjadb1B4THcGJT5sMXZ3kEFu1j12y+rBCLr87MY=;
        b=exHdidwe8sG31KTEg2OjPhYG1kVJOgqbyZusioBsCMtHe+UFSagAx6sqjffeIP+k1A
         29u0jPhILnmbCtScTPLIgt1JzO3xRtt5a1uZz8DypCpx+9zrxPxuEx4zw/3NGO3HG4bg
         vPc71ln3di6HxTw6PGoe2Quv+xpD3W41tnvIN+XFLNq6sL3g/UnTAF6rLd+YW5hO2l6h
         nW9rs3X0H8clx4X3XcOLJOUF00c3wyAv05bPLiFfsQT4syY3oMqoactPt7q88sV2zt8w
         YqvYkOsS0Mt3gnhpZmNWG/ffTJ0ztGdIVDcbbLZIS5pbkgodEYLZ5/KYWu8Rgq32t4jX
         jgpg==
X-Gm-Message-State: AOAM533xXtaI3ZRVdN41IU2KmWWtG8Q9Dv1aDAAOHvg8nd58HzTqlvcb
        zryoLfaU7cVxT35hY3O4tGFKQg==
X-Google-Smtp-Source: ABdhPJxr3lPiVmDNhM/fjqq6u22sPHnIKPDXjlVFYzCAwPeQy3jR4MIHjJKDsw3YszpMmR4ZQPExXg==
X-Received: by 2002:a17:902:ecc4:b029:ef:8e98:3cb0 with SMTP id a4-20020a170902ecc4b02900ef8e983cb0mr31645764plh.50.1621964223320;
        Tue, 25 May 2021 10:37:03 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z125sm14029934pfz.218.2021.05.25.10.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 10:37:02 -0700 (PDT)
Date:   Tue, 25 May 2021 11:37:00 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] remoteproc: Add kernel-doc comment for is_iomem
Message-ID: <20210525173700.GC1113058@xps15>
References: <20210519180304.23563-1-s-anna@ti.com>
 <20210519180304.23563-2-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519180304.23563-2-s-anna@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 01:03:03PM -0500, Suman Anna wrote:
> Add a kernel-doc comment for the is_iomem function argument in
> rproc_da_to_va(). This fixes a warning generated when building
> the remoteproc_core with W=1,
>   warning: Function parameter or member 'is_iomem' not described in 'rproc_da_to_va'
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 626a6b90fba2..8c279039b6a3 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -165,6 +165,7 @@ EXPORT_SYMBOL(rproc_va_to_pa);
>   * @rproc: handle of a remote processor
>   * @da: remoteproc device address to translate
>   * @len: length of the memory region @da is pointing to
> + * @is_iomem: optional pointer filled in to indicate if @da is iomapped memory
>   *
>   * Some remote processors will ask us to allocate them physically contiguous
>   * memory regions (which we call "carveouts"), and map them to specific
> -- 
> 2.30.1
> 
