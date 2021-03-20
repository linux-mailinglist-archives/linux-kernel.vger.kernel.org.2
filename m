Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9173342BD1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhCTLMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhCTLML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:12:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A295A61946;
        Sat, 20 Mar 2021 10:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616237987;
        bh=p31KwVKXtkgcsWMN/om5slcfa/J6I7QJUjp4ye8tGYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F4FLz7muZWDs+zx732Q8vD/ghPIqu2kqAY7ofZYckJlnhlHdcN03PqI8eYU+xFYdS
         gPzB0zbJovJyGJNpr7ECMlkLoykC2TgcJ4zdVe51RLdgfJZ1690bdVkiKacO/G6n2p
         A40yvHvtzYdediG0L9UlFUvDvFXQ+jX+xvn+t4BY=
Date:   Sat, 20 Mar 2021 11:59:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     linux-kernel@vger.kernel.org, apw@canonical.com, joe@perches.com
Subject: Re: CHECKPATCH: missing a warning soon after include files decl -c
Message-ID: <YFXVoHvk/VesFn14@kroah.com>
References: <20210320105424.GA3698@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320105424.GA3698@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 11:54:24AM +0100, Fabio Aiuto wrote:
> Hi,
> 
> here's an issue in checkpatch.pl
> 
> $ perl script/checkpatch.pl -f drivers/staging/rtl8723bs/core/rtw_ap.c
> 
> I get three warning related to an extern declaration
> 
> WARNING: externs should be avoided in .c files
> #14: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:14:
> +extern unsigned char WMM_OUI[];
> --
> WARNING: externs should be avoided in .c files
> #15: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:15:
> +extern unsigned char WPS_OUI[];
> --
> WARNING: externs should be avoided in .c files
> #16: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:16:
> +extern unsigned char P2P_OUI[];
> ----------------------
> 
> but the file checked has 4 extern declaration:
> -----------------------------
> #define _RTW_AP_C_
> 
> #include <drv_types.h>
> #include <rtw_debug.h>
> #include <asm/unaligned.h>
> 
> extern unsigned char RTW_WPA_OUI[];
> extern unsigned char WMM_OUI[];
> extern unsigned char WPS_OUI[];
> extern unsigned char P2P_OUI[];
> 
> void init_mlme_ap_info(struct adapter *padapter)
> -------------------------------
> 
> If I add a ';' this way:
> ----------------------------
> #define _RTW_AP_C_
> 
> #include <drv_types.h>
> #include <rtw_debug.h>
> #include <asm/unaligned.h>
> ;
> extern unsigned char RTW_WPA_OUI[];
> extern unsigned char WMM_OUI[];
> extern unsigned char WPS_OUI[];
> extern unsigned char P2P_OUI[];
> 
> void init_mlme_ap_info(struct adapter *padapter)
> --------------------------------

Wait, why would you do the above?

Don't try to trick a perl script that has a hard time parsing C files,
try to resolve the original issue here.

And that is that the above definitions should be in a .h file somewhere.
If you make that move then all should be fine.

thanks,

greg k-h
