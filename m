Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97656331086
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhCHOMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:12:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230426AbhCHOL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:11:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECADB651DC;
        Mon,  8 Mar 2021 14:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615212716;
        bh=h+f/lalWFSiDqjzRJFvqnAO+QDGAW3ZQIyuEJL6UcBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bJ/ESAuluWky78q3AUv8jD3kGjkSZ7SsOw7wEKtnfnkWJNWrSp5DFMW1DNfQXEkjy
         xX+2yTVy/YrPFzSpdTCal34mVRj25y4BtejJjACGSbm9CQCxXusj9wryC5BmxS2SGt
         a4Kow3FnDrd48qJ+lofHyu6zLAycwncLvRYpPsvg=
Date:   Mon, 8 Mar 2021 14:25:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 18/18] usb: common: move function's kerneldoc next to
 its definition
Message-ID: <YEYlzuH5JMt/0Qvw@kroah.com>
References: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
 <c4d2e010ae2bf67cdfa0b55e6d1deb9339d9d3dc.1615170625.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4d2e010ae2bf67cdfa0b55e6d1deb9339d9d3dc.1615170625.git.chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 10:52:07AM +0800, Chunfeng Yun wrote:
> Following a general rule, add the kerneldoc for a function next
> to it's definition, but not next to its declaration in a header
> file.
> 
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: new patch

Thanks for this change, looks great, all now queued up!

greg k-h
