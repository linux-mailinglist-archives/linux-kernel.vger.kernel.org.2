Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881023D3953
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbhGWKjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 06:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhGWKjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 06:39:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09A9C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 04:20:04 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gv20-20020a17090b11d4b0290173b9578f1cso6036924pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jOu2PPlVOt7NEzf7jq7lMfALdWnbdT7/aeQAZqIkGyM=;
        b=p2apFC49MwCQOIlS78qot3FE5SI9Yb31cpgS1W4bpIuguFxLooKthccyQVqnyRvofD
         Yev48FRNIiui99+CWNXtg4ONj528nT7ngOjuV8mO6SjtAguCfZHgmUVP2gH6Lp23uRI5
         Cdwu3uMyJm0VtI1a4JpjTf5my+oJ6J/0bOI98qZB4C6IoZ+a2LA0Nro+KdzviVh31arS
         FAwpI+mwK2IlesOlvh9V79ykqQrq5I+WUmANROOckGuGlxxCam+9v5vR7r+Z8VptOvzW
         qfaUANhthalt0PtGAx4qstvqtECmzD0Gz1vkfdm6lYjPwtWv58EzYkVgdB0OC288NozC
         LZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jOu2PPlVOt7NEzf7jq7lMfALdWnbdT7/aeQAZqIkGyM=;
        b=fT/iv7cuXMMkwFlOg6zUaEjSarNlwanAybw+5+dedi2clsmVLQZsfGIOodB4NivPAU
         6JVvHJaqTY7pKXdVgas0CesnjSrTLi6wTnhJiP8P9z4wuJNklLXQNfGcsxTjzKxC36YA
         NgVANGuQlaP9Yr4wvK0L/u+MQ5tbKaMG2H4t2LN6BwtYAVM1eXiEZCE23dJzqJ8IH0Vb
         9TZjgCdXgUBLBNPRs2cbAHaTXXm5u1eNTQ8qawcKn/Uvd54bMOql/BPKPDKj5IUVJlE9
         0FyYtDMLTxqivlyIcNo9tZh2aTYdzkRCdjPo/H4N4qEN0YpNs697zFx8F9ld3scYIyTk
         qXWg==
X-Gm-Message-State: AOAM533BR2+ucjZaFr7v/2H64FTz3L0gODGyem9YR2JajR/dCVERfbDl
        xMPWSn4+59OfU2jzaQ6WZItkxp5NQClWCKkfnDZhyw==
X-Google-Smtp-Source: ABdhPJyIDvmw16uZdCZqL6Jak+qdqw/rLReWydWFzAwNzW93GGGXSa4XPlJaVpY8RKLVTFh1LiafbROxAcjfeY7xubI=
X-Received: by 2002:a62:1bc7:0:b029:328:cbf5:b6b0 with SMTP id
 b190-20020a621bc70000b0290328cbf5b6b0mr3963505pfb.81.1627039204026; Fri, 23
 Jul 2021 04:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210723004214.912295-1-phil@philpotter.co.uk>
 <20210723004214.912295-7-phil@philpotter.co.uk> <YPqjTauZTpN6jHUe@kroah.com>
In-Reply-To: <YPqjTauZTpN6jHUe@kroah.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Fri, 23 Jul 2021 12:19:53 +0100
Message-ID: <CAA=Fs0mxBUyEsf8pBQx_oOyVB61xS4DGsP2nvzD5n61kWA6QyA@mail.gmail.com>
Subject: Re: [PATCH 6/7] staging: rtl8188eu: introduce new supporting files
 for RTL8188eu driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, Fabio Aiuto <fabioaiuto83@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2021 at 12:09, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jul 23, 2021 at 01:42:13AM +0100, Phillip Potter wrote:
