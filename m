Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C22630D65E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbhBCJbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:31:46 -0500
Received: from mga09.intel.com ([134.134.136.24]:1714 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhBCJb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:31:27 -0500
IronPort-SDR: h7ahegZIXWRP8N0RdS7NEhFq+oIOMinabFryahx9A02tBBVz4YUvrKuuoqkEe2vEuDrjC37J/V
 OnLTHNEURdvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="181158846"
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="181158846"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 01:29:40 -0800
IronPort-SDR: KJ4lPYHXMdgVlZDMopX9R1W9FxG2zKCK7WQjxWzNe5xTjj0hgL6ICLr74GV11Dy7omu2s2mCZm
 RvnaXcSvfKAw==
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="371352426"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.211]) ([10.254.210.211])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 01:29:38 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Yian Chen <yian.chen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iommu/vt-d: Add support for ACPI/SATC table
To:     Christoph Hellwig <hch@infradead.org>
References: <20210202044057.615277-1-baolu.lu@linux.intel.com>
 <20210203084128.GA3916610@infradead.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <18fc34e2-18db-d6f8-1011-a2cb8df85ed5@linux.intel.com>
Date:   Wed, 3 Feb 2021 17:29:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210203084128.GA3916610@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 2021/2/3 16:41, Christoph Hellwig wrote:
> On Tue, Feb 02, 2021 at 12:40:54PM +0800, Lu Baolu wrote:
>> Intel platform VT-d (v3.2) comes with a new type of DMAR subtable
>> SATC. The SATC table includes a list of SoC integrated devices
>> that require SATC. OS software can use this table to enable ATS
>> only for the devices in the list.
> 
> This all sounds like gibberish. Please expand and if necessary explain
> acronyms when first used in each commit log / cover letter.
> 

I will rephrase the words.

Best regards,
baolu
