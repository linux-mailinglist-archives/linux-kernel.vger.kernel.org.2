Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB27308127
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhA1Wdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhA1Wdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:33:41 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F00C061573;
        Thu, 28 Jan 2021 14:33:01 -0800 (PST)
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BF4C76178;
        Thu, 28 Jan 2021 22:33:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BF4C76178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1611873181; bh=44Srjt6DEE21b218khBkELZAg8mTBSLnqynsx14aC4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ntkd6FSmXRmcxARA0ka5W/tcvxkCfAmHG27w1zbvWVPNSN9QUxiyfLgB2jbp6MSi3
         sgWq+FO7qcM4D6EMP8GDXpzCwOw3ijYzCD4uhdqLC0kkgGdnJTgtfSwqp5FRnZbalg
         G/3AwVEPmIaOV3WJTw34O+zULCoM16bQfEwmoICqEaj1beAQpyQKlwLQ+Si3UgZgYJ
         Z0IVlLxdCUsjIyJ6kj7vS/rEDZwVdnpxuU+B/y4iTpIDtLHxayHbavF1zNUau9s2sa
         qLOtupS6SUbtP7kyFzcCkSD1/hNqhnAqYEXKDyWrym9IULGtQF5+IBr7UPsMV4bIs4
         NtRvBWwwnDwPw==
Date:   Thu, 28 Jan 2021 15:32:59 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: arm: Fix marvell file name
Message-ID: <20210128153259.7d97c2e9@lwn.net>
In-Reply-To: <20210121193418.22678-1-pali@kernel.org>
References: <20210121193418.22678-1-pali@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jan 2021 20:34:17 +0100
Pali Rohár <pali@kernel.org> wrote:

> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  Documentation/arm/index.rst                   | 2 +-
>  Documentation/arm/{marvel.rst => marvell.rst} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/arm/{marvel.rst => marvell.rst} (100%)
> 
> diff --git a/Documentation/arm/index.rst b/Documentation/arm/index.rst
> index a2e9e1bba7b9..b4bea32472b6 100644
> --- a/Documentation/arm/index.rst
> +++ b/Documentation/arm/index.rst
> @@ -33,7 +33,7 @@ SoC-specific documents
>  
>     ixp4xx
>  
> -   marvel
> +   marvell
>     microchip

Both patches applied, thanks.

jon
