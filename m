Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB863A0B54
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhFIEep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:34:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231335AbhFIEeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:34:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45B92601FC;
        Wed,  9 Jun 2021 04:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623213170;
        bh=3rKw8QxVud/J4p90Q24ac10Rx4sDcDuGfcCxqPfKYEs=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=Xk/WXvlkITidp31TMlOHd9tXMBNRTZ+7e1YvG26nYaL2TXu5QRPZkRkeyJyOaUTRT
         aqln//sX1g9/1kweXY+B53fmBlUCVFcN/wNiydPIxri+QTkM+d0zDL9omPqNGW1zjq
         X9khxHScmrH/q8SjwfCKtamBLnST8SyIu8mx4sSPsB4KzqfIKViSvWOQxOPDWnX01u
         8iqwlhEFVudzbakGeE/9Mal5/96YNbFTGmgDezCfGgjuR+1tEYPjVB7sCsBJnxMiRD
         icqWQIpfYydHvj9sZ8lMcPHvOVQSLpa4ZXdlE+0iO4vpuvm+GPBLxorZGtw/4MNn3Z
         1RsO77kbYAbQA==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3F7D127C005A;
        Wed,  9 Jun 2021 00:32:48 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Wed, 09 Jun 2021 00:32:48 -0400
X-ME-Sender: <xms:b0TAYPv4SG84HwM684zeA8w1l782raHZTnmWzutfg7Ivcb2IqSeUHw>
    <xme:b0TAYAehHWuoAYNs-vX-XSBGOXz1nWqXCRlR91ODShHY8m8uhjr9lUy1S5KSanLmY
    VU23saS5kPHjZZWeK4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedutddgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpeegjefghfdtledvfeegfeelvedtgfevkeeugfekffdvveeffeetieeh
    ueetveekfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:b0TAYCwyHrYO5mXqMUl5cUbp9DQOudffzoVHOGm1SzqIti6tQp3lYA>
    <xmx:b0TAYONQYlmkznquzzo__Uwb4b5pCr-1AamiFThP_h0drSfF-mzIJA>
    <xmx:b0TAYP8mEAsoAubevCe3A0BkgRbxyEf_OcxU6oXizp_LxTucCAnioA>
    <xmx:cETAYLT9re2wtAmvOP3JpDXUExduCLXEWgcTmy6C1dO8Hj3OE4dO9f_XFrXWNdkh>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4512E51C0060; Wed,  9 Jun 2021 00:32:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <e9b2aab2-4a6f-4739-a939-c448414e6af2@www.fastmail.com>
In-Reply-To: <4e5ac34f-28cb-def6-0b87-e560fa42e5e5@linux.intel.com>
References: <CAPcyv4iAgXnMmg+Z1cqrgeQUcuQgXZ1WCtAaNmeHuLT_5QArUw@mail.gmail.com>
 <20210609011030.751451-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4gLeKPfYOx1kmg-mO1_mNd+XGqVO-CbqX+2d52GZ+DSFw@mail.gmail.com>
 <23418f34-7c03-7477-6fbf-1b36b4718cb9@kernel.org>
 <4e5ac34f-28cb-def6-0b87-e560fa42e5e5@linux.intel.com>
Date:   Tue, 08 Jun 2021 21:32:26 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Andi Kleen" <ak@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Sathyanarayanan Kuppuswamy" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Kirill Shutemov" <kirill.shutemov@linux.intel.com>,
        "Kuppuswamy Sathyanarayanan" <knsathya@kernel.org>,
        "Raj Ashok" <ashok.raj@intel.com>,
        "Sean Christopherson" <seanjc@google.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?Re:_[RFC_v2-fix-v4_1/1]_x86/tdx:_Skip_WBINVD_instruction_for_T?=
 =?UTF-8?Q?DX_guest?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021, at 9:25 PM, Andi Kleen wrote:
> 
> > I like this description, but shouldn't the logic be:
> >
> > if (!CPUID has hypervisor bit set)
> >    wbinvd();
> >
> > As far as I know, most hypervisors will turn WBINVD into a noop and,
> > even if they don't, it seems to be that something must be really quite
> > wrong for a guest to need to WBINVD for ACPI purposes.
> 
> KVM only turns it into a noop if there is no VT-d, because with VT-d you 
> might need it to turn mappings into uncached and vice versa.

Wow, I found the kvm_arch_register_noncoherent_dma() stuff.  That's horrifying.  What's it for?  Are there actually guests that use devices exposed by VFIO that expect WBINVD to work?  That's a giant DoS hole.

> 
> But yes the change would make sense for reboot. BTW I suspect for the 
> reboot path it isn't really needed anywhere modern, so it might actually 
> be ok to completely disable it. But that's some risk, so doing it only 
> for hypervisor is reasonable.

I agree.
