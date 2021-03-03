Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1A832BCD7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359716AbhCCOug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:50:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1843032AbhCCKYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:24:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6411564EDF;
        Wed,  3 Mar 2021 10:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614767044;
        bh=zMXJiOtRW2C2DuquOpLzInD+Ii95FnMEvcnmh7h8sNU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UvZ5ERh4xHqXS0CDVW0n8HHAn7u9oEoEUfmIUuxBZMaQzg6b+AURi3FnNGBmtFs+D
         oOQeyGE7GimP9CUrXjnrt8ux/6RlPLjpt9zepruhsre+LTLyhdwjBOF68cfpcODeQo
         lyuIYOoMFU52a4VYPbKg1gkfT7ZL0EvisP2cSMQo2Dle3Ar1blgmHJ82Xf9nx2/IG1
         tEDWCTPS7oaNqVs9NieIaxxKbz6UXh+Gpf8xOiLkR4864jlhbTW20orf+CDXh+0C5+
         XoQtPbu2KCcu4i2CFq3POmDcKX9lxPCq56QIEJuuwBK1kNrzBYKPybfvMPGtrC1+j5
         qUGWpp6Pv88iQ==
Subject: Re: [PATCH] usb: dwc3: make USB_DWC3_EXYNOS independent
To:     taehyun cho <taehyun.cho@samsung.com>, balbi@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20210303022537epcas2p1b85ab825ceca3a411a177cc1af8a2c7b@epcas2p1.samsung.com>
 <20210303022628.6540-1-taehyun.cho@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <c9ac155c-56c2-4025-d1ae-d0c6c95533b8@kernel.org>
Date:   Wed, 3 Mar 2021 11:24:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210303022628.6540-1-taehyun.cho@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2021 03:26, taehyun cho wrote:
> 'ARCH_EXYNOS' is not suitable for DWC3_EXYNOS config.
> 'USB_DWC3_EXYNOS' is glue layer which can be used with
> Synopsys DWC3 controller on Exynos SoCs. USB_DWC3_EXYNOS'
> can be used from Exynos5 to Exynos9.
> 
> Signed-off-by: taehyun cho <taehyun.cho@samsung.com>

NACK because you ignored comments from March. Please respond to them 
instead of resending the same patch.

Anyway, when resending you need to version your patches and explain the 
differences. Please also Cc reviewers and other maintainers. I pointed 
out this before:
scripts/get_maintainer.pl -f drivers/usb/dwc3/dwc3-exynos.c

The driver - in current form - should not be available for other 
architectures. It would clutter other platforms and kernel config 
selection. If you want to change this, you need to provide rationale 
(usually by adding support to new non-Exynos platform).

Best regards,
Krzysztof
