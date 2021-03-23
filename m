Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3678B345A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhCWJMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhCWJLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:11:39 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17736C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:11:39 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id s2so14396834qtx.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=TD1jWUXH5hue+PJvMMdqj/dwcVhvU6Zy0rXQBMLL5pk=;
        b=PyNvyTsRuDrcC0p8/dDgxQSeSWEiom7Bdj3QkFYrgrniJ2SeFB158sv9eKFCLOU/RH
         rtdMm5mEns1vga1P6ktdUkAUu3WmtuB4N/xiQs6ErVWx3xMLaak5PpuZNBd3r3fH50f5
         HqYLz8T6KzkIy2+s83HuiiHnetpYg8kfqE6WULawqTS3GVMShJJ7WRTUShvQJRZAqJEF
         AWJUVUxCVs0wI+Nht/34buJUWWmcgWNkf4KImPrQuAu72GkEI1LSZuTkHlbnBBOejN9X
         t1+7jbKtq55k/qG+9StfJldrYHm9vw0AI5c24C9e5pT3BTp8u/KOAMKsphBuE9N6vBiN
         tHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=TD1jWUXH5hue+PJvMMdqj/dwcVhvU6Zy0rXQBMLL5pk=;
        b=BeVFvZTt0Tzyy3bU0nxHPxm3YEXgw3xppM0oMnkzZ2ckElUY7cfJuMY7ve7u1ZMgBa
         bOKfaW86Sr5oIjoMWq6xRf9rDgwH2yU1YlSsrj4XNIsEMt1Sj6gAHW7q9hY/qnIqEPJh
         sLJR9JJcgajx9zuobt9d22M4JFG489WFiKINX/PpVoLC5K1rw04aWi69jAlin+VNhDEv
         wCsaPl9b8+LTW26HZR3DM4pjPUi57b+sH+xrHCFGs11kgcdD8iWoYwIu+/azcOEE3Ktq
         gUZ62SpnaslBVjpkg7mDPTnlTwlch+ogD6RmhzgfN2Ho2TgLhD7pbgNFGx2/3OxbJq3l
         +/Uw==
X-Gm-Message-State: AOAM533T11nFmzfSmw3ytL+y8SKsXAnUWbYAyH2GT/DMdcjKIpfIK01F
        abfCd3zs60xmPVn6CmFtH6Lwjk2qiRBNNnQh
X-Google-Smtp-Source: ABdhPJwUdDdpzM+G/sYPcFc7ckQIb7IDjRaZ1N5ALmvbdDCmi7fSfisF5EdAjMHLtrWTI1+R6dpd5g==
X-Received: by 2002:ac8:702:: with SMTP id g2mr3516727qth.215.1616490698377;
        Tue, 23 Mar 2021 02:11:38 -0700 (PDT)
Received: from ArchLinux ([143.244.44.229])
        by smtp.gmail.com with ESMTPSA id u11sm10225800qta.91.2021.03.23.02.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:11:37 -0700 (PDT)
Date:   Tue, 23 Mar 2021 14:41:24 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     ross.schm.dev@gmail.com, yanaijie@huawei.com,
        matthew.v.deangelis@gmail.com, amarjargal16@gmail.com,
        izabela.bakollari@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Trivial typo fix
Message-ID: <YFmwvBcwN4ZpNAVX@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, ross.schm.dev@gmail.com,
        yanaijie@huawei.com, matthew.v.deangelis@gmail.com,
        amarjargal16@gmail.com, izabela.bakollari@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20210323010835.4061779-1-unixbhaskar@gmail.com>
 <YFmvWzGZ0hHJbx6d@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="STznAHK0HTkLK/SI"
Content-Disposition: inline
In-Reply-To: <YFmvWzGZ0hHJbx6d@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--STznAHK0HTkLK/SI
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 10:05 Tue 23 Mar 2021, Greg KH wrote:
>On Tue, Mar 23, 2021 at 06:38:35AM +0530, Bhaskar Chowdhury wrote:
>>
>> s/netowrk/network/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
>> index 2c9425e2a1e9..3888d3984ec0 100644
>> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
>> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
>> @@ -599,7 +599,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
>>  		}
>>
>>  		if (rtw_roam_flags(adapter)) {
>> -			/* TODO: don't  select netowrk in the same ess as oldest if it's new enough*/
>> +			/* TODO: don't  select network in the same ess as oldest if it's new enough*/
>
>Any reason you did not remove the two spaces at the same time?
>
It skips my attention.Apologies.

>thanks,
>
>greg k-h

--STznAHK0HTkLK/SI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBZsLAACgkQsjqdtxFL
KRVlRAf9GKDqoB9Kc68xSjPR5JTQbf5bfB4sKYZuZ6xQtO+gJQ+8nuzTJcmltity
tGIPR4gVk7jOQi6Y+NfzxlX2k4eeeAPHRFjjtKy+92Upt0wh74AJ74nQBf3f4X33
4EevSmLmQ+umxHFZjh8C4kj520u4l76a2j+xrIfDEjk4hiXtlLsoIiN56Jn6n8x4
BwHSMq1KScJ9U+qIro0CoPgVPkP2cXZpl6P/NqG5qW4n3/UJGEGljkhFMfYDzmA4
pssHL3e4wum6OUTkzh3i5p6ufjCs4M8wPXYIpobpMS4NebsbFZMRqLTYtpOv85OR
dsWmJdq5o+TYYhSGeDSxFQh/StC+Cg==
=wJra
-----END PGP SIGNATURE-----

--STznAHK0HTkLK/SI--
