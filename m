Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A475D3E9C23
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 04:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbhHLCI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 22:08:29 -0400
Received: from m1364.mail.163.com ([220.181.13.64]:12260 "EHLO
        m1364.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhHLCI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 22:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=dAi21
        qFtOUAZAZ7vWpi4qn+7g8lQn04g7RhRHrYS5aQ=; b=hNAIZeBv76OuSS+ZugSO8
        qu7RvuwfW5fEkMIxH7Ua+Hcqp7fPA9iJj2cpbC+Fz0kh2mzy7bgpJIZ5oZfXb5HG
        qNCqHvAG+SHtMZiz8DoFfMXAG1szyCDVlGeG88gOdMpZ/uW9Dh51V0OMcYnK/m24
        fvVacFEARRVVcsXOYvTMm0=
Received: from slark_xiao$163.com ( [223.104.68.9] ) by ajax-webmail-wmsvr64
 (Coremail) ; Thu, 12 Aug 2021 10:07:09 +0800 (CST)
X-Originating-IP: [223.104.68.9]
Date:   Thu, 12 Aug 2021 10:07:09 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] [v2,1/1] This aims to support Foxconn SDX55
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
In-Reply-To: <875ywcfave.fsf@miraculix.mork.no>
References: <20210811085635.4699-1-slark_xiao@163.com>
 <875ywcfave.fsf@miraculix.mork.no>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <24551753.bf2.17b381cff23.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: QMGowABXXs5PghRhNKPBAA--.5850W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBrRDsZF75bLMYbgABs6
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjEtMDgtMTEgMjA6MDE6NTcsICJCasO4cm4gTW9yayIgPGJq
b3JuQG1vcmsubm8+IHdyb3RlOgo+U2xhcmsgWGlhbyA8c2xhcmtfeGlhb0AxNjMuY29tPiB3cml0
ZXM6Cj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL3NlcmlhbC9xY3NlcmlhbC5jIGIvZHJp
dmVycy91c2Ivc2VyaWFsL3Fjc2VyaWFsLmMKPj4gaW5kZXggODNkYTgyMzZlM2M4Li5kOGI1OGFl
YTNjNjAgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdXNiL3NlcmlhbC9xY3NlcmlhbC5jCj4+ICsr
KyBiL2RyaXZlcnMvdXNiL3NlcmlhbC9xY3NlcmlhbC5jCj4+IEBAIC0xMTEsNiArMTExLDcgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCB1c2JfZGV2aWNlX2lkIGlkX3RhYmxlW10gPSB7Cj4+ICAJe1VT
Ql9ERVZJQ0UoMHgxNmQ4LCAweDgwMDIpfSwJLyogQ01EVGVjaCBHb2JpIDIwMDAgTW9kZW0gZGV2
aWNlIChWVTkyMikgKi8KPj4gIAl7VVNCX0RFVklDRSgweDA1YzYsIDB4OTIwNCl9LAkvKiBHb2Jp
IDIwMDAgUURMIGRldmljZSAqLwo+PiAgCXtVU0JfREVWSUNFKDB4MDVjNiwgMHg5MjA1KX0sCS8q
IEdvYmkgMjAwMCBNb2RlbSBkZXZpY2UgKi8KPj4gKwl7VVNCX0RFVklDRSgweDA1YzYsIDB4OTAx
ZCl9LAkvKiBGb3hjb25uIFNEWDU1IFFETCAqLwo+Cj5JIGFzc3VtZSB0aGlzIGRldmljZSB3aWxs
IGV4cG9zZSBvdGhlciBzZXJpYWwgZnVuY3Rpb25zIHdoZW4gYm9vdGVkIGluCj5hcHBsaWNhdGlv
biBVU0IgbW9kZT8gIEJ1dCBwcm9iYWJseSBub3Qgd2l0aCBhIEdvYmkgMmsgbGF5b3V0Li4uIE1h
eWJlCj5hZGQgdGhlIGFwcGxpY2F0aW9uIGRldmljZSBJRCB0byBzb21lIFVTQiBzZXJpYWwgZHJp
dmVyIHRvbywgYW5kIGluY2x1ZGUKPnRoZSBRREwgZGV2aWNlIElEIHRoZXJlIGFzIHdlbGwgdG8g
cmVkdWNlIGNvbmZ1c2lvbj8KPgo+Q291bGQgeW91IHByb3ZpZGUgYSB2aWV3IG9mIHRoZSBkZWZh
dWx0IFVTQiBkZXNjcmlwdG9ycyBpbiBib3RoIFFETCBhbmQKPmFwcGxpY2F0aW9uIG1vZGU/ICBF
LmcgZnJvbSBsc3VzYiAtdiBvciAgL3N5cy9rZXJuZWwvZGVidWcvdXNiL2RldmljZXM/Cj4KPgo+
QmrDuHJuCgpIaSBCasO4cm4sCiAgVGhhbmsgeW91IGZvciB5b3VyIGdvb2QgYWR2aWNlLiBBY3R1
YWxseSBpdCdzIG15IHR5cG8gZm9yICdRREwnLiBJdCBzaG91bGQgYmUgJ0RpYWcnIHBvcnQuCiAg
UGxlYXNlIHNlZSBteSBsb2NhbCBzZXR0aW5nIGZvciBQQ0lFK1VTQiBtb2RlOgoKIGpiZEBqYmQt
VGhpbmtQYWQtUDEtR2VuLTQ6fi9naXQvbmV0LW5leHQkIGxzdXNiIHwgZ3JlcCAwNWM2CkJ1cyAw
MDMgRGV2aWNlIDAwMzogSUQgMDVjNjo5MDFkIFF1YWxjb21tLCBJbmMuIFF1YWxjb21tIEhTLVVT
QiBBbmRyb2lkIERpYWcgOTAxRApqYmRAamJkLVRoaW5rUGFkLVAxLUdlbi00On4kIGxzcGNpIHwg
Z3JlcCBGb3hjb25uCjAwMDA6MDg6MDAuMCBXaXJlbGVzcyBjb250cm9sbGVyIFswZDQwXTogRm94
Y29ubiBJbnRlcm5hdGlvbmFsLCBJbmMuIERldmljZSBlMGFiCgogIE9uZSBtb3JlLCBzaG91bGQg
SSBhZGQgYSBuZXcgbGF5b3V0IGZvciBRdWFsY29tbSBTRFg1NSBwbGF0Zm9ybT8gQXMgdGhlcmUg
YXJlIEcxSyxHMkssIFNJRVJSQSBhbmQgIEhVQVdFSSBsYXlvdXQsIG5vbmUgb2YgdGhlbSBpbmNs
dWRlcyBRdWFsY29tbSBTRFg1NS4KClRoYW5rcwo=
