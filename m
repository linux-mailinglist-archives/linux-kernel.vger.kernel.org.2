Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896E337EEE3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhELWVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 18:21:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51887 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1387802AbhELWKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 18:10:46 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14CM9D8K2844555
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 12 May 2021 15:09:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14CM9D8K2844555
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620857354;
        bh=tkwPeG2CvNXmxpgODLd6wDhM+YhWJn9cKsnKBH4qgEg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XTqtH4VhAhp5lHa5yBIq6ObWL9qhThr0jLsFquf7m0l+42VXD6vTQx9q/IdOzRN8d
         P10KujfKJVR4dgJP2Yd2cNDCqHMZefaj8cLFCTQi9iG3OZu/b2xCf1wy54/M5QA5oe
         iKkbxs0BtMMmRhiYQpZtJQC4rQWLgnLZ6BiQNZAtr3Pn1suxbgxmLUKemtSABoBZ8K
         GS3Mh7Gfh4UX+oh4efkUac7II8jaTpDVSTfNCC0pDU41b+r+Ia8EzQFAGGWc+cvlRL
         fUjQd9+XSYHeZkmpv+eoBWxr8+gggHg7iu4sVcayZ+JPSI4X7Y/VV+l3JsPkLa12sr
         aW7GWFpIcTleg==
Subject: Re: [RFC v2 PATCH 7/7] x86/entry: use int for syscall number; handle
 all invalid syscall nrs
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <871racf928.ffs@nanos.tec.linutronix.de>
 <60495dd3-ea68-4db3-47ad-b7b45796bf76@zytor.com>
 <87o8dfer7k.ffs@nanos.tec.linutronix.de>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <b0ca952a-fd82-7833-ac82-ea8ecad48b53@zytor.com>
Date:   Wed, 12 May 2021 15:09:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87o8dfer7k.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/21 11:34 AM, Thomas Gleixner wrote:
>>
>> That is intentional, as (again) system calls are int.
> 
> They are 'int' kernel internally, but _NOT_ at the user space visible
> side. Again: man syscall
> 
>      syscall(long number,...);
> 
> So that results in a user ABI change.
> 
>> As stated in my reply to Ingo, I'll clean the various descriptions and
>> try to capture the discussion better.
> 
> If we agree to go there then this wants to be a seperate commit which
> does nothing else than changing this behaviour.
> 

Good idea.

As far as this being a user ABI change, this is actually a revert to the 
original x86-64 ABI; see my message to Ingo.

	-hpa

