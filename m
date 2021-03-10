Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48523334243
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbhCJP4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:56:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:31624 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233253AbhCJP4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:56:10 -0500
IronPort-SDR: djN2Lp2OLNdWsQNwToayqS9h3UJFvKDo3zoVSLTgzEoKNjwbRRs+ZnSai7tzgb0sW0gJfuxfX8
 BnGVZzixFxNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="167769373"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="167769373"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 07:56:10 -0800
IronPort-SDR: PN/wuXwd5C7QvPYXD47yxs0L449njoPwxrDcIki4ZuYEjuarWZ8WB5HYaVyp9WfVTUAJso27vp
 pRcmWVxXUztA==
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="403726594"
Received: from sliu49-mobl1.ccr.corp.intel.com (HELO [10.249.170.226]) ([10.249.170.226])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 07:56:08 -0800
Subject: Re: [PATCH] virt: acrn: Fix document of acrn_msi_inject()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com
References: <20210310153751.17516-1-shuo.a.liu@intel.com>
 <YEjqsEtXGr3rspkc@kroah.com>
From:   "Liu, Shuo A" <shuo.a.liu@intel.com>
Message-ID: <acfb840c-6968-33e9-ec81-93a314cf87d9@intel.com>
Date:   Wed, 10 Mar 2021 23:56:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YEjqsEtXGr3rspkc@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/2021 23:50, Greg Kroah-Hartman wrote:
> On Wed, Mar 10, 2021 at 11:37:51PM +0800, shuo.a.liu@intel.com wrote:
>> From: Shuo Liu <shuo.a.liu@intel.com>
>>
>> This fixes below sparse warning.
>>
>> ../drivers/virt/acrn/vm.c:105: warning: expecting prototype for
>> acrn_inject_msi(). Prototype was for acrn_msi_inject() instead
> 
> That is not a warning from sparse :(
> 

Oh. You are right. I was fixing another sparse warning and did
	make O=out -j24 W=1 C=1
to reproduce that warning.

It misled me that this warning coming out with sparse too.

Let me re-send the patch.

Thanks
shuo
