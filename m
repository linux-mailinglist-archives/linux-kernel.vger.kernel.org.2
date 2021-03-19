Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E813234117E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 01:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhCSAeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 20:34:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:65155 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230136AbhCSAdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 20:33:33 -0400
IronPort-SDR: /Py/9i2QxlYnHItM3PhYCXMiflGFHoevFIgIRRGgKOXzNh4BAeMUE7Z4p7vE3y3b2N4ExahHZ8
 EmAsLpuYEowg==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="169720430"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="169720430"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 17:33:33 -0700
IronPort-SDR: 0/JsqJBylArNAIBpJ7LxsLsII1vjAYkOSgqtkQiYZdmGuvV1QVD3qNPKYKvEm5OlYlLcVAsghg
 iuULiUPWziCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="434069868"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 18 Mar 2021 17:33:30 -0700
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        kevin.tian@intel.com, jacob.jun.pan@intel.com, yi.l.liu@intel.com,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iommu/vt-d: Remove WO permissions on second-level
 paging entries
To:     Joerg Roedel <joro@8bytes.org>, "Raj, Ashok" <ashok.raj@intel.com>
References: <20210225062654.2864322-1-baolu.lu@linux.intel.com>
 <20210225062654.2864322-3-baolu.lu@linux.intel.com>
 <20210304122623.GD26414@8bytes.org>
 <c7bffaee-6c3c-3254-a71a-d66d023d1e58@linux.intel.com>
 <20210308194746.GA15436@otc-nc-03> <YFMZjiGT13S2TZ6H@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9b7d09e6-9295-df7c-9197-5e22f6ad2c39@linux.intel.com>
Date:   Fri, 19 Mar 2021 08:24:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YFMZjiGT13S2TZ6H@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 3/18/21 5:12 PM, Joerg Roedel wrote:
> Hi,
> 
> On Mon, Mar 08, 2021 at 11:47:46AM -0800, Raj, Ashok wrote:
>> That is the primary motivation, given that we have moved to 1st level for
>> general IOVA, first level doesn't have a WO mapping. I didn't know enough
>> about the history to determine if a WO without a READ is very useful. I
>> guess the ZLR was invented to support those cases without a READ in PCIe. I
> 
> Okay, please update the commit message and re-send. I guess these
> patches are 5.13 stuff. In that case, Baolu can include them into his
> pull request later this cycle.

Okay! It works for me.

Best regards,
baolu
