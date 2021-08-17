Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3EF3EF11E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 19:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhHQRwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 13:52:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232269AbhHQRwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 13:52:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF8A660FE6;
        Tue, 17 Aug 2021 17:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629222733;
        bh=/dyoKG0guNp8ZGznN909rqgVncnMmv0kevcZcyZqpnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FybZAKKSNXJrUo2qyv/k4c36voo0LPcIPlx4QExh10xbxRvtMuTrSIfG6wYty6365
         rUj6kgUcA2KxCPWWHDAR+3c26SFaMf29Cjzl5XB28KDvP4EH/6lhSoXhcrg73zMtz0
         y17ny5XONe1d/Lx/2hPyXZM+UBz+Vl2NfX2Rti5Q=
Date:   Tue, 17 Aug 2021 19:52:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        insafonov@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Remove LINUX_VERSION_CODE check
Message-ID: <YRv3Stj8q7wf+B8D@kroah.com>
References: <20210817081204.2232-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817081204.2232-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 04:12:04PM +0800, Cai Huoqing wrote:
> no need to check linux version, depending on the latest version
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/staging/r8188eu/core/rtw_mlme.c      |  5 ----
>  drivers/staging/r8188eu/os_dep/os_intfs.c    | 26 ++------------------
>  drivers/staging/r8188eu/os_dep/rtw_android.c |  6 -----
>  drivers/staging/r8188eu/os_dep/xmit_linux.c  |  6 -----
>  4 files changed, 2 insertions(+), 41 deletions(-)
> 

Does not apply to my tree :(
