Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F94433E95
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 20:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbhJSSkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 14:40:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:51110 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231586AbhJSSkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 14:40:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="209393241"
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="209393241"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 11:38:39 -0700
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="718503564"
Received: from tzanussi-mobl4.amr.corp.intel.com (HELO [10.212.76.147]) ([10.212.76.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 11:38:38 -0700
Subject: Re: [QUESTION] Performance deterioration caused by commit
 85f726a35e504418
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yang Jihong <yangjihong1@huawei.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <992d3b1c-70db-5cc7-8400-39caa5d502d5@huawei.com>
 <20211018093731.2dd5917f@gandalf.local.home>
 <19e4222c-c9ac-5c1a-0c3a-b8bfd3524ab7@huawei.com>
 <20211018225112.3f6bda99@gandalf.local.home>
 <a138a0db-94a0-f77e-9b2d-bcffcba6862b@linux.intel.com>
 <20211019141002.386e7b6a@gandalf.local.home>
From:   "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Message-ID: <ea059f74-95d8-3e33-fbeb-02ef1ac567b0@linux.intel.com>
Date:   Tue, 19 Oct 2021 13:38:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211019141002.386e7b6a@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/2021 1:10 PM, Steven Rostedt wrote:
> On Tue, 19 Oct 2021 12:30:28 -0500
> "Zanussi, Tom" <tom.zanussi@linux.intel.com> wrote:
> 
>> So anyway, as far as the histograms go, I think optimizing the two
>> changes in 85f726a35e504418 while ignoring trailing garbage can be done
>> without affecting the histogram correctness.
> 
> So, none of that is exported to user space?

I meant just that any optimization of those two things that ignored the
trailing garbage wouldn't affect the histogram keys.

But yeah I think you're correct that ignoring it in the case of
saved_cmdlines wouldn't be a problem either but it would be in the case of
max_buffer since that's exported by the ring buffer.

Tom

> 
> -- Steve
> 
