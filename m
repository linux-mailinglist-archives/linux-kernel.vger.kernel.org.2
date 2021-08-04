Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C933F3E08CF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 21:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240756AbhHDT2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 15:28:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:25752 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240720AbhHDT2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 15:28:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="193587881"
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="193587881"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 12:27:47 -0700
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="522091507"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.32.138]) ([10.209.32.138])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 12:27:45 -0700
Subject: Re: [PATCH v1] driver: base: Add driver filter support
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrXhnHJCsTxiRcP@casper.infradead.org>
 <0e20cad3-8ba4-71bc-5bfd-3246ef991c6d@linux.intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <515ff3e6-d7aa-4d40-1cf7-7113721d68b9@linux.intel.com>
Date:   Wed, 4 Aug 2021 12:27:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <0e20cad3-8ba4-71bc-5bfd-3246ef991c6d@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/4/2021 11:29 AM, Kuppuswamy, Sathyanarayanan wrote:
>
>
> On 8/4/21 11:08 AM, Matthew Wilcox wrote:
>> Why use a doubly-linked-list here?  An allocating xarray should perform
>> much better and use less memory.
>
> We don't expect the list to be too long. So we may not gain any 
> significant
> advantage in terms of performance or memory when using alternate 
> lists. Since
> linked list easier to use, we chose it.
>
Also even if it was long it wouldn't matter because this isn't a fast 
path at all.

All that matters it to write the code as clearly as possible.

-Andi

