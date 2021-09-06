Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B1B40215B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 00:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhIFW61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 18:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhIFW6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 18:58:23 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A34C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 15:57:17 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z2so15834902lft.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 15:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=srhXsa7k4z9B9dewP7CJCYsVdqMPxXC7d+eygyid4e8=;
        b=J+09wqF8jOGAMMBs89W04LMSnaLIETskzEdq4xIie+Kz+/M9D6Jpqweo8uCauxLlmL
         8PclP85hVU8K8UCFQCDQWgFkMhDH4W1c+JV7clvuum17YU5mT8PPwyAZ/0KdPhwU2bwi
         1MabchyM63ljP49yZXtDHcKIjXvIxlNxkCCe+EBee6w64L8FDa3kZ04p5Cs3CS7uSgdJ
         UjlYuHw/koXKlTgAbBcQzu8mWKLC/ylPW8QDeeZzzKwF135Fq2zrtG/7lujCdTDq75E2
         Q5wqkMFViYLSd6Bbv+CS1qKab0UtsQFA6Uqo4DuhjrQa55K2YI2jyIZCyzZoJ22+KUKJ
         lwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=srhXsa7k4z9B9dewP7CJCYsVdqMPxXC7d+eygyid4e8=;
        b=gJCe5rphY7Knedv8JbgKMjlvaRll9PwzLdtpL0nSgkXnEzlg4SAOvoCszdymLNNFyh
         v9zy6GUh7oqyIlyvlUCWEzG757cZqtAJD/yQzM9R+pPkvwPyi1LoX8xhIadVI/xyVFJK
         KbK/7I4KTgntd7PFgbT7cJY8IaEIiPAgK5NShB/N8ZirjjxK0u9o3oP6JWiMhD/MqXZm
         38dK2NLHopQJWRNlobKQwp4OHnlQMb/Zn45vtJvaOZHKtihEZ5meEqCaqKeLRl9isMlU
         tfBUm996BIpvQr+VqWpTdgJjZNin8u2qfmbycU2ezZcdjSNPaMS+NDinoCEUWk1Z++hx
         FesQ==
X-Gm-Message-State: AOAM533sOkGjskdRumEwTpDMUoF5ZYlpg+vpPLVa6UX6aZiXMNX/dW3a
        y7lszOx9f806ffTdatb0a7kP7COMjao=
X-Google-Smtp-Source: ABdhPJx59RTf/i9N7xLp/SDkzmYOTfDZaSGE+PQHbqtgxfpKU6wP1NcVzjcH3Af+0V+fB63Jcjqe6A==
X-Received: by 2002:a05:6512:3fa3:: with SMTP id x35mr10827686lfa.536.1630969035883;
        Mon, 06 Sep 2021 15:57:15 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id g22sm839308lfb.96.2021.09.06.15.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 15:57:15 -0700 (PDT)
Date:   Tue, 7 Sep 2021 01:57:13 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, martin@kaiser.cx, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/40] staging: r8188eu: remove function pointers from
 struct hal_ops
Message-ID: <20210906225713.zbkm6tzghjsv3s2t@kari-VirtualBox>
References: <20210906190223.11396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 09:01:43PM +0200, Michael Straube wrote:
> In order to get rid of the HAL layer this series removes the next
> bunch of function pointers from struct hal_ops.
> 
> Also it removes some empty functions and cleans up some minor style
> issues I stumbled upon.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> 
> v1 -> v2
> Fixed typos in commit messages.
> 
> v2 -> v3
> Added this missing patchset version changelog.

Can you please hold on litle bit longer before you send next patch
series. This will make quite bit traffic on the lists and it does
not add value. Wait for bit for reviewers and after that make new
series. You can even post below yours own messages if you found some
mistake and point out that you will change it when you send next
series. Good hold on time would be 3-7 days with series this big imo.

