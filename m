Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F1E3B05C1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhFVNYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhFVNYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:24:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B9AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:22:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j2so13102511wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LUO6vg1QrRDDYmaaeflr/Aky3r2WNn95OnvTztYnmaI=;
        b=Z3u+dk4dOtPg+/eVwdjRdKkc/q9o+rFa/dSefQfkpl2kqBi7CKNHmV/VXFrLuxR9uM
         wCTo3YDoDK8UYT+oMF0FRCXLrea4xmjP6Z97hOA4PrP7LKHLdZQvLvRpwnewUU+pAdTw
         goGUYKwfUm5Zttvy9sIcxxiUpwhemeY31+FdSaHXYUYL0AvLKxBUetMsAWwBnRZC8zSp
         /jpY5euPRlbdGEJ/Tt7xdqxNpx64Cz3GE9HkRLQTwM4OB7ibfqLBtB8XHwEXbOZHOuWQ
         qITECbkMUqiX1Is2p60dd8o9WtxddhA2B+TFKBdD8f88R/EmdykKCxd4XmneJwuW/qXu
         14mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LUO6vg1QrRDDYmaaeflr/Aky3r2WNn95OnvTztYnmaI=;
        b=QcDov7Raa09ZtdRsXFJ0viRcqkiBbD8PQ0I42YQW5yTk4rqUZXyjedAsh/LHLUCAUF
         T55wDhrjlvsP2byKNUqrqGWvKoLnowi2oyZ0v+ooKyLk8QCznT9nyIX7uxUuoiww42jf
         TQc2gZfNayemySlMZ1x7/NDTrURHziSfx8BIrQuznxfPrHH/PN4aybpKCihQgB//6Hfo
         5YHCB4UOI5Ejjh4ub8inqFkozzBulF8sa5gxnPrAmsfSmTNIjdz3h4Dxw8FPWs5nFarU
         BqTU+dTPztT/rZ6N2wPu6F5ZztyKSGzUVD65SMJ42A7AJ1zunfXiXnrIgDEhCqRbhktD
         j2MQ==
X-Gm-Message-State: AOAM531W1pO0RVXJ2ReBTgU8w6ayMRwc5dV17Bv4g/Cpj1YgIPyRsgRb
        OWArG2LpsOlQHlJs0QoL+no=
X-Google-Smtp-Source: ABdhPJz8AOoDpkCX0YewEVrDNZdxyVtkiLBRsF5iUFOyshOwZYWonAuxF3yqtJs6MMMfAVnCpUclbg==
X-Received: by 2002:a5d:6485:: with SMTP id o5mr4711440wri.91.1624368133350;
        Tue, 22 Jun 2021 06:22:13 -0700 (PDT)
Received: from agape.jhs ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id o26sm2334517wms.27.2021.06.22.06.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 06:22:13 -0700 (PDT)
Date:   Tue, 22 Jun 2021 15:22:10 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/17] staging: rtl8723bs: remove 5Ghz code
Message-ID: <20210622132210.GB1410@agape.jhs>
References: <cover.1624367071.git.fabioaiuto83@gmail.com>
 <20bed383-adca-e2f0-bede-762707d052ac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20bed383-adca-e2f0-bede-762707d052ac@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Tue, Jun 22, 2021 at 03:19:45PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 6/22/21 3:09 PM, Fabio Aiuto wrote:
> > This patch series removes all occurences of 5Ghz code over the
> > driver as required from driver's TODO list:
> > 
> >         - find and remove remaining code valid only for 5 GHz.
> >           most of the obvious one have been removed, but things
> >           like channel > 14 still exist.
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
> > So:
> > 
> > Tested-by: Fabio Auto <fabioaiuto83@gmail.com>
> 
> From a quick scan the series looks ok to me now:
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> 
> Regards,
> 
> Hans

thank you,

fabio


> 
> 
> 
> 
> > ------------------------------------------------
> > Changes in v3:
> > 	- delete a condition in patch 1 as pointed out by
> > 	  Hans
> > 	- fix in 'Changes in v2' text (pointed out).
> > Changes in v2:
> >         - drop v1 15/18 patch, for it deliberately
> >           does register writes as pointed out by Hans.
> > 
> > Fabio Aiuto (17):
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
> >   staging: rtl8723bs: remove obsolete 5Ghz comments
> >   staging: rtl8723bs: fix check allowing 5Ghz settings
> >   staging: rtl8723bs: remove item from TODO list
> > 
> >  drivers/staging/rtl8723bs/TODO                |    2 -
> >  drivers/staging/rtl8723bs/core/rtw_ap.c       |   11 +-
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
> >  .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |   41 +-
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
> >  44 files changed, 640 insertions(+), 2439 deletions(-)
> > 
> 
