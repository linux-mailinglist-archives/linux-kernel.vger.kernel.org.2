Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE9644F66E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 05:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbhKNE1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 23:27:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34273 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230441AbhKNE1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 23:27:34 -0500
Received: from [IPV6:2601:646:8600:40c0:7285:c2ff:fefb:fd4] ([IPv6:2601:646:8600:40c0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 1AE4OGtI3055967
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 13 Nov 2021 20:24:17 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 1AE4OGtI3055967
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021103101; t=1636863858;
        bh=5F4J6AaUqdSrVc3pi4uPP8opXFtrTRDORKjXiyeUZ+o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iDWj0abd9NmLJo58T5+t9c6oPQElwy6K2uyIDKr4mPsjwAWg7H/vGAT0056fI7fL7
         +rYoHk7PlKV3TpifVjwSUrS+D81MVkL9w57xYhh8tSN4aVK8tE7M1r8eBwacTegAY+
         QNF834rSol53nNEYN+gwLqlczYQLoqUorYizHV/8FDavmepc1eb23RabjevTG5einz
         Cij26DOP0ig8bdolPUsDaCqBa9Cip1b0C72c6Cyi2q8x6SfsTmDD7sk2UeewRIlBdd
         YeMaJL6E7kksLNz9+tNgV7kDhe/41ps12uX6uEv0obH+8vLdeg9jwFCu2V6Hp36kvW
         EcaD2TrqPrNXg==
Message-ID: <47ea5a6a-025d-bcf2-d23a-be96cbcd36d3@zytor.com>
Date:   Sat, 13 Nov 2021 20:24:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 3/3] x86_64: Use relative per-cpu offsets
Content-Language: en-US
To:     Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
References: <20211113124035.9180-1-brgerst@gmail.com>
 <20211113124035.9180-4-brgerst@gmail.com>
 <719e0170-7645-4787-8c3a-676f34068c27@www.fastmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <719e0170-7645-4787-8c3a-676f34068c27@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/21 17:18, Andy Lutomirski wrote:
> 
> 
> On Sat, Nov 13, 2021, at 4:40 AM, Brian Gerst wrote:
>> The per-cpu section is currently linked at virtual address 0, because
>> older compilers hardcoded the stack protector canary value at a fixed
>> offset from the start of the GS segment.  Use a standard relative offset
>> as the GS base when the stack protector is disabled, or a newer compiler
>> is used that supports a configurable location for the stack canary.
> 
> Can you explain the benefit?  Also, I think we should consider dropping support for the fixed model like we did on x86_32.
> 

It would seem that UNLESS the fixed model is dropped, the benefit is 
probably negative.

	-hpa

