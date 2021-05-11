Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92F037A9C5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhEKOo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:44:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43099 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231643AbhEKOoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:44:55 -0400
Received: from [IPv6:2601:646:8602:8be1:5181:d6fc:e7cd:279d] ([IPv6:2601:646:8602:8be1:5181:d6fc:e7cd:279d])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14BEhHY22613901
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 11 May 2021 07:43:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14BEhHY22613901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620744200;
        bh=K/2xiRWvPHCpYREHB6EqzzuF6Hzrmm1Cr6+oTwllx3o=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=IBZlSHq6tmUBuRTC+2YuGCCwseyAEsIqdTiDoOXa0/SOB+62yLc7M0fCi8GUBVg0r
         AfbGqnNDvkUbHlSTLCnjER9bMnVz/HSzlNF/TFWfcSjiJyZOqoB8hGuJnGDXT1K/2/
         LE2or1CjUR8F3xzLFl0iQ9mOJ7p0O6gYvt/A9t/AQYF6W6QqOW7CUJXyGuTby4PqzA
         dFkSR+T8RLxNrWj0BnmIq84k/DX/qbRRmfTXVn79vyMO92T1QfEuEIIBkkEFmrTFdP
         1K93w8o/c6dtpLOZYmKu/kwlSuIqDfBoKjZGqUGBFL8fq1sdfJy/6vLcCDJFTkCUfY
         opLU/XlTVoeqQ==
Date:   Tue, 11 May 2021 07:43:07 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <87o8dhfjc8.ffs@nanos.tec.linutronix.de>
References: <20210511005531.1065536-1-hpa@zytor.com> <20210511005531.1065536-4-hpa@zytor.com> <87o8dhfjc8.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/6] x86/idt: remove address argument to idt_invalidate()
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
CC:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <13944C28-B73C-4B2F-95C9-9395A6C21722@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yup, me bad=2E

On May 11, 2021 7:14:47 AM PDT, Thomas Gleixner <tglx@linutronix=2Ede> wro=
te:
>On Mon, May 10 2021 at 17:55, H=2E Peter Anvin wrote:
>> diff --git a/arch/x86/kernel/machine_kexec_32=2Ec
>b/arch/x86/kernel/machine_kexec_32=2Ec
>> index 64b00b0d7fe8=2E=2E6ba90f47d8c3 100644
>> --- a/arch/x86/kernel/machine_kexec_32=2Ec
>> +++ b/arch/x86/kernel/machine_kexec_32=2Ec
>> @@ -232,8 +232,8 @@ void machine_kexec(struct kimage *image)
>>  	 * The gdt & idt are now invalid=2E
>>  	 * If you want to load them you must set up your own idt & gdt=2E
>>  	 */
>> -	idt_invalidate(phys_to_virt(0));
>> -	set_gdt(phys_to_virt(0), 0);
>> +	idt_invalidate();
>> +	set_gdt(0, 0);
>
>  (NULL, 0)
>
>first argument it a pointer=2E=2E=2E
> =20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
