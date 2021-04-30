Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B50336FAFA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 14:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhD3My4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 08:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231905AbhD3Myz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 08:54:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EC66613CD;
        Fri, 30 Apr 2021 12:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619787245;
        bh=0iKvadesmEvFfj6X+zy2icbY3wPZ4V1ZhwlLc348ZpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pqb0DWYa/KfLbhNyPj8vag80x5snUEaWO1N54mAW55iwnccAiseYMoGEeGms5U16O
         FdRoYqzwemZgqR03dVBW3fSHP/UNHXcZ2ueh7lJrjGyLLK02j/gIt3khCqQ9Zlyvdj
         6nuGYgvzVNnQeYgvOcN4dPyyM6xjqjLxFLMYwLW0=
Date:   Fri, 30 Apr 2021 14:54:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Bin Liu <b-liu@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        David Miller <davem@davemloft.net>,
        DENG Qingfang <dqfext@gmail.com>
Subject: Re: [PATCH] musb: mediatek: rename driver
Message-ID: <YIv969BCnPgXzrcg@kroah.com>
References: <20210430124317.97376-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430124317.97376-1-linux@fw-web.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 02:43:17PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> currently unspecific mediatek.ko is built,
> change this by adding subsystem

I am sorry, I do not understand this changelog text.  What are you doing
here and why?

> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/usb/musb/Makefile                   | 2 +-
>  drivers/usb/musb/{mediatek.c => musb_mtk.c} | 0

Why rename this file, will that not break existing setups that expect
the module to be named this?

thanks,

greg k-h
