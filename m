Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843D039BEC4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhFDRae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhFDRad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:30:33 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53190C061766;
        Fri,  4 Jun 2021 10:28:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EC8E44A6;
        Fri,  4 Jun 2021 17:28:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EC8E44A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1622827727; bh=omNX3MPp1Gd5Phde7YdjGrV13tsq185D8DejkjAB5xA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fz8XLkoqa+DvdXp8DOjeWU4QViLZC8oN4s2FGXv6q3c8oTzWfn+9Otfg0HCTpcphn
         dZZu8TCdE4CKFFebgURYHXWRoP1W4NElbVkyy/TNxUC7I4PIUIx7FgM5d7+g/+0XtH
         cLjvqW99Jra8nMQFIpsA1tBj4fqpYbQyYVbeI1S9/VOILpsS5SPY1IUJurOcQ6M/If
         HjNabeiKHVxTs+uZfGGCDDdiCd/70jHefn2gIcycG52tuuXHBtq+Z4Q+WGsV+d9NT3
         AkTjvgJZTEPVnqLUAg92OFveq75QDHobXUAy1Jh+dxOdPeKBG+bresXiex4yIz+N3v
         wANL4SJilI+Zg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: Re: [PATCH] docs: Fix typo in Documentation/arm/marvell.rst
In-Reply-To: <20210531134235.720351-1-iwamatsu@nigauri.org>
References: <20210531134235.720351-1-iwamatsu@nigauri.org>
Date:   Fri, 04 Jun 2021 11:28:46 -0600
Message-ID: <87bl8lilo1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobuhiro Iwamatsu <iwamatsu@nigauri.org> writes:

> Fix typo in the documentation, changed from 'comatible' to
> 'compatible.
>
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  Documentation/arm/marvell.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
> index c50be711ec728d..db2246493d1827 100644
> --- a/Documentation/arm/marvell.rst
> +++ b/Documentation/arm/marvell.rst
> @@ -259,7 +259,7 @@ Storage family
>  	https://web.archive.org/web/20191129073953/http://www.marvell.com/storage/armada-sp/
>  
>    Core:
> -	Sheeva ARMv7 comatible Quad-core PJ4C
> +	Sheeva ARMv7 compatible Quad-core PJ4C
>  

Applied, thanks.

jon
