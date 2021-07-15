Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C7E3C9F29
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 15:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbhGONPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 09:15:21 -0400
Received: from smtp-fw-80007.amazon.com ([99.78.197.218]:41677 "EHLO
        smtp-fw-80007.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhGONPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 09:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1626354747; x=1657890747;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject;
  bh=AqZy8HmmWkaGvQFDci/L+GLAUjlRxpXnx9pIV90+KUE=;
  b=ekxsoCdWT/crflPaUxyjrQQNiKyxBOmGK8jcZgZevBPuPtX17R+Cmw5r
   fFzUiUf+3Q7ZmzFkZkpeGxq+FP9T1FsIvM6LBHgDIblt+LH24DWi+1JHv
   5rZ5o4FQL6JXXA5yC4tKHFTRYo+aGd15lgD3xwoF4B6qIYJJG+cTx2gJk
   I=;
X-IronPort-AV: E=Sophos;i="5.84,242,1620691200"; 
   d="scan'208";a="12271328"
Subject: Re: Coverity Scan model file, license, public access
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP; 15 Jul 2021 13:12:13 +0000
Received: from EX13D02EUB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id 06584A17C2;
        Thu, 15 Jul 2021 13:12:12 +0000 (UTC)
Received: from u6fc700a6f3c650.ant.amazon.com (10.43.161.199) by
 EX13D02EUB001.ant.amazon.com (10.43.166.150) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Thu, 15 Jul 2021 13:12:08 +0000
To:     Kroah-Hartman <greg@kroah.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "foersleo@amazon.de" <foersleo@amazon.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <d7f096ee-7a9b-684e-433a-f8f3f0e6288d@amazon.de>
 <YOSKuEcPoy/dw0st@kroah.com>
From:   Norbert Manthey <nmanthey@amazon.de>
Message-ID: <a41221c8-86e5-494d-68fd-0a0b87c99e83@amazon.de>
Date:   Thu, 15 Jul 2021 15:12:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOSKuEcPoy/dw0st@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [10.43.161.199]
X-ClientProxiedBy: EX13D49UWB003.ant.amazon.com (10.43.163.121) To
 EX13D02EUB001.ant.amazon.com (10.43.166.150)
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy82LzIxIDY6NTQgUE0sIEtyb2FoLUhhcnRtYW4gd3JvdGU6Cj4gCj4gCj4gT24gVHVlLCBK
dWwgMDYsIDIwMjEgYXQgMDk6NDU6NDdBTSArMDIwMCwgTm9yYmVydCBNYW50aGV5IHdyb3RlOgo+
PiBEZWFyIGFsbCwKPj4KPj4gSSB3b3VsZCBsaWtlIHRvIHdvcmsgd2l0aCBjb2RlIGFuYWx5c2lz
IG9uIHRoZSBMaW51eCBrZXJuZWwuIFRoZQo+PiBjdXJyZW50bHkgdXNlZCBDb3Zlcml0eSBzZXR1
cCBhbHJlYWR5IHVzZXMgYSBtb2RlbCBmaWxlIFsxXSB0byBpbXByb3ZlCj4+IHRoZSBwcmVjaXNp
b24gb2YgdGhlIGFuYWx5c2lzLiBUbyB0aGUgYmVzdCBvZiBteSBrbm93bGVkZ2UsIHRoaXMgbW9k
ZWwKPj4gZmlsZSBpcyBjdXJyZW50bHkgbm90IHB1YmxpY2x5IGFjY2Vzc2libGUuIEkgZGlkIG5v
dCBmaW5kIGEgbGljZW5zZQo+PiBhdHRhY2hlZCB0byAgWzFdLCBub3IgYW55IGluZm9ybWF0aW9u
IGFib3V0IGxpY2Vuc2luZy4KPiAKPiBJIGhhdmUgbm8gaWRlYSB3aG8gd3JvdGUgdGhhdCB0aGlu
Zywgc29ycnkuCgpJcyB0aGVyZSBhbnlib2R5IGVsc2Ugd2hvIGtub3dzIG1vcmUgYWJvdXQgdGhl
IGhpc3Rvcnkgb2YgdGhlIHVzZWQKQ292ZXJpdHkgbW9kZWw/IFRoYW5rcy4KCkJlc3QsCk5vcmJl
cnQKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4g
MzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwg
Sm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcg
dW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK

