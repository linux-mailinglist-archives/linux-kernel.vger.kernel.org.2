Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9953AE67A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhFUJwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:52:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56200 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhFUJwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624268991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KBZu4NLiDdqn7q2pI7+EJJkI7zuo342OmsDKXMlyxd4=;
        b=SdNBOK8pUry/yU7Uc1lzwwxd2pPncQsJfTPk5jq+Q+L7pE08Lzj0xGHiIG4GYOuX8DkCje
        MQ5gSLdHBsCc9C1gUAPefOcG0YLDaGnAg88g6r0Wb+4WaQafl5JjN8TgP2pes9fb+mQmEt
        z8pa/1l9zKEgHRLEul1qHA+A1+bkLow=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-hKfJCt7lNeCkqZ9OOofkLw-1; Mon, 21 Jun 2021 05:49:49 -0400
X-MC-Unique: hKfJCt7lNeCkqZ9OOofkLw-1
Received: by mail-ed1-f71.google.com with SMTP id ee28-20020a056402291cb0290394a9a0bfaeso2030739edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 02:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KBZu4NLiDdqn7q2pI7+EJJkI7zuo342OmsDKXMlyxd4=;
        b=ZbWbN88TXwXgPSCNG4kSwabVMe1XJ+Y4919yqThd6qTqOn6T7fB2FWO69fG6ht+VcG
         FN0Qgfm14wvNdK6vjas3f3nJM5asKNFYGRlM0TSZ+bHknMcO0DEsmJGoaKv8WicQcz6/
         Jw6zQkuwHc3Q4wkE45QEJndY93ApJ/9HJVOrzgx1S9mjVVzisLmLcPZ6/i+xPoBO/1Zy
         9e9gpgZI/ERnAlhhxCVninKu/b7jZXBB/1nqW8Jm5ZmV1YAvcoyiDe4M1zbSyB4klCo4
         o4mDuLezgnsfDebh4tXelg2/2IsUsDI25gan3odlJkfPydzWnglpKE+Rp1SZFImjK5n8
         /xPA==
X-Gm-Message-State: AOAM530f2za1r8q+rxVT8w3gkxAER9xlME6bKNsXxb8Q4rUuM6izCxcy
        1lRC7TbyZ75qus+Mg7Dj2FDw6Z9lwdp4JSFhiXyFDwvuPodIybprOITEd53jj2BLGeIXaHU3UKy
        zhS7mG7YFNRWckBI4TTIj//0s16nwoDgPUt+oE2wRLT6Ez20debsSr9/8V3Gl8h7j90t8S6hRRx
        9R
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr23232089ejj.16.1624268988484;
        Mon, 21 Jun 2021 02:49:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqOBmbDpon6R/Zi2+R474B5WDTe8Yr2efocLiCmMJFCbfj+k8sVeLGbz62b+i7S4UzrwwZog==
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr23232074ejj.16.1624268988274;
        Mon, 21 Jun 2021 02:49:48 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ml14sm464735ejb.27.2021.06.21.02.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 02:49:47 -0700 (PDT)
Subject: Re: [PATCH 00/18] staging: rtl8723bs: remove 5Ghz code
To:     Fabio Aiuto <fabioaiuto83@gmail.com>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1624099125.git.fabioaiuto83@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6cafb0fc-7a53-cc56-a67b-4fb82d5130ea@redhat.com>
Date:   Mon, 21 Jun 2021 11:49:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <cover.1624099125.git.fabioaiuto83@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 6/19/21 12:47 PM, Fabio Aiuto wrote:
> This patch series removes all occurences of 5Ghz code over the
> driver as required from driver's TODO list:
> 
> 	- find and remove remaining code valid only for 5 GHz.
> 	  most of the obvious one have been removed, but things
> 	  like channel > 14 still exist.
> 
> rtl8723bs work on 2.4Ghz band and supports 802.11bgn standards.
> So all code related to 802.11a/ac standard is removed, as well
> as code related to channel numbers above 14.
> 
> VHT code is deleted as well, for it's related to 802.11ac.
> 
> Comments are fixed accordingly and many unused variables are
> deleted.
> 
> Every single patch of this series has been tested on a
> Lenovo Ideapad MIIX 300-10IBY except for the last one,
> for obvious reason (it deletes just the TODO item).

Thank you for your work on this. I've replied to 3 of
the patches with some comments. The rest of the series
looks ok to me (based on a quick scan of the patches).

Regards,

Hans



