Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B7A379317
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhEJPxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:53:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:18037 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231558AbhEJPxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:53:24 -0400
IronPort-SDR: y9dIWG64qIKryxleJ682CFKXp/duFvsUvFivkoFNeh3t+eiUfg6uc61zFbgiJYwQ13WDASoBGb
 dN81BmVT0dng==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="179488770"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="179488770"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 08:52:16 -0700
IronPort-SDR: 27OxFMx8kBBjIQtItvuM1QSdQTrvYwqDTKVkFjoUUwrMw2+wwZexGL1NWnkSc2ae8sV7nWchi9
 h1oU74SsLuiw==
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="433865599"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.32.217]) ([10.209.32.217])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 08:52:16 -0700
Subject: Re: [RFC v2 01/32] x86/paravirt: Introduce CONFIG_PARAVIRT_XL
To:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <4f8c9559dd04d8e8485c419c5ebc9471613f7928.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <YIhKXcNuinL0ar0O@zn.tnic> <f62354fe-e202-ad38-5466-03e79954f757@suse.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <a24884ac-452e-751f-fb3e-82b3a9978ed1@linux.intel.com>
Date:   Mon, 10 May 2021 08:52:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <f62354fe-e202-ad38-5466-03e79954f757@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

\
>>> CONFIG_PARAVIRT_XL will be used by TDX that needs couple of paravirt
>>> calls that were hidden under CONFIG_PARAVIRT_XXL, but the rest of the
>>> config would be a bloat for TDX.
>>
>> Used how? Why is it bloat for TDX?
>
> Is there any major downside to move the halt related pvops functions
> from CONFIG_PARAVIRT_XXL to CONFIG_PARAVIRT?

I think the main motivation is to get rid of all the page table related 
hooks for modern configurations. These are the bulk of the annotations 
and  cause bloat and worse code. Shadow page tables are really obscure 
these days and very few people still need them and it's totally 
reasonable to build even widely used distribution kernels without them. 
On contrast most of the other hooks are comparatively few and also on 
comparatively slow paths, so don't really matter too much.

I think it would be ok to have a CONFIG_PARAVIRT that does not have page 
table support, and a separate config option for those (that could be 
eventually deprecated).

But that would break existing .configs for those shadow stack users, 
that's why I think Kirill did it the other way around.

-Andi


