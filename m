Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACFF317443
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 00:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbhBJXWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 18:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbhBJXWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 18:22:47 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC17DC061574;
        Wed, 10 Feb 2021 15:22:06 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id p6so1743350qvm.12;
        Wed, 10 Feb 2021 15:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=nrUwWEHtkuETZV80esS2kI6jyeXCjRYa+pWFfOnoHMQ=;
        b=S6VcGeoRuNxVgTDgb7qo+VlP2X9I29WrAqKilHb8NyYJO6VezPjxNV5nG3vLZWVbld
         yqVffHgwNfq4FYNJedL5cGbtfhdbBiFLXl+JvZkIxEWueD/fZfNE6oQPhLHw0mvJI2q2
         vbK5RID98rgPz+yqFV1XAxw5aPtuNLQngPIy0T5dfm8K2nfyJDYneV+r+m+FMfngiyGx
         KeHiWl3WHYuI5OXmr6ciUMqQrSy8uNIFE/Q62CxPe9YfNgdj40XKxKIXw5lLNfxQ5S1M
         2/GpA+AB701c9+pO6fAIUsFoFjg6cnP/G86Q4u80hMoTar1ynuKPWJ3m0sH6+EzqiDP+
         vRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=nrUwWEHtkuETZV80esS2kI6jyeXCjRYa+pWFfOnoHMQ=;
        b=ArBthpM4Instz0E3ssnlFrCS2o7HbaMXM2SkURG4JpMI1PjQlFO3abFxke+t+gJUj/
         swfVowGlQrDdXgnP0aAC+iNsmj+8wc13Iykp54OkSAmrJ+HiB5gYIIxmTSLQAFe8Ni+Y
         ltfeRfdHoEPgh8xgJUJBspK1lmunJvrHCUFUWijdXD1O3KMAIE5DMVOh+jDQoWL4Ajiy
         oonMp2nrTt7wI2hyg0lZfEamwcdgW+iWsCu3oVGc0rEWO9RYaK3UT1OJzNMRX49P2MYN
         3/Mk/EBncLYgdj4ayVeHJzp2nBq+EAoWUOy99XZ+qmy1zsT5cpvyAwt8/VVEwru+kSAB
         glYw==
X-Gm-Message-State: AOAM533xrnAasxVfBK2AG4QWMzSYs8g81ltVODphfqcbB655iCFsCdpS
        F5vsU/Xt0n2HXOPJK1jHKvI=
X-Google-Smtp-Source: ABdhPJxRfLxqLOz33phCpwNdYguRGdgXK3/L0y68IbdhfSshfgLwTs0zd+mlms9zytO8fXrFr1w96Q==
X-Received: by 2002:a05:6214:2d4:: with SMTP id g20mr5345799qvu.23.1612999325965;
        Wed, 10 Feb 2021 15:22:05 -0800 (PST)
Received: from OpenSuse ([156.146.36.180])
        by smtp.gmail.com with ESMTPSA id x62sm2629181qkd.1.2021.02.10.15.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:22:05 -0800 (PST)
Date:   Thu, 11 Feb 2021 04:51:56 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     gregkh@linuxfoundation.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] doc: devicetree: bindings: usb:  Chnage descibe to
 describe in usbmisc-imx.txt
Message-ID: <YCRqlBxKwqdH0Z+q@OpenSuse>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Rob Herring <robh@kernel.org>, gregkh@linuxfoundation.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
References: <20210203153315.15170-1-unixbhaskar@gmail.com>
 <20210210225536.GA2968213@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p4xMcFQQKtUQrHm9"
Content-Disposition: inline
In-Reply-To: <20210210225536.GA2968213@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p4xMcFQQKtUQrHm9
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 16:55 Wed 10 Feb 2021, Rob Herring wrote:
>On Wed, Feb 03, 2021 at 09:03:15PM +0530, Bhaskar Chowdhury wrote:
>>
>
>Ironically, a typo in the subject. Will fix when applying.
>
My bad...thanks, Rob.

>> s/descibe/describe/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/usb/usbmisc-imx.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
>> index b353b9816487..b796836d2ce7 100644
>> --- a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
>> +++ b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
>> @@ -1,7 +1,7 @@
>>  * Freescale i.MX non-core registers
>>
>>  Required properties:
>> -- #index-cells: Cells used to descibe usb controller index. Should be <1>
>> +- #index-cells: Cells used to describe usb controller index. Should be <1>
>>  - compatible: Should be one of below:
>>  	"fsl,imx6q-usbmisc" for imx6q
>>  	"fsl,vf610-usbmisc" for Vybrid vf610
>> --
>> 2.26.2
>>

--p4xMcFQQKtUQrHm9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmAkapAACgkQsjqdtxFL
KRUOIwgAh5jPY2t3CnUWX5nywlWkDOMsJa1xJXQfgAPwP4m+HmC9NI2WE6DF0JlW
pf3G72cGE4JH4qxBuKRSJHHSjKAyUMTBFsIpxjMKg4EPEuaDNsMhaVYku82VBrE2
s8mP+gUlrX3S1F1jpG6KrYe90Ep/Ra0uwg0gZerKaSvJzep7hKe1D0K8CN+TdEE0
MBbDcpwRFFtPs6axb3VYLP+Sl86d2XJovFbFEyFMg6n604F3hP7FbTi7ePEYTHKe
PjhaZcmI384jJE0LHMoa+LJ2xUacCmysY/j5QC+85Vp1OQE5Eq2ZRChpeGmeOCBQ
lUe9qXWBHsM9YKeUz/Tlv/TC6FpNgQ==
=WBnP
-----END PGP SIGNATURE-----

--p4xMcFQQKtUQrHm9--
