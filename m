Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADF4453184
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbhKPL6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbhKPL6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:58:24 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9650C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:55:26 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r8so36954810wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xVmgLrTg7EafzupUj3WHCgWIY7jwV5Y51V4BTTWgTkQ=;
        b=hfnrXki1mxFgNJkPEZ55HLNLsArcWJABhwSK+IButgZB+9oilzgyFEZLYggvc5j9a3
         C5xYS2MOkrWD+UP5BNijy2cPvi6fcr7oVzoqx+n7t2F0r138/QUqHQ6/q3FI0IO3dCaq
         LN7WwFfJ4XhdycNQdY0WycwAQwyHk1Y+EDW3rHEWgdkNxfEKT7lh74o+mNr/cNwUkOtR
         wjTlDuqFfaXSFipGXhVk8TDpJY+XOUk6YoaTG5ndgfWaZaRmtV07Wpyk7OSwuaJQqM9A
         d04tZivzDRlbhA/EW6tzt2zYGgsCTIjPELfeGcSciVc8Mn5jYS96+13UiG8tOQZA6Gjq
         xLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xVmgLrTg7EafzupUj3WHCgWIY7jwV5Y51V4BTTWgTkQ=;
        b=W3qiDl1xgTFFDQ2fDJrRJu7g+DpBxiZqIRTv8eAI71Sh9N8md3et/4JHpk71qBryx/
         XNC7n/sXPU/YHj0fqItnrJO1s/a2o2qF48J+GMOhGsz0o78B6OqLlBcbqf3TVrMrMbZ/
         cQ5l4EeBG3VloRfRC4LDoOJ6OSLNd2wd7y6+4nBlF/Ldmvc3/N4uGE9MzeAKBQSqc3ZK
         mqHHjqzQ3aF521NwKTb2KykOTxRJBtVne/tFABEOPf0BX7b49GGsHHBlD+ArDIjahHJw
         SHwnAFQRK/xcZ3h04aSkDpvVz7x+6K+iSGmNtN2Nb4CsVuHDHXArRG0E2ofjLzLFaF7C
         WYkw==
X-Gm-Message-State: AOAM533CzNTYdaKtBuSyKAq7Xk8V7C63oqOoy2PvTdfrW46xiowbQQ9Q
        XVM5CVlqjP6tFOi2PT4MbWufhg==
X-Google-Smtp-Source: ABdhPJyV/RgHXasIzc74MY0/AMpKbqeOBawsiBis5Vn3OKt+UuS9YhzUxmmgERizQK3I0TLs123kog==
X-Received: by 2002:adf:fe8e:: with SMTP id l14mr8606706wrr.177.1637063725359;
        Tue, 16 Nov 2021 03:55:25 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id c79sm2141179wme.43.2021.11.16.03.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:55:24 -0800 (PST)
Date:   Tue, 16 Nov 2021 11:55:23 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, Stefano Babic <sbabic@denx.de>,
        Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2] backlight: ili922x: fix kernel-doc warnings & notation
Message-ID: <20211116115523.oobk2tfidvup5czz@maple.lan>
References: <20211116023355.1775-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116023355.1775-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 06:33:55PM -0800, Randy Dunlap wrote:
> Convert function-like macro comments to kernel-doc notation and
> fix other kernel-doc warnings:
> 
> drivers/video/backlight/ili922x.c:85: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     * START_BYTE(id, rs, rw)
> drivers/video/backlight/ili922x.c:118: warning: expecting prototype for CHECK_FREQ_REG(spi_device s, spi_transfer x)(). Prototype was for CHECK_FREQ_REG() instead
> 
> ili922x.c:92: warning: contents before sections
> ili922x.c:150: warning: No description found for return value of 'ili922x_read_status'
> ili922x.c:193: warning: No description found for return value of 'ili922x_read'
> ili922x.c:247: warning: No description found for return value of 'ili922x_write'
> ili922x.c:353: warning: No description found for return value of 'ili922x_poweron'
> ili922x.c:382: warning: No description found for return value of 'ili922x_poweroff'
> 
> Fixes: 4cfbfa971478 ("video: backlight: add ili922x lcd driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Anatolij Gustschin <agust@denx.de>
> ---
> v2: add periods at end of sentences so that the generated documentation
>     flows correctly. (thanks, Daniel)

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
