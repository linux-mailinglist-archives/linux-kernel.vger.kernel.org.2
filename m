Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93529366E62
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243624AbhDUOju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:39:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:46406 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243476AbhDUOjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:39:48 -0400
IronPort-SDR: LupxxomHL1KBvkM7KxMieqd/DuMb0fGwXheUgmYBmLyv0c/h66H9u+qzQAyolcdonoUVmSu1u/
 0oX1NukqTTBw==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="175194776"
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="175194776"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 07:39:15 -0700
IronPort-SDR: 5FrLDqwjxLoKcB5liQmfvq9kHa0/Cm2aFt6uXtcwXh41gdtzV+M0BR0F0wOut9XQPBOY97/eLE
 rBG+3t5cmTMw==
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="421008986"
Received: from lvaldivi-mobl3.ger.corp.intel.com (HELO [10.252.63.171]) ([10.252.63.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 07:39:13 -0700
Subject: Re: [PATCH] drm/i915: Fix docbook descriptions for i915_cmd_parser
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210421120353.544518-1-maarten.lankhorst@linux.intel.com>
 <CAKMK7uFpoY7YMEMbftjq+P5XHR6L+F0KwFtbK7CtuUFy7HsLkQ@mail.gmail.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <9ae96fa1-6c91-4ec1-422d-8e0a95251bb7@linux.intel.com>
Date:   Wed, 21 Apr 2021 16:39:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uFpoY7YMEMbftjq+P5XHR6L+F0KwFtbK7CtuUFy7HsLkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 21-04-2021 om 16:32 schreef Daniel Vetter:
> On Wed, Apr 21, 2021 at 2:03 PM Maarten Lankhorst
> <maarten.lankhorst@linux.intel.com> wrote:
>> Fixes the following htmldocs warnings:
>> drivers/gpu/drm/i915/i915_cmd_parser.c:1420: warning: Excess function parameter 'trampoline' description in 'intel_engine_cmd_parser'
>> drivers/gpu/drm/i915/i915_cmd_parser.c:1420: warning: Function parameter or member 'jump_whitelist' not described in 'intel_engine_cmd_parser'
>> drivers/gpu/drm/i915/i915_cmd_parser.c:1420: warning: Function parameter or member 'shadow_map' not described in 'intel_engine_cmd_parser'
>> drivers/gpu/drm/i915/i915_cmd_parser.c:1420: warning: Function parameter or member 'batch_map' not described in 'intel_engine_cmd_parser'
>> drivers/gpu/drm/i915/i915_cmd_parser.c:1420: warning: Excess function parameter 'trampoline' description in 'intel_engine_cmd_parser'
>>
>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> ---
>>  drivers/gpu/drm/i915/i915_cmd_parser.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/i915_cmd_parser.c b/drivers/gpu/drm/i915/i915_cmd_parser.c
>> index e6f1e93abbbb..afb9b7516999 100644
>> --- a/drivers/gpu/drm/i915/i915_cmd_parser.c
>> +++ b/drivers/gpu/drm/i915/i915_cmd_parser.c
>> @@ -1369,6 +1369,18 @@ static int check_bbstart(u32 *cmd, u32 offset, u32 length,
>>         return 0;
>>  }
>>
>> +/**
>> + * intel_engine_cmd_parser_alloc_jump_whitelist() - preallocate jump whitelist for intel_engine_cmd_parser()
>> + * @batch_length: length of the commands in batch_obj
>> + * @trampoline: Whether jump trampolines are used.
>> + *
>> + * Preallocates a jump whitelist for parsing the cmd buffer in intel_engine_cmd_parser().
>> + * This has to be preallocated, because the command parser runs in signaling context,
>> + * and may not allocate any memory.
>> + *
>> + * Return: NULL or pointer to a jump whitelist, or ERR_PTR() on failure. Use
>> + * IS_ERR() to check for errors. Must bre freed() with kfree().
> IS_ERR_OR_NULL or needs an actual bugfix in the code since we're not
> consistent. Also s/bre/be/
We're sort of consistent, NULL is a valid return code. IS_ERR is only on faliure. :)
> -Daniel
>
>> + */
>>  unsigned long *intel_engine_cmd_parser_alloc_jump_whitelist(u32 batch_length,
>>                                                             bool trampoline)
>>  {
>> @@ -1401,7 +1413,9 @@ unsigned long *intel_engine_cmd_parser_alloc_jump_whitelist(u32 batch_length,
>>   * @batch_offset: byte offset in the batch at which execution starts
>>   * @batch_length: length of the commands in batch_obj
>>   * @shadow: validated copy of the batch buffer in question
>> - * @trampoline: whether to emit a conditional trampoline at the end of the batch
>> + * @jump_whitelist: buffer preallocated with intel_engine_cmd_parser_alloc_jump_whitelist()
>> + * @shadow_map: mapping to @shadow vma
>> + * @batch_map: mapping to @batch vma
>>   *
>>   * Parses the specified batch buffer looking for privilege violations as
>>   * described in the overview.
>> --
>> 2.31.0
>>
>

