Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76F7451BE3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354881AbhKPAIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:08:51 -0500
Received: from mga18.intel.com ([134.134.136.126]:25873 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349535AbhKOUOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 15:14:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="220412383"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="220412383"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 12:11:29 -0800
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="506079126"
Received: from avandeve-mobl.amr.corp.intel.com (HELO [10.209.23.12]) ([10.209.23.12])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 12:11:28 -0800
Message-ID: <8425e818-f6cc-ae52-ac6b-9cc80515c238@linux.intel.com>
Date:   Mon, 15 Nov 2021 12:11:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Revisiting XFD-based AMX and heterogenous systems
Content-Language: en-US
To:     Andy Lutomirski <luto@kernel.org>,
        Asit K Mallick <asit.k.mallick@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>
References: <0f03a9e2-4611-4b5c-962f-93a7e1d2bde8@www.fastmail.com>
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <0f03a9e2-4611-4b5c-962f-93a7e1d2bde8@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/2021 11:59 AM, Andy Lutomirski wrote:
> [resend -- first try was HTML.  oops.]
> 
> Hi all-
> 
> I just learned that current Alder Lake review samples are actually heterogenous, at least physically.  The performance cores have AVX-512 and the efficiency cores don't have AVX-512.  Since no OS supports actual runtime ISA heterogeneity, this feature seems to be hidden in that one must choose, per boot, whether one wants AVX-512 or efficiency cores, but the CPU is physically heterogenous.
> 
> All the earlier discussions about Linux AMX architecture happened under the assumption that xfeature-heterogenous systems would never happen, and my grudging acceptance of the XFD model was predicated on that.  But now we have obviously heterogenous hardware that is apparently actually shipping at least to reviewers, and I think we should revisit this before we merge AMX support.
> 

Alderlake is not heterogenous.
This is not just an "OS can deal with it" thing... it's throughout everything from low lower power delivery through bios through ...
