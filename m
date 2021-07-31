Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C553DC7C9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 20:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhGaSxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 14:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhGaSxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 14:53:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3791C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 11:53:33 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cf5so6870783edb.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 11:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4JV2FNGIzMOGa8obtGDCciCpFhJ3+9ZCSukHWUja/38=;
        b=leF3Id7qgtL9CMVZmbJDK1L03uDolGYkt1lsYKkGssC8nX9G5MF8okg2gudp46B3h5
         NAnLTRbvYlV+TGQ1NFWjz6SBwVKhdx0ih0qYy8044GV0bZ+ABhPSnlNJ5K530JEbHRhD
         N863VPcDj5+Cy2AJPtvoSAWOy5pqKH0IR1H/37wzrpmTGQW/ZwiqinQRjLTZpqJAZD+D
         f5pDLtfHKXKG1RxUC5pNJ3MvdeU86ZRoMSX8amY41k43X9y7jtlSj3Oa9fE7+RbzkHuV
         BBzHisVRqFMCPvcJ69qKS+ws80Tshy7XCU9pFTFji9iSZg+hl9mNhDRsiQZKyedog7zC
         dCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4JV2FNGIzMOGa8obtGDCciCpFhJ3+9ZCSukHWUja/38=;
        b=lkuN6n9VTYMCYZFNzt9Fpch5Qja1bvSjIjWum85vmkG1WlLoS1qsGIE78Vcbzst83D
         xNzjEv5t4lBumHPV+covSoeA6Plk3jTgzynVZ8mQMP/ApXUChjcBUacxeDfC5TLwSQVE
         0/w0lgD3wRx8vw7zPvbAE/1d7WuH2gihVpBslO1FfPlqC9k5BMOAiaKDU2K+PMKTmFaJ
         uo1kkgwVdFe23891HLqRFgi5vssHbrDPHK3W5pL0nIElbC2wwpZ/mYCEGJgKLtIgpHPh
         dxj5kifM1K9V03Jvrg40w5aZvN7J6+FzbMFQ25QMMNwu3GBko1jM+5HPDY6UoyMK7qDA
         H+SQ==
X-Gm-Message-State: AOAM531KrKuqBAHuaNY9iBdp+s0335+D3SA8papasE5nx0+TbeqyeHhR
        DhiMKtfgbg3nbhdQdGINg8I=
X-Google-Smtp-Source: ABdhPJwy4wH4RZNKr8G0/S/fFEtOBr3P0VpiaiMy/BisFIhs33lig45msCsFownIRjfo/q53a6HVHg==
X-Received: by 2002:aa7:c541:: with SMTP id s1mr10509698edr.327.1627757612328;
        Sat, 31 Jul 2021 11:53:32 -0700 (PDT)
Received: from agape.jhs ([5.171.81.1])
        by smtp.gmail.com with ESMTPSA id oz27sm2032667ejb.90.2021.07.31.11.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 11:53:32 -0700 (PDT)
Date:   Sat, 31 Jul 2021 20:53:29 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
Subject: Re: kernel BUG in new r8188eu
Message-ID: <20210731185328.GA1412@agape.jhs>
References: <80042e9f-6811-38f3-010b-1c0951ba88db@lwfinger.net>
 <YQThm1A0Up1m4l1S@kroah.com>
 <c2a6746a-24e6-6888-9208-32fccebb3fec@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2a6746a-24e6-6888-9208-32fccebb3fec@lwfinger.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Sat, Jul 31, 2021 at 11:18:10AM -0500, Larry Finger wrote:
