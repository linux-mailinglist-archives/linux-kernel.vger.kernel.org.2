Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60043456FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 05:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCWEt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 00:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhCWEs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 00:48:57 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E71C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 21:48:56 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id o19so9918237qvu.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 21:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=8o4w3qvGY4wX+/J7guXd6pbU7uRScmOE2FBMsZ1kUOo=;
        b=KWJs/3rpjKokr24+2+rEAutt7PhwLMsqwfrBLewOIjE9Dx9JuAvzk0wH/F1lt615mp
         pFg+Jn3x4XlfyaJ48tLm5PrKcGhRLmTgwCZpfjxMmh1rz7FM6aQq5G8NWNF11F2UrSeB
         rsM4TmW8a0Y+ZdV9TcdGEwik6oJi3O4ebaHisqfm72YxLHvsOarVJzvGmRuGGXFyA+0q
         zlxTxfxSYXapy6ySdk+/Wk5CX9WsyO8Bcc20V63/w05RSk08Nwmreu4qFYbLLIpyuCKL
         S0O3nZNe8DOCNZzMJzRXO9ff+lrChx/0EteYESGK3AFa6e4SwFmRa64vMk1QIeKGWfU0
         ErrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=8o4w3qvGY4wX+/J7guXd6pbU7uRScmOE2FBMsZ1kUOo=;
        b=Mz+kpuq5iHOx2kgSAxc3S7ki3jzDhPGRKbzuhdMnsSFRFZNapH3xX+I2DiR2BkBNMs
         Zj5xzEDtX7Niv9ZPOX1cYu+ZvyDASn9AnLHG/nzQMf+Am8shzD3lWasGWlTAYwLOj1Fu
         KOfGapM70BltdI1Lkzo40QNuIBMZ4kDauSlnlCh9ujMTvWqsEcIibxq/3tOYA7gBzDD8
         gLiAuE3MedCOhAQIIYwq9+IST/m4MCjsyBr3OQhdt9K0VV/UyI2deGwCCUday5p9Z4hy
         zm02z55o0ht4NkSIr7yMbTFoly3/7Cp3Acf046n/MnzR7GRCWJM/OFQ/+2rcUSp51QYE
         9i3A==
X-Gm-Message-State: AOAM533tdJbYdKJkL7iYs9bBQjkdWjNSrHClStOC+6VPFvwWsa2PPSpM
        5QrBlxQPM7HwImrYDcRpgJQ=
X-Google-Smtp-Source: ABdhPJy+Lui8GtXG1HUpy8iHpBLLve2dzRGvc2AtjtdKGldvBIpiU8cV4VdRqbzxaYjCKY7cWzcDHg==
X-Received: by 2002:ad4:56e1:: with SMTP id cr1mr3020837qvb.25.1616474935325;
        Mon, 22 Mar 2021 21:48:55 -0700 (PDT)
Received: from ArchLinux ([156.146.54.208])
        by smtp.gmail.com with ESMTPSA id y1sm12380688qki.9.2021.03.22.21.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 21:48:54 -0700 (PDT)
Date:   Tue, 23 Mar 2021 10:18:41 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     gregkh@linuxfoundation.org, colin.king@canonical.com,
        davem@davemloft.net, lee.jones@linaro.org, arnd@arndb.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wimax: Mundane typo fixes
Message-ID: <YFlzKap5VsILZG+P@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, gregkh@linuxfoundation.org,
        colin.king@canonical.com, davem@davemloft.net, lee.jones@linaro.org,
        arnd@arndb.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20210323010607.3918516-1-unixbhaskar@gmail.com>
 <36821877-7a6c-9a15-4e94-cb657ef29dad@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fV3FxdRXDNWSw7XV"
Content-Disposition: inline
In-Reply-To: <36821877-7a6c-9a15-4e94-cb657ef29dad@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fV3FxdRXDNWSw7XV
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 21:14 Mon 22 Mar 2021, Randy Dunlap wrote:
>On 3/22/21 6:06 PM, Bhaskar Chowdhury wrote:
>>
>> s/procesing/processing/
>> s/comunication/communication/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>
>drivers/staging/wimax/ is in the process of being deleted.
>
Yes ...I saw the mail day or two back ...skipped my mind ...anyway we can
ignore this.
>> ---
>>  drivers/staging/wimax/i2400m/driver.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/wimax/i2400m/driver.c b/drivers/staging/wimax/i2400m/driver.c
>> index f5186458bb3d..162a92682977 100644
>> --- a/drivers/staging/wimax/i2400m/driver.c
>> +++ b/drivers/staging/wimax/i2400m/driver.c
>
>
>--
>~Randy
>

--fV3FxdRXDNWSw7XV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBZcyUACgkQsjqdtxFL
KRWv6Qf+NZyfQE34E3YqU/2plOy1xbmrT//aurhwcCVfxGjK6daNggG42HjsMnXs
tZad38De4zGZZttW+0HxF2K7r6dsOL0n+aBcu5L81zsfOQFkqcav5Vm5/GBsE7sY
4mnvD/a2NFRcaQEviM0rUxKKiK6aDDQyZVMqZC5f9z8yXHkMDwLVrJrfp6My63YY
EooWkA6OSqquVqOmcLtQWy01q4hcqMSI6ENsecYfedjwbUP9OwNkTYxa2pI42ton
4yD9wIlaTs7cFQUku8FHBQhnl1EpA6xBO7DWbR0P1XLCcSywwlUAfZCy6Vh5RFCf
m/eXN/cyUyhfYDlMMJhsL6dWOvAqyg==
=ccl5
-----END PGP SIGNATURE-----

--fV3FxdRXDNWSw7XV--
