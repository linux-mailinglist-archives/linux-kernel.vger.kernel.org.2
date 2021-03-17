Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D764433EDCF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhCQJ6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhCQJ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:58:26 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669CCC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:58:15 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j18so1146480wra.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=x4zh4SNUmcfd2PXUC3KyCVi6qa14IVpwvMxxZz19GaU=;
        b=a+fxMkr21025v8KyzUdXrHu0dkOQedksKKsOdtCdbozifiP7HUxsiq8WwUYFv5yXqY
         Dq9Ix4ayo29vQ81Q6uxaSlkUyLq/luxJaaceVjuNNHz1qpfUlE6+BvZRRAX0j81RDM+y
         N88dn11gu8L5l0nNkQRK+fAxX09ViWrAF5FKriIM0WlOQjBqgB8hcYzHLH0KL0sVIzHZ
         vU/0tkGnMMUd7n1G4V5hJHim0LuWHBTJI2gQsk0vTHELkPG5xBKeEeIWiUaqmnTzUxBy
         CaQXIYKXWV0mH4M3HAkMPpQGpw7XqSWp7YvT1aI7B149oHdm0knz+JypbLgtIFRn7qsB
         sdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=x4zh4SNUmcfd2PXUC3KyCVi6qa14IVpwvMxxZz19GaU=;
        b=ojNNJ69EAjieJPadCLDRcgAIW94m7tgRAEa9qs3V2HRXVggX6O+aQcntBdcd8SoQft
         otya8EGk/MLk73cY19OYbGNKR8n/gmjsvKS8rZs4dYtY11WhxQR3cE7PBBR5zQo8xI5u
         5eWxYzDsU/TFObc6iTi9P0vHQa0KFzFLcAc7EUekszcV9RWtiqRSL/PUvdKzbEYuDS+V
         xgIOi90mCPsQW4WeRMpFFHAlbc9H9ouqZ6herSA4bkLYkkh21TLo5Ih1fUnW5tFN3y21
         MgymTT45AB0EHFNnefBC1CmovcnD1gBZpgAfRHeGTCDuAYngpbARAAAGCHpRUH/31i/M
         TqOQ==
X-Gm-Message-State: AOAM533fmO5G92kGmi3ohsIT9H0fcBm1HWDDZINfNmiz+LLdefcJD2cf
        exj4ohYrnTqSgJV9tFhnPsrKtvRScDo=
X-Google-Smtp-Source: ABdhPJwTcvpEVOYb4EuzFW/uyLjNVrrSMdeNkMba8xfez82DYHzbAp0Qpw68j/p/jevJnjVKztXRww==
X-Received: by 2002:a05:6000:1803:: with SMTP id m3mr3610739wrh.50.1615975094162;
        Wed, 17 Mar 2021 02:58:14 -0700 (PDT)
Received: from agape.jhs ([5.171.81.191])
        by smtp.gmail.com with ESMTPSA id w131sm1998871wmb.8.2021.03.17.02.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:58:13 -0700 (PDT)
Date:   Wed, 17 Mar 2021 10:58:12 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfounddation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: staging: rtl8723bs: remove unused code blocks completed?
Message-ID: <20210317095812.GA2270@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to search other unused code blocks:

grep -r '^\(#ifdef \|#if defined(\|#ifndef \)CONFIG_' drivers/staging/rtl8723bs/

drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:#if defined(CONFIG_PM)
drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:#if defined(CONFIG_PM)
drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:#if defined(CONFIG_WEXT_PRIV)
drivers/staging/rtl8723bs/include/drv_conf.h:#ifndef CONFIG_RTW_HIQ_FILTER
drivers/staging/rtl8723bs/include/autoconf.h:#ifndef CONFIG_WIRELESS_EXT

all blocks left are checked by existing defines.
Could we apply this?

thank you,

fabio

diff --git a/drivers/staging/rtl8723bs/TODO b/drivers/staging/rtl8723bs/TODO
index 45065fd3fd5d..afa620ceb2d8 100644
--- a/drivers/staging/rtl8723bs/TODO
+++ b/drivers/staging/rtl8723bs/TODO
@@ -1,5 +1,4 @@
 TODO:
-- find and remove code blocks guarded by never set CONFIG_FOO defines
 - find and remove remaining code valid only for 5 GHz. Most of the obvious
   ones have been removed, but things like channel > 14 still exist.
 - find and remove any code for other chips that is left over
