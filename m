Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B40A3DC87A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 23:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhGaVyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 17:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhGaVyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 17:54:23 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B483C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 14:54:16 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 19-20020a9d08930000b02904b98d90c82cso13609420otf.5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 14:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LnzTgGd9e+j0GuCeJ4b2RcgUk17Ct+xjVNHDeB18Pd8=;
        b=RVjKIOCRSkdyXR2zu53LnDBa1SKZRxqnKzFWiUHIXi1yOwLmxUgiaHHBR5pXME/U9y
         ja9lPm37wUnrEkc05OgEJjTwVoFjnIevYTHvVZs5Rz1UuenDeCl/KnDENg19FkgT7Yni
         S3eC+x06K4R4ifmxrBuTa1qJPh0pWMgb+O2pqpd5z/M2bGWrCjMZ/oGjXe+20BjOA26Q
         L0fmmC6RzcR2z8qzRt2LvK5eJWN1TB9maXRd3DxDaAiP+LsYZqIkk8SvSLxuf2GupOvP
         kBnLuKSajDnzyHvXsGiZNl0Tb3UCj7BKmRRxLjLCNkaXu1M1N7RCzFSlHvqXJfEQ3GYg
         mkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LnzTgGd9e+j0GuCeJ4b2RcgUk17Ct+xjVNHDeB18Pd8=;
        b=ULIXrFllnzsxzjcAW+rqHq6pqqPHskOqiBmarCOYzmdY/jL61HW1jsKuWAVDQ3JuEV
         g0zsijXVrYAtcz0+e+Vj5I9fZzikfB0sUSfx/QlCcoQpAehNWvSoSfiQKf+iW37M9pbu
         yQltH9u/4fFz073DlXuhT3cQD5qQPGQfQwWnX3kk9FoxyHDMQ6mZufDaQxhJJVZi8luS
         wMNl9NZJLVgxk5pkZ410zV35T8ntEVT+JVe0t9EPkugorSulDYUDAdelNSiJ5sFTfDod
         Md0j3qkhp1KTydKjw8Nr3KHR/ODl3ZFShd3iop/6cz8rGK4dhpYuiEfr++VJqlyZxxWk
         Vm6w==
X-Gm-Message-State: AOAM530u3NCSPnP7Mb0db5Uv7HZDoxlWLtRQDNXjStAKJXkC5Ya5GX0P
        x8a5BIlvnFxJFka+RvB2bAA=
X-Google-Smtp-Source: ABdhPJywqJcq1YYIo+TERneHMaWiRbyWxH5FuJY7osDwzRgoRGY/VyFgKKVy3JtAmiizeShJB6gFtw==
X-Received: by 2002:a05:6830:411d:: with SMTP id w29mr6849786ott.118.1627768455523;
        Sat, 31 Jul 2021 14:54:15 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id be15sm1001468oib.18.2021.07.31.14.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jul 2021 14:54:14 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: kernel BUG in new r8188eu
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
References: <80042e9f-6811-38f3-010b-1c0951ba88db@lwfinger.net>
 <YQThm1A0Up1m4l1S@kroah.com>
 <c2a6746a-24e6-6888-9208-32fccebb3fec@lwfinger.net>
 <20210731185328.GA1412@agape.jhs>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <0d777868-d3b5-4f64-1bef-f7de8d7cb92d@lwfinger.net>
