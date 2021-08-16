Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1023ED105
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 11:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbhHPJ1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 05:27:03 -0400
Received: from m13101.mail.163.com ([220.181.13.101]:50551 "EHLO
        m13101.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbhHPJ0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 05:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=MDvak
        gQxV72Y3rgrff4F8vOJ4Dkqtx9iU2nREQNf+Ng=; b=Zf/K19n0oyvh5czOBv748
        zsv26W1f2o5msI0VXXXaPBdbQ9emlxKO4CApD76TNGyi/91Bt0XUfWrAU2nKVrtH
        Jyp+uq5tbR5DUfSTwfUp2jk5YPAup9arSh6BuovnUx+RIoXzV3bCfZxTaZ3C7Vcn
        J+DK0qLLoAYxTfkMDJ9Pgk=
Received: from slark_xiao$163.com ( [223.104.68.87] ) by
 ajax-webmail-wmsvr101 (Coremail) ; Mon, 16 Aug 2021 17:25:20 +0800 (CST)
X-Originating-IP: [223.104.68.87]
Date:   Mon, 16 Aug 2021 17:25:20 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     "Reinhard Speyerer" <rspmn@arcor.de>, johan@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: Re: [PATCH] [V2,1/1]USB: serial: option: add Foxconn T77W175
 composition 0x901d
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
In-Reply-To: <YRot+wBa6v529Z7q@kroah.com>
References: <20210816035404.4210-1-slark_xiao@163.com>
 <YRoqAJmGBpV/OuZL@arcor.de>
 <d1d16fd.6f62.17b4e3ffa26.Coremail.slark_xiao@163.com>
 <YRot+wBa6v529Z7q@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <278bcd0d.7189.17b4e479a3a.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: ZcGowAB3f88ALxphkA6FAQ--.9640W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiNQXwZFrPc+jVkQACss
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjEtMDgtMTYgMTc6MjA6NTksICJHcmVnIEtIIiA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+T24gTW9uLCBBdWcgMTYsIDIwMjEgYXQgMDU6
MTc6MDBQTSArMDgwMCwgU2xhcmsgWGlhbyB3cm90ZToKPj4gICBTbyBzaG91bGQgSSB1c2UgVVNC
X0RFVklDRV9JTlRFUkZBQ0VfTlVNQkVSKFFVQUxDT01NX1ZFTkRPUl9JRCwgMHg5MDFkLCAweDAw
KSB0byBiaW5kIERpYWcgcG9ydCBvbmx5Pwo+Cj5XaHkgaXMgdGhpcyBkZXZpY2UgdXNpbmcgdGhl
IFFVQUxDT01NIHZlbmRvciBpZCBhbnl3YXk/ICBJcyB0aGlzIGFsbG93ZWQKPmJ5IFF1YWxjb21t
Pwo+Cj50aGFua3MsCj4KPmdyZWcgay1oCgpIaSBHcmVnLAogIE91ciBwcm9kdWN0IGFyZSBkZXNp
Z25lZCBiYXNlZCBvbiBRdWFsY29tbSBTRFg1NSBwbGF0Zm9ybS4gU28gaXQgc3RpbGwgc3VwcG9y
dCBRdWFsY29tbSB2ZW5kb3IgSUQuCiAgSSB0aGluayB0aGVyZSBpcyBubyBpbmZyaW5nZW1lbnQg
YWJvdXQgdGhpcyBJRCBjb21iby4KIApUaGFua3M=
