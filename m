Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7E83F38EA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 07:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhHUF4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 01:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbhHUF4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 01:56:20 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20D7C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 22:55:41 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g21so17144464edw.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 22:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aMXSgeio3h45yxi1jpobrvpZ5kfyPjCGua20HuqkoIk=;
        b=DfXFHYO+pe9tx63qBvcpTu8tG9Rdogldu/rTmkMhZxmVSQikl1Li1oCuh4o8LFGvRU
         G1tjw6ES7+5T/lKSp59oD1hjVRaMVxHrtcr98IodhIJq/WUczgwd43fsgyX0ye84TqMU
         hE9FuaisdL8hjyhZ8LFtZ7EH82X863LZcLQ6GAdufCpkcJqYGd9G7ckDYtLWJj0H6Ift
         YlWJS+iCMuBJRsY5LsJUAP/FSqJ8phhaumllqUcKSTydPuPbktj/nK/mmOE/r+yUSd6L
         82teS8bmjKwP/kG3iGHkMXdZTzRIDuCW3LvjQV3dpuKd1ESfFXQqEk3mozuHIND60Zr1
         c3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMXSgeio3h45yxi1jpobrvpZ5kfyPjCGua20HuqkoIk=;
        b=t/6m+xvUCBLkITHZRl5A84ibrt13t6Wki5WSX+IZXDV6wAgP0yu/7Te47w7RQ+t5lN
         EynrWUInHCAplv8v2ye937j2rzkQ8zY4wHKB6tmc7IpiVS3I32zq1VgMX94iDJ0c9DN7
         ouMrryEbOQ2yOXkZafF+zSVXSJZ9UiOZM7smpBUizUdnP4WafkRyMYrB7912SQH1qI+5
         atXsMGtH3r/+y0wUlDljRk0uwOFWEL1yB4S7+9kjXSscthBNr7ovv6ym85N/u53ZI9eo
         +h8JZDFyW/d02KxbmNvJl9t1YmvEFcQuu9YuaJnTVa2yswGSU8FbRrNmiH7MnBQ/HjgL
         67dQ==
X-Gm-Message-State: AOAM5301nMH9RbH0miCIvxsEW/eNxQWDZydXhxJJ06+mDw/nFApUmWHT
        sTjpcXCtd+pCjEafOjPDJmA=
X-Google-Smtp-Source: ABdhPJyK5zheDpMOKgrp80d0DqZ0b6GGEYVSizMGuNCGhvmootQL0RLvpvDG47MEoejQ6wAgX4iEyw==
X-Received: by 2002:a50:cb83:: with SMTP id k3mr27091002edi.102.1629525340168;
        Fri, 20 Aug 2021 22:55:40 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id k12sm2037637edq.59.2021.08.20.22.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 22:55:39 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH RFC 1/3] staging: r8188eu: add proper rtw_read* error handling
Date:   Sat, 21 Aug 2021 07:55:38 +0200
Message-ID: <5720270.rXTAdOU5UK@localhost.localdomain>
In-Reply-To: <f4fb967c992c29c8d2e8f67e78835b52a60d2e52.1629479152.git.paskripkin@gmail.com>
References: <cover.1629479152.git.paskripkin@gmail.com> <f4fb967c992c29c8d2e8f67e78835b52a60d2e52.1629479152.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 20, 2021 7:07:36 PM CEST Pavel Skripkin wrote:
> rtw_read*() functions call usb_read* inside. These functions could fail
> in some cases; for example: failed to receive control message. These
> cases should be handled to prevent uninit value bugs, since usb_read*
> functions blindly return stack variable without checking if this value
> _actualy_ initialized.
> 
> To achive it, all usb_read* and rtw_read*() argument list is expanded

Dear Pavel,

Please, achive --> achieve.

