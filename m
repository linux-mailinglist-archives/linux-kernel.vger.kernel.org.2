Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21518372F20
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 19:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhEDRqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 13:46:38 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:35381 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbhEDRqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 13:46:36 -0400
Date:   Tue, 04 May 2021 17:45:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1620150339;
        bh=l7iVg4/OggiIkPeMxEn/RhDWwcdILaZsHBJ2V+aEFSg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=miwE+3WH0QRy/M8fMvtxbKcq4DIoyMWunzOjNUCSYm0+xBJqjhsh8zxp0J1795FYy
         BxLkCcaw+P6oYgEirjQCmniTUePbBAePv7jvMYxUU7M8wPjlv65DSbykv/vceZoQtJ
         L6aFmE9DluKG0+8Tf94Ieh0JjLIlGwEfRDnhs1BRzvx1Qwytmz20kLTPRPszFa3bLQ
         SUHj4frnqp+xnu5aQ2QU7iIqutV3Op4VV7kjD9bERSTlZVzKFgCsrESac2roGQitAm
         fSFJpiFezqLVZDmh3K5MXvu0AvVTOU8qGriqmcdvpOteGNZCtPhzjij7VrTdFsfIER
         98EjtHCr1OHGw==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: Re: [PATCH] staging: rtl8723bs: use generic kernel error codes
Message-ID: <20210504174530.3kog7zq6tuk3wnlk@bryanbrattlof.com>
In-Reply-To: <YJFziyZHnbsWdTFn@kroah.com>
References: <c94e5865e59d35fe0e39d5cd46d71ad4a752ddd4.1620144194.git-series.hello@bryanbrattlof.com> <YJFziyZHnbsWdTFn@kroah.com>
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

Sorry for the spam Greg I dropped the mailing lists from the first
email.  :(

On Tue, May 04, 2021 at 06:17:15PM +0200, Greg Kroah-Hartman wrote:
>On Tue, May 04, 2021 at 04:07:48PM +0000, Bryan Brattlof wrote:

<snip>

>> @@ -139,12 +139,11 @@ static u32 sdio_init(struct dvobj_priv *dvobj)
>>  =09psdio_data->tx_block_mode =3D 1;
>>  =09psdio_data->rx_block_mode =3D 1;
>>
>> +=09return err;
>> +
>>  release:
>>  =09sdio_release_host(func);
>> -
>> -=09if (err)
>> -=09=09return _FAIL;
>> -=09return _SUCCESS;
>> +=09return err;
>>  }
>
>You just changed the logic here, are you SURE that was ok to do?
>

I can't say my brain didn't bleed a little trying to keep this straight
in my head while walking through this. (For what ever reason my brain
sees negative integers as False) =C2=AF\_(=E3=83=84)_/=C2=AF

Both the sdio_enable_func() and sdio_set_block_size() will return a
negative integer if they fail, which we evaluate as True, allowing us to
jump to release, free the card and propagate the error backwards.

If everything worked, we'll skip all the jumps until we get to the first
'return err;' statement, returning our 0 for success.

Inside sdio_dvobj_init() if we see 'anything below 0' (This probably
should be changed to 'anything True') we jump to free_dvobj where we
free the dvobj and return NULL

If I've looked at this long enough I don't thing I changed the logic.

Hopefully. :)

>
>>
>>  static void sdio_deinit(struct dvobj_priv *dvobj)
>> @@ -186,7 +185,7 @@ static struct dvobj_priv *sdio_dvobj_init(struct sdi=
o_func *func)
>>  =09psdio =3D &dvobj->intf_data;
>>  =09psdio->func =3D func;
>>
>> -=09if (sdio_init(dvobj) !=3D _SUCCESS)
>> +=09if (sdio_init(dvobj) < 0)
>>  =09=09goto free_dvobj;
>>
>>  =09rtw_reset_continual_io_error(dvobj);
>>
>> base-commit: 9ccce092fc64d19504fa54de4fd659e279cc92e7
>> --
>> git-series 0.9.1
>>
>>
>
>And that's all to remove the need for these crazy error values?  If so,
>why not also remove the #defines for them as well?
>

I might have over sold this patch. :)

There are quite a few functions like this still here that need to be
converted before we can get rid of the _SUCCESS and _FAIL definitions.

Would it be better if I bundled these up in a series?

--
~Bryan

>
>thanks,
>
>greg k-h

