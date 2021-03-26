Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4E234A843
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 14:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhCZNjw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 Mar 2021 09:39:52 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:43790 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230153AbhCZNj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 09:39:29 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-142-9bIiFNUNNmm70U8_vh6zgQ-1; Fri, 26 Mar 2021 13:39:25 +0000
X-MC-Unique: 9bIiFNUNNmm70U8_vh6zgQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 26 Mar 2021 13:39:24 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Fri, 26 Mar 2021 13:39:24 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Fabio Aiuto' <fabioaiuto83@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 14/15] staging: rtl8723bs:  put parentheses on macros with
 complex values in include/sta_info.h
Thread-Topic: [PATCH 14/15] staging: rtl8723bs:  put parentheses on macros
 with complex values in include/sta_info.h
Thread-Index: AQHXIh/zAuJ0NeHvkECgXPo7PrRwXqqWRkAA
Date:   Fri, 26 Mar 2021 13:39:24 +0000
Message-ID: <0466586ada4d4804bca4e84aa5908c01@AcuMS.aculab.com>
References: <cover.1616748885.git.fabioaiuto83@gmail.com>
 <24e684c1eff8911dacff1b61957ce25bafc46631.1616748885.git.fabioaiuto83@gmail.com>
In-Reply-To: <24e684c1eff8911dacff1b61957ce25bafc46631.1616748885.git.fabioaiuto83@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Aiuto 
> Sent: 26 March 2021 09:09
> 
> fix the following checkpatch warnings:
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> 284: FILE: drivers/staging/rtl8723bs/include/sta_info.h:284:
> +#define STA_RX_PKTS_ARG(sta) \
> --
> ERROR: Macros with complex values should be enclosed in parentheses
> 289: FILE: drivers/staging/rtl8723bs/include/sta_info.h:289:
> +#define STA_LAST_RX_PKTS_ARG(sta) \
> --
> ERROR: Macros with complex values should be enclosed in parentheses
> 294: FILE: drivers/staging/rtl8723bs/include/sta_info.h:294:
> +#define STA_RX_PKTS_DIFF_ARG(sta) \
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/include/sta_info.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/sta_info.h
> b/drivers/staging/rtl8723bs/include/sta_info.h
> index abde3e3df988..1cdf93ec3b66 100644
> --- a/drivers/staging/rtl8723bs/include/sta_info.h
> +++ b/drivers/staging/rtl8723bs/include/sta_info.h
> @@ -282,19 +282,19 @@ struct sta_info {
>  	} while (0)
> 
>  #define STA_RX_PKTS_ARG(sta) \
> -	sta->sta_stats.rx_mgnt_pkts \
> +	(sta->sta_stats.rx_mgnt_pkts \
>  	, sta->sta_stats.rx_ctrl_pkts \
> -	, sta->sta_stats.rx_data_pkts
> +	, sta->sta_stats.rx_data_pkts)

That doesn't look right at all.
You've changed what is (probably) a list of arguments to a function
into a comma operator list.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

