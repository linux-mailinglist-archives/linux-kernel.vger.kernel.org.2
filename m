Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6529F3A7DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFOMOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:14:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229946AbhFOMOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623759117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=catMU2sQUcY0cmzqi/0xf41u4VQHC7Rms2o/nd0B/O8=;
        b=BKgQaIvaEEyxC1ViL0hO2Lr1jXVDvtk1iKfad9DAhsoNZOa1iG3uiR6Xlb+IqEAG4yWuRY
        8ORynIr0kuaMPhhArVTzkcJS/aT4S0XGoe7LW0RAS7GteTFmsnmkT4BpvPk3lEsag9pr6P
        DFWDkDY2q0PWzpCsNzIZEhz2vDCDoic=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-5HjOQiMhMFORxcTI4VXFVw-1; Tue, 15 Jun 2021 08:11:56 -0400
X-MC-Unique: 5HjOQiMhMFORxcTI4VXFVw-1
Received: by mail-ej1-f72.google.com with SMTP id e11-20020a170906080bb02903f9c27ad9f5so4427312ejd.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=catMU2sQUcY0cmzqi/0xf41u4VQHC7Rms2o/nd0B/O8=;
        b=J6U/cmGWSMBN0brOe6EWIeR4AmYOncErxQ4RDUOIohzHGsR1RRqFLsLwsXpXkELHkM
         94e+5gQyBkqafLmmWv7+pLYbNqCCWHtdnABXMn/llO3hLvVL9J0iT/u8Mat+4lHfA+Cf
         hFJHlSY5wuUmL3V4sxJhj+mFcUixTDaJZrl8hwXHpCv2WWxmgrZvVSa356A7l07cFEQ3
         87A6c2d481PHj1plf8VFD1jjBCWOUavCsNoXwETfIp8veybK+toOCWlbzKe8kSRg9IfL
         ozOIeuQN9skxGWCwFF1PBaTQZG5wux76/El1ujK+uB4gAJLhypAZj3gVLBunSAIViKCU
         bDfg==
X-Gm-Message-State: AOAM533AuUKMZmZzH6pZbr+6dMk3UZ/4S2fSyJ7NyeXFhhgeWVPYDXJB
        tvszSKMzBHJblYBUSYFFKwEBh2GgcW1oq9tJXk0M1CbWfdWyQrgksZ7D/0abgc3Z/bEtHhzEYwf
        ZP2uLHLlORkHV/Sq7H3rMXHCujjaMNIxGpTmAkvoUOdPV618ww1OZb9fIOxOLYoKgIyoQ1ugfxy
        hk
X-Received: by 2002:a05:6402:4242:: with SMTP id g2mr2385996edb.350.1623759115480;
        Tue, 15 Jun 2021 05:11:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0eETMZ0KtHAEY/DHOOKsuF/qv/jjzcudE4oivsL7FfV+ozmnRx6Vs5McNXSzrFhYVzjTXlg==
X-Received: by 2002:a05:6402:4242:: with SMTP id g2mr2385980edb.350.1623759115291;
        Tue, 15 Jun 2021 05:11:55 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id cx7sm11793276edb.65.2021.06.15.05.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 05:11:27 -0700 (PDT)
Subject: Re: [PATCH 0/8] staging: rtl8723bs: remove unneeded files from tree
To:     Fabio Aiuto <fabioaiuto83@gmail.com>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1623756906.git.fabioaiuto83@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8109abbd-f7ae-2b88-4b99-98151322c843@redhat.com>
Date:   Tue, 15 Jun 2021 14:11:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <cover.1623756906.git.fabioaiuto83@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/15/21 1:45 PM, Fabio Aiuto wrote:
> This patchset removes some unneeded files.
> 
> autoconf.h seems to be the output of some automatic
> header file generation foreign to the linux kernel
> configuration and build system.
> 
> To toggle some part of code one is asked to
> force an edit by hand on this file.
> 
> Other unneeded definitions were deleted recently,
> now we complete the job.
> 
> Removed core/rtw_eeprom.c and include/drv_conf.h as well,
> for they are excluded from the build process.
> 
> Tested-by: Fabio Aiuto <fabioaiuto83@gmail.com>

Thank you, series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series,

Regards,

Hans

> 
> Fabio Aiuto (8):
>   staging: rtl8723bs: remove unused debug macro
>   staging: rtl8723bs: remove unneeded comments
>   staging: rtl8723bs: remove unused WAKEUP_GPIO_IDX macro definition
>   staging: rtl8723bs: remove unneeded DISABLE_BB_RF macro
>   staging: rtl8723bs: remove HAL_{BB,MAC,RF,FW}_ENABLE macros
>   staging: rtl8723bs: move LPS_RPWM_WAIT_MS macro
>   staging: rtl8723bs: remove include/autoconf.h header file from tree
>   staging: rtl8723bs: remove two unused files from tree
> 
>  drivers/staging/rtl8723bs/core/rtw_eeprom.c   | 208 ------------------
>  .../staging/rtl8723bs/hal/HalPhyRf_8723B.c    |   7 -
>  .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   |  16 --
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c  |  15 --
>  drivers/staging/rtl8723bs/include/autoconf.h  |  50 -----
>  drivers/staging/rtl8723bs/include/drv_conf.h  |  19 --
>  drivers/staging/rtl8723bs/include/drv_types.h |   1 -
>  .../staging/rtl8723bs/include/hal_btcoex.h    |   2 +
>  drivers/staging/rtl8723bs/include/hal_phy.h   |  14 --
>  .../staging/rtl8723bs/include/rtl8723b_spec.h |   2 -
>  10 files changed, 2 insertions(+), 332 deletions(-)
>  delete mode 100644 drivers/staging/rtl8723bs/core/rtw_eeprom.c
>  delete mode 100644 drivers/staging/rtl8723bs/include/autoconf.h
>  delete mode 100644 drivers/staging/rtl8723bs/include/drv_conf.h
> 

