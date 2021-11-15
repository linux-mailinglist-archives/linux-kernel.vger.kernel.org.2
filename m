Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7117451D28
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350004AbhKPAZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:25:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350061AbhKOUVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 15:21:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E289A61C14;
        Mon, 15 Nov 2021 20:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637007508;
        bh=I8BGZUusWEBmOAxcEwHD0ryYVq+3vyEIyOWTQgFH6y4=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=V++HF/QLe6b18n/MSwnA7jIelI9KNmLi/zg7yB9YR0zNh9z+QbFkZabPg42uhjMyX
         7NC8p1rRTwMltkRm0/SgNdF9shoSlWBc1MEVHkrTHzEcOTLvZvrqgq/D4G0FjvBEr0
         Mv/cwmy/FBflRTQkK6UVvGsaBX35ZlOIY1+gcNHzVfB9oU4WCbQq7OUOphJ6CuBxdH
         7A2qymMySZE0TabJe2DMnH2XysAv4aKZVZb8z7a2FvFiPwKObcuYtnj/k4IHqyG+MO
         glomcnwN/7zhlaQn6mBDfHo0yWRv+eIrUqyx85uZLRrbgUcZrjfrkFniiKZVIBhZdn
         qknYcPQmw6mQg==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 00CD027C0054;
        Mon, 15 Nov 2021 15:18:26 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Mon, 15 Nov 2021 15:18:27 -0500
X-ME-Sender: <xms:ksCSYfKZ__pY_3JCV8Lpr5l6sz-SghmiPHLq1EWP7LelNPWQcC-y6A>
    <xme:ksCSYTIUMpJwmRG7agrn4z9WSbCazr2l0-ZueSbFUTKFlfO0oz4Se9_S9FsbM0TLR
    LYYmd8Q6Nnt3hdYHw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfedtgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedthfehtedtvdetvdetudfgueeuhfdtudegvdelveelfedvteelfffg
    fedvkeegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:ksCSYXvd7y6diLlNt0quqBIgu-6xJwpRCvvyl2ZP-WjsDZuv0lhApw>
    <xmx:ksCSYYY7ZZlT5g9iPFsBuDkXPcF21NZmTarhaYyFqmENfswmWi5Nrg>
    <xmx:ksCSYWaAYJM3yPECU6cTNyTt_JCr2uTb1jqZ7sedq17VL3w9RbrndA>
    <xmx:ksCSYcMaDX6zSc2yyn-0lxvsg9JR6nw5ks3X1HPtbMpCjXFWLS5Rv8pzyZI>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6040621E006E; Mon, 15 Nov 2021 15:18:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1371-g2296cc3491-fm-20211109.003-g2296cc34
Mime-Version: 1.0
Message-Id: <c659c2cc-fd87-4506-b0a8-4d22530c59c3@www.fastmail.com>
In-Reply-To: <8425e818-f6cc-ae52-ac6b-9cc80515c238@linux.intel.com>
References: <0f03a9e2-4611-4b5c-962f-93a7e1d2bde8@www.fastmail.com>
 <8425e818-f6cc-ae52-ac6b-9cc80515c238@linux.intel.com>
Date:   Mon, 15 Nov 2021 12:18:06 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Arjan van de Ven" <arjan@linux.intel.com>,
        "Asit K Mallick" <asit.k.mallick@intel.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Borislav Petkov" <bp@alien8.de>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     "Andrew Cooper" <andrew.cooper3@citrix.com>
Subject: Re: Revisiting XFD-based AMX and heterogenous systems
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Nov 15, 2021, at 12:11 PM, Arjan van de Ven wrote:
> On 11/15/2021 11:59 AM, Andy Lutomirski wrote:
>> [resend -- first try was HTML.  oops.]
>> 
>> Hi all-
>> 
>> I just learned that current Alder Lake review samples are actually heterogenous, at least physically.  The performance cores have AVX-512 and the efficiency cores don't have AVX-512.  Since no OS supports actual runtime ISA heterogeneity, this feature seems to be hidden in that one must choose, per boot, whether one wants AVX-512 or efficiency cores, but the CPU is physically heterogenous.
>> 
>> All the earlier discussions about Linux AMX architecture happened under the assumption that xfeature-heterogenous systems would never happen, and my grudging acceptance of the XFD model was predicated on that.  But now we have obviously heterogenous hardware that is apparently actually shipping at least to reviewers, and I think we should revisit this before we merge AMX support.
>> 
>
> Alderlake is not heterogenous.
> This is not just an "OS can deal with it" thing... it's throughout 
> everything from low lower power delivery through bios through ...

Sure, but I bet the demand will be there.  The desktop gamer types will flip off E cores and flip on AVX512 and call it a day.  But the ones who want battery life will be annoyed, and I bet someone at Intel is contemplating how to switch it at runtime.
