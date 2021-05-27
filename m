Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE409392889
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbhE0Hau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:30:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhE0Haj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:30:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD59561028;
        Thu, 27 May 2021 07:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622100547;
        bh=EtJ2JUcfUOkFr5UadD1b4YEvQnUE0JPMElirSd0F8Ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KQTgmshGXUdT3I5R7qgkBf69No4YVt46S5yk/6UG5HRI+erSHYl8uq8gwvjG7foOK
         vOd7DuXvdcd7NmTFD+Tsgov87AE+xJhnrQVgT+HulWJV/YH27HQX6G/DbHamD3fgB8
         Hz0YSRBxc8GohxvSgi6Lo+azuYvCl/5Mktjq8QZw=
Date:   Thu, 27 May 2021 09:29:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/3] usb: common: move usb_get_dr_mode() kerneldoc next
 to its definition
Message-ID: <YK9KQBKRIqZsPcyQ@kroah.com>
References: <1621933165-9661-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621933165-9661-1-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 04:59:23PM +0800, Chunfeng Yun wrote:
> Following a general rule, add the kerneldoc for a function next
> to it's definition, but not next to its declaration in a header
> file, meanwhile fix typo 'correspondig'
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/common/common.c | 7 +++++++
>  include/linux/usb/otg.h     | 7 -------
>  2 files changed, 7 insertions(+), 7 deletions(-)

Does not apply to my usb-next branch :(

thanks,

greg k-h
