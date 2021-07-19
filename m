Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E766C3CCD44
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 07:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhGSFSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 01:18:04 -0400
Received: from mx20.baidu.com ([111.202.115.85]:54844 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229512AbhGSFSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 01:18:02 -0400
Received: from BJHW-Mail-Ex08.internal.baidu.com (unknown [10.127.64.18])
        by Forcepoint Email with ESMTPS id 5AE66E362F1524674B1A;
        Mon, 19 Jul 2021 13:14:56 +0800 (CST)
Received: from BJHW-MAIL-EX25.internal.baidu.com (10.127.64.40) by
 BJHW-Mail-Ex08.internal.baidu.com (10.127.64.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 19 Jul 2021 13:14:56 +0800
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-MAIL-EX25.internal.baidu.com (10.127.64.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 19 Jul 2021 13:14:55 +0800
Received: from BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) by
 BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) with mapi id
 15.01.2308.014; Mon, 19 Jul 2021 13:14:55 +0800
From:   "Cai,Huoqing" <caihuoqing@baidu.com>
To:     "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] virtio_ring: fix error - unknown type name
 'spinlock_t'
Thread-Topic: [PATCH 1/2] virtio_ring: fix error - unknown type name
 'spinlock_t'
Thread-Index: AQHXeFgEtZ7bhfAxVUC3N/ftcHawDatJyDiQ
Date:   Mon, 19 Jul 2021 05:14:55 +0000
Message-ID: <c25458bf5b2c46c390afb4851836f7dc@baidu.com>
References: <20210714022854.1077-1-caihuoqing@baidu.com>
 <20210714022854.1077-2-caihuoqing@baidu.com>
In-Reply-To: <20210714022854.1077-2-caihuoqing@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.18.18.49]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex08_2021-07-19 13:14:56:368
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SXMgaXQgYSBlcnJvciwgIHRyeSChsG1ha2UgdmlydGlvobEgaW4gdGhlIHBhdGggb2YgbGludXgv
dG9vbHMvIHdpdGggY29uZmlnIFZIT1NUX0lPVExCPW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IENhaSxIdW9xaW5nIDxjYWlodW9xaW5nQGJhaWR1LmNvbT4gDQpTZW50OiAy
MDIxxOo31MIxNMjVIDEwOjI5DQpUbzogc2dhcnphcmVAcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5j
b207IGphc293YW5nQHJlZGhhdC5jb20NCkNjOiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQ2FpLEh1b3Fpbmcg
PGNhaWh1b3FpbmdAYmFpZHUuY29tPg0KU3ViamVjdDogW1BBVENIIDEvMl0gdmlydGlvX3Jpbmc6
IGZpeCBlcnJvciAtIHVua25vd24gdHlwZSBuYW1lICdzcGlubG9ja190Jw0KDQp3aGVuIHJ1biAi
bWFrZSB2aXJ0aW8iIGluIGxpbnV4L3Rvb2xzLA0KdGhlIGVycm9yOiB1bmtub3duIHR5cGUgbmFt
ZSAnc3BpbmxvY2tfdCcgb2NjdXJzDQoNClNpZ25lZC1vZmYtYnk6IENhaSBIdW9xaW5nIDxjYWlo
dW9xaW5nQGJhaWR1LmNvbT4NCi0tLQ0KIGluY2x1ZGUvbGludXgvdnJpbmdoLmggfCAyICsrDQog
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC92cmluZ2guaCBiL2luY2x1ZGUvbGludXgvdnJpbmdoLmggaW5kZXggODRkYjdiOGY5MTJm
Li5mZjIxYzI2NDM3OTIgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3ZyaW5naC5oDQorKysg
Yi9pbmNsdWRlL2xpbnV4L3ZyaW5naC5oDQpAQCAtNDMsMTEgKzQzLDEzIEBAIHN0cnVjdCB2cmlu
Z2ggew0KICAgICAgICAvKiBUaGUgdnJpbmcgKG5vdGU6IGl0IG1heSBjb250YWluIHVzZXIgcG9p
bnRlcnMhKSAqLw0KICAgICAgICBzdHJ1Y3QgdnJpbmcgdnJpbmc7DQoNCisjaWYgSVNfUkVBQ0hB
QkxFKENPTkZJR19WSE9TVF9JT1RMQikNCiAgICAgICAgLyogSU9UTEIgZm9yIHRoaXMgdnJpbmcg
Ki8NCiAgICAgICAgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYjsNCg0KICAgICAgICAvKiBzcGlu
bG9jayB0byBzeW5jaHJvbml6ZSBJT1RMQiBhY2Nlc3NlcyAqLw0KICAgICAgICBzcGlubG9ja190
ICppb3RsYl9sb2NrOw0KKyNlbmRpZg0KDQogICAgICAgIC8qIFRoZSBmdW5jdGlvbiB0byBjYWxs
IHRvIG5vdGlmeSB0aGUgZ3Vlc3QgYWJvdXQgYWRkZWQgYnVmZmVycyAqLw0KICAgICAgICB2b2lk
ICgqbm90aWZ5KShzdHJ1Y3QgdnJpbmdoICopOw0KLS0NCjIuMjUuMQ0KDQo=