> > This patchset is split in order to keep the file sizes down. These
> > supporting files are part of the newer/better driver from GitHub modified by
> > Larry Finger. Import this as the basis for all future work going
> > forward. Also, modify Makefile so that driver has same module filename
> > as original rtl8188eu driver from staging.
> >
> > Suggested-by: Larry Finger <Larry.Finger@lwfinger.net>
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> >  drivers/staging/rtl8188eu/COPYING  | 356 ++++++++++++++++++++
>
> This file is not needed in here at all, just drop it, otherwise that
> would be the first patch we submit after this :)
>
> > diff --git a/drivers/staging/rtl8188eu/Kconfig b/drivers/staging/rtl8188eu/Kconfig
> > new file mode 100644
> > index 000000000000..970d5abd6336
> > --- /dev/null
> > +++ b/drivers/staging/rtl8188eu/Kconfig
> > @@ -0,0 +1,25 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +config R8188EU
> > +     tristate "Realtek RTL8188EU Wireless LAN NIC driver"
> > +     depends on WLAN && USB && CFG80211
> > +     depends on m
>
> why m?
>
> > +     select WIRELESS_EXT
> > +     select WEXT_PRIV
> > +     select LIB80211
> > +     select LIB80211_CRYPT_WEP
> > +     select LIB80211_CRYPT_CCMP
> > +     help
> > +     This option adds the Realtek RTL8188EU USB device such as TP-Link TL-WN725N.
> > +     If built as a module, it will be called r8188eu.
>
> Then how about we put this in drivers/staging/r8188eu/ instead of
> "rtl8188eu" so that people do not get confused over time?  Having a
> different directory name will make it obvious this is a new driver
> entirely and no backports will happen incorrectly and other people who
> get out of sync in sending patches will know obviously what happened.
>
> > +
> > +if R8188EU
> > +
> > +config 88EU_AP_MODE
> > +     bool "Realtek RTL8188EU AP mode"
> > +     default y
>
> default y is only if the machine will not boot without this.  Please
> drop this line.
>
> > +     help
> > +     This option enables Access Point mode. Unless you know that your system
> > +     will never be used as an AP, or the target system has limited memory,
> > +     "Y" should be selected.
> > +
> > +endif
> > diff --git a/drivers/staging/rtl8188eu/Makefile b/drivers/staging/rtl8188eu/Makefile
> > new file mode 100755
> > index 000000000000..6c30c8d95b87
> > --- /dev/null
> > +++ b/drivers/staging/rtl8188eu/Makefile
> > @@ -0,0 +1,509 @@
> > +EXTRA_CFLAGS += $(USER_EXTRA_CFLAGS)
> > +EXTRA_CFLAGS += -O1 -g
> > +#EXTRA_CFLAGS += -O3
> > +#EXTRA_CFLAGS += -Wall
> > +#EXTRA_CFLAGS += -Wextra
> > +#EXTRA_CFLAGS += -Werror
> > +#EXTRA_CFLAGS += -pedantic
> > +#EXTRA_CFLAGS += -Wshadow -Wpointer-arith -Wcast-qual -Wstrict-prototypes -Wmissing-prototypes
>
> Just drop these commented out lines right now.
>
> > +
> > +EXTRA_CFLAGS += -Wno-unused-variable
> > +EXTRA_CFLAGS += -Wno-unused-value
> > +EXTRA_CFLAGS += -Wno-unused-label
> > +EXTRA_CFLAGS += -Wno-unused-parameter
> > +EXTRA_CFLAGS += -Wno-unused-function
> > +EXTRA_CFLAGS += -Wno-unused
> > +EXTRA_CFLAGS += -Wno-uninitialized
>
> I doubt those are needed, but we can handle that later.
>
> > +
> > +GCC_VER_49 := $(shell echo `$(CC) -dumpversion | cut -f1-2 -d.` \>= 4.9 | bc )
> > +ifeq ($(GCC_VER_49),1)
> > +EXTRA_CFLAGS += -Wno-date-time       # Fix compile error && warning on gcc 4.9 and later
> > +endif
>
> That's very odd, we can deal with that later.
>
> > +
> > +EXTRA_CFLAGS += -I$(src)/include
> > +EXTRA_CFLAGS += -I$(src)/hal
> > +
> > +#EXTRA_LDFLAGS += --strip-debug
> > +
> > +CONFIG_AUTOCFG_CP = n
>
> What is that?
>
> > +
> > +########################## Features ###########################
> > +CONFIG_MP_INCLUDED = y
> > +CONFIG_POWER_SAVING = y
> > +CONFIG_USB_AUTOSUSPEND = n
> > +CONFIG_HW_PWRP_DETECTION = n
> > +CONFIG_WIFI_TEST = n
> > +CONFIG_BT_COEXIST = n
> > +CONFIG_INTEL_WIDI = n
> > +CONFIG_WAPI_SUPPORT = n
> > +CONFIG_EFUSE_CONFIG_FILE = y
> > +CONFIG_EXT_CLK = n
> > +CONFIG_TRAFFIC_PROTECT = y
> > +CONFIG_LOAD_PHY_PARA_FROM_FILE = y
> > +CONFIG_TXPWR_BY_RATE_EN = n
> > +CONFIG_TXPWR_LIMIT_EN = n
> > +CONFIG_RTW_ADAPTIVITY_EN = disable
> > +CONFIG_RTW_ADAPTIVITY_MODE = normal
> > +CONFIG_SIGNAL_SCALE_MAPPING = n
> > +CONFIG_80211W = n
> > +CONFIG_REDUCE_TX_CPU_LOADING = n
> > +CONFIG_BR_EXT = y
> > +CONFIG_TDLS = n
> > +CONFIG_WIFI_MONITOR = n
> > +CONFIG_MCC_MODE = n
> > +CONFIG_APPEND_VENDOR_IE_ENABLE = n
> > +CONFIG_RTW_NAPI = y
> > +CONFIG_RTW_GRO = y
> > +########################## Debug ###########################
> > +CONFIG_RTW_DEBUG = y
> > +# default log level is _DRV_INFO_ = 4,
> > +# please refer to "How_to_set_driver_debug_log_level.doc" to set the available level.
> > +CONFIG_RTW_LOG_LEVEL = 2
> > +######################## Wake On Lan ##########################
> > +CONFIG_WOWLAN = n
> > +CONFIG_GPIO_WAKEUP = n
> > +CONFIG_DEFAULT_PATTERNS_EN = n
> > +CONFIG_WAKEUP_GPIO_IDX = default
> > +CONFIG_HIGH_ACTIVE = n
> > +CONFIG_PNO_SUPPORT = n
> > +CONFIG_PNO_SET_DEBUG = n
> > +CONFIG_AP_WOWLAN = n
> > +######### Notify SDIO Host Keep Power During Syspend ##########
> > +CONFIG_RTW_SDIO_PM_KEEP_POWER = y
> > +###################### MP HW TX MODE FOR VHT #######################
> > +CONFIG_MP_VHT_HW_TX_MODE = n
> > +###################### Platform Related #######################
> > +CONFIG_PLATFORM_I386_PC = y
> > +###############################################################
> > +
> > +CONFIG_DRVEXT_MODULE = n
>
> I bet all of these config options can be removed, but that can come
> later.
>
> > +
> > +export TopDIR ?= $(CURDIR)
> > +
> > +MSG="Directory .git does not exist indicating that you downloaded the source as a zip file. Only the 'git clone' method is now supported."
>
> Odd, but not needed for building in the kernel tree.
>
> > +
> > +########### COMMON  #################################
> > +
> > +HCI_NAME = usb
> > +
> > +_OS_INTFS_FILES :=   os_dep/osdep_service.o \
> > +                     os_dep/os_intfs.o \
> > +                     os_dep/$(HCI_NAME)_intf.o \
> > +                     os_dep/$(HCI_NAME)_ops_linux.o \
> > +                     os_dep/ioctl_linux.o \
> > +                     os_dep/xmit_linux.o \
> > +                     os_dep/mlme_linux.o \
> > +                     os_dep/recv_linux.o \
> > +                     os_dep/ioctl_cfg80211.o \
> > +                     os_dep/rtw_cfgvendor.o \
> > +                     os_dep/wifi_regd.o \
> > +                     os_dep/rtw_android.o \
> > +                     os_dep/rtw_proc.o
> > +
> > +ifeq ($(CONFIG_MP_INCLUDED), y)
> > +_OS_INTFS_FILES += os_dep/ioctl_mp.o
> > +endif
> > +
> > +_HAL_INTFS_FILES :=  hal/hal_intf.o \
> > +                     hal/hal_com.o \
> > +                     hal/hal_com_phycfg.o \
> > +                     hal/hal_phy.o \
> > +                     hal/hal_dm.o \
> > +                     hal/hal_btcoex_wifionly.o \
> > +                     hal/hal_btcoex.o \
> > +                     hal/hal_mp.o \
> > +                     hal/hal_mcc.o \
> > +                     hal/hal_$(HCI_NAME).o \
> > +                     hal/hal_$(HCI_NAME)_led.o
> > +
> > +
>
> Trailing whitespace :(
>
> > +_OUTSRC_FILES := hal/phydm_debug.o   \
> > +             hal/phydm_antdiv.o\
> > +             hal/phydm_antdect.o\
> > +             hal/phydm_interface.o\
> > +             hal/phydm_hwconfig.o\
> > +             hal/phydm.o\
> > +             hal/halphyrf_ce.o\
> > +             hal/phydm_edcaturbocheck.o\
> > +             hal/phydm_dig.o\
> > +             hal/phydm_pathdiv.o\
> > +             hal/phydm_rainfo.o\
> > +             hal/phydm_dynamicbbpowersaving.o\
> > +             hal/phydm_powertracking_ce.o\
> > +             hal/phydm_dynamictxpower.o\
> > +             hal/phydm_adaptivity.o\
> > +             hal/phydm_cfotracking.o\
> > +             hal/phydm_noisemonitor.o\
> > +             hal/phydm_acs.o\
> > +             hal/phydm_dfs.o\
> > +             hal/phydm_hal_txbf_api.o\
> > +             hal/phydm_adc_sampling.o\
> > +             hal/phydm_kfree.o\
> > +             hal/phydm_ccx.o
> > +
> > +
> > +EXTRA_CFLAGS += -I$(src)/platform
> > +
> > +EXTRA_CFLAGS += -I$(src)/hal/btc
> > +
> > +RTL871X = rtl8188e
> > +
> > +_HAL_INTFS_FILES +=  hal/HalPwrSeqCmd.o \
> > +                                     hal/Hal8188EPwrSeq.o\
> > +                                     hal/$(RTL871X)_xmit.o\
> > +                                     hal/$(RTL871X)_sreset.o
> > +
> > +_HAL_INTFS_FILES +=  hal/$(RTL871X)_hal_init.o \
> > +                     hal/$(RTL871X)_phycfg.o \
> > +                     hal/$(RTL871X)_rf6052.o \
> > +                     hal/$(RTL871X)_dm.o \
> > +                     hal/$(RTL871X)_rxdesc.o \
> > +                     hal/$(RTL871X)_cmd.o \
> > +                     hal/hal8188e_s_fw.o \
> > +                     hal/hal8188e_t_fw.o \
> > +                     hal/$(HCI_NAME)_halinit.o \
> > +                     hal/rtl8188eu_led.o \
> > +                     hal/rtl8188eu_xmit.o \
> > +                     hal/rtl8188eu_recv.o
> > +
> > +_HAL_INTFS_FILES += hal/$(HCI_NAME)_ops_linux.o
> > +
> > +_HAL_INTFS_FILES +=hal/HalEfuseMask8188E_USB.o
> > +
> > +#hal/OUTSRC/Hal8188EFWImg_CE.o
> > +_OUTSRC_FILES += hal/halhwimg8188e_mac.o\
> > +             hal/halhwimg8188e_bb.o\
> > +             hal/halhwimg8188e_rf.o\
> > +             hal/halphyrf_8188e_ce.o\
> > +             hal/phydm_regconfig8188e.o\
> > +             hal/hal8188erateadaptive.o\
> > +             hal/phydm_rtl8188e.o
> > +
> > +########### AUTO_CFG  #################################
> > +
> > +ifeq ($(CONFIG_AUTOCFG_CP), y)
> > +
> > +ifeq ($(CONFIG_MULTIDRV), y)
> > +$(shell cp $(TopDIR)/autoconf_multidrv_$(HCI_NAME)_linux.h $(TopDIR)/include/autoconf.h)
> > +endif
> > +
> > +endif
> > +
> > +########### END OF PATH  #################################
> > +
> > +ifeq ($(CONFIG_USB_AUTOSUSPEND), y)
> > +EXTRA_CFLAGS += -DCONFIG_USB_AUTOSUSPEND
> > +endif
> > +
> > +ifeq ($(CONFIG_MP_INCLUDED), y)
> > +#MODULE_NAME := 8188eu_mp
> > +EXTRA_CFLAGS += -DCONFIG_MP_INCLUDED
> > +endif
> > +
> > +ifeq ($(CONFIG_POWER_SAVING), y)
> > +EXTRA_CFLAGS += -DCONFIG_POWER_SAVING
> > +endif
> > +
> > +ifeq ($(CONFIG_HW_PWRP_DETECTION), y)
> > +EXTRA_CFLAGS += -DCONFIG_HW_PWRP_DETECTION
> > +endif
> > +
> > +ifeq ($(CONFIG_WIFI_TEST), y)
> > +EXTRA_CFLAGS += -DCONFIG_WIFI_TEST
> > +endif
> > +
> > +ifeq ($(CONFIG_BT_COEXIST), y)
> > +EXTRA_CFLAGS += -DCONFIG_BT_COEXIST
> > +endif
> > +
> > +ifeq ($(CONFIG_INTEL_WIDI), y)
> > +EXTRA_CFLAGS += -DCONFIG_INTEL_WIDI
> > +endif
> > +
> > +ifeq ($(CONFIG_WAPI_SUPPORT), y)
> > +EXTRA_CFLAGS += -DCONFIG_WAPI_SUPPORT
> > +endif
> > +
> > +
> > +ifeq ($(CONFIG_EFUSE_CONFIG_FILE), y)
> > +EXTRA_CFLAGS += -DCONFIG_EFUSE_CONFIG_FILE
> > +
> > +#EFUSE_MAP_PATH
> > +USER_EFUSE_MAP_PATH ?=
> > +ifneq ($(USER_EFUSE_MAP_PATH),)
> > +EXTRA_CFLAGS += -DEFUSE_MAP_PATH=\"$(USER_EFUSE_MAP_PATH)\"
> > +else ifeq (r8188eu, 8189es)
> > +EXTRA_CFLAGS += -DEFUSE_MAP_PATH=\"/system/etc/wifi/wifi_efuse_8189e.map\"
> > +else ifeq (r8188eu, 8723bs)
> > +EXTRA_CFLAGS += -DEFUSE_MAP_PATH=\"/system/etc/wifi/wifi_efuse_8723bs.map\"
> > +else
> > +EXTRA_CFLAGS += -DEFUSE_MAP_PATH=\"/system/etc/wifi/wifi_efuse_8188eu.map\"
> > +endif
> > +
> > +#WIFIMAC_PATH
> > +USER_WIFIMAC_PATH ?=
> > +ifneq ($(USER_WIFIMAC_PATH),)
> > +EXTRA_CFLAGS += -DWIFIMAC_PATH=\"$(USER_WIFIMAC_PATH)\"
> > +else
> > +EXTRA_CFLAGS += -DWIFIMAC_PATH=\"/data/wifimac.txt\"
> > +endif
> > +
> > +endif
> > +
> > +ifeq ($(CONFIG_EXT_CLK), y)
> > +EXTRA_CFLAGS += -DCONFIG_EXT_CLK
> > +endif
> > +
> > +ifeq ($(CONFIG_TRAFFIC_PROTECT), y)
> > +EXTRA_CFLAGS += -DCONFIG_TRAFFIC_PROTECT
> > +endif
> > +
> > +ifeq ($(CONFIG_LOAD_PHY_PARA_FROM_FILE), y)
> > +EXTRA_CFLAGS += -DCONFIG_LOAD_PHY_PARA_FROM_FILE
> > +#EXTRA_CFLAGS += -DREALTEK_CONFIG_PATH_WITH_IC_NAME_FOLDER
> > +#EXTRA_CFLAGS += -DREALTEK_CONFIG_PATH=\"/lib/firmware/\"
> > +EXTRA_CFLAGS += -DREALTEK_CONFIG_PATH=\"\"
> > +endif
> > +
> > +ifeq ($(CONFIG_TXPWR_BY_RATE_EN), n)
> > +EXTRA_CFLAGS += -DCONFIG_TXPWR_BY_RATE_EN=0
> > +else ifeq ($(CONFIG_TXPWR_BY_RATE_EN), y)
> > +EXTRA_CFLAGS += -DCONFIG_TXPWR_BY_RATE_EN=1
> > +else ifeq ($(CONFIG_TXPWR_BY_RATE_EN), auto)
> > +EXTRA_CFLAGS += -DCONFIG_TXPWR_BY_RATE_EN=2
> > +endif
> > +
> > +ifeq ($(CONFIG_TXPWR_LIMIT_EN), n)
> > +EXTRA_CFLAGS += -DCONFIG_TXPWR_LIMIT_EN=0
> > +else ifeq ($(CONFIG_TXPWR_LIMIT_EN), y)
> > +EXTRA_CFLAGS += -DCONFIG_TXPWR_LIMIT_EN=1
> > +else ifeq ($(CONFIG_TXPWR_LIMIT_EN), auto)
> > +EXTRA_CFLAGS += -DCONFIG_TXPWR_LIMIT_EN=2
> > +endif
> > +
> > +ifeq ($(CONFIG_CALIBRATE_TX_POWER_BY_REGULATORY), y)
> > +EXTRA_CFLAGS += -DCONFIG_CALIBRATE_TX_POWER_BY_REGULATORY
> > +endif
> > +
> > +ifeq ($(CONFIG_CALIBRATE_TX_POWER_TO_MAX), y)
> > +EXTRA_CFLAGS += -DCONFIG_CALIBRATE_TX_POWER_TO_MAX
> > +endif
> > +
> > +ifeq ($(CONFIG_RTW_ADAPTIVITY_EN), disable)
> > +EXTRA_CFLAGS += -DCONFIG_RTW_ADAPTIVITY_EN=0
> > +else ifeq ($(CONFIG_RTW_ADAPTIVITY_EN), enable)
> > +EXTRA_CFLAGS += -DCONFIG_RTW_ADAPTIVITY_EN=1
> > +endif
> > +
> > +ifeq ($(CONFIG_RTW_ADAPTIVITY_MODE), normal)
> > +EXTRA_CFLAGS += -DCONFIG_RTW_ADAPTIVITY_MODE=0
> > +else ifeq ($(CONFIG_RTW_ADAPTIVITY_MODE), carrier_sense)
> > +EXTRA_CFLAGS += -DCONFIG_RTW_ADAPTIVITY_MODE=1
> > +endif
> > +
> > +ifeq ($(CONFIG_SIGNAL_SCALE_MAPPING), y)
> > +EXTRA_CFLAGS += -DCONFIG_SIGNAL_SCALE_MAPPING
> > +endif
> > +
> > +ifeq ($(CONFIG_80211W), y)
> > +EXTRA_CFLAGS += -DCONFIG_IEEE80211W
> > +endif
> > +
> > +ifeq ($(CONFIG_WOWLAN), y)
> > +EXTRA_CFLAGS += -DCONFIG_WOWLAN
> > +ifeq ($(CONFIG_DEFAULT_PATTERNS_EN), y)
> > +EXTRA_CFLAGS += -DCONFIG_DEFAULT_PATTERNS_EN
> > +endif
> > +endif
> > +
> > +ifeq ($(CONFIG_AP_WOWLAN), y)
> > +EXTRA_CFLAGS += -DCONFIG_AP_WOWLAN
> > +endif
> > +
> > +ifeq ($(CONFIG_PNO_SUPPORT), y)
> > +EXTRA_CFLAGS += -DCONFIG_PNO_SUPPORT
> > +ifeq ($(CONFIG_PNO_SET_DEBUG), y)
> > +EXTRA_CFLAGS += -DCONFIG_PNO_SET_DEBUG
> > +endif
> > +endif
> > +
> > +ifeq ($(CONFIG_GPIO_WAKEUP), y)
> > +EXTRA_CFLAGS += -DCONFIG_GPIO_WAKEUP
> > +ifeq ($(CONFIG_HIGH_ACTIVE), y)
> > +EXTRA_CFLAGS += -DHIGH_ACTIVE=1
> > +else
> > +EXTRA_CFLAGS += -DHIGH_ACTIVE=0
> > +endif
> > +endif
> > +
> > +ifneq ($(CONFIG_WAKEUP_GPIO_IDX), default)
> > +EXTRA_CFLAGS += -DWAKEUP_GPIO_IDX=$(CONFIG_WAKEUP_GPIO_IDX)
> > +endif
> > +
> > +ifeq ($(CONFIG_REDUCE_TX_CPU_LOADING), y)
> > +EXTRA_CFLAGS += -DCONFIG_REDUCE_TX_CPU_LOADING
> > +endif
> > +
> > +ifeq ($(CONFIG_BR_EXT), y)
> > +BR_NAME = br0
> > +EXTRA_CFLAGS += -DCONFIG_BR_EXT
> > +EXTRA_CFLAGS += '-DCONFIG_BR_EXT_BRNAME="'$(BR_NAME)'"'
> > +endif
> > +
> > +
> > +ifeq ($(CONFIG_TDLS), y)
> > +EXTRA_CFLAGS += -DCONFIG_TDLS
> > +endif
> > +
> > +ifeq ($(CONFIG_WIFI_MONITOR), y)
> > +EXTRA_CFLAGS += -DCONFIG_WIFI_MONITOR
> > +endif
> > +
> > +ifeq ($(CONFIG_MCC_MODE), y)
> > +EXTRA_CFLAGS += -DCONFIG_MCC_MODE
> > +endif
> > +
> > +ifeq ($(CONFIG_RTW_NAPI), y)
> > +EXTRA_CFLAGS += -DCONFIG_RTW_NAPI
> > +endif
> > +
> > +ifeq ($(CONFIG_RTW_GRO), y)
> > +EXTRA_CFLAGS += -DCONFIG_RTW_GRO
> > +endif
> > +
> > +ifeq ($(CONFIG_MP_VHT_HW_TX_MODE), y)
> > +EXTRA_CFLAGS += -DCONFIG_MP_VHT_HW_TX_MODE
> > +ifeq ($(CONFIG_PLATFORM_I386_PC), y)
> > +## For I386 X86 ToolChain use Hardware FLOATING
> > +EXTRA_CFLAGS += -mhard-float
> > +else
> > +## For ARM ToolChain use Hardware FLOATING
> > +EXTRA_CFLAGS += -mfloat-abi=hard
> > +endif
> > +endif
> > +
> > +ifeq ($(CONFIG_APPEND_VENDOR_IE_ENABLE), y)
> > +EXTRA_CFLAGS += -DCONFIG_APPEND_VENDOR_IE_ENABLE
> > +endif
> > +
> > +ifeq ($(CONFIG_RTW_DEBUG), y)
> > +EXTRA_CFLAGS += -DCONFIG_RTW_DEBUG
> > +EXTRA_CFLAGS += -DRTW_LOG_LEVEL=$(CONFIG_RTW_LOG_LEVEL)
> > +endif
> > +
> > +EXTRA_CFLAGS += -DDM_ODM_SUPPORT_TYPE=0x04
> > +
> > +EXTRA_CFLAGS += -DRTW_USE_CFG80211_STA_EVENT
> > +
> > +SUBARCH := $(shell uname -m | sed -e "s/i.86/i386/; s/ppc.*/powerpc/; s/armv.l/arm/; s/aarch64/arm64/;")
> > +ARCH ?= $(SUBARCH)
> > +CROSS_COMPILE ?=
> > +KVER  ?= $(if $(KERNELRELEASE),$(KERNELRELEASE),$(shell uname -r))
> > +KSRC := /lib/modules/$(KVER)/build
> > +MODDESTDIR := /lib/modules/$(KVER)/kernel/drivers/net/wireless/
> > +INSTALL_PREFIX :=
> > +
> > +ifeq ($(CONFIG_MULTIDRV), y)
> > +
> > +
> > +MODULE_NAME := rtw_usb
> > +
> > +endif
> > +
> > +USER_MODULE_NAME ?=
> > +ifneq ($(USER_MODULE_NAME),)
> > +MODULE_NAME := $(USER_MODULE_NAME)
> > +endif
> > +
> > +ifneq ($(KERNELRELEASE),)
> > +
> > +rtk_core :=  core/rtw_cmd.o \
> > +             core/rtw_security.o \
> > +             core/rtw_debug.o \
> > +             core/rtw_io.o \
> > +             core/rtw_ioctl_query.o \
> > +             core/rtw_ioctl_set.o \
> > +             core/rtw_ieee80211.o \
> > +             core/rtw_mlme.o \
> > +             core/rtw_mlme_ext.o \
> > +             core/rtw_mi.o \
> > +             core/rtw_wlan_util.o \
> > +             core/rtw_pwrctrl.o \
> > +             core/rtw_rf.o \
> > +             core/rtw_recv.o \
> > +             core/rtw_sta_mgt.o \
> > +             core/rtw_ap.o \
> > +             core/rtw_xmit.o \
> > +             core/rtw_p2p.o \
> > +             core/rtw_tdls.o \
> > +             core/rtw_br_ext.o \
> > +             core/rtw_iol.o \
> > +             core/rtw_sreset.o \
> > +             core/rtw_btcoex_wifionly.o \
> > +             core/rtw_btcoex.o \
> > +             core/rtw_beamforming.o \
> > +             core/rtw_odm.o \
> > +             core/rtw_efuse.o
> > +
> > +r8188eu-y += $(rtk_core)
> > +
> > +r8188eu-$(CONFIG_INTEL_WIDI) += core/rtw_intel_widi.o
> > +
> > +r8188eu-$(CONFIG_WAPI_SUPPORT) += core/rtw_wapi.o    \
> > +                                     core/rtw_wapi_sms4.o
> > +
> > +r8188eu-y += $(_OS_INTFS_FILES)
> > +r8188eu-y += $(_HAL_INTFS_FILES)
> > +r8188eu-y += $(_OUTSRC_FILES)
> > +
> > +r8188eu-$(CONFIG_MP_INCLUDED) += core/rtw_mp.o
> > +
> > +ifeq ($(CONFIG_RTL8723B), y)
> > +r8188eu-$(CONFIG_MP_INCLUDED)+= core/rtw_bt_mp.o
> > +endif
> > +
> > +obj-m := r8188eu.o
>
> The makefile should stop here, below this is for when this was a
> stand-alone repo.  Just drop them.
>
> > +
> > +else
> > +
> > +all: test modules
> > +
> > +test:
> > +     @if [ !  -e  ./.git ] ; then echo $(MSG); exit 1; fi;
> > +
> > +modules:
> > +     $(MAKE) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KSRC) M=$(CURDIR)  modules
> > +
> > +strip:
> > +     $(CROSS_COMPILE)strip r8188eu.ko --strip-unneeded
> > +
> > +install:
> > +     install -p -m 644 r8188eu.ko  $(MODDESTDIR)
> > +     /sbin/depmod -a ${KVER}
> > +
> > +uninstall:
> > +     rm -f $(MODDESTDIR)/r8188eu.ko
> > +     /sbin/depmod -a ${KVER}
> > +
> > +config_r:
> > +     @echo "make config"
> > +     /bin/bash script/Configure script/config.in
> > +
> > +
> > +.PHONY: modules clean
> > +
> > +clean:
> > +     #$(MAKE) -C $(KSRC) M=$(CURDIR) clean
> > +     cd hal ; rm -fr */*/*/*.mod.c */*/*/*.mod */*/*/*.o */*/*/.*.cmd */*/*/*.ko
> > +     cd hal ; rm -fr */*/*.mod.c */*/*.mod */*/*.o */*/.*.cmd */*/*.ko
> > +     cd hal ; rm -fr */*.mod.c */*.mod */*.o */.*.cmd */*.ko
> > +     cd hal/led ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko .*.cmd
> > +     cd core ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
> > +     cd os_dep/linux ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
> > +     cd os_dep ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
> > +     cd platform ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
> > +     rm -fr Module.symvers ; rm -fr Module.markers ; rm -fr modules.order
> > +     rm -fr *.mod.c *.mod *.o .*.cmd *.ko *~
> > +     rm -fr .tmp_versions
> > +endif
>
> thanks,
>
> greg k-h
Dear Greg,

I will make sure these changes go into the v3 revision of the patch
set when I prepare it. Many thanks.

Regards,
Phil
