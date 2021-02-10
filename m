Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06360317479
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 00:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhBJXe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 18:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbhBJXee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 18:34:34 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9BFC061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:33:53 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z32so2926234qtd.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=EcRyK06TdSJllxPfkcZO7AUNE3Hvypf+8oH6aavhd7M=;
        b=QeefNrAXpb9W0VJFrvcmggK9waf8wiwxNfqHl2at+SA4wTxdHCE1tZY5ev0TIVoQFH
         E+ESfn0lsp6SYvCkdN0OoypWUHEI3tosYpUHo3oVNHcXviDdP3tMoPBs5K0A2cHyOXSa
         6zpPX5OshBjLaX/XQ24+Md90J3Li0xlpPt9qifHrR8Dvz++Kd8BxkixP4rZrwoNd747l
         kTQ1Xbyq0vaztZEU0nDUtdvyO0Q6nQcJ5fsdN834Zab9yUoSO68rROX8rykMM4f+vA0U
         5Rzk9lZ/ihn4G/JgGix8xPFDho45eOX82nTqkleGGSISUf+auqxpLWJvI4E5NPQJPHew
         1fOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=EcRyK06TdSJllxPfkcZO7AUNE3Hvypf+8oH6aavhd7M=;
        b=pvDw7uBNG4OYPxhG5b/95CP8IK8bV8J5INc56mRAYx2NaC80jW49CWh7k60djzPGp9
         tJRglQ/lOfwf/A48xV5FXwcYA2zxGFkpPbzl3DgZmBC3ja+RSnrCV35K3y1SguGZxHnB
         RIBcRa6lvMsN1/V0pQnN+/35erXh7YWpflzXtjGA9TibohwVyizeTJ+QQ2By6yW8cIA0
         JC8GVN2eMz3NTCdtaX8k8CGX2o1QJFeYFfXWcyEYWNJeJys9qWNpY7Ru7QJKlF5neaqc
         mbGbeDzztzmwkpZh7oYHblWRviV5pTdZFy6dWsu7pLlJ5NFSd7xLP2spIfFQaLTPectI
         uDdg==
X-Gm-Message-State: AOAM531OF7kpOGOxqY32p6uMUf9jpoz9BXkvL4Te7olT2lbUilVyeIw0
        TcBw5z3ufXa74HVGK2qn/qQ=
X-Google-Smtp-Source: ABdhPJy/bhiMUzgrqxTVI1bv2Z0DnjsMaoaJOdZOVCnIdmiUFcLSBE3V9yZuE6TtKHsyczOqXCuNpw==
X-Received: by 2002:ac8:454e:: with SMTP id z14mr3806180qtn.380.1613000032379;
        Wed, 10 Feb 2021 15:33:52 -0800 (PST)
Received: from OpenSuse ([156.146.36.180])
        by smtp.gmail.com with ESMTPSA id u133sm2640970qka.116.2021.02.10.15.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:33:51 -0800 (PST)
Date:   Thu, 11 Feb 2021 05:03:46 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include: uapi: linux: Fix the spelling simulatneous to
 simultaneous in the file capi.h
Message-ID: <YCRtWi+CPdeQb5Hv@OpenSuse>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <20210209141445.3927167-1-unixbhaskar@gmail.com>
 <e1c73570-3734-5548-cbf2-63bf58a9a40f@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RyPiD7c45mILML1c"
Content-Disposition: inline
In-Reply-To: <e1c73570-3734-5548-cbf2-63bf58a9a40f@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RyPiD7c45mILML1c
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12:58 Wed 10 Feb 2021, Randy Dunlap wrote:
>On 2/9/21 6:14 AM, Bhaskar Chowdhury wrote:
>>
>> s/simulatneous/simultaneous/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>
>Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
>but you need to Cc: a maintainer who can merge this.
>
This is what the get_maintainer script returns,so I followed

=E2=9C=94 ~/git-linux/linux [master =E2=86=93=C2=B782|=E2=9C=94]
05:00 $ owner include/uapi/linux/capi.h
linux-kernel@vger.kernel.org (open list)

=2E.Yup ,no other address to adress to it.
>> ---
>>  include/uapi/linux/capi.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/capi.h b/include/uapi/linux/capi.h
>> index 31f946f8a88d..4dcdb628d98b 100644
>> --- a/include/uapi/linux/capi.h
>> +++ b/include/uapi/linux/capi.h
>> @@ -24,7 +24,7 @@
>>   */
>>
>>  typedef struct capi_register_params {	/* CAPI_REGISTER */
>> -	__u32 level3cnt;	/* No. of simulatneous user data connections */
>> +	__u32 level3cnt;	/* No. of simultaneous user data connections */
>>  	__u32 datablkcnt;	/* No. of buffered data messages */
>>  	__u32 datablklen;	/* Size of buffered data messages */
>>  } capi_register_params;
>> --
>
>
>--
>~Randy
>

--RyPiD7c45mILML1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmAkbVYACgkQsjqdtxFL
KRXxsAgAkkRXFEjR4VU+HXNrcb7QO9JUEu/33X/xqQFtpf5fkcfFKh38Qmaop7/L
j+yOKK6nNftj/Kep6UA2vDOW6bcer3COmiBbRU8GAPIuXn0KqMpbmz6g+Yap2KeH
CiEqkrUwt0hSqRcNiYpkeVMXP7DZO3P1lqH7H3jp6atC9YS8TEO5ik9cnmgHJsRQ
g9zn/H6ist/miYwKcbPKzSX7RByChMSRsTGAypYUOCZvBPWsq2OFD0+IAd/T9LNJ
GOarrUT30+GmSIVhmf6sXZKndEvtdcH8fCdn7M/va0XT6WH7dH4lXLQ5h4ySTPpl
mnR9ecQvsTQeuNwal+8VR8Kf3fRD6w==
=joGi
-----END PGP SIGNATURE-----

--RyPiD7c45mILML1c--
