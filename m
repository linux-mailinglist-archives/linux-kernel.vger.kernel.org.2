Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598EB3CD004
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 11:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbhGSIYf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Jul 2021 04:24:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:51192 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236154AbhGSIYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:24:30 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-177-VQvrqKVeODiOEdc9VbXbMQ-1; Mon, 19 Jul 2021 09:49:54 +0100
X-MC-Unique: VQvrqKVeODiOEdc9VbXbMQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Mon, 19 Jul 2021 09:49:54 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Mon, 19 Jul 2021 09:49:54 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Len Baker' <len.baker@gmx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Dmitrii Wolf <dev.dragon@bk.ru>,
        "Iain Craig" <coldcity@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging/rtl8192u: Remove all strcpy() uses in favor of
 strscpy()
Thread-Topic: [PATCH] staging/rtl8192u: Remove all strcpy() uses in favor of
 strscpy()
Thread-Index: AQHXe8ibLc5KfSAIiUeCQQLqeIr8o6tJ/WEw
Date:   Mon, 19 Jul 2021 08:49:54 +0000
Message-ID: <ec6c9adc089849b5984b9273c38efd93@AcuMS.aculab.com>
References: <20210718113207.10045-1-len.baker@gmx.com>
In-Reply-To: <20210718113207.10045-1-len.baker@gmx.com>
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

From: Len Baker
> Sent: 18 July 2021 12:32
> 
> strcpy() performs no bounds checking on the destination buffer. This
> could result in linear overflows beyond the end of the buffer, leading
> to all kinds of misbehaviors. The safe replacement is strscpy().
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> index ab885353f668..1a193f900779 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> @@ -2226,7 +2226,8 @@ static void ieee80211_start_ibss_wq(struct work_struct *work)
>  	mutex_lock(&ieee->wx_mutex);
> 
>  	if (ieee->current_network.ssid_len == 0) {
> -		strcpy(ieee->current_network.ssid, IEEE80211_DEFAULT_TX_ESSID);
> +		strscpy(ieee->current_network.ssid, IEEE80211_DEFAULT_TX_ESSID,
> +			sizeof(ieee->current_network.ssid));

I'm pretty sure that recent compiler releases know enough
about strcpy() to error overflows for strcpy() from quoted
strings into char[].

If these checks are enabled for kernel builds then they are
actually safer than the run-time check above
(which can be mistyped).

The compiler can (it may not) convert the strcpy() into a memcpy()
using the compile-time length of the quoted string.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