> with pointer to error and added error usbctrl_vendorreq() error checking.
> If transfer is successful error will be initialized to 0 otherwise to
> error returned from usb_control_msg().
> 
> To not break the build, added error checking for rtw_read*() call all
> across the driver.
> 
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_debug.c      |  79 +++-
>  drivers/staging/r8188eu/core/rtw_efuse.c      |  83 +++-
>  drivers/staging/r8188eu/core/rtw_io.c         |  18 +-
>  drivers/staging/r8188eu/core/rtw_mp.c         |  37 +-
>  drivers/staging/r8188eu/core/rtw_mp_ioctl.c   |  20 +-
>  drivers/staging/r8188eu/core/rtw_pwrctrl.c    |   6 +-
>  drivers/staging/r8188eu/core/rtw_sreset.c     |   7 +-
>  drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |   9 +-
>  drivers/staging/r8188eu/hal/hal_com.c         |  22 +-
>  drivers/staging/r8188eu/hal/odm_interface.c   |  12 +-
>  drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  37 +-
>  drivers/staging/r8188eu/hal/rtl8188e_dm.c     |   6 +-
>  .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 198 +++++++--
>  drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  26 +-
>  drivers/staging/r8188eu/hal/rtl8188e_sreset.c |  20 +-
>  drivers/staging/r8188eu/hal/rtl8188eu_led.c   |  17 +-
>  drivers/staging/r8188eu/hal/usb_halinit.c     | 394 ++++++++++++++----
>  drivers/staging/r8188eu/hal/usb_ops_linux.c   |  16 +-
>  drivers/staging/r8188eu/include/rtw_io.h      |  18 +-
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 168 +++++---
>  20 files changed, 941 insertions(+), 252 deletions(-)

I agree with Philip: please, split this long patch. If I were you, I'd make 
one patch for each of the three rtw_read*() and a fourth patch for usb_read*().

> --- a/drivers/staging/r8188eu/core/rtw_io.c
> +++ b/drivers/staging/r8188eu/core/rtw_io.c
> @@ -34,44 +34,44 @@ jackson@realtek.com.tw
>  #define rtw_cpu_to_le16(val)		cpu_to_le16(val)
>  #define rtw_cpu_to_le32(val)		cpu_to_le32(val)

Not related to your patch, these macros are useless and misleading.

> -u8 _rtw_read8(struct adapter *adapter, u32 addr)
> +u8 _rtw_read8(struct adapter *adapter, u32 addr, int *error)
>  {
>  	u8 r_val;
>  	struct io_priv *pio_priv = &adapter->iopriv;
>  	struct	intf_hdl *pintfhdl = &pio_priv->intf;
> -	u8 (*_read8)(struct intf_hdl *pintfhdl, u32 addr);
> +	u8 (*_read8)(struct intf_hdl *pintfhdl, u32 addr, int *error);
>  
>  
>  	_read8 = pintfhdl->io_ops._read8;
> -	r_val = _read8(pintfhdl, addr);
> +	r_val = _read8(pintfhdl, addr, error);
>  
>  	return r_val;
>  }

I really don't like passing errors through arguments. Why don't you pass 
a storage location where the function save the byte read and instead use the 
return for errors? I think that this would result in a cleaner design. Furthermore,
it is used everywhere in the kernel.
  
> -u16 _rtw_read16(struct adapter *adapter, u32 addr)
> +u16 _rtw_read16(struct adapter *adapter, u32 addr, int *error)
>  {
>  	u16 r_val;
>  	struct io_priv *pio_priv = &adapter->iopriv;
>  	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
> -	u16 (*_read16)(struct intf_hdl *pintfhdl, u32 addr);
> +	u16 (*_read16)(struct intf_hdl *pintfhdl, u32 addr, int *error);
>  
>  	_read16 = pintfhdl->io_ops._read16;
>  
> -	r_val = _read16(pintfhdl, addr);
> +	r_val = _read16(pintfhdl, addr, error);
>  
>  	return r_val;
>  }

Same.

> -u32 _rtw_read32(struct adapter *adapter, u32 addr)
> +u32 _rtw_read32(struct adapter *adapter, u32 addr, int *error)
>  {
>  	u32 r_val;
>  	struct io_priv *pio_priv = &adapter->iopriv;
>  	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
> -	u32	(*_read32)(struct intf_hdl *pintfhdl, u32 addr);
> +	u32	(*_read32)(struct intf_hdl *pintfhdl, u32 addr, int *error);
>  
>  	_read32 = pintfhdl->io_ops._read32;
>  
> -	r_val = _read32(pintfhdl, addr);
> +	r_val = _read32(pintfhdl, addr, error);
>  
>  	return r_val;
>  }

Same.

I'm done for now: too many lines to read all at once :)

Regards,

Fabio


