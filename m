Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3C93ECF02
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhHPHMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233709AbhHPHMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:12:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C9296023E;
        Mon, 16 Aug 2021 07:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629097922;
        bh=wuC3MbKwNcYgbRdNFJ0/jHurY/1bsRRkCdawma6fyec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yjxbn0WjN6lBB+eErzldT52ZiTS5ASm7BUmcveyRDhvsicLuYCaXRDfOzD3YRXZqW
         FsEqxoJhPTgiqQPHY4UTrIQJOQuIcmfEw59jgZJVwI0+J9TUHxl2bqTSq0U+Pc9V7B
         jk66hVaSQoqMJ2hLzmr7HORgt1U5x05+vSmQ4t5w=
Date:   Mon, 16 Aug 2021 09:12:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove unused variable and DBG_88E in
 hal/rtl8188e_cmd.c
Message-ID: <YRoPwPAlKBJfg252@kroah.com>
References: <20210815230518.91656-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210815230518.91656-1-phil@philpotter.co.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 12:05:18AM +0100, Phillip Potter wrote:
> Remove set but unused variable init_rate from rtl8188e_Add_RateATid
> function in hal/rtl8188e_cmd.c, as it fixes a kernel test robot warning.
> Removing the call to get_highest_rate_idx has no side effects here so is
> safe.
> 
> Also remove the DBG_88E macro call in this function, as it is not
> particularly clear in my opinion. Additionally, rename variable
> shortGIrate to short_gi_rate to conform to kernel camel case rules,
> and improve general spacing around operators, some of which triggers
> checkpatch 'CHECK' messages. These are not related to the test robot
> warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  drivers/staging/r8188eu/hal/rtl8188e_cmd.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)

As Fabio said, this should be split up into multiple patches.

If you ever have to say "also" in a changelog text, that's a good hint
that the patch should be broken up.

thanks,

greg k-h
