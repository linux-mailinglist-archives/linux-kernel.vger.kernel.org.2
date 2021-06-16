Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9053AA0D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhFPQId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhFPQIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:08:32 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7694C061574;
        Wed, 16 Jun 2021 09:06:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s6so3390788edu.10;
        Wed, 16 Jun 2021 09:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=br/vs3IzlO0oycfaHGi4uCUaHE0ptyW4GY+sjqdpmsY=;
        b=XzRjiiwm2rzlalnhvNtzn3//DNDoJ3YGvQ9/gb1mpiGR5XOjz4tTonLb+xzDPtdoNb
         IdjqHiBLMXXWhYgsC81E0rGOBxjdWd0dbbDk9+xnmuAntQU17Wb7/q+NzZInbIBH9B60
         Qx8nXAZJ6vliNoSzuMegyRfQnf++smUHghmHWYWLFRcFCU4vApSNIHGmYvrfJcGTuvOL
         Sny9cPwC2YeSuPiNv9YOQ+WwMPU3OsxVxaG17V4nBdgovungQFb92W1UFVT5flr60Esq
         7oE9eH6Nk+Z2SAD8FnuKfPZOj0ZS9n9/pegQc0vXTkAQlwcbBRm6KVjDqKAoMpgXEOvG
         69bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=br/vs3IzlO0oycfaHGi4uCUaHE0ptyW4GY+sjqdpmsY=;
        b=npW5h2QeHG1sqBmE+lYWG2rFuH+cFuw9M1KbW1naMiZf/f+xyyCUjUZ9S5ucQFYpTu
         BRKH/OTZMG0b/FtOKzLGXwE+Gc8uJbGkaBBh54BEulm7Itzb2ff6GVRHSKt9M8vJ8uEB
         RGglwK1zxBl9IYQF0hWC/BWy0pMUSbigrszaOFfxa6C+QJpFm6sySLwFwYs3eSlHWw2H
         KJM6DVmxEKiToM4AN+iLoS4INx9lNg7Z5zcAOQjjyv3gMkMcIPF/8t0IA9/lsI5/GXcy
         BMMjyYDmbarn2RHtcVhWKcZ3zn4FMixeePNfCFGK4hsiNOMTgrxnXxk4ftzVnLcBCrkO
         3QFg==
X-Gm-Message-State: AOAM533qWprs6e0qCzEznQb6awJaFC85ivazcTr77xB4K2hHaTETFS3h
        Y5Nv9ow8iySsvXWTc1kbF6k=
X-Google-Smtp-Source: ABdhPJzvXXz4pkssjOn5h/XA8T7eViwo3GiNGLPT46/hYkoEF7/3J09Tq7haKl3ZfWBa6aW0i4ys7Q==
X-Received: by 2002:aa7:ce96:: with SMTP id y22mr491217edv.210.1623859583257;
        Wed, 16 Jun 2021 09:06:23 -0700 (PDT)
Received: from BV030612LT ([188.24.178.25])
        by smtp.gmail.com with ESMTPSA id g8sm2130561edw.89.2021.06.16.09.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 09:06:22 -0700 (PDT)
Date:   Wed, 16 Jun 2021 19:06:19 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Improve clock support for Actions S500 SoC
Message-ID: <20210616160619.GA1992596@BV030612LT>
References: <cover.1623354574.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623354574.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Could you please pick up this patch series since there are some more
patches ready for merging which depend on it?

Thanks,
Cristi

On Thu, Jun 10, 2021 at 11:05:20PM +0300, Cristian Ciocaltea wrote:
> While working on a driver to support the Actions Semi Owl Ethernet MAC,
> I found and fixed some issues on the existing implementation of the S500
> SoC clock subsystem and, additionally, I added two missing clocks.
> 
> Thanks,
> Cristi
> 
> Changes in v3:
> - Fixed swapped flags between "ahbprediv_clk" and "ahb_clk" in patch 4/6
> - Added Reviewed-by tags from Mani
> - Rebased patch series on v5.13-rc5
> 
> Changes in v2 (according to Mani's review):
> - Re-added entry "{ 24, 1, 25 }" to sd_factor_table, according to the
>   datasheet (V1.8+), this is a valid divider
> - Re-added OWL_GATE_HW to SENSOR[0-1], according to the datasheet they
>   are gated, even though the vendor implementation states the opposite
> - Reverted the addition of the clock div table for H clock to support the
>   '1' divider (according to the datasheet), even though the vendor
>   implementation marks it as reserved
> - Reordered "nic_clk_mux_p" after "ahbprediv_clk_mux_p" to follow the reg
>   field ordering
> - Rebased patch series on v5.13-rc3
> 
> Cristian Ciocaltea (6):
>   clk: actions: Fix UART clock dividers on Owl S500 SoC
>   clk: actions: Fix SD clocks factor table on Owl S500 SoC
>   clk: actions: Fix bisp_factor_table based clocks on Owl S500 SoC
>   clk: actions: Fix AHPPREDIV-H-AHB clock chain on Owl S500 SoC
>   dt-bindings: clock: Add NIC and ETHERNET bindings for Actions S500 SoC
>   clk: actions: Add NIC and ETHERNET clock support for Actions S500 SoC
> 
>  drivers/clk/actions/owl-s500.c               | 92 +++++++++++++-------
>  include/dt-bindings/clock/actions,s500-cmu.h |  6 +-
>  2 files changed, 65 insertions(+), 33 deletions(-)
> 
> -- 
> 2.32.0
> 
