Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A9E42F396
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbhJONg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:36:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:19798 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234697AbhJONgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:36:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="227805464"
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="227805464"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 06:34:18 -0700
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="461566038"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.163.167]) ([10.212.163.167])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 06:34:17 -0700
Message-ID: <d5e755fd-41a7-7c3f-f540-094c1c583365@linux.intel.com>
Date:   Fri, 15 Oct 2021 06:34:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 16/16] x86/tdx: Add cmdline option to force use of
 ioremap_host_shared
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211009070132-mutt-send-email-mst@kernel.org>
 <8c906de6-5efa-b87a-c800-6f07b98339d0@linux.intel.com>
 <20211011075945-mutt-send-email-mst@kernel.org>
 <9d0ac556-6a06-0f2e-c4ff-0c3ce742a382@linux.intel.com>
 <20211011142330-mutt-send-email-mst@kernel.org>
 <4fe8d60a-2522-f111-995c-dcbefd0d5e31@linux.intel.com>
 <20211012165705-mutt-send-email-mst@kernel.org>
 <c09c961d-f433-4a68-0b38-208ffe8b36c7@linux.intel.com>
 <20211012171846-mutt-send-email-mst@kernel.org>
 <c2ce5ad8-4df7-3a37-b235-8762a76b1fd3@linux.intel.com>
 <20211015024923-mutt-send-email-mst@kernel.org>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20211015024923-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cutting down the insane cc list.

On 10/14/2021 11:57 PM, Michael S. Tsirkin wrote:
> On Thu, Oct 14, 2021 at 10:50:59PM -0700, Andi Kleen wrote:
>>> I thought you basically create an OperationRegion of SystemMemory type,
>>> and off you go. Maybe the OSPM in Linux is clever and protects
>>> some memory, I wouldn't know.
>>
>> I investigated this now, and it looks like acpi is using ioremap_cache(). We
>> can hook into that and force non sharing. It's probably safe to assume that
>> this is not used on real IO devices.
>>
>> I think there are still some other BIOS mappings that use just plain
>> ioremap() though.
>>
>>
>> -Andi
> Hmm don't you mean the reverse? If you make ioremap shared then OS is
> protected from malicious ACPI?


Nope

>   If you don't make it shared then
> malicious ACPI can poke at arbitrary OS memory.


When it's private it's protected and when it's shared it can be attacked


>
> For BIOS I suspect there's no way around it, it needs to be
> audited since it's executable.


The guest BIOS is attested and trusted. The original ACPI tables by the 
BIOS are attested and trusted too.

Just if we map the ACPI tables temporarily shared then an evil 
hypervisor could modify them during that time window.

-Andi

