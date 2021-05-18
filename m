Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A513881CF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 23:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352333AbhERVGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 17:06:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:34921 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240342AbhERVGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 17:06:40 -0400
IronPort-SDR: K2atSkCMswWLjBTsGtSns9QnpqET8+MFh9o+vjlGcve8f8QUqoi6mfZRFlpqLig1Gta7MvMN7S
 JrYHd5+WagMQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="262046929"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="262046929"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 14:05:21 -0700
IronPort-SDR: kdkQNPVnSxUhXsXwBunT2zS3NZXjEXl9j1tN8HdDYiJlGJM7MNl73uqESiww5XNxso7RSBC3lO
 lndX7VYR2t1Q==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439635187"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.65.183]) ([10.209.65.183])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 14:05:21 -0700
Subject: Re: [RFC v2-fix 1/1] x86/tdx: Handle in-kernel MMIO
To:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
 <20210518004807.258503-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <36cd2665-6d8b-9c0b-eec1-25152dcca2a3@intel.com>
 <43e583a3-ee2b-52d8-5275-e26a6609c126@linux.intel.com>
 <YKP1Xty7EEzHkZ6Y@google.com>
 <8fb0e52c-ed0a-2185-585a-27007c27ed56@linux.intel.com>
 <d711ca30-ff84-2efa-4b9e-d9b46f53c0a5@intel.com>
 <a46544ba-e995-1e95-4e62-e9f48eec0db1@linux.intel.com>
 <8dd9b9c8-0bf5-3ce5-119c-b52f8518e473@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <26518d17-cc9e-ac0d-aac0-b65dbe22af68@linux.intel.com>
Date:   Tue, 18 May 2021 14:05:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <8dd9b9c8-0bf5-3ce5-119c-b52f8518e473@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm not actually trying to propose things.  I'm really just trying to
> get an idea why the implementation ended up how it did.  I actually
> entirely respect the position that the KVM code is a monster and
> shouldn't get reused.  That seems totally reasonable.

Mainly because it's relatively simple and straight forward to do it this 
way, Yes I know, that's a shocking concept, but sometimes it works even 
in Linux code.

>
> What isn't reasonable is the lack of documentation of these design
> decisions in the changelogs.  My goal here is to raise the quality of
> the changelogs so that other reviewers and maintainers don't have to ask
> these questions when they perform their reviews.
>
> This is honestly the best way I know to help get this code merged as
> soon as possible.  If I'm not helping, please let me know.  I'm happy to
> spend my time elsewhere.

I'm sure the commit logs can be improved and I appreciate your feedback.


I don't think every commit log needs to be an extended essay meandering 
all over the possible design space, talking about everything that could 
have been and wasn't. The way code is normally written is that we don't 
do an exhaustive search of possible options, but instead we pick a 
reasonable path and as long as that works and doesn't have too many 
problems we just stick to it. The commit log reflects that single path 
chosen, with only rare exceptions to talk about dead alleys.

In this case you can even see that multiple independent efforts (AMD and 
Intel) came mostly to fairly similar implementations, so the path chosen 
wasn't really that strange or non obvious.

Also overall I would appreciate if people would focus more on the code 
than the commit logs. Commit logs are important, but in the end what 
really matters is that the code is correct.

-Andi


