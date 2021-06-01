Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4355D397BA0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 23:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhFAVSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 17:18:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:63172 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234707AbhFAVSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 17:18:13 -0400
IronPort-SDR: IqBf7QQJ3LNZFXZAaP+EajqTz9lQ/OrRgmrAl24D+/N5qxj90Lz5hNDJVzFrB/EH6p4M2l/PqK
 le1Aw0B4cqSw==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="264822798"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="264822798"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 14:16:30 -0700
IronPort-SDR: Ahr6yiJeA+QINx6dPh6s1Y1XSbvy790SlbtSqyxH6xGj5Xn25z53+Vf2T1tRQL5Az1NVc5TO6p
 K/4fYsShrCuA==
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="416610847"
Received: from gemalouf-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.187.103])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 14:16:30 -0700
Subject: Re: [RFC v2 28/32] x86/tdx: Make pages shared in ioremap()
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>
References: <0e233779-9c10-11df-b527-ef61e003ea35@linux.intel.com>
 <YKfPLlulaqwypNkO@zn.tnic> <f5e64c61-7f3c-3936-1b8e-7874ec81d83e@amd.com>
 <YKgA1od/SqycWWds@zn.tnic> <86b4d995-9619-81fa-5ef4-86f48ab01e96@amd.com>
 <a94e1fb8-50bf-ef69-6553-237937029c5d@linux.intel.com>
 <YLT9AGodkvct8YTO@zn.tnic>
 <96a63ddf-98f9-7095-f7bb-100bf56a4d10@linux.intel.com>
 <YLUjCqdPu/8eWuB+@zn.tnic>
 <280669ec-d43a-83af-55ba-ad03411538b5@linux.intel.com>
 <YLU1peNu/744jR/R@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <f44767ef-c46f-0f22-d185-a79792532d99@linux.intel.com>
Date:   Tue, 1 Jun 2021 14:16:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YLU1peNu/744jR/R@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/31/21 12:14 PM, Borislav Petkov wrote:
>> We can also use protected_guest_has(VM_VIRTIO_SECURE_FIX) or something
>> similar for this purpose. Andi, any comments?
> protected_guest_has() is enough for that - no need for two functions.
> 
>> IMHO, its better to use above generic config option in common header
>> file (linux/protected_guest.h). Any architecture that implements
>> protected guest feature can enable it. This will help is hide arch
>> specific config options in arch specific header file.
> You define empty function stubs for when the arch config option is not
> enabled. Everything else is unnecessary. When another architecture needs
> this, then another architecture will generalize it like it is usually
> done.

Please check the updated version in email titled "[RFC v2-fix-v2 1/1] x86:
Introduce generic protected guest abstraction".

We can continue the rest of the discussion in that email.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
