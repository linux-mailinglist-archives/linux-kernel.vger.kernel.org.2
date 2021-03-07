Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229AA3302D5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 17:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhCGQBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 11:01:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231222AbhCGQAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 11:00:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5421A650A0;
        Sun,  7 Mar 2021 16:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615132841;
        bh=nNt0pGGU/ofH/w83o0mxL+LLmwH6VXk5fV0QcqBwQRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rL9HRj44aSg3k3DeEU5GvPgAptNE450cjqhSUK2IBxODcJXJOPc7oja1T43QY03+m
         tX7q1zeigSb1HPyVwzMpZTrM99FbFNo70jaeRVHHtG6vssQ2mceZDH9VtNBTV5QOuc
         Ghky4a8nLtcwu3cME5/NEhR47dZQCI3FK0f6brnw=
Date:   Sun, 7 Mar 2021 17:00:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH 15/17] usb: xhci-mtk: support to build xhci-mtk-hcd.ko
Message-ID: <YET4p6rKSynLGEUv@kroah.com>
References: <1614934975-15188-1-git-send-email-chunfeng.yun@mediatek.com>
 <1614934975-15188-15-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614934975-15188-15-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 05:02:53PM +0800, Chunfeng Yun wrote:
> Currently xhci-hcd.ko building depends on USB_XHCI_MTK, this
> is not flexible for some cases. For example:
> USB_XHCI_HCD is y, and USB_XHCI_MTK is m, then we can't
> implement extended functions if only update xhci-mtk.ko
> This patch is used to remove the dependence.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Oh nice, I tried to unwind this once, but did not succeed.

Mathias, any objection to this?  I think this is the only patch in this
series that touches the non-mtk code, want me to just queue it up in my
tree, or are you going to send it to me through your patches?

thanks,
g
reg k-h
