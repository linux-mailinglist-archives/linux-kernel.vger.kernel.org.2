Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0B245B7EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 11:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240640AbhKXKEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 05:04:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240565AbhKXKD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 05:03:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDC4D60FDA;
        Wed, 24 Nov 2021 10:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637748049;
        bh=tyGWagdxSjAUpuZKgMwcoDlBrFsjxt1/LSWCau1pYkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y2DyOvSMgLbXInhTzfa997izKe6tFXhBCFpgTAHlojISeHZNDva2zgoULjlcJtNmg
         ThcI65dj6+zrb9sJUtpry5pyRExUOrEoRi/X3+euhqnmhLrXgo0TN3U8L0IoVhnDET
         W/359WxRRP/PuraExZSUT98W8B+hGbroKU7M9RGk=
Date:   Wed, 24 Nov 2021 11:00:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zoeb Mithaiwala <zoebm@google.com>
Cc:     trivial@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/2] Staging: rtl8712: rtl871x_security: fixed a camel
 case variable name coding style issue
Message-ID: <YZ4NTZBtLoizblt/@kroah.com>
References: <YZixPDg8kKHZrGJB@kroah.com>
 <20211120111151.1086970-1-zoebm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120111151.1086970-1-zoebm@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 11:11:51AM +0000, Zoeb Mithaiwala wrote:
> Changed additional 'n' from variable name. Corrected comment indentation.
> 
> Signed-off-by: Zoeb Mithaiwala <zoebm@google.com>
> ---
>  drivers/staging/rtl8712/rtl871x_security.c | 12 ++++++------
>  drivers/staging/rtl8712/rtl871x_security.h |  6 +++---
>  2 files changed, 9 insertions(+), 9 deletions(-)

Where is patch 1/2 of this series?  I only received patch 2/2

thanks,

greg k-h
