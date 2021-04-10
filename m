Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C5A35AD33
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 14:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbhDJMKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 08:10:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231279AbhDJMJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 08:09:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B560D611AF;
        Sat, 10 Apr 2021 12:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618056585;
        bh=ZnQfVUJlE/hyrfgDFzqUZAHEdNuh2Ys/CDqf/79/Vl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oPaF0A6B+VWseOzTBs5PhQccHCzxoAYjsGaEBcaRskDQfpQ6GMK6LZEEh1ms0BmtH
         4TKcMYCGyP7x3twJVuDIYbIbTWKxofA+Jgl3RWVb/ZqEdJPoDoKOgHQo/MD1JA4fM7
         z05MaURqUHeD2JPoJ3daINyzKku8j59OZhMd7ziY=
Date:   Sat, 10 Apr 2021 14:09:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: rtl8712: Use existing arc4 implementation
Message-ID: <YHGVhjprFvmqMaY9@kroah.com>
References: <7e16c40d5baa007dca81a12b967a597ed00d8dd7.1618055514.git.christophe.jaillet@wanadoo.fr>
 <a793f56d34e53397607df54c683943d2c48b84f7.1618055514.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a793f56d34e53397607df54c683943d2c48b84f7.1618055514.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 01:56:57PM +0200, Christophe JAILLET wrote:
> Use functions provided by <crypto/arc4.h> instead of hand writing them.
> 
> The implementations are slightly different, but are equivalent. It has
> been checked with a test program which compares the output of the 2 sets of
> functions.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

I can not see patch 2/3 of this series, what happened to it?

thanks,

greg k-h
