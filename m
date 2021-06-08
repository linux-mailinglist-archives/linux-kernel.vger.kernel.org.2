Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1765C39FED3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 20:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhFHSUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232521AbhFHSUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:20:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBE796136D;
        Tue,  8 Jun 2021 18:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623176291;
        bh=jk14c85Uu/xNVdtsyfXmX2URMOAC3QI2bPvUzbgknHk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=T83dI8Xm2fJ+4dW391/OmdJv2DLOJ73cws0jQufETNcgJ7X9cgTXBaKPPEXPOLyt3
         aS6XnHIdsZE92okQEPn6SkH5+ZZ4UIzx6bpIFM4M7kmNNyhoXu+GE7n9j1dXybX8x5
         96nCf3s4DcLKDRqyCn12ojN9WjLnf2OQFl1YaXN0B7KmXklDqBXFQdc0PjG6YBlfSk
         Jc1fSJ6Xg7fDgxMdL85E1QF38FUvwZeJtbXQb63UNq13ZzmDVr9K3C8F7J5Uv0hPzA
         qdZ9acAq8WxjFsR2PUSzkVW2MjSjZoe7jVTpjt3fY/g7cVnLng7mjheWvIeHwL2M5a
         kI8ZyHKuLn4+w==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id D5EF627C0054;
        Tue,  8 Jun 2021 14:18:09 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Tue, 08 Jun 2021 14:18:09 -0400
X-ME-Sender: <xms:YLS_YMj4gyueUk-TS3tRJcNyrwN6UzgOgUItYZiVZMz86l5FagwU8g>
    <xme:YLS_YFC5CimIJaCbpUew_5NziPy8h0DcBtPaEQfOrSUUT5Oyr61kcSyJiAXsjCtXD
    5svzuY9SIRH68nAhd8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtledguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleff
    gfefvdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:YLS_YEEfL0kT3z9rSJXqRElwGVk6E8FynRwnpjMM34jiqDoc4wCcbw>
    <xmx:YLS_YNQg9PGZRc4QSEnKJTuPS8cK6HZu4brpiMby1UJ9130UdGf5XQ>
    <xmx:YLS_YJw2JLJnqO5jvmrPgG_jl19Z6PcAuLeZvUEMoSyQ_MuKBCV7kA>
    <xmx:YbS_YAlaWLQV4DO4eDpvDwFPHOpe8hs4cnYBHuT6KmkOXVn-1PfkP6kqJnYQzYCp>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ABAD551C0060; Tue,  8 Jun 2021 14:18:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <cd58659a-c3ec-427a-bf57-26fb8f61505c@www.fastmail.com>
In-Reply-To: <4635488d-b98b-330f-1485-fecfcf6e72ff@intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <8a1d6930f784cb57c957cf20cea870947db91e05.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <fe05830e-e82b-f338-2ba1-02651cb8087e@intel.com>
 <YL+tfGOMWEvDJTwc@google.com>
 <42f6b603-7c21-28fa-b6ec-e53268aa6ff7@intel.com>
 <3afaebee-77dc-83ff-c397-aa64991c52be@linux.intel.com>
 <4635488d-b98b-330f-1485-fecfcf6e72ff@intel.com>
Date:   Tue, 08 Jun 2021 11:17:47 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Dave Hansen" <dave.hansen@intel.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Sean Christopherson" <seanjc@google.com>
Cc:     "Sathyanarayanan Kuppuswamy" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Kirill Shutemov" <kirill.shutemov@linux.intel.com>,
        "Kuppuswamy Sathyanarayanan" <knsathya@kernel.org>,
        "Raj Ashok" <ashok.raj@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v2 08/32] x86/traps: Add #VE support for TDX guest
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Jun 8, 2021, at 11:15 AM, Dave Hansen wrote:
> On 6/8/21 11:12 AM, Andi Kleen wrote:
> > I believe neither does mmio/msr normally (except maybe
> > ftrace+tp_printk, but that will likely work because it shouldn't
> > recurse more than once due to ftrace's reentry protection)
> 
> Can it do MMIO:
> 
> > +DEFINE_IDTENTRY(exc_virtualization_exception)
> > +{
> =======> HERE
> > +    ret = tdg_get_ve_info(&ve); 
> 
> Recursion isn't the problem.  It would double-fault there, right?
> 

We should do the get_ve_info in a noinstr region.