Date:   Sat, 31 Jul 2021 16:54:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210731185328.GA1412@agape.jhs>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/21 1:53 PM, Fabio Aiuto wrote:
> Hi all,
> 
> On Sat, Jul 31, 2021 at 11:18:10AM -0500, Larry Finger wrote:
>> On 7/31/21 12:37 AM, Greg Kroah-Hartman wrote:
>>> Is this a new regression due to the recent cleanups, or something that
>>> has always been here?
>>
>> I suspect that it has been there forever. I was just doing the kinds of
>> things a user might do, and locked up my box.
>>
>>> As for the error, looks like someone is reading to an address that is
>>> in userspace without doing the proper copy_from_user() thing.  Do you
>>> have a full traceback?
>>
>>   BUG: unable to handle page fault for address: ffffeb020003b848
>>   #PF: supervisor read access in kernel mode
>>   #PF: error_code(0x0000) - not-present page
>>   PGD 0 P4D 0
>>   Oops: 0000 [#1] SMP PTI
>>   CPU: 2 PID: 45 Comm: kworker/2:1 Tainted: G         C O
>> 5.14.0-rc2-00157-g390c661543a8 #8
>>   Hardware name: TOSHIBA TECRA A50-A/TECRA A50-A, BIOS Version 4.50   09/29/2014
>>   Workqueue: usb_hub_wq hub_event [usbcore]
>>   RIP: 0010:kfree+0x68/0x2c0
>>   Code: 01 e5 0f 82 5f 02 00 00 48 b8 00 00 00 80 7f 77 00 00 48 01 c5 48 b8
>> 00 00 00 00 00 ea ff ff 48 c1 ed 0c 48 c1 e5 06 48 01 c5 <48> 8b 45 0>
>>   RSP: 0018:ffffc900001efa78 EFLAGS: 00010282
>>   RAX: ffffea0000000000 RBX: ffffc90000ee1028 RCX: 000000008010000d
>>   RDX: 0000000000000000 RSI: ffffffffa149eddf RDI: ffffc90000ee1578
>>   RBP: ffffeb020003b840 R08: 0000000000000001 R09: 0000000000000001
>>   R10: 0000000000000000 R11: ffff888121c0e400 R12: ffffc90000ee1578
>>   R13: ffff888101fd0000 R14: ffff888101fd0030 R15: 0000000000000003
>>   FS:  0000000000000000(0000) GS:ffff888323280000(0000) knlGS:0000000000000000
>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   CR2: ffffeb020003b848 CR3: 000000000220a002 CR4: 00000000001706e0
>>   Call Trace:
>>    ? kfree+0x25a/0x2c0
>>    rtw_free_mlme_priv_ie_data+0x15/0xf8 [r8188eu]
>>    _rtw_free_mlme_priv+0xe/0x30 [r8188eu]
>>    rtw_free_mlme_priv+0x1a/0x47 [r8188eu]
>>    rtw_free_drv_sw+0x5c/0x1ae [r8188eu]
>>    rtw_usb_if1_deinit+0x67/0xcd [r8188eu]
>>    rtw_dev_remove+0x5a/0xf4 [r8188eu]
>>    usb_unbind_interface+0x8a/0x270 [usbcore]
>>    ? kernfs_find_ns+0x35/0xd0
>>    __device_release_driver+0x1a0/0x260
>>    device_release_driver+0x24/0x30
>>    bus_remove_device+0xd8/0x140
>>    device_del+0x18b/0x3e0
>>    ? kobject_cleanup+0x49/0x130
>>    usb_disable_device+0xd9/0x260 [usbcore]
>>    usb_disconnect.cold+0x7b/0x201 [usbcore]
>>    hub_port_connect+0x88/0x8d0 [usbcore]
>>    ? kfree+0xe6/0x2c0
>>    hub_port_connect_change+0xb1/0x3a0 [usbcore]
>>    port_event+0x5d4/0x720 [usbcore]
>>    hub_event+0x1db/0x430 [usbcore]
>>    process_one_work+0x1dd/0x3a0
>>    worker_thread+0x50/0x3f0
>>    ? rescuer_thread+0x390/0x390
>>    kthread+0x128/0x140
>>    ? set_kthread_struct+0x40/0x40
>>    ret_from_fork+0x22/0x30
>>   Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device ctr ccm
>> r8188eu(C) rfcomm rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs>
>>    crypto_simd cryptd i915 i2c_algo_bit serio_raw ttm drm_kms_helper
>> syscopyarea sysfillrect sysimgblt fb_sys_fops drm xhci_pci ehci_pci xhci_hcd
>>>
>>   CR2: ffffeb020003b848
>>   ---[ end trace f5f4e2b2680b5fd7 ]---
>>
>> The driver is allocating some buffers using kmalloc variants, and others
>> using vmalloc. I checked to see if there was confusion on which form of free
>> should be used, but this one is allocated with kmalloc and freed with kfree,
>> which should be OK.
>>
>> Larry
>>
> 
> Maybe hostapd is involved. Try killing hostapd before and then
> unplug the dongle... does the system freeze?
> 
> #include "../include/rtw_android.h"
> int rtw_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
> {
>          struct iwreq *wrq = (struct iwreq *)rq;
>          int ret = 0;
> 
>          switch (cmd) {
>          case RTL_IOCTL_WPA_SUPPLICANT:
>                  ret = wpa_supplicant_ioctl(dev, &wrq->u.data);
>                  break;
> #ifdef CONFIG_88EU_AP_MODE
>          case RTL_IOCTL_HOSTAPD:
>                  ret = rtw_hostapd_ioctl(dev, &wrq->u.data);
>          	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> I think that someone tries to write the wrong fields while
> freeing memory...
> 
> 	break;
> #endif /*  CONFIG_88EU_AP_MODE */
>          case SIOCDEVPRIVATE:
> 
> static int rtw_hostapd_ioctl(struct net_device *dev, struct iw_point *p)
> {
>          struct ieee_param *param;
>          int ret = 0;
>          struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
> 
> ...
> 
>          switch (param->cmd) {
>          case RTL871X_HOSTAPD_FLUSH:
>                  ret = rtw_hostapd_sta_flush(dev);
>                  break;
> ...
>          case RTL871X_HOSTAPD_SET_WPS_BEACON:
>                  ret = rtw_set_wps_beacon(dev, param, p->length);
>                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 		break;
> 
> static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param, int len)
> {
>          int ret = 0;
>         
> ...
> 
>                  memcpy(pmlmepriv->wps_beacon_ie, param->u.bcn_ie.buf, ie_len);
> 		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 		maybe hotsapd does some ioctl at the wrong moment.
> 
> Just to verify, we could kill hostapd, if ever runs in your machine...

No, hostapd was not involved. I was using r8188eu in STA mode.

Larry

