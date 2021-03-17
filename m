Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20B633EDD8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhCQJ7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhCQJ7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:59:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A38C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:59:35 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so916493wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=x4zh4SNUmcfd2PXUC3KyCVi6qa14IVpwvMxxZz19GaU=;
        b=RAU5np/eftqddHmvUd91pRF2x7OmGchGIUni9qiz3ZnusMkPHtr0CvDP1FwU9RApkL
         KsroEVk6BBPu/UswmQ5Nqw6VhEPU63JprUGSeJIHJQXujyz7WUB4V/Sou0HTpaaMWlGD
         AGeTO+UxUZipbqqBIY9K8pjJRoBeL11QTo6pzcJ7QgHH3pUXdvQuUxPuwgSBzMrBTclH
         Ba9NblP63vMUpRlmFZA6qp1fXSdaNlsdDGkEuu99DbZZpKTtD8ueUjf16kJIdxJXTtuQ
         aKqL4g98M0rmQ7G3y2uMsfYJrd4vMRsiVpwa6vqxUZ93c2WFU6fVZQzvQ6i3LfGxBaFx
         5rsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=x4zh4SNUmcfd2PXUC3KyCVi6qa14IVpwvMxxZz19GaU=;
        b=DBxazAMF/Ac1UsaCUqpoQjSjyx2NVgrdvTnxsecNdDvHyxgQtIvA0p0G2XCoMTnTXD
         n7oG4EnetPOIg0FNST5ykGcqtwT7bwyBGVkdGZW/S7bnqTW8jFLyzzO1XBHRCdiztEXX
         sJLgLri5EPR6b2D74GbTTOS/QDtbG+R9300WVq57Gbd+jg6scstKzmT8+5Q7Ja5CReH0
         58V7V8ry/eDv06eg7plS8BcT+sgqY3KMU5s3yvI2j484hMoePIH4UWRkzLvl5gVFozXs
         7XxJnEB13ZOeEE+LIKFJsn4hSi6T5X2N7LDZRYjzhgSaSiLcQbkurzeZ8iWwfLlpPapd
         ZleA==
X-Gm-Message-State: AOAM533f3ziIXavjPD8HOKlDS8f8aHPU6UwkSohfI0P56OPqS6d6kyin
        KznpetAYW8ap24AgT1tzdTSGZYT7xA8=
X-Google-Smtp-Source: ABdhPJzCQwaBGCPMvrYnw1j6e8gM0U97jtKMOwk/M4YQMboeaJWQoljMeroxG5VLAON/dIK83WIoJQ==
X-Received: by 2002:a1c:a74b:: with SMTP id q72mr2837753wme.158.1615975174384;
        Wed, 17 Mar 2021 02:59:34 -0700 (PDT)
Received: from agape.jhs ([5.171.81.191])
        by smtp.gmail.com with ESMTPSA id u4sm26518413wrm.24.2021.03.17.02.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:59:34 -0700 (PDT)
Date:   Wed, 17 Mar 2021 10:59:32 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: staging: rtl8723bs: remove unused code blocks completed?
Message-ID: <20210317095932.GA2308@agape.jhs>
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
