Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885A33A05AB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbhFHVZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:25:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:4271 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhFHVZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:25:20 -0400
IronPort-SDR: gj3fsiNWltRd+nevzd99v6A4aMr2gIgQEbAoVE/YKL/pyaQYwnvTl0BdFKP3dEdBYSU7VTCUkS
 qPj3GRJWf7xA==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="290572221"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="290572221"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 14:23:27 -0700
IronPort-SDR: mBheP2NNJomVXZhQ+Lj6qxkKbNi/cUQCm/X0YuBfVJ/Lwy+dswVQsam18InQOeSUkO2dbqiyHy
 lQwCaOn6QDyg==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="482120515"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.209.87.156]) ([10.209.87.156])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 14:23:27 -0700
Subject: Re: [PATCH] x86: kernel: cpu: resctrl: Fix kernel-doc in
 pseudo_lock.c
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20210602222326.7765-1-fmdefrancesco@gmail.com>
 <017e9a77-d17e-effd-5639-72a06abc4fc3@intel.com>
 <1711024.RBxhUqbo4a@linux.local>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <a63931e6-b01e-bb26-d8e9-2d89493db4c1@intel.com>
Date:   Tue, 8 Jun 2021 14:23:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1711024.RBxhUqbo4a@linux.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 6/8/2021 1:12 PM, Fabio M. De Francesco wrote:
> On Tuesday, June 8, 2021 1:30:34 AM CEST Reinette Chatre wrote:
>> Hi Fabio,
>>
> Hi Reinette,
>>
>> Thank you very much for catching these. I am curious what your goal is
>> because when I ran a kernel-doc check on the resctrl area there were
>> many more warnings than are not addressed in this patch. Also, while
>> this patch claims to fix the kernel-doc in pseudo_lock.c there seems to
>> be a few more that are not addressed.
>>
> Actually this patch was just a preliminary test for checking if my
> contributions to this subsystem would be taken into consideration or
> completely ignored. That is the real reason why I just started with trying to
> fix only a couple of kernel-doc issues in pseudo_lock.c.

Your submissions are appreciated and will be taken into consideration.

>> Are you planning to submit more
>> patches to do a cleanup of kernel-doc or are these the only ones
>> bothering you for some reason?
>>
> I'd like to submit more cleanup patches of kernel-doc, because I always read
> carefully the kernel-doc above the functions I want to understand. I have a
> long term plan to study the Linux code and try to contribute the better I can.
> I'm into Linux developing since about two months, so I'm a newcomer and I
> still have a lot to learn.
>>
>> Could you please fixup the subject to conform to this area:
>> "x86/resctrl: Fix kernel-doc in pseudo_lock.c"
>>
> Sure. I was inadvertently using the drivers/staging convention I've used for
> the patches I've submitted there.

Unfortunately the kernel is not consistent in this regard.
>> For this subject to be accurate though it should fix all the kernel-doc
>> warnings found in pseudo_lock.c - or if not it would be helpful to
>> explain what the criteria for fixes are. I tested this by running:
>> $ scripts/kernel-doc -v -none arch/x86/kernel/cpu/resctrl/*
>>
> I've just run the above script and I see that there are a lot more warnings
> that I was expecting.
> 
> I want to fix as much as I can. Unfortunately I'm pretty sure I won't be able
> to fix them all, just because the inner working and the purpose of some
> functions are a bit obscure to me (at least until I get more knowledge of x86
> architecture - it may take a lot of time because I'm also studying other
> subsystems at the same time).

...

> region
>>>
>>> + * @rdtgrp: resource group to which the pseudo-locked region belongs
>>> + * @sel: cache level selector
>>
>> This is not correct. A more accurate description could be:
>> "select which measurement to perform on pseudo-locked region"
>>
> Here it is an example of my lack of knowledge/experience. Obviously, I'll
> rewrite it according to your review.
> 
> To summarize: as soon as possible I'll submit a v2 patch with the kernel-doc
> fixes that I think I can understand. I am pretty sure that some fixes will not
> be to your standards and that for what regards some others I will not even be
> able to attempt to fix them :(
> 

Thank you for giving me insight into your status and plans. Your 
approach sounds reasonable to me. When you submit fixes to parts you 
understand I can provide feedback based on my understandings to 
collaborate towards improved kernel-doc in this area.

Thank you

Reinette


