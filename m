Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8243034850D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238964AbhCXXHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbhCXXHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:07:22 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDF5C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:07:20 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 7so36538qka.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=unU9mIXis029RymGHdH7V1zjjWKUJpo7L/5r2jBdOHw=;
        b=Aw54LjN39oNkovcR3V4TfpdwnEylMj/oVtzW/NXQdaYCxg3Z1Ec6YWTJf/U+L1LIjf
         35ZXylU6/XHmVtfM6knNs2/JPE81nifQvV5LbfJPqpX/txjlJFIpkoNMXSvXNR45JeN4
         scwViwmTM2ZaZcE4fK8t6bREcUD+COLNZBIQkktPUelFaQ64yTnrwNX3B7V0pGztfYQY
         UHxVmGhKa4Vcmg8LjpzVCWi5T78/dOtGgBzxKDzrdcJHyIjkuM24Fcc8qbKHGFlWy6Qo
         p3HTj2YIogqMHlwBlzT5cTsiAG43mqH3xFT3Ei4RnVgk6mk9UtlMkWge4kpsPogcioxs
         IXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=unU9mIXis029RymGHdH7V1zjjWKUJpo7L/5r2jBdOHw=;
        b=iphcrZgXx1T7ZIunSVf1+aR44TyL2yVyV3jojqiIE2dgWhgOSdUpsVPFQbG5/kaL3y
         WQjofxiWWgjDLB/1+6o3zTJMiXJ29FGKYUF6HdNB2Da6/H4ztzUi0Bs66/UIS6cF2KUC
         PLPp1i82zGu9iaUomnKsFa6O7bHlJilkrVeedD+Kalbnu11nXWrHYTeE0xu7zo8lZgOl
         KdDAthovyzK7nxL0lmlOumnno6ROpYnol1b+TMGFRW/g/6apCOhwaDQ0QYxqdyBDlBf7
         Mv9yLJCBYB1qyhNVKVYrnWrgsMdWtDKtQ+S2kFy8f+Fgw2AocYGTI5fcQz+KFcU9gUgK
         HDpg==
X-Gm-Message-State: AOAM530shLpFvJo5NdrlyUZMumdSD5SrpwmzX5Z5fOGZ9ARdrFMNeYvu
        3kPfoNJsM/fhF0XqqUulVTs9kA7EWeA2TQBM
X-Google-Smtp-Source: ABdhPJy0XDX6xf+AUtITEYmLy/Evqhue1H4jw/H6OCKGGRWyxuZQkdH3VsEtvbV9hUJzchPL3P/mIA==
X-Received: by 2002:a37:2749:: with SMTP id n70mr5477245qkn.105.1616627239714;
        Wed, 24 Mar 2021 16:07:19 -0700 (PDT)
Received: from Slackware ([156.146.55.193])
        by smtp.gmail.com with ESMTPSA id m13sm2793041qkm.103.2021.03.24.16.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 16:07:18 -0700 (PDT)
Date:   Thu, 25 Mar 2021 10:07:08 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stefano Stabellini <sstabellini@kernel.org>, linux@armlinux.org.uk,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH] ARM: xen/mm.c: A mundane typo fix
Message-ID: <YFwTdAnamANFsBPZ@Slackware>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stefano Stabellini <sstabellini@kernel.org>, linux@armlinux.org.uk,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com
References: <20210324133036.17665-1-unixbhaskar@gmail.com>
 <alpine.DEB.2.21.2103241154320.439@sstabellini-ThinkPad-T480s>
 <5e1b573a-6dc7-7f28-28ae-c509e6782fbf@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TCrfE9v/6+6uxuTN"
Content-Disposition: inline
In-Reply-To: <5e1b573a-6dc7-7f28-28ae-c509e6782fbf@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TCrfE9v/6+6uxuTN
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 11:59 Wed 24 Mar 2021, Randy Dunlap wrote:
>On 3/24/21 11:55 AM, Stefano Stabellini wrote:
>> On Wed, 24 Mar 2021, Bhaskar Chowdhury wrote:
>>> s/acrros/across/
>>>
>>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>>
>> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
>>
>>
>
>Hi,
>It seems to me like some of those "page" should be "pages".
>
>>> ---
>>>  arch/arm/xen/mm.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
>>> index 467fa225c3d0..be7c942c74bf 100644
>>> --- a/arch/arm/xen/mm.c
>>> +++ b/arch/arm/xen/mm.c
>>> @@ -105,7 +105,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
>>>  	 *	- The Linux page refers to foreign memory
>>>  	 *	- The device doesn't support coherent DMA request
>>>  	 *
>>> -	 * The Linux page may be spanned acrros multiple Xen page, although>> +	 * The Linux page may be spanned across multiple Xen page, although
>
>	                                                     pages,
>
>>>  	 * it's not possible to have a mix of local and foreign Xen page.
>
>	                                                            pages.
>
>>>  	 * Furthermore, range_straddles_page_boundary is already checking
>>>  	 * if buffer is physically contiguous in the host RAM.
>>> --
>
Thank you....I have sent a V2 now.
>
>
>~Randy
>

--TCrfE9v/6+6uxuTN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBcE20ACgkQsjqdtxFL
KRUvIggA0Bu+io2ijz60vfhZz7xZNVSid1OoUl1Om/MMq2kve/J9NbkNzt7dGSaO
Nb8vdiEZT77497MkjBJ8U/pxck9POJdv7RJ4S5s949pPcbuP6PsGhlzk35nN7NqM
vZ42o9L0cEtLrIrAxWtl3Rscy6x7W90BHhDMhix174CXg5S8ciQ+MCPdo3EyBwuN
crlJJJZ6VbQiaxOkjGnxyRobSz+WpFCJa/XPioII8xf3p854qdgbVE0GLRaC5f9y
koN0TLULWOVyX8tm1LOkP8ACv6wIQehPlFCkxRLk8C67CUdmQdx+Mz/u6hQK54K2
WjwbqPHASv5QkWa+p9PHbF+GjV7yqg==
=PKSI
-----END PGP SIGNATURE-----

--TCrfE9v/6+6uxuTN--
