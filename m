Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C862E3903FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhEYOei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbhEYOed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:34:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AFFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 07:33:02 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f18so17514249ejq.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 07:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X0/cri9kjWtPtMkKuW0701bqM8cHh3fnkpYQwW7XeeQ=;
        b=tRONr3fm/d4IqX7ifGNSHvBE4nnraRl8uA0xu4NExPcx+tZ3Bwo+9quMFMYhLmx7KO
         RTmYk+Wdmyv+ieWzsSJo5KUhTlks8nmtaelbIPHtIGTnoVWwD0tOC70XjI1qHraMUJod
         g6njP92BeNFDCxj2GSVDtZwlo5myFOqFLt51xluVw0SS3sOj5cs0zX4qIqmfjX1OkKni
         cmhPEI0Q3rGWxC1czroohpPThI+NE+PVOgnDSYfMA82OQ4n6I98nQT6oU8h295BvD5cf
         kzbWSXrh9nO0H4f/vQnxX+CucODjUwZ37zqjcCFyfiUEW4OYyFWbelrLud56ZYCyka0N
         p7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0/cri9kjWtPtMkKuW0701bqM8cHh3fnkpYQwW7XeeQ=;
        b=l4w+iEkB7QQsPRmhYZFrKZwHvwdKwMOt6LgmEjyzXt4uVunpoiU+5y6Yp5/2wJN12s
         HCZZCoajNhOeglGEoq+pFPQHKcIjy/Qqd8WW7JgzOFsRR4GO3bv+oJy/n+ha9BuzUuSn
         tLqIcCtb0nEsrJL/tG7B5c7yvQixjPjVfc4uR6JQg2b5Mq8Mv/Puu7qxIZ5QiW7kxXLh
         4RdoJ38/PSayCe7JXS3SPX2KraOtqtTqjCHxwKe8NYJJybaJ9plcoQmefsakmOKUFVxm
         v/HB48HOQS1NsJIdpYZoYiA8VJTf+2xgAV5OaBEHVBdhlRd2AOCVpvqL2HjrLXbT8KNT
         8JMw==
X-Gm-Message-State: AOAM533slXY4P9OcZ4XJWytWidy4ocX13EKD310nNKFE3AbFM1lh4aCB
        +in8IBTctPW4TUAtNOpR2k1GvUt8B9h5WbrRwOk=
X-Google-Smtp-Source: ABdhPJy7LxDZg2wlX73IZHt5fMcFdzrfG8Ozxoec45HmDihLpME0IylAFd30b3JSTcrRwJpUkyE9QRHw79UfGebCpgA=
X-Received: by 2002:a17:906:594f:: with SMTP id g15mr28688362ejr.103.1621953180913;
 Tue, 25 May 2021 07:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210524114904.873174-1-mudongliangabcd@gmail.com> <20210525110351.GF24442@kadam>
In-Reply-To: <20210525110351.GF24442@kadam>
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date:   Tue, 25 May 2021 22:32:34 +0800
Message-ID: <CAD-N9QU6JXi=W64M-LbfCiiaVTWgbDLd2+U8jkhsUBkuuNbmLA@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8712: Fix memory leak in r8712_init_recv_priv
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        Greg KH <gregkh@linuxfoundation.org>, rkovhaev@gmail.com,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 7:04 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> This is a syzbot warning, right?  If so, it needs a Reported-by tag.

Yes, https://syzkaller.appspot.com/bug?id=3a325b8389fc41c1bc94de0f4ac437ed13cce584

>
> I don't really understand why rtl871x_load_fw_cb() calls:

I am also confused about the invocation of rtl871x_load_fw_cb. In my
local reproduction, if the firmware (rtlwifi/rtl8712u.bin) is missing,
the memory leak occurs, otherwise, no memory leak is reported.
However, my testing in the syzbot dashboard shows there is no
invocation of rtl871x_load_fw_cb. If that's the fact, then I don't
quite understand how this memory leak occurred.

I doubt the bug I reproduced in the local environment may be not the
bug in the syzbot dashboard. So I did not add Reported-by tag

