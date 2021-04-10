Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CE435AE9A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbhDJO4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:56:51 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:27969 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbhDJO4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:56:50 -0400
Date:   Sat, 10 Apr 2021 14:56:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1618066593;
        bh=y+5Vaf23mVkXNxK22g/k1LT3KwDKQudyGF5Dp8peF64=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=O4ZjCVBl18lbwdYtjqLGF7C3LTOo5h94bAQtsLukLIyKzN664zh4+DBbdDZo28nKq
         PbIdaXvbshVioUnCP6N7xBAvUYnJyGQrEyZhv6d08s0bS1WXw45jnCdvIEPx66sQsg
         8rivE962hKca7Q/Fp4xrVQMBWrB6oQNVPJhaeUrUJ/v0J+9xrXH2szMO11kHxbkH6l
         Au4+ohKawGAE2bUUKSaxLGfv9cVmX8iBcKDmajpR4mrShRTgopdq69UF1vrhYqHCLC
         /8vCIP1kPbf3fi+MSo+LT6NJoUyUbBKfMI7NmDJY+9edIUEYnLVYhviCsT4to5knG7
         AKog8hkAJNTPw==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: Re: [PATCH v2] staging: rtl8723bs: remove unnecessary goto jumps
Message-ID: <20210410145615.gz4yzy34ofvmwjde@bryanbrattlof.com>
In-Reply-To: <YHG2A4rJdl1uiZjV@kroah.com>
References: <20210410141945.424238-1-hello@bryanbrattlof.com> <YHG2A4rJdl1uiZjV@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 04:28:19PM +0200, Greg Kroah-Hartman wrote:
>
>On Sat, Apr 10, 2021 at 02:20:19PM +0000, Bryan Brattlof wrote:
>> The next instruction for both 'goto exit' jump statements is to
>> execute the exit jump instructions regardless. We can safely
>> remove all jump statements from __init rtw_drv_entry()
>>
>> Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
>> ---
>> Changes from:
>>   v1: removed unnecessary edit of DBG_871X_LEVEL
>>
>>  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/stag=
ing/rtl8723bs/os_dep/sdio_intf.c
>> index 9fd926e1698f..39b6d4b6dec4 100644
>> --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
>> +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
>> @@ -517,12 +517,8 @@ static int __init rtw_drv_entry(void)
>>  =09if (ret !=3D 0) {
>>  =09=09sdio_drvpriv.drv_registered =3D false;
>>  =09=09rtw_ndev_notifier_unregister();
>> -=09=09goto exit;
>>  =09}
>>
>> -=09goto exit;
>> -
>> -exit:
>>  =09DBG_871X_LEVEL(_drv_always_, "module init ret =3D%d\n", ret);
>>  =09return ret;
>>  }
>> @@ -540,6 +536,5 @@ static void __exit rtw_drv_halt(void)
>>  =09DBG_871X_LEVEL(_drv_always_, "module exit success\n");
>>  }
>>
>> -
>>  module_init(rtw_drv_entry);
>>  module_exit(rtw_drv_halt);
>
>Any reason you removed this extra line?
>

Oops! My bad... again :(

I removed the line to take away one of the many checkpatch.pl messages.

I'll be sending v3 here momentarily with an updated commit message

>
>thanks,
>
>greg k-h

Sorry for the noise today
--
~Bryan

