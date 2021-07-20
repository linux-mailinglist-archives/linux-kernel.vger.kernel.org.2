Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8385C3D04D4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 00:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhGTWLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 18:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbhGTWKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 18:10:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05702C061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 15:51:24 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m11-20020a05600c3b0bb0290228f19cb433so2398573wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 15:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8W1KbjY8fT8BQvIAZVuxTpUxou1s0JW4/9580Ls3I/U=;
        b=mGsK65QOANR2CO0EdxSdjHISh2tPghmUxcSBS65WhS5BotcRFzc0c/lI/XKcNfHPW2
         xN+kbCpvVXXsRQJlr+RmYh8Rsp1sVHqjJJHzUX7HLwKTLQ5UDS3W88kOhPVrcXMu70EW
         9kOL6Hak4b+oQgIM6sF6h9zQwpzMEWGHQHa/iJ8qo81D5WALan28ob+sc6PJpKduJTIH
         PCgNRTGxZECL1Av3LPnXhLobo9XcgqC6Q2cxs4d14RCFzUNl7EqXtqTocLakj14o6y4l
         2MhIR4kyiZTaYmA+iyXsHKg1cAWLX9xrhbmOeHlh+KF9x+cVMNpr/AMtaJwYq+eEJS8/
         LosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8W1KbjY8fT8BQvIAZVuxTpUxou1s0JW4/9580Ls3I/U=;
        b=WYjsyBQrt7zTsZXIoVWgX3W++Lplxr6VMGofARJ0IbQEsEEKcuLQ2nwR1zeYjk5BSV
         pSBwsUM7owGMaYBJbZWMbJhitClXDHfNkwG8dQZcG4O2Tz/2PvI4nlvbQsDqDhY6KZrF
         jC3J8u2NIYfuu8CfwvIjK3gsfbnc4oD72TX5i7BtdOFAiOEc6pT4ov37fTmsg+N8vTNL
         mx1op7DAPVuE1TVtsASPPqdubklM/num/tN76zU/zm+69G+CehLD40In/xJXVJsy9WMk
         s9moOLTR0lpr6y2doWBTg10yrsv4is+K54kcNUKkbtcyM4pkLAj4QjV1qi7JF5G8/irx
         2grw==
X-Gm-Message-State: AOAM532yau5JdhFCnZKJq6/Y8ZKZSOoTLEeJQIXlZqurR+5S1+Ba3e+7
        tLt5473o/bmLGAsBkrSvl/YRFA==
X-Google-Smtp-Source: ABdhPJwJL3pVx8oufIcdQtq29JC8z4pRU7rHCxACydg4sIGsTVFRu5GCYsyX3H2M+++gfZZmzlmv0w==
X-Received: by 2002:a1c:a58b:: with SMTP id o133mr34220178wme.160.1626821482516;
        Tue, 20 Jul 2021 15:51:22 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id z11sm24800835wru.65.2021.07.20.15.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 15:51:21 -0700 (PDT)
Date:   Tue, 20 Jul 2021 23:51:19 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org
Subject: Re: [PATCH resend] staging: rtl8188eu: move all source files from
 core subdirectory
Message-ID: <YPdTZ9Q9zCIyBjjB@equinox>
References: <20210719224601.255364-1-phil@philpotter.co.uk>
 <7bc43fb0-2dab-190b-c480-9e77cff863d4@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bc43fb0-2dab-190b-c480-9e77cff863d4@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 06:46:16PM -0500, Larry Finger wrote:
