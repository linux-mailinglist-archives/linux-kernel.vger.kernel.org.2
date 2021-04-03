Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A312A353596
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 23:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbhDCVbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 17:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbhDCVbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 17:31:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2DBC061756
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 14:31:00 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d12so12136843lfv.11
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 14:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wAwaa9LP0wQ209XA7qPfB41Svfic7ft68qPsbT5JtIM=;
        b=Oh55ya+pPEbtZQ9V4bd/ADzwbAatOuoslLhY3grU0ZF6RzeyXh4m+pLQS4sGLViUn5
         lexWhNpBBTNesiz5n+awTqXn140ClJm7RBaZasq6eJPEJuML9e6uKOZYRlMsaqEYql2q
         P/YsMcj39SRNPQQzosmP9VVnP4siJQNOqvbmJgtxuA+OWgbRWsmyFI4TXtYJuev3n7uz
         GvrDHJl+LnFi3L/Xo+LuUV/9w8VFInsCjMoP7492T4JrlqBx0KACo5xEI7+YeAdhfq+l
         nPNNxGlMSGd7asUKlnEiv+qO+ApnfQzEXkxe1r4MG9PnjrWNm8eeLN1zGAAAck1FJr/A
         VR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wAwaa9LP0wQ209XA7qPfB41Svfic7ft68qPsbT5JtIM=;
        b=VbpGuYAyaL2NCFb6L4ECiM92hG/uFWvueCajT7O7WW+4VerhMD1IdJCubRFaBv00hJ
         kDX5aFrwEArATPpizObaptwjkq42nwVgOh7ouBr9kWsy+cWXmdMtC/dumZDp/DuikNfz
         evVBFgD9AcpvwoXs4CmvRq9Shw+rXAF0QcKImvxFRAHwCn9vZ2IWH9jgFCt5eKY08roe
         fLEhCeP+q4yQH83l5AihE9q4UH3KGVVYkoFQCcGOp8MUKL2PwNbO8QD0d5l5JTsymF2J
         /3Xlhlu5P7uUVMcZPLfIBok21zs02NexPd2SREeT03s7rrXUsJT122UVP70Nvz2e02Xz
         5+vg==
X-Gm-Message-State: AOAM53217bM2AreCEmXA5TCVSHYPUWXpXYHzv/7gpw3IzNCiyeLLeYNO
        ze42aqbvHlQsBSuv7FSmGC60PPOcpbc=
X-Google-Smtp-Source: ABdhPJxpSa3m+3fSh7iJM4XPELlxclT+nVjh5P3ZCQ4osmltScszpMNni9Z53zHpZCNjo0Z01Jkd2A==
X-Received: by 2002:a19:5e14:: with SMTP id s20mr13132692lfb.110.1617485459165;
        Sat, 03 Apr 2021 14:30:59 -0700 (PDT)
Received: from [192.168.0.160] (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id h7sm1240676lfg.246.2021.04.03.14.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Apr 2021 14:30:58 -0700 (PDT)
Subject: Re: [PATCH 2/2] staging:r8188eu: remove dummy handlers from
 OnAction()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210328163323.53163-1-insafonov@gmail.com>
 <20210328163323.53163-2-insafonov@gmail.com> <YGcWTOUl8OtAHTT4@kroah.com>
From:   Ivan Safonov <insafonov@gmail.com>
Message-ID: <8955077a-94b6-9ffb-d2f6-b611845b6cfc@gmail.com>
Date:   Sun, 4 Apr 2021 00:30:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YGcWTOUl8OtAHTT4@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/21 4:04 PM, Greg Kroah-Hartman wrote:
> On Sun, Mar 28, 2021 at 07:33:25PM +0300, Ivan Safonov wrote:
>> on_action_spct() do nothing, because rtw_get_stainfo() has no side
>> effects. Other action handlers are trivial.
>>
>> Signed-off-by: Ivan Safonov <insafonov@gmail.com>
> 
> Same here, wrong driver name :(
> 

Driver name is "r8188eu"...

$ grep 'r8188eu' drivers/staging/rtl8188eu/include/drv_types.h
#define DRV_NAME "r8188eu"

$ grep 'r8188eu' drivers/staging/rtl8188eu/os_dep/usb_intf.c -B1 -A7
static struct usb_driver rtl8188e_usb_drv = {
         .name = "r8188eu",
         .probe = rtw_drv_init,
         .disconnect = rtw_dev_remove,
         .id_table = rtw_usb_id_tbl,
         .suspend =  rtw_suspend,
         .resume = rtw_resume,
         .reset_resume = rtw_resume,
};

$ cat drivers/staging/rtl8188eu/Kconfig
# SPDX-License-Identifier: GPL-2.0
config R8188EU
         tristate "Realtek RTL8188EU Wireless LAN NIC driver"
         depends on WLAN && USB && CFG80211
         depends on m
         select WIRELESS_EXT
         select WEXT_PRIV
         select LIB80211
         select LIB80211_CRYPT_WEP
         select LIB80211_CRYPT_CCMP
         help
         This option adds the Realtek RTL8188EU USB device such as 
TP-Link TL-WN725N.
         If built as a module, it will be called r8188eu.

if R8188EU

config 88EU_AP_MODE
         bool "Realtek RTL8188EU AP mode"
         default y
         help
         This option enables Access Point mode. Unless you know that 
your system
         will never be used as an AP, or the target system has limited 
memory,
         "Y" should be selected.

endif
