Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C70734EA27
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhC3OTP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 Mar 2021 10:19:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:26658 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231579AbhC3OTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:19:07 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-95-E6F1qpSaM4ySxvE-6DYFTg-1; Tue, 30 Mar 2021 15:19:03 +0100
X-MC-Unique: E6F1qpSaM4ySxvE-6DYFTg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 30 Mar 2021 15:19:02 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Tue, 30 Mar 2021 15:19:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'richard.gong@linux.intel.com'" <richard.gong@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Gong <richard.gong@intel.com>
Subject: RE: [PATCH] firmware: stratix10-svc: extend SVC driver to get the
 firmware version
Thread-Topic: [PATCH] firmware: stratix10-svc: extend SVC driver to get the
 firmware version
Thread-Index: AQHXJW8QJprlVYn+I0GTi16JBVOwMqqck+Gw
Date:   Tue, 30 Mar 2021 14:19:02 +0000
Message-ID: <26176a0062114b9faa7c2c64c8ea3e64@AcuMS.aculab.com>
References: <1617114785-22211-1-git-send-email-richard.gong@linux.intel.com>
 <1617114785-22211-2-git-send-email-richard.gong@linux.intel.com>
In-Reply-To: <1617114785-22211-2-git-send-email-richard.gong@linux.intel.com>
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

From: richard.gong@linux.intel.com
> Sent: 30 March 2021 15:33
> 
> Extend Intel service layer driver to get the firmware version running at
> FPGA device. Therefore FPGA manager driver, one of Intel service layer
> driver's client, can decide whether to handle the newly added bitstream
> authentication function based on the retrieved firmware version.

Using the version number to detect features is just plain wrong.

You should use something like a bitmap of supported features.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

