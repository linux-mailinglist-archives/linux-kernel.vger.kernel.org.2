Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB2D454ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 21:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239048AbhKQU57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 15:57:59 -0500
Received: from mga18.intel.com ([134.134.136.126]:26861 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235689AbhKQU55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 15:57:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="220937089"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="220937089"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 12:54:57 -0800
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="672536002"
Received: from kkempf-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.255.92.124])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 12:54:56 -0800
Subject: Re: [PATCH] x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV
To:     Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
References: <20211117181439.4368-1-kirill.shutemov@linux.intel.com>
 <YZVLVfd5E6d6YQig@hirez.programming.kicks-ass.net>
 <20211117184225.6e257nfpdd2qhrj4@box.shutemov.name>
 <4824bf30-851e-c927-a50f-87fa2a429b2a@linux.intel.com>
 <YZVOfGtHyiZg1pIP@zn.tnic>
 <980ceab6-6686-c8f3-72b8-5743ca517bdf@linux.intel.com>
 <0f0b9784-1902-1526-2796-7d1a7ab17fb6@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <21f1325d-d97e-1bb7-ea87-d84e44089ab4@linux.intel.com>
Date:   Wed, 17 Nov 2021 12:54:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0f0b9784-1902-1526-2796-7d1a7ab17fb6@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/21 11:57 AM, Dave Hansen wrote:
> If it really is just about idle, perhaps Peter's suggestion warrants
> investigation.  But, we need to know the root cause instead of simply
> tossing around "requirements".

It is not only for idle case. We also need to support emulation of
normal halt case (which is used in cases like reboot or
early_fixup_exception(), etc.).

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
