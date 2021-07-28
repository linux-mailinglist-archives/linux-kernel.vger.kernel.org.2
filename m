Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABD53D9516
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhG1SPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:15:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhG1SO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:14:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE49060462;
        Wed, 28 Jul 2021 18:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627496096;
        bh=8EUKfV8kS3O311sXlNjcPWiu4Dc+lo6jGIAKFYYnWdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FauvfWOu/fdFkhiWL7/WkqgcNSzjkeHkbrMrWb9o9Ud0UtKxdGiwf7SRBE+9UGXby
         RGFESAX4fCBGnqHtLjkDLizp6Nm/hVJyRvAaAVOBXiZbCxFf4jFjCoxVpDcbVvttA6
         5izrm2TehjPJdys+1yzi4FqZFzwy8KcWv3Or8p2U=
Date:   Wed, 28 Jul 2021 20:14:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        fabioaiuto83@gmail.com, martin@kaiser.cx
Subject: Re: [PATCH v4 0/6] staging: r8188eu: add newer/better RTL8188eu
 driver
Message-ID: <YQGenmf2m3Tu7FFg@kroah.com>
References: <20210727232219.2948-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727232219.2948-1-phil@philpotter.co.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 12:22:13AM +0100, Phillip Potter wrote:
> I had to break this patchset up a bit to get around the file size limits
> on the mailing list, and also I removed the hostapd stuff which is
> userspace related and therefore not required.
> 
> The driver currently in staging is older and less functional than the
> version on Larry Finger's GitHub account, based upon v4.1.4_6773.20130222.
> This series of patches therefore:
> 
> (1) Marks the older driver as deprecated and changes its CONFIG_
>     parameter and module name.
> (2) Imports the GitHub version mentioned above into the r8188eu folder
>     and configures the build system to allow the building of both drivers.
> 
> There is plenty of work to do to this driver, including to its Makefile,
> but it is at least buildable/usable for now (albeit with a few build
> warnings).
> 
> Revisions of this patch set:
> V1: contained deletion of old driver as one patch and the whole new
>     driver as another, so was too big for the mailing lists.
> V2: split things up, but contained whitespace errorsm and various other
>     mistakes.
> V3: now based upon v4.1.4_6773.20130222 of the GitHub driver, with
>     tweaks to the Makefile (which is already cleaner but needed additional
>     tweaks) and the Kconfig to take into account feedback. There were
>     several trailing whitespace warnings even in this branch/version which
>     have now been corrected as well.
> V4: don't remove old driver now, just mark as deprecated and modify to
>     allow building alongside the new driver.
> 
> Phillip Potter (6):
>   staging: r8188eu: introduce new core dir for RTL8188eu driver
>   staging: r8188eu: introduce new hal dir for RTL8188eu driver
>   staging: r8188eu: introduce new os_dep dir for RTL8188eu driver
>   staging: r8188eu: introduce new include dir for RTL8188eu driver
>   staging: r8188eu: introduce new supporting files for RTL8188eu driver
>   staging: r8188eu: attach newly imported driver to build system
> 
>  drivers/staging/Kconfig                       |    2 +
>  drivers/staging/Makefile                      |    3 +-
>  drivers/staging/r8188eu/Kconfig               |   25 +
>  drivers/staging/r8188eu/Makefile              |  129 +
>  drivers/staging/r8188eu/core/rtw_ap.c         | 1976 ++++
>  drivers/staging/r8188eu/core/rtw_br_ext.c     | 1184 +++
>  drivers/staging/r8188eu/core/rtw_cmd.c        | 2206 +++++
>  drivers/staging/r8188eu/core/rtw_debug.c      |  943 ++
>  drivers/staging/r8188eu/core/rtw_efuse.c      |  872 ++
>  drivers/staging/r8188eu/core/rtw_ieee80211.c  | 1625 ++++
>  drivers/staging/r8188eu/core/rtw_io.c         |  323 +
>  drivers/staging/r8188eu/core/rtw_ioctl_set.c  | 1118 +++
>  drivers/staging/r8188eu/core/rtw_iol.c        |  209 +
>  drivers/staging/r8188eu/core/rtw_led.c        | 1705 ++++
>  drivers/staging/r8188eu/core/rtw_mlme.c       | 2354 +++++
>  drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 8407 +++++++++++++++++
>  drivers/staging/r8188eu/core/rtw_mp.c         | 1000 ++
>  drivers/staging/r8188eu/core/rtw_mp_ioctl.c   | 1352 +++
>  drivers/staging/r8188eu/core/rtw_p2p.c        | 2068 ++++
>  drivers/staging/r8188eu/core/rtw_pwrctrl.c    |  655 ++
>  drivers/staging/r8188eu/core/rtw_recv.c       | 2252 +++++
>  drivers/staging/r8188eu/core/rtw_rf.c         |   88 +
>  drivers/staging/r8188eu/core/rtw_security.c   | 1757 ++++
>  drivers/staging/r8188eu/core/rtw_sreset.c     |   79 +
>  drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  609 ++
>  drivers/staging/r8188eu/core/rtw_wlan_util.c  | 1690 ++++
>  drivers/staging/r8188eu/core/rtw_xmit.c       | 2370 +++++
>  drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c  |   86 +
>  .../r8188eu/hal/Hal8188ERateAdaptive.c        |  760 ++
>  .../staging/r8188eu/hal/HalHWImg8188E_BB.c    |  720 ++
>  .../staging/r8188eu/hal/HalHWImg8188E_MAC.c   |  230 +
>  .../staging/r8188eu/hal/HalHWImg8188E_RF.c    |  268 +
>  drivers/staging/r8188eu/hal/HalPhyRf.c        |   49 +
>  drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 1505 +++
>  drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |  132 +
>  drivers/staging/r8188eu/hal/hal_com.c         |  381 +
>  drivers/staging/r8188eu/hal/hal_intf.c        |  468 +
>  drivers/staging/r8188eu/hal/odm.c             | 2174 +++++
>  drivers/staging/r8188eu/hal/odm_HWConfig.c    |  601 ++
>  drivers/staging/r8188eu/hal/odm_RTL8188E.c    |  400 +
>  .../staging/r8188eu/hal/odm_RegConfig8188E.c  |  130 +
>  drivers/staging/r8188eu/hal/odm_debug.c       |   32 +
>  drivers/staging/r8188eu/hal/odm_interface.c   |  205 +
>  drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  762 ++
>  drivers/staging/r8188eu/hal/rtl8188e_dm.c     |  267 +
>  .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 2390 +++++
>  drivers/staging/r8188eu/hal/rtl8188e_mp.c     |  851 ++
>  drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 1135 +++
>  drivers/staging/r8188eu/hal/rtl8188e_rf6052.c |  569 ++
>  drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |  202 +
>  drivers/staging/r8188eu/hal/rtl8188e_sreset.c |   80 +
>  drivers/staging/r8188eu/hal/rtl8188e_xmit.c   |   91 +
>  drivers/staging/r8188eu/hal/rtl8188eu_led.c   |  111 +
>  drivers/staging/r8188eu/hal/rtl8188eu_recv.c  |  136 +
>  drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  703 ++
>  drivers/staging/r8188eu/hal/usb_halinit.c     | 2334 +++++
>  drivers/staging/r8188eu/hal/usb_ops_linux.c   |  717 ++
>  .../staging/r8188eu/include/Hal8188EPhyCfg.h  |  269 +
>  .../staging/r8188eu/include/Hal8188EPhyReg.h  | 1088 +++
>  .../staging/r8188eu/include/Hal8188EPwrSeq.h  |  173 +
>  .../r8188eu/include/Hal8188ERateAdaptive.h    |   75 +
>  drivers/staging/r8188eu/include/Hal8188EReg.h |   44 +
>  .../r8188eu/include/HalHWImg8188E_BB.h        |   44 +
>  .../r8188eu/include/HalHWImg8188E_FW.h        |   33 +
>  .../r8188eu/include/HalHWImg8188E_MAC.h       |   30 +
>  .../r8188eu/include/HalHWImg8188E_RF.h        |   30 +
>  drivers/staging/r8188eu/include/HalPhyRf.h    |   30 +
>  .../staging/r8188eu/include/HalPhyRf_8188e.h  |   58 +
>  .../staging/r8188eu/include/HalPwrSeqCmd.h    |  126 +
>  drivers/staging/r8188eu/include/HalVerDef.h   |  166 +
>  drivers/staging/r8188eu/include/autoconf.h    |   43 +
>  drivers/staging/r8188eu/include/basic_types.h |  184 +
>  drivers/staging/r8188eu/include/cmd_osdep.h   |   32 +
>  drivers/staging/r8188eu/include/drv_types.h   |  346 +
>  .../staging/r8188eu/include/drv_types_linux.h |   23 +
>  drivers/staging/r8188eu/include/ethernet.h    |   41 +
>  drivers/staging/r8188eu/include/h2clbk.h      |   32 +
>  drivers/staging/r8188eu/include/hal_com.h     |  172 +
>  drivers/staging/r8188eu/include/hal_intf.h    |  430 +
>  drivers/staging/r8188eu/include/ieee80211.h   | 1261 +++
>  .../staging/r8188eu/include/ieee80211_ext.h   |  287 +
>  drivers/staging/r8188eu/include/if_ether.h    |  111 +
>  .../staging/r8188eu/include/ioctl_cfg80211.h  |  107 +
>  drivers/staging/r8188eu/include/ip.h          |  125 +
>  drivers/staging/r8188eu/include/mlme_osdep.h  |   35 +
>  .../staging/r8188eu/include/mp_custom_oid.h   |  349 +
>  drivers/staging/r8188eu/include/nic_spec.h    |   41 +
>  drivers/staging/r8188eu/include/odm.h         | 1182 +++
>  .../staging/r8188eu/include/odm_HWConfig.h    |  133 +
>  .../staging/r8188eu/include/odm_RTL8188E.h    |   56 +
>  .../r8188eu/include/odm_RegConfig8188E.h      |   43 +
>  .../r8188eu/include/odm_RegDefine11AC.h       |   46 +
>  .../r8188eu/include/odm_RegDefine11N.h        |  160 +
>  drivers/staging/r8188eu/include/odm_debug.h   |  143 +
>  .../staging/r8188eu/include/odm_interface.h   |  164 +
>  drivers/staging/r8188eu/include/odm_precomp.h |  103 +
>  drivers/staging/r8188eu/include/odm_reg.h     |  116 +
>  drivers/staging/r8188eu/include/odm_types.h   |   61 +
>  drivers/staging/r8188eu/include/osdep_intf.h  |   83 +
>  .../staging/r8188eu/include/osdep_service.h   |  489 +
>  drivers/staging/r8188eu/include/recv_osdep.h  |   54 +
>  .../staging/r8188eu/include/rtl8188e_cmd.h    |  122 +
>  drivers/staging/r8188eu/include/rtl8188e_dm.h |   62 +
>  .../staging/r8188eu/include/rtl8188e_hal.h    |  471 +
>  .../staging/r8188eu/include/rtl8188e_led.h    |   34 +
>  .../staging/r8188eu/include/rtl8188e_recv.h   |   69 +
>  drivers/staging/r8188eu/include/rtl8188e_rf.h |   35 +
>  .../staging/r8188eu/include/rtl8188e_spec.h   | 1438 +++
>  .../staging/r8188eu/include/rtl8188e_sreset.h |   31 +
>  .../staging/r8188eu/include/rtl8188e_xmit.h   |  177 +
>  drivers/staging/r8188eu/include/rtw_android.h |   64 +
>  drivers/staging/r8188eu/include/rtw_ap.h      |   67 +
>  drivers/staging/r8188eu/include/rtw_br_ext.h  |   66 +
>  drivers/staging/r8188eu/include/rtw_cmd.h     |  991 ++
>  drivers/staging/r8188eu/include/rtw_debug.h   |  274 +
>  drivers/staging/r8188eu/include/rtw_eeprom.h  |  130 +
>  drivers/staging/r8188eu/include/rtw_efuse.h   |  150 +
>  drivers/staging/r8188eu/include/rtw_event.h   |  113 +
>  drivers/staging/r8188eu/include/rtw_ht.h      |   44 +
>  drivers/staging/r8188eu/include/rtw_io.h      |  387 +
>  drivers/staging/r8188eu/include/rtw_ioctl.h   |  120 +
>  .../staging/r8188eu/include/rtw_ioctl_rtl.h   |   79 +
>  .../staging/r8188eu/include/rtw_ioctl_set.h   |   49 +
>  drivers/staging/r8188eu/include/rtw_iol.h     |   84 +
>  drivers/staging/r8188eu/include/rtw_led.h     |  201 +
>  drivers/staging/r8188eu/include/rtw_mlme.h    |  649 ++
>  .../staging/r8188eu/include/rtw_mlme_ext.h    |  874 ++
>  drivers/staging/r8188eu/include/rtw_mp.h      |  492 +
>  .../staging/r8188eu/include/rtw_mp_ioctl.h    |  339 +
>  .../r8188eu/include/rtw_mp_phy_regdef.h       | 1079 +++
>  drivers/staging/r8188eu/include/rtw_p2p.h     |  135 +
>  drivers/staging/r8188eu/include/rtw_pwrctrl.h |  282 +
>  drivers/staging/r8188eu/include/rtw_qos.h     |   30 +
>  drivers/staging/r8188eu/include/rtw_recv.h    |  473 +
>  drivers/staging/r8188eu/include/rtw_rf.h      |  145 +
>  .../staging/r8188eu/include/rtw_security.h    |  382 +
>  drivers/staging/r8188eu/include/rtw_sreset.h  |   50 +
>  drivers/staging/r8188eu/include/rtw_version.h |    1 +
>  drivers/staging/r8188eu/include/rtw_xmit.h    |  383 +
>  drivers/staging/r8188eu/include/sta_info.h    |  384 +
>  drivers/staging/r8188eu/include/usb_hal.h     |   26 +
>  drivers/staging/r8188eu/include/usb_ops.h     |  115 +
>  .../staging/r8188eu/include/usb_ops_linux.h   |   55 +
>  drivers/staging/r8188eu/include/usb_osintf.h  |   45 +
>  .../staging/r8188eu/include/usb_vendor_req.h  |   51 +
>  drivers/staging/r8188eu/include/wifi.h        | 1105 +++
>  drivers/staging/r8188eu/include/wlan_bssdef.h |  343 +
>  drivers/staging/r8188eu/include/xmit_osdep.h  |   67 +
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 8178 ++++++++++++++++
>  drivers/staging/r8188eu/os_dep/mlme_linux.c   |  302 +
>  drivers/staging/r8188eu/os_dep/os_intfs.c     | 1283 +++
>  .../staging/r8188eu/os_dep/osdep_service.c    |  535 ++
>  drivers/staging/r8188eu/os_dep/recv_linux.c   |  270 +
>  drivers/staging/r8188eu/os_dep/rtw_android.c  |  303 +
>  drivers/staging/r8188eu/os_dep/usb_intf.c     |  863 ++
>  .../staging/r8188eu/os_dep/usb_ops_linux.c    |  283 +
>  drivers/staging/r8188eu/os_dep/xmit_linux.c   |  282 +
>  drivers/staging/rtl8188eu/Kconfig             |    9 +-
>  drivers/staging/rtl8188eu/Makefile            |    4 +-
>  159 files changed, 89176 insertions(+), 7 deletions(-)

Hm, I thought this would be in better shape than it is.

Right now we have 107 .c and .h files in drivers/staging/rtl8188eu/ that
come to a total of 44597 lines.

So we are taking double the size here?

I'm all for putting a "better" driver in here, but this feels odd to
me...  Is there major new functionality here that is not in the existing
driver to justify this?

Ok, let's see how this goes, I'll give it a few weeks to see how much
can easily be fixed up to hopefully get back to at least close the
existing driver size...

thanks,

greg k-h
