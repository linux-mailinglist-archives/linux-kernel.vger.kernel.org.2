Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550B1348683
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 02:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhCYBmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 21:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbhCYBmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 21:42:31 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905A7C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 18:42:31 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id by2so393923qvb.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 18:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=1L/pz9gZOSJi4hs0og36D4HdxDIy6dNEhwI8kgZvdSY=;
        b=p61uiZpTrWay4TVukMqYkKP+ps7Z6wSw13hob6VM8YgWbgHn9NsZI1RUuqDq02lGNS
         z8gecNWLHB2yUrvjEwziltT84FGROuPclAoKlVJ/IaDO36FzDNrrGGGkHKBCSDhQJQQh
         AZxwQC1qpOv1gR4jpF27VZlRZCOA+XsAajmq1xzQjerjKBv+q0MP05YtnAc903+dkioC
         bxx6e9bMKPvMjfaj4G0tesq2dPbSDLbSdENknpFdLx7xX3c7ZehYbyAm/Ndzf7Kq2Yuz
         4P0J84khTvln/LDJTah42BWLM3zV6mfrLjETwENc9Tv9KX0SrIy/ldCKv4F1GwhEQ/Ik
         hrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=1L/pz9gZOSJi4hs0og36D4HdxDIy6dNEhwI8kgZvdSY=;
        b=udo2WRZdGlHDlfGeRKTnF/phkuxu29HmgGLQp6P5BQTtVSd56EnEyg2xmnjdF6O/aN
         30XtmLog7DB9dhdhgUVvl24FF05cF+qu9okFoeHbXLhan7XXuEdDMCux6IL/03V3NObw
         /k/RGQ5JNcCukZvNuEB6uY63kacWKlgWxoUXSEcSsUG/a2qtlMKETGIRVMj22AwWuBJg
         fWvk4R3rUL7xdnD3r3d22si/85GhydnrpGQVDQUccGpweBenhG03wpCpTG0JcKc8nGF6
         q0To5D77hwhuCQI07XleBWrbGVlnxFJ5FVi1RRAhsZsimRtY5322xrxGBJKGTmXXLsu/
         2E1A==
X-Gm-Message-State: AOAM531xDpLAjQvhA66Hw2yRr0cM9BFilzxD5kITpQHWXmcOC6FFsgdy
        eg0quhSzoa4Y94HC9DGq5XM=
X-Google-Smtp-Source: ABdhPJxJyHNSWTKbxwnP7Jn0iUPmMYejxMFQM78hS25H1Ch/TnEhJX0MtCMeTQKZMCAxuJ61U/mZzg==
X-Received: by 2002:ad4:4e23:: with SMTP id dm3mr6307674qvb.4.1616636550917;
        Wed, 24 Mar 2021 18:42:30 -0700 (PDT)
Received: from Slackware ([156.146.55.193])
        by smtp.gmail.com with ESMTPSA id o7sm3148730qki.63.2021.03.24.18.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 18:42:30 -0700 (PDT)
Date:   Thu, 25 Mar 2021 07:11:50 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     haver@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: genwqe: Rudimentary typo fixes
Message-ID: <YFvqXpMXuQgXY4eL@Slackware>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, haver@linux.ibm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20210324062828.14807-1-unixbhaskar@gmail.com>
 <d6366447-add9-0fcf-b4f1-1787afcecb58@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aJbkihaVCEms+Aqx"
Content-Disposition: inline
In-Reply-To: <d6366447-add9-0fcf-b4f1-1787afcecb58@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aJbkihaVCEms+Aqx
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 14:47 Wed 24 Mar 2021, Randy Dunlap wrote:
>On 3/23/21 11:28 PM, Bhaskar Chowdhury wrote:
>>
>> s/requsted/requested/  .....two different places.
>> s/equests/requests/
>> s/occured/occurred/    ......two different places.
>> s/conditon/condition/
>> s/requestors/requesters/
>>
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  drivers/misc/genwqe/card_ddcb.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/misc/genwqe/card_ddcb.c b/drivers/misc/genwqe/card_ddcb.c
>> index 0db4000dedf2..98f6cd3fc66a 100644
>> --- a/drivers/misc/genwqe/card_ddcb.c
>> +++ b/drivers/misc/genwqe/card_ddcb.c
>
>
>> @@ -1182,7 +1182,7 @@ static irqreturn_t genwqe_vf_isr(int irq, void *dev_id)
>>   *
>>   * The idea is to check if there are DDCBs in processing. If there are
>>   * some finished DDCBs, we process them and wakeup the
>> - * requestors. Otherwise we give other processes time using
>> + * requesters. Otherwise we give other processes time using
>
>"requestor" seems to be a word AFAICT.
It was certainly not showing to me , that was why the change.Let me go back
and check, if I missed it.
>
>>   * cond_resched().
>>   */
>>  static int genwqe_card_thread(void *data)
>> --
>
>and codespell says (for linux-next):
>
>drivers/misc/genwqe/card_ddcb.c:985: emtpy  ==> empty
>

Thanks, good catch...will do a V2 ...
>
>The other changes LGTM.
>
>--
>~Randy
>

--aJbkihaVCEms+Aqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBb6l4ACgkQsjqdtxFL
KRWe4QgAxi6eu/xGMe9OcKcis3XctPXHDO80SBtd9s1IR6ksov2rmNODLcSbAXDv
Ubszcgo8F3xXf1/ijX4AGXNhu+r/LcRPy8jFj9PkzPsbM4dZteG3F2fGHLq+XrUC
/AyTveiFZopxih/ZQJUGtKSY9md/eFlWkjaU8SPwuYfjaT7DFpQ/gxuE5Guwy2vQ
6nh+T7S95MIKFLB+tsSIcKiYI8jgT3DEaX+xNKF6aA4KDM0+QMuffDV1FTjt5fu7
otKxXgeM8kS+21kV9BXnPfVnT90yW39+GL8i3Dkhe8tuKgui3FneZl84sLXH/I/A
xcLDEyp51Dw96ACVFM2D7NJdXGNaeQ==
=aho2
-----END PGP SIGNATURE-----

--aJbkihaVCEms+Aqx--
