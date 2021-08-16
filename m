Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CB73ED481
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 15:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhHPNDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 09:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhHPNDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:03:39 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DEEC0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:03:07 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bt14so15827676ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0gDpDkzRxQRlixBQR7npyfgn3bTr4IPbX9H8aX4jeAU=;
        b=cYLKOxYJTIkkHGCkFBWHO+SRTXY28id2ocgWbr/IwlFhPzitX+KATmadUdZwZJZTRq
         TpImd3bVbCk6+RzEBDDAZoBMxfyTbQ70AMUMN8HPP7h05vyUEo1m1TrU1XiebDV8zTBq
         r7R7CdpsAZAtCPgRkfQwZVyLEY/h/HMAjrWLkQaK2pniDSGdkseXy6/5qYoSZ+qVZO3e
         d+hNbpBI7unYL5dU8aTq4ZDXJa1jIGi4qyHEU/s46b+H2w5rDZxf45vHTGht8cgjnWpU
         /ogmQme+grhiMxc+BIc9x9Z5drNmmynscswKFK4MwXy5lP9E/EWgz0HNnidTa4mT7Mox
         lf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0gDpDkzRxQRlixBQR7npyfgn3bTr4IPbX9H8aX4jeAU=;
        b=t1L4U5tUmcGiMuHVm9lbST/pKgGm6lGN1hDFOMnHKF3QnvkZ8fNpatUaRnHcSSqjYg
         aEOP2C4Lr6xj0yE7x8r6TgqWulP8Ut8ThnNH24xVQviGKmlLU3g28FFU6dPDNBYP+rVN
         BzDioFZL5ydEpBv768AuEOzzZVy8GhGUslucBwvsjRsGPjmAXSZN+UWzbzm0Y8CldTHc
         HN6Up7XkLWxDsccbgNs1u9Gp9no5xy89QsCTTjGcIn0QoD1SJYQ9IjyLciIapfKIcWR3
         ZJZLwa8touWPI7j9jQLSaEC4UmK0RYUp4bFGd/QwByYfqbMMON6dMfMopfUZpe0TOOJO
         Em9w==
X-Gm-Message-State: AOAM531OgNpORbHSNSPFxI6IhOG0w+DevewTdB65I4vDtq29/2yYhpJg
        HUcB9ul0ncrV7RtHl8FV/Vk=
X-Google-Smtp-Source: ABdhPJxc9AiiP8G8g58vtTbvxXAu9cyszcx03ZgTMcXuNeuwayn5MbacXdkxTyxdP7eguqx8qlcITQ==
X-Received: by 2002:a17:906:5a98:: with SMTP id l24mr15441373ejq.540.1629118986053;
        Mon, 16 Aug 2021 06:03:06 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id c21sm3668108ejz.69.2021.08.16.06.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 06:03:05 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org,
        Michael Straube <straube.linux@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] staging: r8188eu: refactor rtw_is_cckratesonly_included()
Date:   Mon, 16 Aug 2021 15:03:03 +0200
Message-ID: <5487901.nydP0h6v93@localhost.localdomain>
In-Reply-To: <20210816115430.28264-3-straube.linux@gmail.com>
References: <20210816115430.28264-1-straube.linux@gmail.com> <20210816115430.28264-3-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 16, 2021 1:54:29 PM CEST Michael Straube wrote:
> Refactor function rtw_is_cckratesonly_included(). Improves readability
> and slightly reduces object file size.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
> v1 -> v2
> Refactored to more compact code as suggested by Joe Perches.
> 
>  drivers/staging/r8188eu/core/rtw_ieee80211.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks,

Fabio



