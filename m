Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640DF44BBD2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 07:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhKJGxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 01:53:21 -0500
Received: from mail.vivotek.com ([60.248.39.150]:38226 "EHLO mail.vivotek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhKJGxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 01:53:17 -0500
X-Greylist: delayed 663 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Nov 2021 01:53:16 EST
Received: from pps.filterd (vivotekpps.vivotek.com [127.0.0.1])
        by vivotekpps.vivotek.com (8.16.1.2/8.16.1.2) with SMTP id 1AA6aKmY010916;
        Wed, 10 Nov 2021 14:39:11 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivotek.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=dkim; bh=6UXrSK6DnaxPssGCNRIHJgNanNZxSwhTiocjCJmV730=;
 b=ZWNPX9OTsBV1V6aqRReq/Ww9hYbzh9UqNxLIrFXzbYReWhsh7YfyrlmwO8zEJnwl0olu
 vNBKuQATBGtHf9HAJKJ1HXgT4FK3weI4xZ6abh6YWEKwmLiQg7PVfsXnKlgNQKXPHjzY
 jmGhKVQgmPRqeEiVUw5yRmeLP6EQIqFIgao= 
Received: from cas02.vivotek.tw ([192.168.0.59])
        by vivotekpps.vivotek.com with ESMTP id 3c87khr2s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 14:39:11 +0800
Received: from MBS07.vivotek.tw ([fe80::2027:4d67:6c01:78d8]) by
 CAS02.vivotek.tw ([::1]) with mapi id 14.03.0513.000; Wed, 10 Nov 2021
 14:39:10 +0800
From:   <Michael.Wu@vatics.com>
To:     <apw@canonical.com>, <joe@perches.com>
CC:     <dwaipayanray1@gmail.com>, <lukas.bulwahn@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: checkpatch warns a symbolic link has not a newline
Thread-Topic: checkpatch warns a symbolic link has not a newline
Thread-Index: AdfV/ap0o7FQpZ4YSCGIdlNiqjhb1g==
Date:   Wed, 10 Nov 2021 06:39:09 +0000
Message-ID: <5DB475451BAA174CB158B5E897FC1525D8B30486@MBS07.vivotek.tw>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.17.134]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-GUID: k2j8tccEQNJY32S9XTQdYH7_j8vcgdER
X-Proofpoint-ORIG-GUID: k2j8tccEQNJY32S9XTQdYH7_j8vcgdER
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-11-10_02:2021-11-08,2021-11-10 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSAmIEpvZSwNCg0KSSBoYXZlIGEgY29tbWl0IHRoYXQgY29udGFpbnMgYSBuZXdseSBj
cmVhdGVkIHN5bWJvbGljIGxpbmsgcG9pbnRpbmcgdG8gYSBjZXJ0YWluIGZpbGUuIEkgdXNlZCAu
L3NjcmlwdHMvY2hlY2twYXRjaC5wbCB0byBjaGVjayB0aGlzIGNvbW1pdCBhbmQgdGhlbiBJIGdv
dCBhIFdBUk5JTkc6IGFkZGluZyBhIGxpbmUgd2l0aG91dCBuZXdsaW5lIGF0IGVuZCBvZiBmaWxl
LiBUaGUgc3ltYm9saWMgbGluayB3YXMgY3JlYXRlZCBieSBsbiAtcy4NCg0KSSdtIGNvbmZ1c2Vk
IHdoeSBpdCByZXR1cm5lZCBzdWNoIGEgd2FybmluZy4gSXMgdGhlIGNvbnRlbnQgb2YgdGhlIHBh
dGNoIG5vdCBhbGxvd2VkIHRvIGNvbnRhaW4gc3ltYm9saWMgbGlua3M/IElmIGl0IGlzIGFsbG93
ZWQsIEkgdGhpbmsgY2hlY2twYXRjaC5wbCBjYW4gbWFrZSBzb21lIGltcHJvdmVtZW50cywgc28g
dGhhdCBzeW1ib2xpYyBsaW5rcyB3aWxsIG5vdCBiZSB0cmVhdGVkIGEgd2FybmluZ3MgYmVjYXVz
ZSBvZiBtaXNzaW5nIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUuDQoNCkJlc3QgUmVnYXJkcywNCk1p
Y2hhZWwgV3UNCg==