> On 7/19/21 5:46 PM, Phillip Potter wrote:
> > Move all C source files from the core subdirectory to the root
> > folder of the driver, and adjust Makefile accordingly. The ultmate
> > goal is to remove hal layer and fold its functionalty into the main
> > sources. At this point, the distinction between hal and core will be
> > meaningless, so this is the first step towards simplifying the file
> > layout.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> >   drivers/staging/rtl8188eu/Makefile            | 34 +++++++++----------
> >   drivers/staging/rtl8188eu/{core => }/rtw_ap.c |  0
> >   .../staging/rtl8188eu/{core => }/rtw_cmd.c    |  0
> >   .../staging/rtl8188eu/{core => }/rtw_efuse.c  |  0
> >   .../rtl8188eu/{core => }/rtw_ieee80211.c      |  0
> >   .../rtl8188eu/{core => }/rtw_ioctl_set.c      |  0
> >   .../staging/rtl8188eu/{core => }/rtw_iol.c    |  0
> >   .../staging/rtl8188eu/{core => }/rtw_led.c    |  0
> >   .../staging/rtl8188eu/{core => }/rtw_mlme.c   |  0
> >   .../rtl8188eu/{core => }/rtw_mlme_ext.c       |  0
> >   .../rtl8188eu/{core => }/rtw_pwrctrl.c        |  0
> >   .../staging/rtl8188eu/{core => }/rtw_recv.c   |  0
> >   drivers/staging/rtl8188eu/{core => }/rtw_rf.c |  0
> >   .../rtl8188eu/{core => }/rtw_security.c       |  0
> >   .../staging/rtl8188eu/{core => }/rtw_sreset.c |  0
> >   .../rtl8188eu/{core => }/rtw_sta_mgt.c        |  0
> >   .../rtl8188eu/{core => }/rtw_wlan_util.c      |  0
> >   .../staging/rtl8188eu/{core => }/rtw_xmit.c   |  0
> >   18 files changed, 17 insertions(+), 17 deletions(-)
> >   rename drivers/staging/rtl8188eu/{core => }/rtw_ap.c (100%)
> >   rename drivers/staging/rtl8188eu/{core => }/rtw_cmd.c (100%)
> >   rename drivers/staging/rtl8188eu/{core => }/rtw_efuse.c (100%)
> >   rename drivers/staging/rtl8188eu/{core => }/rtw_ieee80211.c (100%)
> >   rename drivers/staging/rtl8188eu/{core => }/rtw_ioctl_set.c (100%)
> >   rename drivers/staging/rtl8188eu/{core => }/rtw_iol.c (100%)
> >   rename drivers/staging/rtl8188eu/{core => }/rtw_led.c (100%)
> >   rename drivers/staging/rtl8188eu/{core => }/rtw_mlme.c (100%)
> >   rename drivers/staging/rtl8188eu/{core => }/rtw_mlme_ext.c (100%)
> >   rename drivers/staging/rtl8188eu/{core => }/rtw_pwrctrl.c (100%)
> >   rename drivers/staging/rtl8188eu/{core => }/rtw_recv.c (100%)
> >   rename drivers/staging/rtl8188eu/{core => }/rtw_rf.c (100%)
> >   rename drivers/staging/rtl8188eu/{core => }/rtw_security.c (100%)
> >   rename drivers/staging/rtl8188eu/{core => }/rtw_sreset.c (100%)
> >   rename drivers/staging/rtl8188eu/{core => }/rtw_sta_mgt.c (100%)
> >   rename drivers/staging/rtl8188eu/{core => }/rtw_wlan_util.c (100%)
> >   rename drivers/staging/rtl8188eu/{core => }/rtw_xmit.c (100%)
> > 
> > diff --git a/drivers/staging/rtl8188eu/Makefile b/drivers/staging/rtl8188eu/Makefile
> > index 28b936e8be0a..2dad13bdbdeb 100644
> > --- a/drivers/staging/rtl8188eu/Makefile
> > +++ b/drivers/staging/rtl8188eu/Makefile
> > @@ -1,22 +1,22 @@
> >   # SPDX-License-Identifier: GPL-2.0
> >   r8188eu-y :=				\
> > -		core/rtw_ap.o		\
> > -		core/rtw_cmd.o		\
> > -		core/rtw_efuse.o	\
> > -		core/rtw_ieee80211.o	\
> > -		core/rtw_ioctl_set.o	\
> > -		core/rtw_iol.o		\
> > -		core/rtw_led.o		\
> > -		core/rtw_mlme.o		\
> > -		core/rtw_mlme_ext.o	\
> > -		core/rtw_pwrctrl.o	\
> > -		core/rtw_recv.o		\
> > -		core/rtw_rf.o		\
> > -		core/rtw_security.o	\
> > -		core/rtw_sreset.o	\
> > -		core/rtw_sta_mgt.o	\
> > -		core/rtw_wlan_util.o	\
> > -		core/rtw_xmit.o		\
> > +		rtw_ap.o		\
> > +		rtw_cmd.o		\
> > +		rtw_efuse.o		\
> > +		rtw_ieee80211.o		\
> > +		rtw_ioctl_set.o		\
> > +		rtw_iol.o		\
> > +		rtw_led.o		\
> > +		rtw_mlme.o		\
> > +		rtw_mlme_ext.o		\
> > +		rtw_pwrctrl.o		\
> > +		rtw_recv.o		\
> > +		rtw_rf.o		\
> > +		rtw_security.o		\
> > +		rtw_sreset.o		\
> > +		rtw_sta_mgt.o		\
> > +		rtw_wlan_util.o		\
> > +		rtw_xmit.o		\
> >   		hal/fw.o	\
> >   		hal/mac_cfg.o \
> >   		hal/bb_cfg.o \
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/rtw_ap.c
> > similarity index 100%
> > rename from drivers/staging/rtl8188eu/core/rtw_ap.c
> > rename to drivers/staging/rtl8188eu/rtw_ap.c
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/rtw_cmd.c
> > similarity index 100%
> > rename from drivers/staging/rtl8188eu/core/rtw_cmd.c
> > rename to drivers/staging/rtl8188eu/rtw_cmd.c
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/rtw_efuse.c
> > similarity index 100%
> > rename from drivers/staging/rtl8188eu/core/rtw_efuse.c
> > rename to drivers/staging/rtl8188eu/rtw_efuse.c
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/rtw_ieee80211.c
> > similarity index 100%
> > rename from drivers/staging/rtl8188eu/core/rtw_ieee80211.c
> > rename to drivers/staging/rtl8188eu/rtw_ieee80211.c
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c b/drivers/staging/rtl8188eu/rtw_ioctl_set.c
> > similarity index 100%
> > rename from drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
> > rename to drivers/staging/rtl8188eu/rtw_ioctl_set.c
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_iol.c b/drivers/staging/rtl8188eu/rtw_iol.c
> > similarity index 100%
> > rename from drivers/staging/rtl8188eu/core/rtw_iol.c
> > rename to drivers/staging/rtl8188eu/rtw_iol.c
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c b/drivers/staging/rtl8188eu/rtw_led.c
> > similarity index 100%
> > rename from drivers/staging/rtl8188eu/core/rtw_led.c
> > rename to drivers/staging/rtl8188eu/rtw_led.c
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/rtw_mlme.c
> > similarity index 100%
> > rename from drivers/staging/rtl8188eu/core/rtw_mlme.c
> > rename to drivers/staging/rtl8188eu/rtw_mlme.c
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/rtw_mlme_ext.c
> > similarity index 100%
> > rename from drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> > rename to drivers/staging/rtl8188eu/rtw_mlme_ext.c
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c b/drivers/staging/rtl8188eu/rtw_pwrctrl.c
> > similarity index 100%
> > rename from drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
> > rename to drivers/staging/rtl8188eu/rtw_pwrctrl.c
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/rtw_recv.c
> > similarity index 100%
> > rename from drivers/staging/rtl8188eu/core/rtw_recv.c
> > rename to drivers/staging/rtl8188eu/rtw_recv.c
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_rf.c b/drivers/staging/rtl8188eu/rtw_rf.c
> > similarity index 100%
> > rename from drivers/staging/rtl8188eu/core/rtw_rf.c
> > rename to drivers/staging/rtl8188eu/rtw_rf.c
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/rtw_security.c
> > similarity index 100%
> > rename from drivers/staging/rtl8188eu/core/rtw_security.c
> > rename to drivers/staging/rtl8188eu/rtw_security.c
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_sreset.c b/drivers/staging/rtl8188eu/rtw_sreset.c
> > similarity index 100%
> > rename from drivers/staging/rtl8188eu/core/rtw_sreset.c
> > rename to drivers/staging/rtl8188eu/rtw_sreset.c
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/rtw_sta_mgt.c
> > similarity index 100%
> > rename from drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
> > rename to drivers/staging/rtl8188eu/rtw_sta_mgt.c
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/rtw_wlan_util.c
> > similarity index 100%
> > rename from drivers/staging/rtl8188eu/core/rtw_wlan_util.c
> > rename to drivers/staging/rtl8188eu/rtw_wlan_util.c
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/rtw_xmit.c
> > similarity index 100%
> > rename from drivers/staging/rtl8188eu/core/rtw_xmit.c
> > rename to drivers/staging/rtl8188eu/rtw_xmit.c
> > 
> 
> I think this is just source churning. The current setup with include. core.
> hal and os_dep subdirectories are not opressive.
> 
> Larry
> 
Dear Larry,

Thank you for your feedback. I will focus on utilising the existing
folder structure in that case, with a view towards reducing/removing the
'hal' folder and reintegrating its code.

Regards,
Phil
