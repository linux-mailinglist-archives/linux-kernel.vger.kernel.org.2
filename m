Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F2D45CDE9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 21:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243658AbhKXUZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 15:25:52 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:38492 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237467AbhKXUZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 15:25:51 -0500
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2A850806B7;
        Thu, 25 Nov 2021 09:22:39 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1637785359;
        bh=SpBmbrWsKJy5YcLQaguh5SYKUw0Din+pi2qoAHan/0Y=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=OJMd6gMq8mMRHgDLxgwHKeKHsgLPmynlLQ+CURYQJJzRhyX7LpAP5+CngJCKt6uQ2
         r1qTSPK9qTpXpawIzTAsuTuDX3YXrgUxfBXkPz7DR0eqWAVzLF8RMG+rRdgXIIzQo8
         cFmPWHpFbue6kk+hh8LBZEz/Z3TcBCmERTD/pvy26HMjX1nSw+2pE5H5kBpZ3Pyg+0
         Qpb64TgIBJstsHR68jqsU1G7RmhLSf2bgcEHmP9jEMoq5tQZ/VDTH/oBUaDi+ZrkIf
         Itu4iGK6FZBoDJ9NOe7ZThw4WSAs0scvRa+rcZK9oRvkb47TyTlLMynnaPVXMYhevX
         P7rU8IqEHiCEw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B619e9f0f0001>; Thu, 25 Nov 2021 09:22:39 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 25 Nov 2021 09:22:38 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.026; Thu, 25 Nov 2021 09:22:38 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Pavel Machek <pavel@ucw.cz>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Dealing with custom hardware on x86
Thread-Topic: Dealing with custom hardware on x86
Thread-Index: AQHX1d9bV9KaxyAm9kmZoGSBHWA2lqwRu6aAgACguIA=
Date:   Wed, 24 Nov 2021 20:22:38 +0000
Message-ID: <b6924a00-873d-715f-2f00-93ee19032ecd@alliedtelesis.co.nz>
References: <4ad5a438-ddc4-ca0a-a792-09d17edeb66b@alliedtelesis.co.nz>
 <20211124104723.GA8909@duo.ucw.cz>
In-Reply-To: <20211124104723.GA8909@duo.ucw.cz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <2A36094F55B8A843BC31B93E84A8B624@atlnz.lc>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=XOZOtjpE c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=N659UExz7-8A:10 a=vIxV3rELxO4A:10 a=nKVqsS7p1WRy7Mo3RhkA:9 a=pILNOxqGKmIA:10
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Thanks for responding

On 24/11/21 11:47 pm, Pavel Machek wrote:
> Hi!
>
>> I'm about to start a project involving custom hardware using an x86 CPU.
>> Complicating things somewhat we will have a CPU board supplied by a 3rd
>> party vendor using a COM Express type 7 connector which will plug in to
>> the board we're designing (actually 2 different boards each with some
>> modular aspects) .
>>
>> Coming from an embedded (mostly ARM) background I'm used to describing
>> the hardware via a devicetree and dealing with plug-in modules by
>> loading devicetree overlays. How do people achieve this kind of thing on
>> x86?
>>
>> I gather ACPI is involved somewhere but the knowledge that the BIOS has
>> will go as far as the COM Express header and somehow we'll have to tell
>> the kernel about the various non-probeable (mostly i2c) devices on our
>> board which is kind of where I'm stuck. Any pointers would be greatly
>> appreciated.
> In x86 land, we usually use PCI/PCIE and have a add-on board expose
> unique IDs with driver knowing what the IDs are. ACPI should not be
> involved for add-on boards.

So if I had a chain of i2c devices (endpoints behind muxes etc) I'd have=20
the PCI add-on board declare that hierarchy with i2c_new_device()?

>
> Best regards,
> 								Pavel=
