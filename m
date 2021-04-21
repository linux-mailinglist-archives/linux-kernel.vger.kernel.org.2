Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155483663E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 05:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhDUDKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 23:10:50 -0400
Received: from smtp37.cstnet.cn ([159.226.251.37]:46506 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233982AbhDUDKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 23:10:49 -0400
Received: by ajax-webmail-APP-12 (Coremail) ; Wed, 21 Apr 2021 11:08:27
 +0800 (GMT+08:00)
X-Originating-IP: [121.232.27.162]
Date:   Wed, 21 Apr 2021 11:08:27 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?546L5L+K5by6?= <wangjunqiang@iscas.ac.cn>
To:     "Randy Dunlap" <rdunlap@infradead.org>
Cc:     guoren@kernel.org, guoren@linux.alibaba.com,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Li Weiwei" <liweiwei@iscas.ac.cn>
Subject: Re: Re: [PATCH 2/2] csky: add CONFIG_CPU_HAS_MATHEMU and use in
 traps
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2021 www.mailtech.cn cnic.cn
In-Reply-To: <8bb2a70f-7f3a-26f1-98ed-e6b7b2220798@infradead.org>
References: <20210421024916.13603-1-wangjunqiang@iscas.ac.cn>
 <8bb2a70f-7f3a-26f1-98ed-e6b7b2220798@infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <152262a1.2e207.178f2668250.Coremail.wangjunqiang@iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: tgCowAC35VQrl39gObwCAA--.35080W
X-CM-SenderInfo: pzdqwy5xqtxt1qj6x2xfdvhtffof0/1tbiCwoSAFz4kATtrAAAsi
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dGhhbmtzLCBJIHdpbGwgZml4IGl0CgoiUmFuZHkgRHVubGFwIiAmbHQ7cmR1bmxhcEBpbmZyYWRl
YWQub3JnJmd0O+WGmemBk++8mgomZ3Q7IEhpLS0KJmd0OyAKJmd0OyBPbiA0LzIwLzIxIDc6NDkg
UE0sIFdhbmcgSnVucWlhbmcgd3JvdGU6CiZndDsgJmd0OyBkaWZmIC0tZ2l0IGEvYXJjaC9jc2t5
L0tjb25maWcgYi9hcmNoL2Nza3kvS2NvbmZpZwomZ3Q7ICZndDsgaW5kZXggMzRlOTEyMjRhZGMz
Li5hNDE0MjI1NTcwYzEgMTAwNjQ0CiZndDsgJmd0OyAtLS0gYS9hcmNoL2Nza3kvS2NvbmZpZwom
Z3Q7ICZndDsgKysrIGIvYXJjaC9jc2t5L0tjb25maWcKJmd0OyAmZ3Q7IEBAIC05Nyw2ICs5Nyw5
IEBAIGNvbmZpZyBDUFVfSEFTX0NBQ0hFVjIKJmd0OyAmZ3Q7ICBjb25maWcgQ1BVX0hBU19GUFVW
MgomZ3Q7ICZndDsgIAlib29sCiZndDsgJmd0OyAgCiZndDsgJmd0OyArY29uZmlnIENQVV9IQVNf
TUFUSEVNVQomZ3Q7ICZndDsgKwlib29sCiZndDsgJmd0OyArCiZndDsgCiZndDsgV2h5IGRvIHlv
dSBoYXZlIHRoaXMgbmV3IGtjb25maWcgc3ltYm9sIHR3byB0aW1lcyBpbiB0aGUgc2FtZSBmaWxl
PwomZ3Q7IAomZ3Q7ICZndDsgIGNvbmZpZyBDUFVfSEFTX0hJTE8KJmd0OyAmZ3Q7ICAJYm9vbAom
Z3Q7ICZndDsgIAomZ3Q7ICZndDsgQEAgLTI4MSw2ICsyODQsMTEgQEAgY29uZmlnIENQVV9IQVNf
VkRTUAomZ3Q7ICZndDsgIAlib29sICJDUFUgaGFzIFZEU1AgY29wcm9jZXNzb3IiCiZndDsgJmd0
OyAgCWRlcGVuZHMgb24gQ1BVX0hBU19GUFUgJmFtcDsmYW1wOyBDUFVfSEFTX0ZQVVYyCiZndDsg
Jmd0OyAgCiZndDsgJmd0OyArY29uZmlnIENQVV9IQVNfTUFUSEVNVQomZ3Q7ICZndDsgKwlib29s
ICJDUFUgaGFzIEZQVSBNYXRoZW11IEluc3RydWN0aW9ucyIKJmd0OyAmZ3Q7ICsJZGVwZW5kcyBv
biBDUFVfQ0s4MTAgfHwgQ1BVX0NLODYwCiZndDsgJmd0OyArCWRlZmF1bHQgbgomZ3Q7ICZndDsg
KwomZ3Q7ICZndDsgIGNvbmZpZyBDUFVfSEFTX0ZQVQomZ3Q7ICZndDsgIAlib29sICJDUFUgaGFz
IEZQVSBjb3Byb2Nlc3NvciIKJmd0OyAmZ3Q7ICAJZGVwZW5kcyBvbiBDUFVfQ0s4MDcgfHwgQ1BV
X0NLODEwIHx8IENQVV9DSzg2MAomZ3Q7IAomZ3Q7IAomZ3Q7IHRoYW5rcy4KJmd0OyAtLSAKJmd0
OyB+UmFuZHkK
