Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1723F77CE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241882AbhHYOxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:53:46 -0400
Received: from m13153.mail.163.com ([220.181.13.153]:14451 "EHLO
        m13153.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241873AbhHYOxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:53:44 -0400
X-Greylist: delayed 914 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Aug 2021 10:53:43 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=aEdnm
        Q2XKRbyf+UVdYL1Swp9HKEwTMTQQk3fBsu3y6Q=; b=Re5xfPIeJE6WSA4DPnvHX
        zWe8zCCXs/ytE8UU6jtTooCP3FplB12JKwOA3Io8eMWf5clLVUC9KdWQrhALpu4e
        YsV5tRwWdVmOPPk3hhHelGs59gAMDn25ciGPiycGyLC3XPnwzLgxKGzRBWKePrDQ
        DZH609y608UOwj3kGmbsZ4=
Received: from junhuahuangdream$163.com ( [183.220.92.18] ) by
 ajax-webmail-wmsvr153 (Coremail) ; Wed, 25 Aug 2021 22:37:29 +0800 (CST)
X-Originating-IP: [183.220.92.18]
Date:   Wed, 25 Aug 2021 22:37:29 +0800 (CST)
From:   =?GBK?B?u8a+/Luq?= <junhuahuangdream@163.com>
To:     "teng sterling" <sterlingteng@gmail.com>
Cc:     "Alex Shi" <alexs@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
        "Wu X.C." <bobwxc@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Junhua Huang" <huang.junhua@zte.com.cn>,
        "Yanteng Si" <siyanteng@loongson.cn>
Subject: Re:Re: [PATCH v2] docs/zh_CN: Add zh_CN/admin-guide/sysrq.rst
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
In-Reply-To: <CAMU9jJq-z0qkX=-60zFqyP=YdUFyqY8WJWTWZZyPdREBB-uD5Q@mail.gmail.com>
References: <20210822143204.224282-1-junhuahuangdream@163.com>
 <CAMU9jJq-z0qkX=-60zFqyP=YdUFyqY8WJWTWZZyPdREBB-uD5Q@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <51b6f421.6a57.17b7dbe9c89.Coremail.junhuahuangdream@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: mcGowADX+5ipVSZhbuYSAQ--.14997W
X-CM-SenderInfo: xmxqx3pdkxt05jguvtrp6rljoofrz/1tbiTgD5ZVUDLjMyDwABsl
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ckhpo6xZYW50ZW5nCgpUaGFuayB5b3UgIGZvciBwb2ludGluZyBteSBwcm9ibGVtcy4gSSB3aWxs
IGZpeCBpdCBpbiB2My4KCgrU2iAyMDIxLTA4LTI0IDE1OjQ4OjAwo6widGVuZyBzdGVybGluZyIg
PHN0ZXJsaW5ndGVuZ0BnbWFpbC5jb20+INC0tcCjugo+SnVuaHVhIEh1YW5nIDxqdW5odWFodWFu
Z2RyZWFtQDE2My5jb20+INPaMjAyMcTqONTCMjLI1dbcyNUgz8LO5zEwOjMz0LS1wKO6Cj4+Cj4+
IEZyb206IEp1bmh1YSBIdWFuZyA8aHVhbmcuanVuaHVhQHp0ZS5jb20uY24+Cj4+Cj4+IEFkZCB0
cmFuc2xhdGlvbiB6aF9DTi9hZG1pbi1ndWlkZS9zeXNycS5yc3QgYW5kIGxpbmsgaXQgdG8KPj4g
emhfQ04vYWRtaW4tZ3VpZGUvaW5kZXgucnN0IHdoaWxlIGNsZWFuIGl0cyB0b2RvIGVudHJ5Lgo+
Pgo+PiBSZXZpZXdlZC1ieTogWWFudGVuZyBTaSA8c2l5YW50ZW5nQGxvb25nc29uLmNuPgo+PiBT
aWduZWQtb2ZmLWJ5OiBKdW5odWEgSHVhbmcgPGh1YW5nLmp1bmh1YUB6dGUuY29tLmNuPgo+SGkg
SnVuaHVhOgo+Cj5Tb21lIHdhcm5pbmdzIHdlcmUgZ2VuZXJhdGVkIGR1cmluZyB0aGUgYnVpbGQg
cHJvY2VzcywgaWYgeW91IGNhbiBmaXggdGhlbToKT0ssIEkgd2lsbCBmaXggdGhlbS4KPgo+UmV2
aWV3ZWQtYnk6IFlhbnRlbmcgU2kgPHNpeWFudGVuZ0Bsb29uZ3Nvbi5jbj4KPgo+QlRXOgo+Cj4q
IEl0IGlzIGJlc3Qgbm90IHRvIHBpY2sgdGhlIFJldmlld2VkLWJ5IHRhZyB1bnRpbCB0aGUgcmV2
aWV3ZXIKPnZvbHVudGFyaWx5IHNpZ25zIGl0LgpteSBtaXN1bmRlcnN0YW5kaW5nIGZvciBpdC4K
Pgo+KiBQZXJmb3JtIGFkZXF1YXRlIHRlc3RpbmcgYmVmb3JlIHNlbmQgcGF0Y2hlcy4KPiAgICAg
YnVpbGQgaXQsIC0tLS0tLS0tPiBmaXggZXJyb3IgYW5kIHdhcm5pbmcuCj4gICAgIGNoZWNrcGF0
Y2gucGwgPHlvdXIgcGF0Y2g+LCAtLS0tLS0tLS0+IGZpeCBlcnJvciBhbmQgd2FybmluZy4KPj4g
LS0tCj4KPlRoYW5rcywKPgo+WWFudGVuZwoKVGhhbmtzLAoKSnVuaHVhCg==
