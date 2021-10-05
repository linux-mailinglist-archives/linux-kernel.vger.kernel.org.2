Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FB742267E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 14:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbhJEM32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 08:29:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50608 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbhJEM3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:29:17 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633436846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3kK9xoGY9q1BQ0iWLjqmNJRsd+6Y8c8/p/triD44+A8=;
        b=dbEzOarTS2bW+LMoROS2TCV2vrfbcgNAhGt0RycohPw2dlgEr6+HZCNm3pmL5PdQSkN70W
        VSUW3vhx/2ccVbRSTvyTNTGk+G8/6wLucHAqHF0xfKR6Cb4C8uAzajPCXpfBBhpnYoBSha
        zn1CQs+lojcAX+wUze97tc8N9I+0jZpKX6k/dnx1lWwjYRDwuNzKjTcN0LKWXxxYx5CSQW
        P6qy1+7WBQ5xY++7Ye4nyxAD2ay0xUIjxnWgU0jr9H1QeTXEr00VbPm1JeQ7dPsDO2Jb29
        ZirgvEWCaFsU0emZc8C/Oi5mZDscR+lS1h183yq+6bph2TbosV0cS2VPr+3tWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633436846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3kK9xoGY9q1BQ0iWLjqmNJRsd+6Y8c8/p/triD44+A8=;
        b=/NulxX9OXeYr5zfckOvKqSRlTF4Ndg3DaYtDB4G9qUMLP+3WMdJjPmkGHLn6nFGyPH/Yb1
        Gna3QtBEOiTHaDAA==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, mingo@kernel.org, x86@kernel.org,
        len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 15/29] x86/arch_prctl: Create
 ARCH_SET_STATE_ENABLE/ARCH_GET_STATE_ENABLE
In-Reply-To: <YVw1vvy0QUKcKaxU@hirez.programming.kicks-ass.net>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
 <20211001223728.9309-16-chang.seok.bae@intel.com> <87o884fh3g.ffs@tglx>
 <87ilybg5ta.ffs@tglx> <YVw1vvy0QUKcKaxU@hirez.programming.kicks-ass.net>
Date:   Tue, 05 Oct 2021 14:27:25 +0200
Message-ID: <878rz7fyhe.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05 2021 at 13:23, Peter Zijlstra wrote:
> On Tue, Oct 05, 2021 at 11:49:05AM +0200, Thomas Gleixner wrote:
>> So this gives us two options:
>> 
>>    1) Bitmap with proper sanity checks
>> 
>>       reject (1 << 17) and (1 << 18)
>>       grant (1 << 17 | 1 << 18)
>> 
>>       but for sanity sake and also for ease of filtering, we want to
>>       restrict a permission request to one functional block at a time.
>> 
>>       #define X86_XCOMP_AMX	(1 << 17 | 1 << 18)
>>       #define X86_XCOMP_XYZ1    (1 << 19)
>> 
>>       But that gets a bit odd when there is a component which depends on
>>       others:
>> 
>>       #define X86_XCOMP_XYZ2    (1 << 19 | 1 << 20)
>> 
>>    2) Facility based numerical interface, i.e.
>> 
>>       #define X86_XCOMP_AMX	1
>>       #define X86_XCOMP_XYZ1    2
>>       #define X86_XCOMP_XYZ2    3
>> 
>>       is way simpler to understand IMO.
>
> I'm thinking 2 makes most sense. Perhaps we could use the highest
> feature number involved in the facility to denote it? The rationale
> being that we don't have to invent yet another enumeration and it's
> easier to figure out what's what.

That makes sense. So the above would be:

      #define X86_XCOMP_AMX	18      (implies 17)
      #define X86_XCOMP_XYZ1    19
      #define X86_XCOMP_XYZ2    20      (implies 19)

Thanks,

        tglx
