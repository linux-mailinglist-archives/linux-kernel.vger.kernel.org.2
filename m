Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D09433D81
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 19:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhJSRdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 13:33:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:49792 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233170AbhJSRdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 13:33:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="215746093"
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="215746093"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 10:30:30 -0700
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="718479005"
Received: from tzanussi-mobl4.amr.corp.intel.com (HELO [10.212.76.147]) ([10.212.76.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 10:30:29 -0700
Subject: Re: [QUESTION] Performance deterioration caused by commit
 85f726a35e504418
To:     Steven Rostedt <rostedt@goodmis.org>,
        Yang Jihong <yangjihong1@huawei.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <992d3b1c-70db-5cc7-8400-39caa5d502d5@huawei.com>
 <20211018093731.2dd5917f@gandalf.local.home>
 <19e4222c-c9ac-5c1a-0c3a-b8bfd3524ab7@huawei.com>
 <20211018225112.3f6bda99@gandalf.local.home>
From:   "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Message-ID: <a138a0db-94a0-f77e-9b2d-bcffcba6862b@linux.intel.com>
Date:   Tue, 19 Oct 2021 12:30:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211018225112.3f6bda99@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 10/18/2021 9:51 PM, Steven Rostedt wrote:
> On Tue, 19 Oct 2021 10:39:47 +0800
> Yang Jihong <yangjihong1@huawei.com> wrote:
> 
>> Hi Steve,
>>
>> On 2021/10/18 21:37, Steven Rostedt wrote:
>>> On Mon, 18 Oct 2021 11:23:14 +0800
>>> Yang Jihong <yangjihong1@huawei.com> wrote:
>>>    
>>>> Hi Tom and Steven,
>>>>
>>>> commit 85f726a35e504418 use strncpy instead of memcpy when copying comm,
>>>> on ARM64 machine, this commit causes performance degradation.
>>>>
>>>> I test the number of instructions executed by invoking the
>>>> trace_sched_switch function once on an arm64 machine:
>>>> 1. Use memcpy, the number of instructions executed is 850.
>>>> 2. Use strncpy, the number of instructions executed 1100.
>>>> That is, use strncpy is almost 250 more instructions than memcpy.
>>>>
>>>> Has the impact on performance been considered in this commit? :)
>>>> What is the impact of revert the patch?
>>>>   
>>>
>>> It's a security issue. And like everything security, there's always going
>>> to be a performance impact. Look at the performance impact due to spectre
>>> and meltdown!
>>>
>>> That said, although memcpy() may not be used, we don't need strncpy.
>>> strncpy() will pad the rest of the string with nul bytes. But since the
>>> memory the string is being recorded into is already initialized (or can be
>>> if it isn't), we could use the faster strlcpy().
>>>
>>> Have you tried testing it by switching strncpy() with strlcpy()?
>>>    
>> I have tried testing it by switching strncpy() with strlcpy(), there is
>> no performance improvement, probably because the strlen function is
>> called in strlpy and the string is traversed each time.
> 
> Then there's not much we can do. Security trumps performance. Not to
> mention, the garbage in the comm after the '\0' causes the histograms to
> produce strange results.
> 
> Now for the saved_cmdlines, since it isn't exported directly to user space,
> that one may be put back to memcpy().
> 
> Tom, was there a reason to change saved_cmdlines(), as I'm not sure that is
> leaked. It looks like it is printed with the normal seq_printf() in
> saved_cmdlines_show().
> 

I don't think either of the changes in commit 85f726a35e504418 are directly related to the original problem [1] and therefore changing them back to memcpy or whatever shouldn't affect the histograms since that data is never used in keys.

Commit 85f726a35e504418 was basically a follow-on to commit 9f0bbf3115ca (tracing: Use strncpy instead of memcpy for string keys in hist triggers) and was added for completeness after examining other uses of memcpy in the tracing code (there's even a comment in there from you about possible performance hits from changing it ;-)

So anyway, as far as the histograms go, I think optimizing the two changes in 85f726a35e504418 while ignoring trailing garbage can be done without affecting the histogram correctness.

Tom

[1] https://lore.kernel.org/all/50c35ae1267d64eee975b8125e151e600071d4dc.1549309756.git.tom.zanussi@linux.intel.com/

> And it doesn't even look like the saved_cmdlines() is even initialized to
> zero, so it itself could leak memory if it was exposed.
> 
> -- Steve
> 
