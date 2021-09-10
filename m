Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0626E406A34
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 12:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhIJKgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 06:36:48 -0400
Received: from mout.web.de ([212.227.17.12]:53279 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232157AbhIJKgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 06:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631270120;
        bh=NkaF6yzyaw3gMwcBE5iEi8F34hLhYgz9u3+0igXeSrM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=m0s4tDItyYkg5wwuAwxXO5se0uejWOfgWwZngwOIQAX3KKgIM5cOjQ7O4nCX+N6qz
         Tag2epZb/JSNJz/0K23Z267ckKwcEqFzge17+WxWBNgyax2woIbVd26vmuaaGMsK/v
         rQmXiuLjuOZh2zedZWmVfGBNz2lZS4X4VKAy4XQk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [10.0.0.17] ([185.159.157.24]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Le4Tw-1mjd9I0ur6-00psTr; Fri, 10
 Sep 2021 12:35:20 +0200
Subject: Re: [PATCH] of: property: Disable fw_devlink DT support for X86
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210910011446.3208894-1-saravanak@google.com>
 <YTr4CZW+rOXAjNq9@kroah.com>
From:   Andre Muller <andre.muller@web.de>
Message-ID: <5064e6ca-344d-7eda-3264-50fb63e2e3f3@web.de>
Date:   Fri, 10 Sep 2021 12:37:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTr4CZW+rOXAjNq9@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wPimF1SPwTSrk6vH6Mnw/WxrIttEdY5oCk9Fbcef4RsFjrxVNLL
 YUCpz/wG/ahPxsNR/AyEp2mVy+D5CwCR8tVvGuUVbMNYXR4+geSqsidcWvOOpEHXIcQ9lrM
 lEUE5cR+VUjzpK5QzfQPpARKd4j7daIKQML8Ll95zpAkgqWk+H4/7bGL0j7DwQMKKMG7QVh
 xpioQrZcvMv2Lji8Xivag==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6HjYgy6odGY=:mtnZVk3N0IuPRnd92mAyC0
 Umfg0FIZgJgNuQ8Fv1KSEk+XAUIKlWTiyPn+p2KkzW4S08os4fD4M4veYXEAUcPaZXOiy7P1u
 NzBd6zPrdUSQ+7qXOZZGL/zi2/du28H611JxOdbwX/n5joyyJCTeFkJYnIuj/SYf9bBggPSar
 we0UBkGjg4ydorF3yeuPQNLjPedqJ/TPA9yTmgAzmuZsPatRXtOUnCuJZVzUq+EKGq3ftwGVu
 SxZvJrE34ZBKiLONHTuNQo53I8AVUDbFn1zr2LqWVdddj1vKBYqhUa8VrDbFXt3pjTcmHJRfn
 EiWvtUBdxAm/gfC5lVbOMh0favWxWKWOyDAMwWaTA7/FRGnidm4tiIpS8s9T4Ex5vN3HnBEFW
 UtdmDPcsKDUf6C+hPHLfpgO3w2oRbjtc4PbLPNCOllEDg+nK1A/k43fbx8Oyxs3z56lr0AWBk
 wnn/yTFudhrtY79wg1r4+ECeGk4GPKeb8brMh6sNzGtEGiC5DgCI3VQ+7/3GMggERR0QxXhhj
 /p/oAyG65dR048ULpicNAipXZp32cv5xlMdwoyqzX97QqnectJUf3qOEuGr3EaEAw8F9nmGkw
 SLtNffL3kEhTZ87C+fN11cTgSuSI9KO9IYIaagmUkgO9epSLFXdpY9RI+KojdZPRlR5t1fxR9
 D7XfXZ9RjGW0JlQkToObmPQdCyi6G2u5Z9peQDB9aKB9ymukj2PxkUHw74bTiHB++j+3GIaRc
 TyI4f+VYrwKlXWRRISnqw8XY7fjR3J0L34X5SCeVuZZeWfxCgnCh1Rq/msm4sWxlyUedZ7KU0
 vCscmYtcOlgF9q9EaAvc0peeSO1m+Bb5itHj75h25o/H0JCfBHX/zGClKOE5tXdyoZnQ7uEOK
 LI/lSO2A5ErO2w/ULhCQmHhDJOxWiDGl7hwZNeExEYGTxgzHqoi/cJaEq2i9d8t1LK2L214yN
 jllOYE9cpJ/Z2yFozQCpha+g4zL3n6G2FCja+N0yhg9gbqqAJqHaRGVfBnM+fR/naJQP0k1Jf
 Jc8u8hd0CzDkexmtERR3g+HTtMn7rdhO2ZmnH0n2WN6R30vbH3zRwqKRfq5maEuwUOZPcvrei
 w7uIoCzRk4Z8A4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2021 08.15, Greg Kroah-Hartman wrote:
> On Thu, Sep 09, 2021 at 06:14:45PM -0700, Saravana Kannan wrote:
>> Andre reported fw_devlink=3Don breaking OLPC XO-1.5 [1].
>>
>> OLPC XO-1.5 is an X86 system that uses a mix of ACPI and OF to populate
>> devices. The root cause seems to be ISA devices not setting their fwnod=
e
>> field. But trying to figure out how to fix that doesn't seem worth the
>> trouble because the OLPC devicetree is very sparse/limited and fw_devli=
nk
>> only adds the links causing this issue. Considering that there aren't m=
any
>> users of OF in an X86 system, simply fw_devlink DT support for X86.
>>
>> [1] - https://lore.kernel.org/lkml/3c1f2473-92ad-bfc4-258e-a5a08ad73dd0=
@web.de/
>> Fixes: ea718c699055 ("Revert "Revert "driver core: Set fw_devlink=3Don =
by default""")
>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>> Cc: Andre Muller <andre.muller@web.de>
>> ---
>>   drivers/of/property.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/of/property.c b/drivers/of/property.c
>> index 0c0dc2e369c0..3fd74bb34819 100644
>> --- a/drivers/of/property.c
>> +++ b/drivers/of/property.c
>> @@ -1444,6 +1444,9 @@ static int of_fwnode_add_links(struct fwnode_hand=
le *fwnode)
>>   	struct property *p;
>>   	struct device_node *con_np =3D to_of_node(fwnode);
>>
>> +	if (IS_ENABLED(CONFIG_X86))
>> +		return 0;
>
> I love it :)
>
> Anyway, getting a "Tested-by:" would be great to have here.  Andre, can
> you verify this solves your issue?

Yes, this patch fixes the issue, the drives work fine.
Tested-by: Andre M=FCller <andre.muller@web.de>

Thanks all,
Andre

>
> thanks,
>
> greg k-h
>

