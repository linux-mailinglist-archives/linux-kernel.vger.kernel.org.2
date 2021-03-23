Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DCB345BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 11:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhCWKdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 06:33:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229986AbhCWKdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 06:33:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08CCA60C3E;
        Tue, 23 Mar 2021 10:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616495615;
        bh=Sl+Ct1QgMB9NjlBuAueKeUHN451/+jE3cb62MlWU48s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TWS0/lWBKJgcxO4/hpRX9x2ra4uTeGjfro9YRA4Sj2Yr7RAn6AB239mQCJqMQ1d4V
         L8V0Ad91CIO6NpIY32+IWNVKfMrg0sRRpxQtFWyEx2g20FOwaalQX+S77DG1C6MNAV
         hlekcprjg9h2W5SzIe75Cr/wTpBlRfFmrEx0RJno=
Date:   Tue, 23 Mar 2021 11:33:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     caizhichao <tomstomsczc@163.com>
Cc:     matthias.bgg@gmail.com, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        zhichao Cai <caizhichao@yulong.com>
Subject: Re: [PATCH resend]  tty:serial: fix spelling typo of values
Message-ID: <YFnD/EhzcHg1TWH6@kroah.com>
References: <20210323102556.1136-1-tomstomsczc@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323102556.1136-1-tomstomsczc@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 06:25:56PM +0800, caizhichao wrote:
> From: zhichao Cai <caizhichao@yulong.com>
> 
> vaules -> values
> 
> Signed-off-by: zhichao Cai <caizhichao@yulong.com>

Please capitalize your name.

> ---
>  drivers/tty/serial/8250/8250_mtk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What changed from the first version?

Please always list that below the -- line.

v3?

thanks,

greg k-h
