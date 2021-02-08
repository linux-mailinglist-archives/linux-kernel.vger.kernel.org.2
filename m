Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9487F314078
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbhBHU2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:28:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:24189 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236062AbhBHTHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:07:50 -0500
IronPort-SDR: iObCHjOBsk33QyXsug57qYsqLDED+ailr104/fs9Te3UFDQ01y5qouoDJL1jz+TJGsMNhf9D5S
 2/OON836RncA==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="160919257"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="160919257"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 11:05:51 -0800
IronPort-SDR: BqRyR0TusqarIqpi65CUz3lpAA1FgCvlj9p+7mEZGPW+xHiTQ+UyAl+CIVZFI43sl9giBIbpLw
 IwHwphisqV2Q==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="509573541"
Received: from uonwuzur-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.251.25.106])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 11:05:51 -0800
Subject: Re: [RFC v1 05/26] x86/traps: Add #VE support for TDX guest
To:     Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <48a702f536ccf953eee5778023ed6d1a452f6dcf.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <YCEQiDNSHTGBXBcj@hirez.programming.kicks-ass.net>
 <20210208162301.GA365765@tassilo.jf.intel.com>
 <YCFnwnzgHXNGKW+M@hirez.programming.kicks-ass.net>
 <YCFq3y5b62NsmBhO@google.com>
 <YCFuBu3O/U6pP0yr@hirez.programming.kicks-ass.net>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <803ff349-61eb-4543-0541-05a9b7228816@linux.intel.com>
Date:   Mon, 8 Feb 2021 11:05:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YCFuBu3O/U6pP0yr@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/8/21 8:59 AM, Peter Zijlstra wrote:
> 'cute', might be useful to have that mentioned somewhere.
we will add a note for it in comments.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