> 
> So:
> 
> Tested-by: Fabio Auto <fabioaiuto83@gmail.com>
> 
> Fabio Aiuto (18):
>   staging: rtl8723bs: remove all 5Ghz network types
>   staging: rtl8723bs: remove code related to unsupported channel
>     bandwidth
>   staging: rtl8723bs: remove unused enum items related to channel
>     bonding
>   staging: rtl8723bs: rename enum items related to channel bonding
>   staging: rtl8723bs: remove 5Ghz field in struct registry_priv
>   staging: rtl8723bs: remove struct rt_channel_plan_5g
>   staging: rtl8723bs: remove all branchings between 2.4Ghz and 5Ghz band
>     types
>   staging: rtl8723bs: beautify prototypes in include/hal_com_phycfg.h
>   staging: rtl8723bs: remove 5Ghz code related to channel plan
>     definition
>   staging: rtl8723bs: remove some unused 5Ghz macro definitions
>   staging: rtl8723bs: remove 5Ghz code related to RF power calibration
>   staging: rtl8723bs: remove VHT dead code
>   staging: rtl8723bs: remove unused ODM_CMNINFO_BOARD_TYPE enum item
>   staging: rtl8723bs: fix macro value for 2.4Ghz only device
>   staging: rtl8723bs: remove register initializations tied to 802.11ac
>     standard
>   staging: rtl8723bs: remove obsolete 5Ghz comments
>   staging: rtl8723bs: fix check allowing 5Ghz settings
>   staging: rtl8723bs: remove item from TODO list
> 
>  drivers/staging/rtl8723bs/TODO                |    2 -
>  drivers/staging/rtl8723bs/core/rtw_ap.c       |   10 +-
>  .../staging/rtl8723bs/core/rtw_ieee80211.c    |   22 +-
>  drivers/staging/rtl8723bs/core/rtw_mlme.c     |   10 -
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  328 ++---
>  .../staging/rtl8723bs/core/rtw_wlan_util.c    |   29 +-
>  drivers/staging/rtl8723bs/core/rtw_xmit.c     |    5 +-
>  .../staging/rtl8723bs/hal/HalBtc8723b1Ant.c   |    4 +-
>  .../staging/rtl8723bs/hal/HalBtc8723b2Ant.c   |    5 +-
>  drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h  |    1 -
>  .../staging/rtl8723bs/hal/HalHWImg8723B_BB.c  |   17 +-
>  .../staging/rtl8723bs/hal/HalHWImg8723B_RF.c  |  595 ++++-----
>  .../staging/rtl8723bs/hal/HalPhyRf_8723B.c    |   19 +-
>  drivers/staging/rtl8723bs/hal/hal_btcoex.c    |    4 -
>  drivers/staging/rtl8723bs/hal/hal_com.c       |  241 ----
>  .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 1059 +++--------------
>  drivers/staging/rtl8723bs/hal/odm.c           |   50 -
>  drivers/staging/rtl8723bs/hal/odm.h           |   42 +-
>  drivers/staging/rtl8723bs/hal/odm_DIG.c       |    2 -
>  .../rtl8723bs/hal/odm_EdcaTurboCheck.c        |    4 +-
>  .../rtl8723bs/hal/odm_RegConfig8723B.c        |    5 +-
>  .../rtl8723bs/hal/odm_RegConfig8723B.h        |    2 -
>  drivers/staging/rtl8723bs/hal/rtl8723b_dm.c   |    1 -
>  .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |   53 +-
>  .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   |   43 +-
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c  |    5 -
>  .../rtl8723bs/include/Hal8192CPhyReg.h        |    2 -
>  drivers/staging/rtl8723bs/include/drv_types.h |   10 +-
>  drivers/staging/rtl8723bs/include/hal_com.h   |   62 +-
>  .../rtl8723bs/include/hal_com_phycfg.h        |  198 +--
>  .../staging/rtl8723bs/include/hal_com_reg.h   |    1 -
>  drivers/staging/rtl8723bs/include/hal_data.h  |   40 +-
>  drivers/staging/rtl8723bs/include/hal_pg.h    |    2 -
>  drivers/staging/rtl8723bs/include/hal_phy.h   |   10 -
>  drivers/staging/rtl8723bs/include/ieee80211.h |   67 +-
>  .../staging/rtl8723bs/include/rtl8723b_xmit.h |   21 -
>  drivers/staging/rtl8723bs/include/rtw_ht.h    |    4 -
>  .../staging/rtl8723bs/include/rtw_mlme_ext.h  |   52 +-
>  drivers/staging/rtl8723bs/include/rtw_rf.h    |   33 +-
>  drivers/staging/rtl8723bs/include/wifi.h      |    1 -
>  .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |    4 -
>  .../staging/rtl8723bs/os_dep/ioctl_linux.c    |    8 +-
>  drivers/staging/rtl8723bs/os_dep/os_intfs.c   |   13 +-
>  drivers/staging/rtl8723bs/os_dep/wifi_regd.c  |    4 -
>  44 files changed, 640 insertions(+), 2450 deletions(-)
> 

