Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7D0320A6C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 14:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhBUNHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 08:07:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229866AbhBUNHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 08:07:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1907164E5F;
        Sun, 21 Feb 2021 13:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613912824;
        bh=EfXpJm2T1aJ20t51Y8CWcBcwXFsjPKmSxEqB6kDBkIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ziRMZBiJhN30CTB0eNn0PCyL4Tg0W9rd7vNizXHImjOrERmtNjSQlYZHxQSXMJ9fX
         QQQNwDDmlJFGLA8VCL389QiAHFkwi51SGW5zPZzswhQr1xNFdYqQ+mTLV5dstGrNqz
         k53xJEtI9MJoruEb1Jej0Ah/IoxbcMy6phmmqiWw=
Date:   Sun, 21 Feb 2021 14:07:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Julian Braha <julianbraha@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Staging: rtl8192e: fix kconfig dependency on CRYPTO
Message-ID: <YDJa9n/l7+MIAO8M@kroah.com>
References: <8483722.hVsnvgcxvV@ubuntu-mate-laptop>
 <YDCz/6gQgp07NGw2@kroah.com>
 <4036376.6NakBfNh49@ubuntu-mate-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4036376.6NakBfNh49@ubuntu-mate-laptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 12:22:43PM -0500, Julian Braha wrote:
> >From fd949b204eeb6b685bbf5dc9a329c931fcf8b0da Mon Sep 17 00:00:00 2001
> From: Julian Braha <julianbraha@gmail.com>
> Date: Sat, 20 Feb 2021 12:07:30 -0500
> Subject: [PATCH] staging: rtl8192e: fix kconfig dependency on CRYPTO

Why is this all in the body of the email?  Please just use 'git
send-email' to send the patch out, do not attach it all to the message
like this :(

> 
> When RTLLIB_CRYPTO_TKIP is enabled and CRYPTO is disabled,
> Kbuild gives the following warning:
> 
> WARNING: unmet direct dependencies detected for CRYPTO_MICHAEL_MIC
>   Depends on [n]: CRYPTO [=n]
>   Selected by [m]:
>   - RTLLIB_CRYPTO_TKIP [=m] && STAGING [=y] && RTLLIB [=m]
> 
> WARNING: unmet direct dependencies detected for CRYPTO_LIB_ARC4
>   Depends on [n]: CRYPTO [=n]
>   Selected by [m]:
>   - RTLLIB_CRYPTO_TKIP [=m] && STAGING [=y] && RTLLIB [=m]
>   - RTLLIB_CRYPTO_WEP [=m] && STAGING [=y] && RTLLIB [=m]
> 
> This is because RTLLIB_CRYPTO_TKIP selects CRYPTO_MICHAEL_MIC and 
> CRYPTO_LIB_ARC4, without depending on or selecting CRYPTO, 
> despite those config options being subordinate to CRYPTO.

trailing whitespace in your commit log :(

thanks,

greg k-h
