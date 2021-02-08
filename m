Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4660313D92
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbhBHScV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:32:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:38419 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233828AbhBHQMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:12:10 -0500
IronPort-SDR: 1mcaaaruglw7EEKyvzwJPbYXlN+2DT+lDwxa7T46xBAkRrXsPkLTKE8YFbMjiCZpqnR2TS7b25
 Fn0b8gBbFCZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="266569109"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="266569109"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 08:11:25 -0800
IronPort-SDR: XzJrWnxkAtcJHpNU5MS+kFte3K3H7htIwsiJvSQG1O75or1u1ubIRfbIrJWztHDJgL9Rho10gm
 r57SaWrsCM8A==
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="395525574"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.251.11.33]) ([10.251.11.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 08:11:24 -0800
Subject: Re: [GIT PULL] x86/urgent for v5.11-rc7
To:     Dave Hansen <dave.hansen@intel.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20210207104022.GA32127@zn.tnic>
 <CAHk-=widXSyJ8W3vRrqO-zNP12A+odxg2J2_-oOUskz33wtfqA@mail.gmail.com>
 <20210207175814.GF32127@zn.tnic>
 <661b9809-2c6a-5fc8-163b-a159b84c9ab8@intel.com>
 <CAADnVQ+Sqna6X2a3MKaBv7xmdCcj-aD=prp8OggTTwCjoVN_0A@mail.gmail.com>
 <0ea22b5e-9bf5-37d5-0020-03ad2bd48923@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <a1c9a34a-e39d-403c-bdc8-c161558d43a5@intel.com>
Date:   Mon, 8 Feb 2021 08:11:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <0ea22b5e-9bf5-37d5-0020-03ad2bd48923@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/2021 2:35 PM, Dave Hansen wrote:
> On 2/7/21 12:44 PM, Alexei Starovoitov wrote:
>>>> It probably is an item on some Intel manager's to-enable list. So far,
>>>> the CET enablement concentrates only on userspace but dhansen might know
>>>> more about future plans. CCed.
>>> It's definitely on our radar to look at after CET userspace.
>> What is the desired timeline to enable CET in the kernel ?
>> I think for bpf and tracing it will be mostly straightforward to deal
>> with extra endbr64 insn in front of the fentry nop.
>> Just trying to figure when this work needs to be done.
> 
> Yu-cheng?  Any idea when you're going to start hacking on the in-kernel
> IBT bits?
> 

I have some kernel-mode enabling patches that I will soon send 
internally for comments.  My estimate is probably before the summer, I 
can send those to the mailing list.

--
Yu-cheng
