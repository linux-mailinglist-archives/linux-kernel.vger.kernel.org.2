Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AB83AE962
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhFUMtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhFUMtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:49:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601A4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:47:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p8-20020a7bcc880000b02901dbb595a9f1so3896032wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lzkPtw/9EKbOK3AeRqVQs/Ym+dXkBqm63R35cvRHEGk=;
        b=HanNE5NyTFk6fYe1VoFlOEE+a9SW0XU8tG0TMiGb2u0wfCcvvZaslnweUX4MZz6Vfe
         lKCNuv/KFAxZJ2bLaLEUZbpu78AxxP0Oo7jT7kC66YoMqTzVE34FPToAJwcvdsACEffv
         20ADcCUbeBVS0NvjvUpKKCDOAocnqaQnWog5uMOW8pjTTIrwy0cCZPUOsUr1PHkY5Z09
         aZ6eEcMAchvqfOra/nQyAyJdrIwdxCk4DV+jEl19E0YVq0PrtHDbm9QesOET9Dg5gZd8
         MlYwb8MwpbKLeOWXc9GxOntkOH4gQWkKd90b/lxc6ZzTvnZR+OOnn4lYamO1luulQnz6
         prNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lzkPtw/9EKbOK3AeRqVQs/Ym+dXkBqm63R35cvRHEGk=;
        b=WocABQ5o7XHWp+29cpQPWJNBHXgUvw7zGePv3+iNa/BvK6x4+dMQc5wnuicPPPQ0Nl
         hScik7NgBFe2udXtuiWp9DYcr/qCQRdEwBmIUu/lpR8lfnpcCubFxNBH97Pza97uzgx1
         ezI/mQ2148xKNN1L/YYPwGISb21STKa/LtiIbyZdAbz1VG0oc6PIDiRu0LuTAAApTcHR
         4S4kcGYvTLKgRF1lVUx5XdDIL5cdwHOlnk+rx+T6HLsAqe4iwRMHkSJkx957h4hvjeTV
         W7W/HEhjeGC0Ykmu8nnkxMD7kUixCT5IZiRmUjsFOOvkmiMbU49pg9XHiAp/nMpVTehu
         HKmA==
X-Gm-Message-State: AOAM532414hqGeNAuPoAqGCBh/QJCkM/OQwCm7MY6NIc0YsRvfqBQA1O
        IqYQ7LMstwr3RTjQVyQBgsw=
X-Google-Smtp-Source: ABdhPJxFGwVnsiW08T1w6la37oS51XaOuYJCzjdMbTTMYJ4ceKrtWUYOD3PFpg2Ac13+LWLD+N7TQw==
X-Received: by 2002:a05:600c:4f09:: with SMTP id l9mr27705628wmq.114.1624279639909;
        Mon, 21 Jun 2021 05:47:19 -0700 (PDT)
Received: from agape.jhs ([5.171.73.54])
        by smtp.gmail.com with ESMTPSA id c74sm7334302wme.11.2021.06.21.05.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 05:47:19 -0700 (PDT)
Date:   Mon, 21 Jun 2021 14:47:17 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/18] staging: rtl8723bs: remove 5Ghz code
Message-ID: <20210621124716.GD1408@agape.jhs>
References: <cover.1624099125.git.fabioaiuto83@gmail.com>
 <6cafb0fc-7a53-cc56-a67b-4fb82d5130ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cafb0fc-7a53-cc56-a67b-4fb82d5130ea@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hans,

On Mon, Jun 21, 2021 at 11:49:47AM +0200, Hans de Goede wrote:
> Hi Fabio,
> 
> On 6/19/21 12:47 PM, Fabio Aiuto wrote:
> > This patch series removes all occurences of 5Ghz code over the
> > driver as required from driver's TODO list:
> > 
> > 	- find and remove remaining code valid only for 5 GHz.
> > 	  most of the obvious one have been removed, but things
> > 	  like channel > 14 still exist.
> > 
> > rtl8723bs work on 2.4Ghz band and supports 802.11bgn standards.
> > So all code related to 802.11a/ac standard is removed, as well
> > as code related to channel numbers above 14.
> > 
> > VHT code is deleted as well, for it's related to 802.11ac.
> > 
> > Comments are fixed accordingly and many unused variables are
> > deleted.
> > 
> > Every single patch of this series has been tested on a
> > Lenovo Ideapad MIIX 300-10IBY except for the last one,
> > for obvious reason (it deletes just the TODO item).
> 
> Thank you for your work on this. I've replied to 3 of
> the patches with some comments. The rest of the series
> looks ok to me (based on a quick scan of the patches).
> 
> Regards,
> 
> Hans

thank you, will improve what you pointed out
as soon as I figure out how to do it. See replies
to you reviews.

thank you,

fabio

