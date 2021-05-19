Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8FD38864A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240537AbhESFBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:01:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:18504 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232005AbhESFBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:01:35 -0400
IronPort-SDR: ThhIdzq0ZQXnZY09ViuSg4L5M9n9RxmLFJf53JSuUuIk+86caxn1E8sZVVuiWKIgJVi5KdfNqs
 7Al2vdwbfE+g==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="200950459"
X-IronPort-AV: E=Sophos;i="5.82,311,1613462400"; 
   d="scan'208";a="200950459"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 22:00:15 -0700
IronPort-SDR: FFtY6X66d/WoHbQWhavZVeIXBHLWzk02bKD/gqg0qZSh2cjz+409LGEA90QNFTgCTm62RRpDBX
 QGSmXAvqnUiQ==
X-IronPort-AV: E=Sophos;i="5.82,311,1613462400"; 
   d="scan'208";a="439798873"
Received: from dwchow-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.41.14])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 22:00:14 -0700
Subject: Re: [RFC v2 27/32] x86/tdx: Exclude Shared bit from __PHYSICAL_MASK
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <87b31425b79df3cc44d2bdc6a79d6aa36c42d116.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <3e6af3c5-4063-9b63-e80b-05d78f653ab2@linux.intel.com>
Date:   Tue, 18 May 2021 22:00:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87b31425b79df3cc44d2bdc6a79d6aa36c42d116.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 4/26/21 11:01 AM, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov"<kirill.shutemov@linux.intel.com>
> 
> tdx_shared_mask() returns the mask that has to be set in a page
> table entry to make page shared with VMM.
> 
> Also, note that we cannot club shared mapping configuration between
> AMD SME and Intel TDX Guest platforms in common function. SME has
> to do it very early in __startup_64() as it sets the bit on all
> memory, except what is used for communication. TDX can postpone as
> we don't need any shared mapping in very early boot.
> 
> Signed-off-by: Kirill A. Shutemov<kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen<ak@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan<sathyanarayanan.kuppuswamy@linux.intel.com>

Any comments on this patch?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
