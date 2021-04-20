Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE40E36609B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 22:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhDTUFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 16:05:50 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:34763 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhDTUFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:05:49 -0400
Received: by mail-ot1-f52.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so36932143otn.1;
        Tue, 20 Apr 2021 13:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q+tqxQ3Q6LhOcEipZ0QTYi59icJlUnRrh9D6XQ8uUeU=;
        b=aujL67Q4FqEaAAi6zJflrfrBubW+6sdeip8LlBPHMth23CcaD+mNmQ/IvfUHfypk3k
         eu55sokXgectLvVCs8W//cOYPjlecUDu5K1uDjTGoSlwhOlAq4zePz3HHqBVcY0dlXQH
         rcLoqiRGxfQ+MTR12hZ0A4z+d56J7xwV93sKoMjhjqvzTzcQY/uCmIJM4FMpMkOObgMN
         2NjlNoVpBruGGykH1IbitU4UQcoLlJUngtsIu0ShIJN9oz6vVtRnVtQ6o6u2BwS8kZ2u
         HcY7WjgJBXJNGUR7vfgJso9+z1Ly8pmP7lmlIt+U30MzG2CHUQWdbLAbFpXW82Kx+PB3
         9g9A==
X-Gm-Message-State: AOAM5339542f+XtYtx9hHOAjOmuS574oujA+wJiHZeOAyI8cem/SSQHu
        kVYTAzliux46eBfeMrQDsQ==
X-Google-Smtp-Source: ABdhPJwZSSIoC6uF19n5L31wsl9PPxvexohOI6uFjQn+6nFP41e9RiqwlbBELQAmTV3cAnRwZOgc6g==
X-Received: by 2002:a05:6830:2241:: with SMTP id t1mr20241162otd.126.1618949117716;
        Tue, 20 Apr 2021 13:05:17 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u4sm19112ool.25.2021.04.20.13.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 13:05:17 -0700 (PDT)
Received: (nullmailer pid 3723485 invoked by uid 1000);
        Tue, 20 Apr 2021 20:05:16 -0000
Date:   Tue, 20 Apr 2021 15:05:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>, robh+dt@kernel.org,
        jagan@amarulasolutions.com, devicetree@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>, arnd@arndb.de,
        Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 08/13] dt-bindings: net: document ptp_ref clk in dwmac
Message-ID: <20210420200516.GA3723455@robh.at.kernel.org>
References: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
 <20210415101037.1465-9-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415101037.1465-9-alexandre.torgue@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021 12:10:32 +0200, Alexandre Torgue wrote:
> ptp_ref clk has been added in DT but not documented which makes yaml
> validation failed:
> 
> ethernet@5800a000: clocks: [[6, 105], [6, 103], [6, 104], [6, 123],
> [6, 169], [6, 112]] is too long
> ethernet@5800a000: clock-names: ['stmmaceth', 'mac-clk-tx', 'mac-clk-rx',
> 'eth-ck', 'ptp_ref', 'ethstp'] is too long
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 

Reviewed-by: Rob Herring <robh@kernel.org>