> 
> Michael Straube (40):
>   staging: r8188eu: remove InitSwLeds from hal_ops
>   staging: r8188eu: remove DeInitSwLeds from hal_ops
>   staging: r8188eu: remove dm_init from hal_ops
>   staging: r8188eu: remove dm_deinit from hal_ops
>   staging: r8188eu: remove SetHalODMVarHandler from hal_ops
>   staging: r8188eu: remove empty functions
>   staging: r8188eu: remove unused function rtw_interface_ps_func()
>   staging: r8188eu: remove interface_ps_func from hal_ops
>   staging: r8188eu: remove hal_dm_watchdog from hal_ops
>   staging: r8188eu: remove set_bwmode_handler from hal_ops
>   staging: r8188eu: remove set_channel_handler from hal_ops
>   staging: r8188eu: remove unused enum hal_intf_ps_func
>   staging: r8188eu: remove Add_RateATid from hal_ops
>   staging: r8188eu: remove hal_power_on from hal_ops
>   staging: r8188eu: remove sreset_init_value from hal_ops
>   staging: r8188eu: remove sreset_reset_value from hal_ops
>   staging: r8188eu: remove silentreset from hal_ops
>   staging: r8188eu: remove sreset_xmit_status_check from hal_ops
>   staging: r8188eu: remove sreset_linked_status_check from hal_ops
>   staging: r8188eu: remove sreset_get_wifi_status from hal_ops
>   staging: r8188eu: remove EfusePowerSwitch from hal_ops
>   staging: r8188eu: rename hal_EfusePowerSwitch_RTL8188E()
>   staging: r8188eu: remove wrapper Efuse_PowerSwitch()
>   staging: r8188eu: remove ReadEFuse from hal_ops
>   staging: r8188eu: remove EFUSEGetEfuseDefinition from hal_ops
>   staging: r8188eu: remove EfuseGetCurrentSize from hal_ops
>   staging: r8188eu: remove empty comments
>   staging: r8188eu: remove Efuse_PgPacketRead from hal_ops
>   staging: r8188eu: remove Efuse_PgPacketWrite from hal_ops
>   staging: r8188eu: remove Efuse_WordEnableDataWrite from hal_ops
>   staging: r8188eu: remove useless assignment
>   staging: r8188eu: remove AntDivBeforeLinkHandler from hal_ops
>   staging: r8188eu: remove AntDivCompareHandler from hal_ops
>   staging: r8188eu: remove empty function rtl8188e_start_thread()
>   staging: r8188eu: remove empty function rtl8188e_stop_thread()
>   staging: r8188eu: remove hal_notch_filter from hal_ops
>   staging: r8188eu: remove free_hal_data from hal_ops
>   staging: r8188eu: remove unused function rtl8188e_clone_haldata()
>   staging: r8188eu: remove SetBeaconRelatedRegistersHandler from hal_ops
>   staging: r8188eu: remove UpdateHalRAMask8188EUsb from hal_ops
> 
>  drivers/staging/r8188eu/core/rtw_ap.c         |   9 +-
>  drivers/staging/r8188eu/core/rtw_cmd.c        |   6 +-
>  drivers/staging/r8188eu/core/rtw_efuse.c      | 182 ++++--------------
>  drivers/staging/r8188eu/core/rtw_mlme.c       |   7 +-
>  drivers/staging/r8188eu/core/rtw_mlme_ext.c   |   5 +-
>  drivers/staging/r8188eu/core/rtw_mp_ioctl.c   |  18 +-
>  drivers/staging/r8188eu/core/rtw_p2p.c        |   4 +-
>  drivers/staging/r8188eu/core/rtw_pwrctrl.c    |   8 -
>  drivers/staging/r8188eu/core/rtw_sta_mgt.c    |   2 +-
>  drivers/staging/r8188eu/core/rtw_wlan_util.c  |   8 +-
>  drivers/staging/r8188eu/hal/hal_intf.c        | 170 +---------------
>  .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 123 +++---------
>  drivers/staging/r8188eu/hal/usb_halinit.c     |  36 +---
>  drivers/staging/r8188eu/include/hal_intf.h    | 123 ++----------
>  .../staging/r8188eu/include/rtl8188e_hal.h    |   5 -
>  drivers/staging/r8188eu/include/rtw_efuse.h   |   9 -
>  drivers/staging/r8188eu/include/rtw_pwrctrl.h |   2 -
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  31 +--
>  drivers/staging/r8188eu/os_dep/os_intfs.c     |  21 +-
>  19 files changed, 142 insertions(+), 627 deletions(-)
> 
> -- 
> 2.33.0
> 
