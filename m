Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BAD3B5A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 10:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhF1I0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 04:26:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:35082 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232308AbhF1I0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 04:26:43 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-89-FswThSeuNS-iTkJMwVP7Ow-1; Mon, 28 Jun 2021 09:24:16 +0100
X-MC-Unique: FswThSeuNS-iTkJMwVP7Ow-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 28 Jun
 2021 09:24:15 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Mon, 28 Jun 2021 09:24:15 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Chen, Rong A'" <rong.a.chen@intel.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        kernel test robot <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [kbuild-all] Re: net/ceph/messenger_v2.c:2808:5: warning: stack
 frame size (2336) exceeds limit (2048) in function 'ceph_con_v2_try_read'
Thread-Topic: [kbuild-all] Re: net/ceph/messenger_v2.c:2808:5: warning: stack
 frame size (2336) exceeds limit (2048) in function 'ceph_con_v2_try_read'
Thread-Index: AQHXa/RueJm4ArZTY06Bo3hjOSis8KspFAQw
Date:   Mon, 28 Jun 2021 08:24:15 +0000
Message-ID: <3d6a513b51d545cc87a7a0ae22452567@AcuMS.aculab.com>
References: <202106280955.VUsBSyHq-lkp@intel.com>
 <CAOi1vP-FR2PpqdW4WuhJaaFPZifxthf0B45dV03v00ef66R8wg@mail.gmail.com>
 <a875976b-3117-f001-606b-8e90802bef8a@intel.com>
In-Reply-To: <a875976b-3117-f001-606b-8e90802bef8a@intel.com>
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
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li4uDQo+ID4+ICAgICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vaW8tZGVmcy5oOjQzOjE6IHdh
cm5pbmc6IHBlcmZvcm1pbmcgcG9pbnRlciBhcml0aG1ldGljIG9uIGEgbnVsbA0KPiBwb2ludGVy
IGhhcyB1bmRlZmluZWQgYmVoYXZpb3IgWy1XbnVsbC1wb2ludGVyLWFyaXRobWV0aWNdDQoNCkkn
dmUganVzdCByZWFsaXNlZCB3aHkgdGhhdCBlcnJvciBpcyBvdXRwdXQuDQpUaGUgcmVzdWx0IG9m
IChsb25nKSgoY2hhciAqKTAgKyA0KSBpcyBvbmx5IDQgaWYgdGhlIE5VTEwgcG9pbnRlcg0KaGFz
IHRoZSAnYWxsLXplcm8nIGJpdCBwYXR0ZXJuLg0KVGhpcyBpc24ndCBtYW5kYXRlZCBieSB0aGUg
bGFuZ3VhZ2UuDQoNCkhvd2V2ZXIgSSBzdXNwZWN0IGFsbW9zdCBldmVyeSBpbXBsZW1lbnRhdGlv
biBvZiBDIHRoZXJlIGhhcyBldmVyDQpiZWVuIGhhcyB1c2VkIHRoZSBhbGwtemVybyBiaXQgcGF0
dGVybiBmb3IgTlVMTC4NClRoaXMgaW5jbHVkZXMgb25lIHN5c3RlbSBJIHVzZWQgKG1hbnkgeWVh
cnMgYWdvKSB3aGVyZSB0aGUgJ25hdHVyYWwnDQpOVUxMIHBvaW50ZXIgd291bGQgaGF2ZSBiZWVu
IHRoZSBhbGwtb25lcyBwYXR0ZXJuLg0KDQpGYXIgdG9vIG11Y2ggY29kZSBhc3N1bWVzIG1lbXNl
dChwdHIsIDAsIGxlbikgd2lsbCBzZXQgcG9pbnRlcnMNCnRvIE5VTEwgZm9yIGFueSBvdGhlciB2
YWx1ZSB0byBldmVyIHdvcmsuDQoNCk9mIGNvdXJzZSAndW5kZWZpbmVkIGJlaGF2aW91cicgZG9l
c24ndCBtZWFuICd1bmRlZmluZWQgdmFsdWUnDQppdCBpbmNsdWRlcyBmaXJpbmcgYSBJQ0JNIGF0
IHRoZSBjb2RlcidzIGhvdXNlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExh
a2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQs
IFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

