Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039D53C7F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 09:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbhGNHrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 03:47:16 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:34362 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238139AbhGNHrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 03:47:14 -0400
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Jul 2021 03:47:14 EDT
Received: by ajax-webmail-APP-10 (Coremail) ; Wed, 14 Jul 2021 15:35:36
 +0800 (GMT+08:00)
X-Originating-IP: [106.120.127.5]
Date:   Wed, 14 Jul 2021 15:35:36 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
To:     "yong w" <yongw.pur@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, nico@fluxnic.net, wang.yong12@zte.com.cn
Subject: Re: Re: [BUG] ramfs system panic when using dd to create files
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2021 www.mailtech.cn cnic.cn
In-Reply-To: <CAOH5QeC0PhnZY6Cpe4zZ8o07XHA4-5B3xGEontkezrYu=Jt0VQ@mail.gmail.com>
References: <CAOH5QeChR8s6vENfRdGtUeeqKsSSbeFkY9TArmOyDcUvgAgU7Q@mail.gmail.com>
 <CAOH5QeC0PhnZY6Cpe4zZ8o07XHA4-5B3xGEontkezrYu=Jt0VQ@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7074179d.c3fd.17aa3f148cc.Coremail.wuzhouhui14@mails.ucas.ac.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: tACowACHE_DKk+5g1tYAAA--.5115W
X-CM-SenderInfo: xzx2x05xkxxi2u6ptx1ovo3u1dvotugofq/1tbiCQcCAV02aWP1xg
        ABse
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUCw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jmd0OyAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KJmd0OyBGcm9tOiAieW9uZyB3IiA8eW9u
Z3cucHVyQGdtYWlsLmNvbT4KJmd0OyBTZW50IFRpbWU6IDIwMjEtMDctMTQgMDg6MjQ6MjMgKFdl
ZG5lc2RheSkKJmd0OyBUbzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywgbGludXgtbW1A
a3ZhY2sub3JnLCBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnLCBuaWNvQGZsdXhuaWMubmV0LCB3
YW5nLnlvbmcxMkB6dGUuY29tLmNuCiZndDsgQ2M6IAomZ3Q7IFN1YmplY3Q6IFJlOiBbQlVHXSBy
YW1mcyBzeXN0ZW0gcGFuaWMgd2hlbiB1c2luZyBkZCB0byBjcmVhdGUgZmlsZXMKJmd0OyAKJmd0
OyBIZWxsbywgaXMgdGhlcmUgYW55IHNvbHV0aW9uLCBvciBob3cgdG8gYXZvaWQgdGhpcyBwcm9i
bGVtIHdoZW4gdXNpbmcgcmFtZnM/CgpMaW1pdCBtYXggc2l6ZSBvZiByYW1mcy4KCiZndDsgCiZn
dDsgeW9uZyB3IDx5b25ndy5wdXJAZ21haWwuY29tPiDkuo4yMDIx5bm0N+aciDfml6XlkajkuIkg
5LiL5Y2INTo1OOWGmemBk++8mgomZ3Q7ICZndDsKJmd0OyAmZ3Q7IFdoZW4gSSAgdXNlIGRkIHRv
IGNyZWF0ZSBmaWxlcyBtdWx0aXBsZSB0aW1lcyB1bmRlciB0aGUgcmFtZnMgZmlsZQomZ3Q7ICZn
dDsgc3lzdGVt77yMUGFuaWMgYXBwZWFycywgaW5kaWNhdGluZyB0aGF0IHRoZXJlIGlzIG5vIHBy
b2Nlc3MgdG8ga2lsbC4KJmd0OyAmZ3Q7IEkgbGVhcm4gdGhhdCByYW1mcyB3aWxsIGF1dG9tYXRp
Y2FsbHkgZ3JvdyBzcGFjZSBkdWUgdG8gZGF0YSB3cml0aW5nLAomZ3Q7ICZndDsgY2F1c2luZyBh
bGwgdGhlIHN5c3RlbSBtZW1vcnkgdG8gcnVuIG91dCwgIGJ1dCBpIHRoaW5rIGl0IHNob3VsZG4n
dAomZ3Q7ICZndDsgY2F1c2UgdGhlIHN5c3RlbSB0byBwYW5pYy4KClRoZSBjb21tZW50cyBhbHJl
YWR5IGV4cGxhaW5zIHdoeSBrZXJuZWwgc2hvdWxkIHBhbmljIG9uIHRoaXMgc2l0dWF0aW9uOgog
ICAgICAgICAgICAvKgogICAgICAgICAgICAgKiBJZiB3ZSBnb3QgaGVyZSBkdWUgdG8gYW4gYWN0
dWFsIGFsbG9jYXRpb24gYXQgdGhlCiAgICAgICAgICAgICAqIHN5c3RlbSBsZXZlbCwgd2UgY2Fu
bm90IHN1cnZpdmUgdGhpcyBhbmQgd2lsbCBlbnRlcgogICAgICAgICAgICAgKiBhbiBlbmRsZXNz
IGxvb3AgaW4gdGhlIGFsbG9jYXRvci4gQmFpbCBvdXQgbm93LgogICAgICAgICAgICAgKi8KPC95
b25ndy5wdXJAZ21haWwuY29tPjwveW9uZ3cucHVyQGdtYWlsLmNvbT4=
