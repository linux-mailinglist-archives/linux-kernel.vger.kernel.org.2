Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FEE380267
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 05:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhENDTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 23:19:51 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:41147 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229984AbhENDTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 23:19:50 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8E09A58129C;
        Thu, 13 May 2021 23:18:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 13 May 2021 23:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.luto.us;
         h=subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=b
        e7rDCROltBLN4RZPe+I3AnBxPdRYbt9l4ad1PTcfz0=; b=H5jqFKBqMEpTu2kD7
        lwS3SJfSH/EoqZFaEni6P7KDSaRT9nFAX46qMQe202aUAjOT5ZLPW52RNe5O93oO
        YN5BKaG3MWabci6F05t0Rw/AR8Q/nRRruEgFeMih+KbpxdTO7zfxDtLOwicXaLf+
        gsk7Ci1uAtajtEwM+CMJKoKGz3JhHHVJ9rfyb9orUAXN705IM4xu9rGKwQBEYHPH
        ne+RLyRAk8aUM7MOq3+GYcnIbKBTHhvOFYyNQPcNdNmmqoGXuq1JLyyegzRzmZj1
        Hgx8OYg5VomZ24pgwr2V0ghGS1R6iKL0zlrE7fqhPw9J+w5wGD6VglxRkL5aH5aY
        x6s2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=be7rDCROltBLN4RZPe+I3AnBxPdRYbt9l4ad1PTcf
        z0=; b=UJ1J1ysSShDrJiYbpvSSEKvZdSPdQcbz7J0IPVZYaBCD7rOHlYRctp5Xa
        n1kVPgButVLCgBn1eqBMiP7E8CGmQ3ZoDcAVq516Xim6My4bAvc80OD55bZj9NV6
        MNtKxfs2Yb3mZjF8z63p2zKbMSAmZ+1wvswuHRqB/+v9mupwxr2IlLRWHkVOsEek
        1b0bYSaJnSfiDk9ies7GWOuwTSSfdFan8jEkrwsihtTLdQshoq6owfOLdIaoWgcR
        2VI6i+kDwVSeFWg3rKyRVYkxzo6FtpPazv68+C7lqxj/0dnShTafpuhG+zkRudp0
        1ONUHE7roawKe+6qmvvdGdzCM53MA==
X-ME-Sender: <xms:DuydYNapxp5uVqBV-J9XpA4xlRzwNWHQPk_jHza84FMqJvwbWItwWg>
    <xme:DuydYEawaoRAdHjhjYSg8PpNJqB4lzt6yDwSuVHwUlzH-I21bpgSCj_tHCcWHIvcc
    s3KuVRLZpxWDEVA4H8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehhedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheptehnugih
    ucfnuhhtohhmihhrshhkihcuoegrnhguhieslhhinhhugidrlhhuthhordhusheqnecugg
    ftrfgrthhtvghrnhepuedvtdegueejueduhffgleekvddutedvheduudetgefhhfffuefg
    udekgeejfeeknecukfhppeeijedrudektddrudeihedrudegieenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhieslhhinhhugidrlhhu
    thhordhush
X-ME-Proxy: <xmx:DuydYP9JtGeNvGUKjdkvd5GjteSw-jr3h-YYc00bikQPUOuOr9msEA>
    <xmx:DuydYLoHNsCMXRoIat7xAYyFdzI8dfQw8U867Sszp4lU2ZrUlNEFpw>
    <xmx:DuydYIoqrgkdMA7vpn3qDOdkwiRW3kMxct5O4Y3jd6IXcFGRFExbCQ>
    <xmx:D-ydYDUpWd2Uk2V2PkQleushU8zRdSXDbVcPzanTdeK3LCi-xUtmKKiTmBk>
Received: from [192.168.0.55] (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 13 May 2021 23:18:38 -0400 (EDT)
Subject: Re: [RFC v2 PATCH 7/7] x86/entry: use int for syscall number; handle
 all invalid syscall nrs
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <871racf928.ffs@nanos.tec.linutronix.de>
 <60495dd3-ea68-4db3-47ad-b7b45796bf76@zytor.com>
 <87o8dfer7k.ffs@nanos.tec.linutronix.de>
 <b0ca952a-fd82-7833-ac82-ea8ecad48b53@zytor.com>
 <87mtsz619u.ffs@nanos.tec.linutronix.de>
 <b6f47bd3-3e4c-7200-befe-5e14fecf3da7@zytor.com>
From:   Andy Lutomirski <andy@linux.luto.us>
Message-ID: <57bf2ff9-11ff-0907-975e-15177df72144@linux.luto.us>
Date:   Thu, 13 May 2021 20:18:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b6f47bd3-3e4c-7200-befe-5e14fecf3da7@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/21 5:38 PM, H. Peter Anvin wrote:
> On 5/12/21 3:22 PM, Thomas Gleixner wrote:
>>>
>>> As far as this being a user ABI change, this is actually a revert to the
>>> original x86-64 ABI; see my message to Ingo.
>>
>> I'm not against that change, but it has to be well justified and the
>> reasoning wants to be in the changelog. You know the drill :)
>>
> 
> FYI:
> 
> So in the process of breaking up and better document this patch, I have
> looked at the syscall_numbering_64 (and have rewritten it to be more
> complete.)
> 
> I found that running it under strace fails, as strace (possibly ptrace,
> possibly the strace binary) causes %rax = 2^32 to be clobbered to zero
> already...
> 
> More motivation, I guess.
> 

Indeed.

I would love to go back in time and switch to long, but there are plenty
of things that use int now.  I suppose we could try to make it long for
real, but seccomp has u32 baked into its ABI.

