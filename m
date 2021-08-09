Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F3D3E422F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 11:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbhHIJMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 05:12:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234130AbhHIJMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 05:12:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A562D6101D;
        Mon,  9 Aug 2021 09:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628500305;
        bh=UCLknj9tc8LczjOHUUN+VpDgDoLql2fB1/oOaHk0U18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AAfCz0PGiIhXhwGWCYjbYcGQe5P9XYiS7XrTSkAINzG3Tv8LOJJSOxhTDE81G7Oty
         42Dx+ZcLlxZWtIEOFGroZlWZAAN2A/TVkEM1uRAy8Va3jmvOgXAp+p9uqyjpqBMF3l
         BP/vLH9aUsg9j2tKycFfDaoEFQG1CDZnFQ8hGSVk=
Date:   Mon, 9 Aug 2021 11:11:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: [RFC PATCH] usb: xhci-mtk: handle bandwidth table rollover
Message-ID: <YRDxTodNNqtnpPpn@kroah.com>
References: <20210809165904.RFC.1.I5165a4a8da5cac23c9928b1ec3c3a1a7383b7c23@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809165904.RFC.1.I5165a4a8da5cac23c9928b1ec3c3a1a7383b7c23@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 04:59:29PM +0800, Ikjoon Jang wrote:
> xhci-mtk has 64 slots for periodic bandwidth calculations and each
> slot represents byte budgets on a microframe. When an endpoint's
> allocation sits on the boundary of the table, byte budgets' slot
> should be rolled over but the current implementation doesn't.
> 
> This patch applies a 6 bits mask to the microframe index to handle
> its rollover 64 slots and prevent out-of-bounds array access.
> 
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---
> 
>  drivers/usb/host/xhci-mtk-sch.c | 79 +++++++++------------------------
>  drivers/usb/host/xhci-mtk.h     |  1 +
>  2 files changed, 23 insertions(+), 57 deletions(-)

Why is this "RFC"?  What needs to be addressed in this change before it
can be accepted?

thanks,

greg k-h
