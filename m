Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC9436C49F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbhD0LI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235583AbhD0LIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:08:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2870613BD;
        Tue, 27 Apr 2021 11:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619521586;
        bh=3JPNz4QHvRgaT51rdG6M27l4WPls5bAceUeZJjjnBPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ab5vCK9D+ZsU5FLMMOj3qRzZq/mkMGsgyw9ZpNNpPLhd1AiBZLqBcmNumHuUUSVAD
         SAu9oRf0wjQDfw2/MG0drcmBJdrzSESZK9R+qR7hfy0oo7/vV9dDfH9ij4+/RVb9xF
         6PccCR7OZoOk5nuGOrYuOPRAOFIqTrHhSuIxyAGw=
Date:   Tue, 27 Apr 2021 13:06:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/50] staging: rtl8723bs: remove all remaining debug
 macros in rtw_debug.h
Message-ID: <YIfwL3s5hdRTCNrm@kroah.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24, 2021 at 11:01:43AM +0200, Fabio Aiuto wrote:
> This patchset removes all remaining debug macros in rtw_debug.h
> 
> DBG_871X_SEL macro is replaced with netdev_dbg() for it does
> a raw printk call which is not best recommended for a driver.
> 
> @@
> expression sel;
> expression list args;
> identifier padapter;
> identifier func;
> @@
> 
> func(..., struct adapter *padapter, ...) {
>         <...
> -       DBG_871X_SEL(sel, args);
> +       netdev_dbg(padapter->pnetdev, args);
>         ...>
> 
> unused _DBG_871X_LEVEL macro declaration is removed.
> 
> Beautified register dump in core/rtw_debug.c 
> 
> Some code cleaning is done and all other private component tracing
> macros are removed.

Nice work, thanks for doing all of this!  Now queued up for 5.14-rc1.

greg k-h
