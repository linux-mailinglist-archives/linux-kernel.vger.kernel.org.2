Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D398C36965C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242899AbhDWPsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:48:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:22321 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230294AbhDWPsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:48:04 -0400
IronPort-SDR: DEmEplVAu3ulYCRxmP3Hg0Z8Qtjc3wjbJKkJmOmnT/pgII360j9hEUfyQ0q4SW+N6HZnQUUiS0
 V/tnPT6vD9JQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="183218742"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="183218742"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 08:47:26 -0700
IronPort-SDR: ScvTJ+7h64ZfgISV9PPUk6i6d/Lf3HgvxRFIlaY1pIs3MtbC8ME12QECZG7AjGxdx2e7yI3M3E
 K6jwS4qNlmNw==
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="446620444"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 08:47:26 -0700
Date:   Fri, 23 Apr 2021 08:47:25 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] x86/tdx: Add __tdcall() and __tdvmcall() helper
 functions
Message-ID: <20210423154725.GM1401198@tassilo.jf.intel.com>
References: <c015093fdbc8e6a5aa9fc43f78fec8d9c38295c7.1616801167.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <77a13ae9-0220-030e-7ae4-fd26edd7b110@intel.com>
 <2a3f6b3d-cd80-0734-ce83-c067666c8326@linux.intel.com>
 <14332abf-c78c-3bc2-9a7c-ceacfa7a0661@intel.com>
 <596175e3-9d1e-6c9c-fadb-ad02c396e3ad@linux.intel.com>
 <d99941db-6ee6-267e-dece-6220af0ea305@intel.com>
 <9161efc0-fd25-d239-32b7-5d2c726579b0@linux.intel.com>
 <4ac4ed35-212b-f7ad-55f4-937946ffec1a@intel.com>
 <20210423013546.GK1401198@tassilo.jf.intel.com>
 <YILkl3C4YjGPM5Jr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YILkl3C4YjGPM5Jr@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Has Intel "officially" switched to "tdg" as the acronym for TDX guest?  As much

Just for the global symbols to avoid conflicts with the tdx host code.

-Andi
