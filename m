Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8377388DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 14:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351815AbhESMZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 08:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351953AbhESMZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 08:25:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDD6C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:24:02 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j14so12074426wrq.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Qmzj5sXb0dQGIp3IEqGvuU1Z+vJnbjFyzmJBniDVjRY=;
        b=wO9Fjndg3DsMOveXObNUhI/yN79ZZF6/0upv0Dkfj3WkTKw7wX30M394CafYendJ1n
         5qeCk2cbOIHr5nVytq8ZFa38S7TOjl7cvYGsIIZYmNei5JfE7xF/p5THZhMKnQbucd2D
         YSh13zo4fhx4a/Rt3+qKbLlKvQkfTO/aQYP6rbLSP5CUCzW4kffN0TobaHX6f9LMZuWR
         iPW2iKqXHG35T+7kSlM+hQdbYWsxgDJv/cF15mtr4XN6xYpDMJbZtCpwEYqodCz5URRb
         Mj0yJTEkMC+cEwpr8DybUMogfvjVMz+T4nv2cvSvMAvBLFqLKtC+nzXiJ6Ru9M4XL3mq
         QhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Qmzj5sXb0dQGIp3IEqGvuU1Z+vJnbjFyzmJBniDVjRY=;
        b=cHMy/YM3Jv1Uida+oLcIVmNkldQCDrhKCO6o9xuze8mK4FUmEPcjHwJ/KOwVnXQ0Tb
         HXpUKAZBAyHDGfwt2G9nX9KhJBGB+D1cWFSTyYl3DFPK7lfrk5iYopn3pmwWYSglZ2wM
         p0Bf679jf9FpcDDPbXInmXDjdxuhCw8kf/9/wrsK0cI/DDFaPAfxiO0+fbzjnQtIg4Jo
         t0smuE0DR4VBzdJyiYDb1B8eIBkd/LwgYVYbo4d/j0GL1yBjuLt7qjKTKsNiUhNNqB9i
         Ipxxy8Bq+JW3GkV5zJup85i0YNQxZrg8b/ASEaZ+q5TBjEf0kjcJb2EqYriJBKCN02zD
         Szpg==
X-Gm-Message-State: AOAM533QNllOy6Mf/WBN/PY8mSZY1lsWr3ZBSwci54uVgqO35IVErqwN
        +SHOttNyH2uwuj29ZskoAk9sfg==
X-Google-Smtp-Source: ABdhPJxsaaoyh3v42GGp2jx2R71stELQyc5iAP9FqL9RmKf4o2XjMTUiclQ29lbfFLfXGQ+B5ufxWw==
X-Received: by 2002:a5d:4d92:: with SMTP id b18mr7614957wru.167.1621427041422;
        Wed, 19 May 2021 05:24:01 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id x11sm24810477wrl.13.2021.05.19.05.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 05:24:01 -0700 (PDT)
Date:   Wed, 19 May 2021 13:23:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     support.opensource@diasemi.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] mfd: da9052/stmpe: Add and modify
 MODULE_DEVICE_TABLE
Message-ID: <20210519122359.GA2415519@dell>
References: <1620801226-18474-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1620801226-18474-1-git-send-email-zou_wei@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021, Zou Wei wrote:

> This patch adds/modifies MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/mfd/da9052-i2c.c | 1 +
>  drivers/mfd/stmpe-i2c.c  | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
