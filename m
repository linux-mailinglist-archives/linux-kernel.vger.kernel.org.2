Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FB23E48EB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbhHIPeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:34:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235646AbhHIPdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:33:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 585BC6101D;
        Mon,  9 Aug 2021 15:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628523168;
        bh=tY/5TPtukmu45Bu5bM1UZtXQkRe15+S5hGnEyBWZ2Wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xFzw761z7jrVG3r8TSF7xjK5ou4z5RFk5fl+OzrnADW9ja+5ieQ8x+1yLNXsJUIOE
         2mWMN8CZLcmibRQSQ7j4MNEP3jWK9Nf7wVqvIXuJbBm0j4IIgozanMPya1/eA1OWI4
         98iq4Hfl6mt5NCiR4QRd1UgRO/0gZgHGhp27KWOw=
Date:   Mon, 9 Aug 2021 17:32:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ipack: tpci200: fix memory leak in the
 tpci200_register
Message-ID: <YRFKnvN+jUoOaCiA@kroah.com>
References: <20210809143049.3531188-1-mudongliangabcd@gmail.com>
 <20210809143049.3531188-2-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809143049.3531188-2-mudongliangabcd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 10:30:27PM +0800, Dongliang Mu wrote:
> The error handling code in tpci200_register does not free interface_regs
> allocated by ioremap and the current version of error handling code is
> problematic.
> 
> Fix this by refactoring the error handling code and free interface_regs
> when necessary.
> 
> Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
> Fixes: 43986798fd50 ("ipack: add error handling for ioremap_nocache")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/ipack/carriers/tpci200.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)

Also for stable?
