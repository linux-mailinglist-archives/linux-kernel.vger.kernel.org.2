Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6576454D61
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240214AbhKQSth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:49:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:63761 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240192AbhKQStf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:49:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="233973487"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="233973487"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 10:46:32 -0800
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="672497290"
Received: from kkempf-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.255.92.124])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 10:46:31 -0800
Subject: Re: [PATCH] x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
References: <20211117181439.4368-1-kirill.shutemov@linux.intel.com>
 <YZVLVfd5E6d6YQig@hirez.programming.kicks-ass.net>
 <20211117184225.6e257nfpdd2qhrj4@box.shutemov.name>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <4824bf30-851e-c927-a50f-87fa2a429b2a@linux.intel.com>
Date:   Wed, 17 Nov 2021 10:46:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211117184225.6e257nfpdd2qhrj4@box.shutemov.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/21 10:42 AM, Kirill A. Shutemov wrote:
> On Wed, Nov 17, 2021 at 07:35:01PM +0100, Peter Zijlstra wrote:
>> On Wed, Nov 17, 2021 at 09:14:39PM +0300, Kirill A. Shutemov wrote:
>>> TDX is going to use CONFIG_PARAVIRT_XXL
>>
>> *AARGGHHH*. srlsy? We were trying to cut back on that insanity, not
>> proliferate it.
> 
> It is a way to minimize amount of changes needed for getting TDX
> functinal. We will remove the dependency later on.
> 

TDX has a requirement to use HLT paravirt calls (which is currently
listed under PARAVIRT_XXL). Once we submit a patch to move it
under CONFIG_PARAVIRT, we will drop this dependency.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
