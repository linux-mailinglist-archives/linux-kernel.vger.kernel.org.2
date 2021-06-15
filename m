Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DC23A7903
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 10:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFOI3q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Jun 2021 04:29:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:31534 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230190AbhFOI3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:29:45 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-272-IOhnSOrBMBO3j2cHIO6oBQ-1; Tue, 15 Jun 2021 09:27:39 +0100
X-MC-Unique: IOhnSOrBMBO3j2cHIO6oBQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Jun
 2021 09:27:38 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Tue, 15 Jun 2021 09:27:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Oded Gabbay' <ogabbay@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Koby Elbaz <kelbaz@habana.ai>
Subject: RE: [PATCH 2/9] habanalabs: zero complex structures using memset
Thread-Topic: [PATCH 2/9] habanalabs: zero complex structures using memset
Thread-Index: AQHXYRwQZE/ZQ83R6029wR0YI8AD3KsUvd1A
Date:   Tue, 15 Jun 2021 08:27:38 +0000
Message-ID: <0ad1aa7cc1504b759f997028c80a6bd6@AcuMS.aculab.com>
References: <20210614125100.17627-1-ogabbay@kernel.org>
 <20210614125100.17627-2-ogabbay@kernel.org>
In-Reply-To: <20210614125100.17627-2-ogabbay@kernel.org>
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

From: Oded Gabbay
> Sent: 14 June 2021 13:51
> 
> From: Koby Elbaz <kelbaz@habana.ai>
> 
> fix the following sparse warnings:
> 'warning: Using plain integer as NULL pointer'
> 'warning: missing braces around initializer'

Sparse is being over-enthusiastic.

...
> diff --git a/drivers/misc/habanalabs/common/firmware_if.c
> b/drivers/misc/habanalabs/common/firmware_if.c
> index 14e70422af25..d5d0db7fd6ef 100644
> --- a/drivers/misc/habanalabs/common/firmware_if.c
> +++ b/drivers/misc/habanalabs/common/firmware_if.c
> @@ -392,10 +392,11 @@ void hl_fw_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
> 
>  int hl_fw_send_heartbeat(struct hl_device *hdev)
>  {
> -	struct cpucp_packet hb_pkt = {0};
> +	struct cpucp_packet hb_pkt;

Try just deleting the 0?
I think modern compilers allow {}.

	David

>  	u64 result;
>  	int rc;
> 
> +	memset(&hb_pkt, 0, sizeof(hb_pkt));
>  	hb_pkt.ctl = cpu_to_le32(CPUCP_PACKET_TEST <<
>  					CPUCP_PKT_CTL_OPCODE_SHIFT);
>  	hb_pkt.value = cpu_to_le64(CPUCP_PACKET_FENCE_VAL);
> --
> 2.25.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