> On 7/31/21 12:37 AM, Greg Kroah-Hartman wrote:
> > Is this a new regression due to the recent cleanups, or something that
> > has always been here?
> 
> I suspect that it has been there forever. I was just doing the kinds of
> things a user might do, and locked up my box.
> 
> > As for the error, looks like someone is reading to an address that is
> > in userspace without doing the proper copy_from_user() thing.  Do you
> > have a full traceback?
> 
>  BUG: unable to handle page fault for address: ffffeb020003b848
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: 0000 [#1] SMP PTI
>  CPU: 2 PID: 45 Comm: kworker/2:1 Tainted: G         C O
> 5.14.0-rc2-00157-g390c661543a8 #8
>  Hardware name: TOSHIBA TECRA A50-A/TECRA A50-A, BIOS Version 4.50   09/29/2014
>  Workqueue: usb_hub_wq hub_event [usbcore]
>  RIP: 0010:kfree+0x68/0x2c0
>  Code: 01 e5 0f 82 5f 02 00 00 48 b8 00 00 00 80 7f 77 00 00 48 01 c5 48 b8
> 00 00 00 00 00 ea ff ff 48 c1 ed 0c 48 c1 e5 06 48 01 c5 <48> 8b 45 0>
>  RSP: 0018:ffffc900001efa78 EFLAGS: 00010282
>  RAX: ffffea0000000000 RBX: ffffc90000ee1028 RCX: 000000008010000d
>  RDX: 0000000000000000 RSI: ffffffffa149eddf RDI: ffffc90000ee1578
>  RBP: ffffeb020003b840 R08: 0000000000000001 R09: 0000000000000001
>  R10: 0000000000000000 R11: ffff888121c0e400 R12: ffffc90000ee1578
>  R13: ffff888101fd0000 R14: ffff888101fd0030 R15: 0000000000000003
>  FS:  0000000000000000(0000) GS:ffff888323280000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: ffffeb020003b848 CR3: 000000000220a002 CR4: 00000000001706e0
>  Call Trace:
>   ? kfree+0x25a/0x2c0
>   rtw_free_mlme_priv_ie_data+0x15/0xf8 [r8188eu]
>   _rtw_free_mlme_priv+0xe/0x30 [r8188eu]
>   rtw_free_mlme_priv+0x1a/0x47 [r8188eu]
>   rtw_free_drv_sw+0x5c/0x1ae [r8188eu]
>   rtw_usb_if1_deinit+0x67/0xcd [r8188eu]
>   rtw_dev_remove+0x5a/0xf4 [r8188eu]
>   usb_unbind_interface+0x8a/0x270 [usbcore]
>   ? kernfs_find_ns+0x35/0xd0
>   __device_release_driver+0x1a0/0x260
>   device_release_driver+0x24/0x30
>   bus_remove_device+0xd8/0x140
>   device_del+0x18b/0x3e0
>   ? kobject_cleanup+0x49/0x130
>   usb_disable_device+0xd9/0x260 [usbcore]
>   usb_disconnect.cold+0x7b/0x201 [usbcore]
>   hub_port_connect+0x88/0x8d0 [usbcore]
>   ? kfree+0xe6/0x2c0
>   hub_port_connect_change+0xb1/0x3a0 [usbcore]
>   port_event+0x5d4/0x720 [usbcore]
>   hub_event+0x1db/0x430 [usbcore]
>   process_one_work+0x1dd/0x3a0
>   worker_thread+0x50/0x3f0
>   ? rescuer_thread+0x390/0x390
>   kthread+0x128/0x140
>   ? set_kthread_struct+0x40/0x40
>   ret_from_fork+0x22/0x30
>  Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device ctr ccm
> r8188eu(C) rfcomm rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs>
>   crypto_simd cryptd i915 i2c_algo_bit serio_raw ttm drm_kms_helper
> syscopyarea sysfillrect sysimgblt fb_sys_fops drm xhci_pci ehci_pci xhci_hcd
> >
>  CR2: ffffeb020003b848
>  ---[ end trace f5f4e2b2680b5fd7 ]---
> 
> The driver is allocating some buffers using kmalloc variants, and others
> using vmalloc. I checked to see if there was confusion on which form of free
> should be used, but this one is allocated with kmalloc and freed with kfree,
> which should be OK.
> 
> Larry
> 

Maybe hostapd is involved. Try killing hostapd before and then
unplug the dongle... does the system freeze?

#include "../include/rtw_android.h"
int rtw_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
{
        struct iwreq *wrq = (struct iwreq *)rq;
        int ret = 0;

        switch (cmd) {
        case RTL_IOCTL_WPA_SUPPLICANT:
                ret = wpa_supplicant_ioctl(dev, &wrq->u.data);
                break;
#ifdef CONFIG_88EU_AP_MODE
        case RTL_IOCTL_HOSTAPD:
                ret = rtw_hostapd_ioctl(dev, &wrq->u.data);
        	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I think that someone tries to write the wrong fields while
freeing memory...        

	break;
#endif /*  CONFIG_88EU_AP_MODE */
        case SIOCDEVPRIVATE:

static int rtw_hostapd_ioctl(struct net_device *dev, struct iw_point *p)
{
        struct ieee_param *param;
        int ret = 0;
        struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);

...

        switch (param->cmd) {
        case RTL871X_HOSTAPD_FLUSH:
                ret = rtw_hostapd_sta_flush(dev);
                break;
...
        case RTL871X_HOSTAPD_SET_WPS_BEACON:
                ret = rtw_set_wps_beacon(dev, param, p->length);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		break;

static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param, int len)
{
        int ret = 0;
       
...

                memcpy(pmlmepriv->wps_beacon_ie, param->u.bcn_ie.buf, ie_len);
		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		maybe hotsapd does some ioctl at the wrong moment. 

Just to verify, we could kill hostapd, if ever runs in your machine...

thank you,

fabio
