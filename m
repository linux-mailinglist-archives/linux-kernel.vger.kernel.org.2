Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF7237A5B8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 13:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhEKL2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 07:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230441AbhEKL2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 07:28:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09AC46186A;
        Tue, 11 May 2021 11:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620732456;
        bh=z4Xwx6G0EVHQsG2p959XEORObr8SXf7pV9nctlXNA38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q/2hLnrRdI7yIpYKOlx6oYNX3+CUrXGqEwduRCO/0gpW+/1zXlDfWDQd4hzyuPwlF
         r0WLn9vJ8NiLkfS0W2s66gUqKvXxqtMnCA1NJXWI0oKoVP0BPusXiggYOrCMlyyY49
         M4ICG5kPKUA+bGELcVrFtq8yAIg5Cy1HkwpX7H2E=
Date:   Tue, 11 May 2021 13:27:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: Re: [PATCH] usb: core: hub: fix race condition about TRSMRCY of
 resume
Message-ID: <YJpqJr/3XEIYrtko@kroah.com>
References: <20210511101522.34193-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511101522.34193-1-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 06:15:22PM +0800, Chunfeng Yun wrote:
> This may happen if the port becomes resume status exactly
> when usb_port_resume() gets port status, it still need provide
> a TRSMCRY time before access the device.
> 
> Reported-by: Tianping Fang <tianping.fang@mediatek.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/core/hub.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Does this need to go to any older/stable kernels?  If so, how far back?

thanks,

greg k-h
