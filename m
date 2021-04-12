Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B034335C2ED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240988AbhDLJxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241741AbhDLJj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:39:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4647C61244;
        Mon, 12 Apr 2021 09:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618220350;
        bh=PUMF/0c1yluMKRRDaOsZ7nkcPqnaJzxIUF2KhkjqHl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oet6HkAWe7zz2BTRO3nHxgFToo+cQoXWbaqgHZvutrBYhHd72hvPMyg+kB4bH1GAN
         NNioI/F0G/5w4BXkcLzYtbA4Brag6n6A/IMsanILx/ESAYgzoctc9TxTHBx9DXs2If
         CAD78GcskslXyXULD/kLD8psEguCyiRxuRPAa1/M=
Date:   Mon, 12 Apr 2021 11:39:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging rtl8723bs: split long lines
Message-ID: <YHQVPG7O2F7ofoO3@kroah.com>
References: <cover.1618145345.git.fabioaiuto83@gmail.com>
 <014291a522569d0450bf9ba6452497d812b4caab.1618145345.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <014291a522569d0450bf9ba6452497d812b4caab.1618145345.git.fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 02:57:36PM +0200, Fabio Aiuto wrote:
> fix following post-commit hook checkpatch issues:
> 
> WARNING: line length of 116 exceeds 100 columns
> 30: FILE: drivers/staging/rtl8723bs/hal/sdio_halinit.c:883:
> +	HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK,
> PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_enter_lps_flow);
> 
> WARNING: line length of 119 exceeds 100 columns
> 41: FILE: drivers/staging/rtl8723bs/hal/sdio_halinit.c:912:
> +	HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK,
> PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_card_disable_flow);
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

You forgot a ':' in your subject line :(

