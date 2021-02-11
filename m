Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE10F3190BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhBKRPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:15:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:4719 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231477AbhBKQMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 11:12:30 -0500
IronPort-SDR: 4ZiQKTlxAmdhQdND4fQeeOBeVm9sfXxgtTQ2ktYUSyxtDBvmrbAV85kccFPIG3hXqAa+hwbCoR
 eDRUqaWt3ZCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="179707358"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="179707358"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 08:11:34 -0800
IronPort-SDR: AnEqEOS4EETBMPL/ToQ+rFZDaxlzewFj7BulAEU1GsWTwWVRk46wiR+O9PSc1CQE2i+L1Irv8m
 ltaWIXR1WHhA==
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="362547479"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.225.14]) ([10.212.225.14])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 08:11:33 -0800
Subject: Re: [PATCH v3] driver core: auxiliary bus: Fix calling stage for
 auxiliary bus init
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Dave Ertman <david.m.ertman@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20210210201611.1611074-1-dave.jiang@intel.com>
 <YCTgYWEAxiBgq3xz@kroah.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <9896ca8c-f4c3-a4d2-05fd-675cd53069dd@intel.com>
Date:   Thu, 11 Feb 2021 09:11:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YCTgYWEAxiBgq3xz@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/11/2021 12:44 AM, Greg KH wrote:
> On Wed, Feb 10, 2021 at 01:16:11PM -0700, Dave Jiang wrote:
>>   MODULE_LICENSE("GPL v2");
>>   MODULE_DESCRIPTION("Auxiliary Bus");
>>   MODULE_AUTHOR("David Ertman <david.m.ertman@intel.com>");
> As this code can not be built as a module, can you remove these lines as
> well?  I don't think they do anything, and were never needed.

Ok I will remove them.


> thanks,
>
> greg k-h
