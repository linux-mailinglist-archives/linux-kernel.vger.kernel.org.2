Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6F336FBD0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 15:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhD3N6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 09:58:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229688AbhD3N6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 09:58:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23F7961459;
        Fri, 30 Apr 2021 13:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619791039;
        bh=4U5STTHKz/FQJupb+0tWwRXQW3K2+e2V43lp6ZRD56o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iV4LzR+dEAD1STOrVm6PhT5nUrmtpPuQVeRzNUsqi19AQ1O07bKlkLkXelA5+nZrg
         qnNsR0/ENWZsxnKRaaD3AijsarApdAIwB0HIKCgGE4WQkIuXQ7qwM0Vkk7wnaqGCjo
         65c5ekfpt1HUuMmQBDEhuHKYNLE74VTbNE4PC0is=
Date:   Fri, 30 Apr 2021 15:57:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org, Bin Liu <b-liu@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        David Miller <davem@davemloft.net>,
        DENG Qingfang <dqfext@gmail.com>
Subject: Re: Re: [PATCH] musb: mediatek: rename driver
Message-ID: <YIwMvUVmeeYT1aph@kroah.com>
References: <20210430124317.97376-1-linux@fw-web.de>
 <YIv969BCnPgXzrcg@kroah.com>
 <trinity-5166e76d-779d-4b05-870b-59971bd1571c-1619789439850@3c-app-gmx-bap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-5166e76d-779d-4b05-870b-59971bd1571c-1619789439850@3c-app-gmx-bap03>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please do not top-post :)

On Fri, Apr 30, 2021 at 03:30:39PM +0200, Frank Wunderlich wrote:
> Hi Grek
> 
> the problem is that the name mediatek.ko does not point to musb-subsystem. I had discussed with Min Gao (author of this driver) some time ago about this as the name may conflict with other modules (don't remember which was that).
> We have searched issue using the driver on my board (not yet resolved).
> 
> if the module is loaded it shows (based on name) only "mediatek" and user does not know that is the mediatek musb driver, not very good in my eyes as mediatek is a vendor designing many different hardware and so drivers. Imho the module-name should at least give a clue to the subsystem to avoid confusion/conflicts
> 
> Now the discussion comes up again here for a new driver:
> https://patchwork.kernel.org/project/linux-mediatek/cover/20210429062130.29403-1-dqfext@gmail.com/#24148777
> 
> so i decided to rebase and post my patch created in past to clean this up.

All of this information needs to go into the changelog text, what you
wrote there does not explain all of the above.

> and yes this can result in user-space issues depending on the name...because of this i have not added stable-tag ;)

Why does stable matter?  If this could result in a userspace breakage,
that's not ok for any kernel change.

Why not just have any new driver not use this name, as it is, it's not
hurting anything.  Until you can guarantee that renaming this is not
going to break anything, I can not take it.

thanks,

greg k-h
