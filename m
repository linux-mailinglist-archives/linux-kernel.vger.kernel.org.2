Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA6A3B1FFD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 20:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFWSGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 14:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWSGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 14:06:14 -0400
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1214C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 11:03:56 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4G9B3D65p5zMqVcd;
        Wed, 23 Jun 2021 20:03:52 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4G9B3B5kZCzlmrrn;
        Wed, 23 Jun 2021 20:03:50 +0200 (CEST)
Subject: Re: [PATCH v1] crypto: Make the DRBG compliant with NIST SP800-90A
 rev1
To:     =?UTF-8?Q?Stephan_M=c3=bcller?= <smueller@chronox.de>,
        James Morris <jamorris@linux.microsoft.com>
Cc:     David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Haxby <john.haxby@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Simo Sorce <simo@redhat.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        hpa@zytor.com, tytso@mit.edu
References: <20210623120751.3033390-1-mic@digikod.net>
 <9dbbf4e751cb4953fe63079cdc917a0bb3a91670.camel@chronox.de>
 <a4e1c071-32af-9650-e6fd-8943b3a79bb0@linux.microsoft.com>
 <8811360.37IJKxs2K1@positron.chronox.de>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <9ca2fdb4-8cee-3667-c90a-358255fb8f54@digikod.net>
Date:   Wed, 23 Jun 2021 20:04:00 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <8811360.37IJKxs2K1@positron.chronox.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/06/2021 19:27, Stephan M�ller wrote:
> Am Mittwoch, 23. Juni 2021, 19:00:29 CEST schrieb James Morris:
> 
> Hi James,
> 
>> On Wed, 23 Jun 2021, Stephan Mueller wrote:
>>>> These changes replace the use of the Linux RNG with the Jitter RNG,
>>>> which is NIST SP800-90B compliant, to get a proper entropy input and a
>>>> nonce as defined by FIPS.
>>>
>>> Can you please help me understand what is missing in the current code
>>> which
>>> seemingly already has achieved this goal?
>>
>> The advice we have is that if an attacker knows the internal state of the
>> CPU, then the output of the Jitter RNG can be predicted.
> 
> Thank you for the hint. And I think such goal is worthwhile (albeit I have to 
> admit that if an attacker is able to gain the internal state of a CPU, I would 
> assume we have more pressing problems that a bit of entropy).
> 
> Anyways, the current code does:
> 
> - in regular mode: seed the DRBG with 384 bits of data from get_random_bytes
> 
> - in FIPS mode: seed the DRBG with 384 bits of data from get_random_bytes 
> concatenated with 384 bits from the Jitter RNG
> 
> 
> If I understand the suggested changes right, I would see the following changes 
> in the patch:
> 
> - in the regular case: 640 bits from get_random_bytes

Why 640 bits?

> 
> - in FIPS mode: 256 bits of data from get_random_bytes concatenated with 384 
> bits from the Jitter RNG

In both cases there are 256 bits for the entropy input and 128 bits for
the nonce. If Jitter RNG is not available, then urandom is used instead,
which means that the system is not FIPS compliant.

This follows the SP800-90Ar1, section 8.6.7: [a nonce shall be] "A value
with at least (security_strength/2) bits of entropy".

> 
> So, I am not fully sure what the benefit of the difference is: in FIPS mode 
> (where the Jitter RNG is used), the amount of data pulled from 
> get_random_bytes seems to be now reduced.

We can increase the amount of data pulled from get_random_bytes (how to
decide the amount?), but as we understand the document, this should be
part of the personalization string and additional input, not the nonce.
I guess it may not change much according to the implementation, as for
the order of random and entropy concatenation, but these changes align
with the specifications and it should help FIPS certifications.

> 
> Maybe I miss a point here, but I currently fail to understand why the changes 
> should be an improvement compared to the current case.
> 
> Ciao
> Stephan
> 
> 
