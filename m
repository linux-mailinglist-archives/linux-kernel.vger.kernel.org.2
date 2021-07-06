Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B463BC77D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 09:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhGFHz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 03:55:59 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:46067 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhGFHz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 03:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1625558000; x=1657094000;
  h=to:cc:from:subject:message-id:date:mime-version:
   content-transfer-encoding;
  bh=Z92FrkHp4okqXiANH4cU8ppIKjnXPS1Rh1az2B2o60Y=;
  b=Eo6P6hdd+U6myZJMoQYr0sCht1C67zwLxYy8DANEu5maTwD5TFQCqMMx
   Kfgxhlc/Mr3an5RNeFMkkcFFiugmxI6CVxJ9fUs1d7/5a0cK5dLHMlVhl
   zVk9qANs1F2TKh0qUg/sHaUKq6ToMxAUNItirsbRI0aPmFZklYIcnPi6P
   4=;
X-IronPort-AV: E=Sophos;i="5.83,328,1616457600"; 
   d="scan'208";a="118844977"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-4101.iad4.amazon.com with ESMTP; 06 Jul 2021 07:46:04 +0000
Received: from EX13D02EUB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id 01BBFA1CEC;
        Tue,  6 Jul 2021 07:46:02 +0000 (UTC)
Received: from u6fc700a6f3c650.ant.amazon.com (10.43.161.199) by
 EX13D02EUB001.ant.amazon.com (10.43.166.150) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Tue, 6 Jul 2021 07:45:51 +0000
To:     LKML <linux-kernel@vger.kernel.org>
CC:     "Woodhouse, David" <dwmw@amazon.co.uk>,
        "foersleo@amazon.de" <foersleo@amazon.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Kroah-Hartman <greg@kroah.com>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Norbert Manthey <nmanthey@amazon.de>
Subject: Coverity Scan model file, license, public access
Message-ID: <d7f096ee-7a9b-684e-433a-f8f3f0e6288d@amazon.de>
Date:   Tue, 6 Jul 2021 09:45:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [10.43.161.199]
X-ClientProxiedBy: EX13D03UWA001.ant.amazon.com (10.43.160.141) To
 EX13D02EUB001.ant.amazon.com (10.43.166.150)
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBhbGwsCgpJIHdvdWxkIGxpa2UgdG8gd29yayB3aXRoIGNvZGUgYW5hbHlzaXMgb24gdGhl
IExpbnV4IGtlcm5lbC4gVGhlCmN1cnJlbnRseSB1c2VkIENvdmVyaXR5IHNldHVwIGFscmVhZHkg
dXNlcyBhIG1vZGVsIGZpbGUgWzFdIHRvIGltcHJvdmUKdGhlIHByZWNpc2lvbiBvZiB0aGUgYW5h
bHlzaXMuIFRvIHRoZSBiZXN0IG9mIG15IGtub3dsZWRnZSwgdGhpcyBtb2RlbApmaWxlIGlzIGN1
cnJlbnRseSBub3QgcHVibGljbHkgYWNjZXNzaWJsZS4gSSBkaWQgbm90IGZpbmQgYSBsaWNlbnNl
CmF0dGFjaGVkIHRvwqAgWzFdLCBub3IgYW55IGluZm9ybWF0aW9uIGFib3V0IGxpY2Vuc2luZy4K
ClRvIGltcHJvdmUgdGhlIHdheSBDb3Zlcml0eSBpcyB1c2VkLCBJIHdvdWxkIGxpa2UgdG8gbW92
ZSB0aGlzIG1vZGVsCmZpbGUgaW50byBhIHB1YmxpYyByZXBvc2l0b3J5LCBhbmQgYWRkIGEgbGlj
ZW5zZS4gSSB3b25kZXIgd2hvbSBlbHNlIEkKc2hvdWxkIGludm9sdmUgaW50byB0aGlzIHByb2Nl
c3MuIElzIHRoZXJlIGEgcmVjb21tZW5kZWQgcGxhY2UgZm9yIHRoZQpsb2NhdGlvbiBvZiB0aGUg
bGljZW5zZT8gSSBhc3N1bWUgdGhlIHRhcmdldGVkIGxpY2Vuc2Ugc2hvdWxkIGJlIEdQTCwKYW5k
IHdvdWxkIGxpa2UgdG8gdW5kZXJzdGFuZCB3aGV0aGVyIHRoYXQgd29ya3Mgd2l0aCB0aGUgd2F5
IHRoaXMgZmlsZQppcyBjdXJyZW50bHkgbWFpbnRhaW5lZC4KCkJlc3QsCk5vcmJlcnQKClsxXSBo
dHRwczovL3NjYW4uY292ZXJpdHkuY29tL3Byb2plY3RzL2xpbnV4LW5leHQtd2Vla2x5LXNjYW4v
bW9kZWxfZmlsZQoKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3Jh
dXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNj
aGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxv
dHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAy
MzcgODc5CgoK