> 
> 
> 
> > 
> > So:
> > 
> > Tested-by: Fabio Auto <fabioaiuto83@gmail.com>
> > 
> > Fabio Aiuto (18):
> >   staging: rtl8723bs: remove all 5Ghz network types
> >   staging: rtl8723bs: remove code related to unsupported channel
> >     bandwidth
> >   staging: rtl8723bs: remove unused enum items related to channel
> >     bonding
> >   staging: rtl8723bs: rename enum items related to channel bonding
> >   staging: rtl8723bs: remove 5Ghz field in struct registry_priv
> >   staging: rtl8723bs: remove struct rt_channel_plan_5g
> >   staging: rtl8723bs: remove all branchings between 2.4Ghz and 5Ghz band
> >     types
> >   staging: rtl8723bs: beautify prototypes in include/hal_com_phycfg.h
> >   staging: rtl8723bs: remove 5Ghz code related to channel plan
> >     definition
> >   staging: rtl8723bs: remove some unused 5Ghz macro definitions
> >   staging: rtl8723bs: remove 5Ghz code related to RF power calibration
> >   staging: rtl8723bs: remove VHT dead code
> >   staging: rtl8723bs: remove unused ODM_CMNINFO_BOARD_TYPE enum item
> >   staging: rtl8723bs: fix macro value for 2.4Ghz only device
> >   staging: rtl8723bs: remove register initializations tied to 802.11ac
> >     standard
> >   staging: rtl8723bs: remove obsolete 5Ghz comments
> >   staging: rtl8723bs: fix check allowing 5Ghz settings
> >   staging: rtl8723bs: remove item from TODO list
> > 
> >  drivers/staging/rtl8723bs/TODO                |    2 -
> >  drivers/staging/rtl8723bs/core/rtw_ap.c       |   10 +-
> >  .../staging/rtl8723bs/core/rtw_ieee80211.c    |   22 +-
> >  drivers/staging/rtl8723bs/core/rtw_mlme.c     |   10 -
> >  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  328 ++---
> >  .../staging/rtl8723bs/core/rtw_wlan_util.c    |   29 +-
> >  drivers/staging/rtl8723bs/core/rtw_xmit.c     |    5 +-
> >  .../staging/rtl8723bs/hal/HalBtc8723b1Ant.c   |    4 +-
> >  .../staging/rtl8723bs/hal/HalBtc8723b2Ant.c   |    5 +-
> >  drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h  |    1 -
> >  .../staging/rtl8723bs/hal/HalHWImg8723B_BB.c  |   17 +-
> >  .../staging/rtl8723bs/hal/HalHWImg8723B_RF.c  |  595 ++++-----
> >  .../staging/rtl8723bs/hal/HalPhyRf_8723B.c    |   19 +-
> >  drivers/staging/rtl8723bs/hal/hal_btcoex.c    |    4 -
> >  drivers/staging/rtl8723bs/hal/hal_com.c       |  241 ----
> >  .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 1059 +++--------------
> >  drivers/staging/rtl8723bs/hal/odm.c           |   50 -
> >  drivers/staging/rtl8723bs/hal/odm.h           |   42 +-
> >  drivers/staging/rtl8723bs/hal/odm_DIG.c       |    2 -
> >  .../rtl8723bs/hal/odm_EdcaTurboCheck.c        |    4 +-
> >  .../rtl8723bs/hal/odm_RegConfig8723B.c        |    5 +-
> >  .../rtl8723bs/hal/odm_RegConfig8723B.h        |    2 -
> >  drivers/staging/rtl8723bs/hal/rtl8723b_dm.c   |    1 -
> >  .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |   53 +-
> >  .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   |   43 +-
> >  drivers/staging/rtl8723bs/hal/sdio_halinit.c  |    5 -
> >  .../rtl8723bs/include/Hal8192CPhyReg.h        |    2 -
> >  drivers/staging/rtl8723bs/include/drv_types.h |   10 +-
> >  drivers/staging/rtl8723bs/include/hal_com.h   |   62 +-
> >  .../rtl8723bs/include/hal_com_phycfg.h        |  198 +--
> >  .../staging/rtl8723bs/include/hal_com_reg.h   |    1 -
> >  drivers/staging/rtl8723bs/include/hal_data.h  |   40 +-
> >  drivers/staging/rtl8723bs/include/hal_pg.h    |    2 -
> >  drivers/staging/rtl8723bs/include/hal_phy.h   |   10 -
> >  drivers/staging/rtl8723bs/include/ieee80211.h |   67 +-
> >  .../staging/rtl8723bs/include/rtl8723b_xmit.h |   21 -
> >  drivers/staging/rtl8723bs/include/rtw_ht.h    |    4 -
> >  .../staging/rtl8723bs/include/rtw_mlme_ext.h  |   52 +-
> >  drivers/staging/rtl8723bs/include/rtw_rf.h    |   33 +-
> >  drivers/staging/rtl8723bs/include/wifi.h      |    1 -
> >  .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |    4 -
> >  .../staging/rtl8723bs/os_dep/ioctl_linux.c    |    8 +-
> >  drivers/staging/rtl8723bs/os_dep/os_intfs.c   |   13 +-
> >  drivers/staging/rtl8723bs/os_dep/wifi_regd.c  |    4 -
> >  44 files changed, 640 insertions(+), 2450 deletions(-)
> > 
> 
