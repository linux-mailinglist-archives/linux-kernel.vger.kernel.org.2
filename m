Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19CA41D0B1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 02:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347527AbhI3AmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 20:42:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:59879 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244341AbhI3AmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 20:42:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="310618244"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="310618244"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 17:40:35 -0700
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="555162139"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 17:40:35 -0700
Date:   Thu, 30 Sep 2021 00:40:28 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] iommu/vt-d: Clean up unused PASID updating functions
Message-ID: <YVUHfPA2mMXR9CJo@otcwcpicx3.sc.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-2-fenghua.yu@intel.com>
 <2f2ab378-9967-ff84-18f1-c48ddeb0ceb6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f2ab378-9967-ff84-18f1-c48ddeb0ceb6@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Baolu,

On Wed, Sep 29, 2021 at 03:34:51PM +0800, Lu Baolu wrote:
> On 2021/9/21 3:23, Fenghua Yu wrote:
> > update_pasid() and its call chain are currently unused in the tree because
> > Thomas disabled the ENQCMD feature. The feature will be re-enabled shortly
> > using a different approach and update_pasid() and its call chain will not
> > be used in the new approach.
> > 
> > Remove the useless functions.
> > 
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> 
> Thanks for this cleanup. I have queued it for v5.16.

Thank you for pushing this patch to 5.16!

-Fenghua