>
>         usb_put_dev(udev);
>         usb_set_intfdata(usb_intf, NULL);
>
> That just seems like a layering violation and it keeps causing bugs and
> I think everything would be simpler if we deleted that.  That way we
> could remove both checks for if pnetdev is NULL.
>

The following description of patches is **really** friendly for
newbies like me, especially for rules for allocation and deallocation.
I will keep them in mind when developing patches in the future.

Thanks very much. I really appreciate it,

> [PATCH 10/x] staging: rtl8712: delete bogus clean up code in firmware callback
>
>     This clean up is supposed to be done in r871xu_dev_remove().
>     Setting the usb USB interface leads to leaks which syzbot detects.
>         <stack trace>
>     Reported-by: Sysbot blah blah
>
> Patch 10 because their are some other easier patches which could be
> done first.  Always do the easiest patch first in case a patch set needs
> to be changed, it's easier to change the latter patches.
>
> Your patch fixes one sysbot warning but then syzbot will complain about
> something else because there are a bunch of other things which need to
> be freed as well.  Of course, it's complicated to know which things need
> to be freed and which not because the code is really bad.  It's better
> to just re-write the cleanup code and fix everything at once.
>
> I always encourage everyone to follow the "free the most recently
> allocated resource" system of error handling.  This is the only
> *systematic* way I know to do error handling.  Everything else is
> ad-hoc, impossible to review and has proven bug prone in real life.
>
> The rules are:
> 1) Every function cleans up it's own allocations.  Never partially
>    allocate things.  Never leave the caller to clean up your resources.
> 2) Keep track in your head of the most recently allocated resource.
>    Keeping track of just one thing is a lot easier than keeping track of
>    everything.
> 3) Use good label names which say what the labels free.
>
> err_free_netdev:
>         free_netdev(netdev);
>
> 4) Every allocator function has a mirror free function.
>
> How it works in real life is like this:
>
> int my_probe(...)
> {
>         a = alloc();
>         if (!a)
>                 return -ENOMEM;
>
>         b = alloc();
>         if (!b) {
>                 ret = -ENOMEM;
>                 goto free_a;  // <-- a is most recent allocation
>         }
>
>         c = alloc();
>         if (!c) {
>                 ret = -ENOMEM;
>                 goto free_b;
>         }
>
>         return 0;
>
> free_b:
>         free(b);
> free_a:
>         free(a);
>
>         return ret;
> }
>
> Then the mirror function basically writes its self.  You just have to
> cut and paste the clean up code and add a kfree(c) to the start.
>
> void my_release(...)
> {
>         free(c);
>         free(b);
>         free(a);
> }
>
> Once we move all the frees to the correct place and in the right order
> then it becomes simpler.
>
> drivers/staging/rtl8712/usb_intf.c
>    345  static int r871xu_drv_init(struct usb_interface *pusb_intf,
>    346                             const struct usb_device_id *pdid)
>    347  {
>    348          uint status;
>
> Keep status for status = padapter->dvobj_init() but everything else
> should be int ret.  Eventually "status" will be deleted.
>
>    349          struct _adapter *padapter = NULL;
>    350          struct dvobj_priv *pdvobjpriv;
>    351          struct net_device *pnetdev;
>    352          struct usb_device *udev;
>    353
>    354          /* In this probe function, O.S. will provide the usb interface pointer
>    355           * to driver. We have to increase the reference count of the usb device
>    356           * structure by using the usb_get_dev function.
>    357           */
>    358          udev = interface_to_usbdev(pusb_intf);
>    359          usb_get_dev(udev);
>                 ^^^^^^^^^^^^^^^^^
> First resource allocation/thing to be freed.  Is this really required?
> I'm not sure.  Anyway, it's harmless.
>
>    360          pintf = pusb_intf;
>    361          /* step 1. */
>
> Delete all these step 1,2,3...  comments.  The authors were trying to
> keep track of what they had allocated but unfortunately writing it down
> did not help them.
>
>    362          pnetdev = r8712_init_netdev();
>    363          if (!pnetdev)
>    364                  goto error;
>
>         if (!pnetdev) {
>                 ret = -ENOMEM;
>                 goto put_dev;
>         }
>
> r8712_init_netdev() needs a free function.  Right now the free_netdev()
> is hidden in r8712_free_drv_sw() which is the wrong place.
>
> void r8712_free_netdev(struct net_device *dev)
> {
>         free_netdev(dev);
> }
>
> "pnetdev" is now our current resource.
>
> [PATCH 6/x] staging: rtl8712: create r8712_free_netdev() function
>
>     This is a release function for r8712_init_netdev().  I changed
>     the free_netdev() in r871xu_drv_init() to use this and I moved
>     the free_netdev() out of r8712_free_drv_sw() and into the
>     r871xu_dev_remove() function where it belongs.
>
>    365          padapter = netdev_priv(pnetdev);
>    366          disable_ht_for_spec_devid(pdid, padapter);
>    367          pdvobjpriv = &padapter->dvobjpriv;
>    368          pdvobjpriv->padapter = padapter;
>    369          padapter->dvobjpriv.pusbdev = udev;
>    370          padapter->pusb_intf = pusb_intf;
>    371          usb_set_intfdata(pusb_intf, pnetdev);
>    372          SET_NETDEV_DEV(pnetdev, &pusb_intf->dev);
>    373          pnetdev->dev.type = &wlan_type;
>    374          /* step 2. */
>    375          padapter->dvobj_init = r8712_usb_dvobj_init;
>    376          padapter->dvobj_deinit = r8712_usb_dvobj_deinit;
>    377          padapter->halpriv.hal_bus_init = r8712_usb_hal_bus_init;
>    378          padapter->dvobjpriv.inirp_init = r8712_usb_inirp_init;
>    379          padapter->dvobjpriv.inirp_deinit = r8712_usb_inirp_deinit;
>
> These function pointers are garbage.  We should try to move this code
> to calling the functions directly and delete the pointers from the
> struct.
>
>    380          /* step 3.
>    381           * initialize the dvobj_priv
>    382           */
>    383          if (!padapter->dvobj_init) {
>    384                  goto error;
>
>
> We set ->dvobj_init on line 375 so it can't be NULL.  Delete this.
>
> [PATCH 1/x] staging: rtl8712: delete impossible NULL check
>
>    385          } else {
>    386                  status = padapter->dvobj_init(padapter);
>    387                  if (status != _SUCCESS)
>    388                          goto error;
>
> Since we know that ->dvobj_init is r8712_usb_dvobj_init() then lets call
> that directly.
>
>         status = r8712_usb_dvobj_init(padapter);
>         if (status != _SUCCESS) {
>                 ret = -ENOMEM;
>                 goto free_netdev;
>         }
>
> [PATCH 2/x] staging: rtl8712: Get rid of ->dvobj_init/deinit function pointers
>
>     The "padapter->dvobj_init/->dvobj_deinit" pointers are not required.
>     We can call the functions directly.
>
> This usb_dvobj (dumb name) is now our current resource.  Unfortunately
> the r8712_usb_dvobj_deinit() function is an empty stub function.  It
> should be:
>
> static void r8712_usb_dvobj_deinit(struct _adapter *padapter)
> {
>         r8712_free_io_queue(padapter);
> }
>
> Currently the call to r8712_free_io_queue() is hidden inside the
> r8712_free_drv_sw() function but that's the wrong place for it.
>
> [PATCH 8/x] staging: rtl8712: implement r8712_usb_dvobj_deinit()
>
>     The r8712_usb_dvobj_deinit() function is supposed to clean up from
>     r8712_usb_dvobj_deinit().  Currently that is open coded in
>     r8712_free_drv_sw(), but it should be implemented as a separate
>     function and called from r871xu_dev_remove().
>
>    389          }
>    390          /* step 4. */
>    391          status = r8712_init_drv_sw(padapter);
>    392          if (status)
>    393                  goto error;
>
>         ret = r8712_init_drv_sw(padapter);
>         if (ret)
>                 goto free_usb_dvobj;
>
> The r8712_init_drv_sw() function does not clean up after itself on
> error.
>
> [PATCH 3/x] staging: rtl8712: fix leaks in r8712_init_drv_sw().
>
> The r8712_free_drv_sw() exists but it is not a mirror of the
> r8712_init_drv_sw() function.  As we've noticed, it frees some things
> which it should not but it also leaves timers running so presumably
> that leads to a use after free.
>
> [PATCH 9/x] staging: rtl8712: re-write r8712_free_drv_sw()
>
>     The r8712_free_drv_sw() should clean up everything allocated in
>     r8712_init_drv_sw() but it does not.  Some of it was done in
>     r8712_stop_drv_timers() and so I have moved it here and deleted
>     that code.
>
> PATCH 9 is slightly risky.  Be careful not to introduce any double
> frees!
>
>    394          /* step 5. read efuse/eeprom data and get mac_addr */
>    395          {
>    396                  int i, offset;
>    397                  u8 mac[6];
>    398                  u8 tmpU1b, AutoloadFail, eeprom_CustomerID;
>    399                  u8 *pdata = padapter->eeprompriv.efuse_eeprom_data;
>
> Declare this at the top.  Pull the code in one tab.
>
> [PATCH 4/x] staging: rtl8712: pull code in one tab
>
>    400
>    401                  tmpU1b = r8712_read8(padapter, EE_9346CR);/*CR9346*/
>    402
>    403                  /* To check system boot selection.*/
>    404                  dev_info(&udev->dev, "r8712u: Boot from %s: Autoload %s\n",
>    405                           (tmpU1b & _9356SEL) ? "EEPROM" : "EFUSE",
>    406                           (tmpU1b & _EEPROM_EN) ? "OK" : "Failed");
>    407
>    408                  /* To check autoload success or not.*/
>    409                  if (tmpU1b & _EEPROM_EN) {
>    410                          AutoloadFail = true;
>
> Put the rest of this if statement after the "AutoloadFail = true;" into
> a separate function.  Set AutoloadFail = false at the top of the
> function:
>
>         bool AutoloadFail = false;
>
> [PATCH 5/x] staging: rtl8712: move code to a separate function
>
>
>    411                          /* The following operations prevent Efuse leakage by
>    412                           * turning on 2.5V.
>    413                           */
>    414                          tmpU1b = r8712_read8(padapter, EFUSE_TEST + 3);
>    415                          r8712_write8(padapter, EFUSE_TEST + 3, tmpU1b | 0x80);
>    416                          msleep(20);
>    417                          r8712_write8(padapter, EFUSE_TEST + 3,
>    418                                       (tmpU1b & (~BIT(7))));
>    419
>    420                          /* Retrieve Chip version.
>    421                           * Recognize IC version by Reg0x4 BIT15.
>    422                           */
>    423                          tmpU1b = (u8)((r8712_read32(padapter, PMC_FSM) >> 15) &
>    424                                                      0x1F);
>    425                          if (tmpU1b == 0x3)
>    426                                  padapter->registrypriv.chip_version =
>    427                                       RTL8712_3rdCUT;
>    428                          else
>    429                                  padapter->registrypriv.chip_version =
>    429                                  padapter->registrypriv.chip_version =
>    430                                       (tmpU1b >> 1) + 1;
>    431                          switch (padapter->registrypriv.chip_version) {
>    432                          case RTL8712_1stCUT:
>    433                          case RTL8712_2ndCUT:
>    434                          case RTL8712_3rdCUT:
>    435                                  break;
>    436                          default:
>    437                                  padapter->registrypriv.chip_version =
>    438                                       RTL8712_2ndCUT;
>    439                                  break;
>    440                          }
>    441
>    442                          for (i = 0, offset = 0; i < 128; i += 8, offset++)
>    443                                  r8712_efuse_pg_packet_read(padapter, offset,
>    444                                                       &pdata[i]);
>    445
>    446                          if (!r8712_initmac || !mac_pton(r8712_initmac, mac)) {
>    447                                  /* Use the mac address stored in the Efuse
>    448                                   * offset = 0x12 for usb in efuse
>    449                                   */
>    450                                  ether_addr_copy(mac, &pdata[0x12]);
>    451                          }
>    452                          eeprom_CustomerID = pdata[0x52];
>    453                          switch (eeprom_CustomerID) {
>    454                          case EEPROM_CID_ALPHA:
>    455                                  padapter->eeprompriv.CustomerID =
>    456                                                   RT_CID_819x_ALPHA;
>    457                                  break;
>    458                          case EEPROM_CID_CAMEO:
>    459                                  padapter->eeprompriv.CustomerID =
>    460                                                   RT_CID_819x_CAMEO;
>    461                                  break;
>    462                          case EEPROM_CID_SITECOM:
>    463                                  padapter->eeprompriv.CustomerID =
>    464                                                   RT_CID_819x_Sitecom;
>    465                                  break;
>    466                          case EEPROM_CID_COREGA:
>    467                                  padapter->eeprompriv.CustomerID =
>    468                                                   RT_CID_COREGA;
>    469                                  break;
>    470                          case EEPROM_CID_Senao:
>    471                                  padapter->eeprompriv.CustomerID =
>    472                                                   RT_CID_819x_Senao;
>    473                                  break;
>    474                          case EEPROM_CID_EDIMAX_BELKIN:
>    475                                  padapter->eeprompriv.CustomerID =
>    476                                                   RT_CID_819x_Edimax_Belkin;
>    477                                  break;
>    478                          case EEPROM_CID_SERCOMM_BELKIN:
>    479                                  padapter->eeprompriv.CustomerID =
>    480                                                   RT_CID_819x_Sercomm_Belkin;
>    481                                  break;
>    482                          case EEPROM_CID_WNC_COREGA:
>    483                                  padapter->eeprompriv.CustomerID =
>    484                                                   RT_CID_819x_WNC_COREGA;
>    485                                  break;
>    486                          case EEPROM_CID_WHQL:
>    487                                  break;
>    488                          case EEPROM_CID_NetCore:
>    489                                  padapter->eeprompriv.CustomerID =
>    490                                                   RT_CID_819x_Netcore;
>    491                                  break;
>    492                          case EEPROM_CID_CAMEO1:
>    493                                  padapter->eeprompriv.CustomerID =
>    494                                                   RT_CID_819x_CAMEO1;
>    495                                  break;
>    496                          case EEPROM_CID_CLEVO:
>    497                                  padapter->eeprompriv.CustomerID =
>    498                                                   RT_CID_819x_CLEVO;
>    499                                  break;
>    500                          default:
>    501                                  padapter->eeprompriv.CustomerID =
>    502                                                   RT_CID_DEFAULT;
>    503                                  break;
>    504                          }
>    505                          dev_info(&udev->dev, "r8712u: CustomerID = 0x%.4x\n",
>    506                                   padapter->eeprompriv.CustomerID);
>    507                          /* Led mode */
>    508                          switch (padapter->eeprompriv.CustomerID) {
>    509                          case RT_CID_DEFAULT:
>    510                          case RT_CID_819x_ALPHA:
>    510                          case RT_CID_819x_ALPHA:
>    511                          case RT_CID_819x_CAMEO:
>    512                                  padapter->ledpriv.LedStrategy = SW_LED_MODE1;
>    513                                  padapter->ledpriv.bRegUseLed = true;
>    514                                  break;
>    515                          case RT_CID_819x_Sitecom:
>    516                                  padapter->ledpriv.LedStrategy = SW_LED_MODE2;
>    517                                  padapter->ledpriv.bRegUseLed = true;
>    518                                  break;
>    519                          case RT_CID_COREGA:
>    520                          case RT_CID_819x_Senao:
>    521                                  padapter->ledpriv.LedStrategy = SW_LED_MODE3;
>    522                                  padapter->ledpriv.bRegUseLed = true;
>    523                                  break;
>    524                          case RT_CID_819x_Edimax_Belkin:
>    525                                  padapter->ledpriv.LedStrategy = SW_LED_MODE4;
>    526                                  padapter->ledpriv.bRegUseLed = true;
>    527                                  break;
>    528                          case RT_CID_819x_Sercomm_Belkin:
>    529                                  padapter->ledpriv.LedStrategy = SW_LED_MODE5;
>    530                                  padapter->ledpriv.bRegUseLed = true;
>    531                                  break;
>    532                          case RT_CID_819x_WNC_COREGA:
>    533                                  padapter->ledpriv.LedStrategy = SW_LED_MODE6;
>    534                                  padapter->ledpriv.bRegUseLed = true;
>    535                                  break;
>    536                          default:
>    537                                  padapter->ledpriv.LedStrategy = SW_LED_MODE0;
>    538                                  padapter->ledpriv.bRegUseLed = false;
>    539                                  break;
>    540                          }
>    541                  } else {
>    542                          AutoloadFail = false;
>    543                  }
>    544                  if (((mac[0] == 0xff) && (mac[1] == 0xff) &&
>    545                       (mac[2] == 0xff) && (mac[3] == 0xff) &&
>    546                       (mac[4] == 0xff) && (mac[5] == 0xff)) ||
>    547                      ((mac[0] == 0x00) && (mac[1] == 0x00) &&
>    548                       (mac[2] == 0x00) && (mac[3] == 0x00) &&
>    549                       (mac[4] == 0x00) && (mac[5] == 0x00)) ||
>    550                       (!AutoloadFail)) {
>    551                          mac[0] = 0x00;
>    552                          mac[1] = 0xe0;
>    553                          mac[2] = 0x4c;
>    554                          mac[3] = 0x87;
>    555                          mac[4] = 0x00;
>    556                          mac[5] = 0x00;
>    557                  }
>    558                  if (r8712_initmac) {
>    559                          /* Make sure the user did not select a multicast
>    560                           * address by setting bit 1 of first octet.
>    561                           */
>    562                          mac[0] &= 0xFE;
>    563                          dev_info(&udev->dev,
>    564                                  "r8712u: MAC Address from user = %pM\n", mac);
>    565                  } else {
>    566                          dev_info(&udev->dev,
>    567                                  "r8712u: MAC Address from efuse = %pM\n", mac);
>    568                  }
>    569                  ether_addr_copy(pnetdev->dev_addr, mac);
>    570          }
>    571          /* step 6. Load the firmware asynchronously */
>    572          if (rtl871x_load_fw(padapter))
>    573                  goto error;
>
> The big indent block didn't allocate anything so our most recent
> allocation is still drv_sw.
>
>                 ret = rtl871x_load_fw(padapter);
>                 if (ret)
>                         goto free_drv_sw;
>
>    574          spin_lock_init(&padapter->lock_rx_ff0_filter);
>    575          mutex_init(&padapter->mutex_start);
>    576          return 0;
>    577  error:
>    578          usb_put_dev(udev);
>    579          usb_set_intfdata(pusb_intf, NULL);
>    580          if (padapter && padapter->dvobj_deinit)
>    581                  padapter->dvobj_deinit(padapter);
>    582          if (pnetdev)
>    583                  free_netdev(pnetdev);
>    584          return -ENODEV;
>    585  }
>
> dvobj_deinit() is a no-op as discussed.  This also doesn't release
> the drv_sw.  So there are some leaks.  When we fix and implement the
> mirrored clean up functions it becomes:
>
>         return 0;
>
> free_drv_sw:
>         r8712_free_drv_sw(padapter);
> free_usb_dvobj:
>         r8712_usb_dvobj_deinit(padapter);
> free_netdev:
>         r8712_free_netdev(pnetdev);
> put_dev:
>         usb_put_dev(udev);
>         usb_set_intfdata(pusb_intf, NULL);
>
>         return ret;
> }
>
> Now we can implement a remove function.  It's complicated because
> we don't know if the firmware loaded successfully and if the network
> device is registered.  We don't really need to test if (adapter->fw)
> becaue release_firmware(NULL) is a no-op but I did it anyway.
>
> Based on what we know so far, this is what it should look like:
>
> static void r871xu_dev_remove(struct usb_interface *pusb_intf)
> {
>         struct net_device *pnetdev = usb_get_intfdata(pusb_intf);
>         struct usb_device *udev = interface_to_usbdev(pusb_intf);
>         struct _adapter *padapter = netdev_priv(pnetdev);
>
>         /* never exit with a firmware callback pending */
>         wait_for_completion(&padapter->rtl8712_fw_ready);
>         if (pnetdev->reg_state != NETREG_UNINITIALIZED)
>                 unregister_netdev(pnetdev); /* will call netdev_close() */
>         if (adapter->fw)
>                 release_firmware(padapter->fw);
>         r8712_free_drv_sw(padapter);
>         r8712_usb_dvobj_deinit(padapter);
>         r8712_free_netdev(pnetdev);
>         usb_put_dev(udev);
>         usb_set_intfdata(pusb_intf, NULL);
> }
>
> The kernel's r871xu_dev_remove() look different so there are some
> remaining questions.
>
>    585  static void r871xu_dev_remove(struct usb_interface *pusb_intf)
>    586  {
>    587          struct net_device *pnetdev = usb_get_intfdata(pusb_intf);
>    588          struct usb_device *udev = interface_to_usbdev(pusb_intf);
>    589
>    590          if (pnetdev) {
>
> These checks are no longer required now that we deleted the two lines
> from rtl871x_load_fw_cb().
>
>    591                  struct _adapter *padapter = netdev_priv(pnetdev);
>    592
>    593                  /* never exit with a firmware callback pending */
>    594                  wait_for_completion(&padapter->rtl8712_fw_ready);
>    595                  pnetdev = usb_get_intfdata(pusb_intf);
>
> This assignment is not required becuse "pnetdev" remains the same.
>
>    596                  usb_set_intfdata(pusb_intf, NULL);
>    597                  if (!pnetdev)
>    598                          goto firmware_load_fail;
>    599                  release_firmware(padapter->fw);
>    600                  if (drvpriv.drv_registered)
>    601                          padapter->surprise_removed = true;
>
> All the "padapter->surprise_removed" code is bogus, but it needs to
> be audited and deleted before any other fixes to the error handling can
> be done.
>
> [PATCH 7/x] staging: rtl8712: delete padapter->surprise_removed
>
>
>    602                  if (pnetdev->reg_state != NETREG_UNINITIALIZED)
>    603                          unregister_netdev(pnetdev); /* will call netdev_close() */
>    604                  flush_scheduled_work();
>    605                  udelay(1);
>
> This is a layering violation.  If it's really required then it needs to
> be done in the correct location...
>
>    606                  /* Stop driver mlme relation timer */
>    607                  r8712_stop_drv_timers(padapter);
>
> Once r8712_free_drv_sw() is fixed I think it will take care of the
> timers.
>
>    608                  r871x_dev_unload(padapter);
>
> The r871x_dev_unload() stuff is suposed to be move to netdev_close(), I
> think?
>
>    609                  r8712_free_drv_sw(padapter);
>    610
>    611                  /* decrease the reference count of the usb device structure
>    612                   * when disconnect
>    613                   */
>
> Pointless comment.
>
>    614                  usb_put_dev(udev);
>    615          }
>    616  firmware_load_fail:
>    617          /* If we didn't unplug usb dongle and remove/insert module, driver
>    618           * fails on sitesurvey for the first time when device is up.
>    619           * Reset usb port for sitesurvey fail issue.
>    620           */
>    621          if (udev->state != USB_STATE_NOTATTACHED)
>    622                  usb_reset_device(udev);
>
> This feels wrong.  Also it feels like using "udev" after calling
> usb_put_dev(udev) would be a use after free, but I think the stuff
> with usb_get/put_dev() is not really required so it doesn't matter.
>
> Anyway, leave this stuff.  Even though, we might not like it we can't
> change it without a way to test it using real hardware.  That's the
> same for the flush_scheduled_work() and the udelay(1).  We don't like it
> but we can't test it.
>
>    623  }
>
> It would probably take a 15 patch series to fix this code.  The ordering
> is important but slightly tricky so be careful with it.
>
> regards,
> dan carpenter
