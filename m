Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC194207D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 11:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhJDJHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 05:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhJDJG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 05:06:59 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB720C061745;
        Mon,  4 Oct 2021 02:05:10 -0700 (PDT)
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8E8D380D2E;
        Mon,  4 Oct 2021 11:05:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1633338307;
        bh=SdoqJLKmubUagmXHnGxb49M8Qt5ZdbF/okH3GByeG98=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OOOW3ycLKZ5AX08jBnTL86jvCfKkQr0ebqwxPgZ4DeHeOovbNGxTxxntTlV7YC98z
         evuCKh+s4IIkXABNzj8Q1F2C0GiCQYdS8CBRYF+2B6az6aX6rcIqkM5KHq1PamGgho
         x5Lc0ysBKD7RuPEJsexrVY5tKo/hy/Fy8MeqYTxXucKNuJQnEX6VtUH2N6FmtFAfJu
         CZLNnanNJyERacGXN3o79fj8JyWu0ai+MwRmNNnBRkKfjlO8lyjw59+Ur4sicZUlCV
         CIVnXjYeyLSMMcItYMlDPYMS9bFqt7nrA1hVz+sDXYj5+udmIple9+TpM0j5FBmtoA
         RTNkF7HAQRW3w==
Subject: Re: [PATCH v2] ARM: dts: stm32: fix AV96 board SAI2 pin muxing on
 stm32mp15
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20211004090304.8984-1-olivier.moysan@foss.st.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <e8440a2b-521f-75f5-c529-e05c93e9a40f@denx.de>
Date:   Mon, 4 Oct 2021 11:05:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211004090304.8984-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/21 11:03 AM, Olivier Moysan wrote:
> Fix SAI2A and SAI2B pin muxings for AV96 board on STM32MP15.
> Change sai2a-4 & sai2a-5 to sai2a-2 & sai2a-2.
> Change sai2a-4 & sai2a-sleep-5 to sai2b-2 & sai2b-sleep-2
> 
> Fixes: dcf185ca8175 ("ARM: dts: stm32: Add alternate pinmux for SAI2 pins on stm32mp15")
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>

Nice, thank you.

Reviewed-by: Marek Vasut <marex@denx.de>
