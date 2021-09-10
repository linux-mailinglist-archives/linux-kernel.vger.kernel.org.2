Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03DE406D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 16:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhIJORs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 10:17:48 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40641 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233806AbhIJORp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 10:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1631283390;
        bh=K/rOvSuYgaLnknL2KSEDyeYf85pxBp1RfczcK2sf6XI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Hj8dW57Pww3U3V7+GtXE5mdCuH0Ws+FugjziObUxVTAR4zC9IcQbj38K9e2XVgkp2
         BqLpy8WpZ4uR7klbK/lIGyNdRP7PmMI3/uczieTB8dotWagtPC5xP1r02lrXNZdXF/
         Pi6spJzIvNvsPeuZvWwLQtY0Ajf0y4TgmBMR5D8uYlesS/2I0wqP/Q+iGS4/GcG39t
         IdJbQf+fcKLszSbCKyfoUuRFuthd2+kKvQYWRtox82H7Lil0TqgDOLqGev43ds4j0k
         T7RYG69xX8EMFZ1JcmtDZBQRAEZeuR8/zhx0OAFN/Bu5tiB5fK4qhs+LxWnBeWjTCz
         CNmaogFhUZX3A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4H5dGP47xJz9sW4;
        Sat, 11 Sep 2021 00:16:29 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com,
        atrajeev@linux.vnet.ibm.com, maddy@linux.ibm.com
Subject: Re: [PATCH v1 01/13] perf/core: add union to struct perf_branch_entry
In-Reply-To: <878s04my3b.fsf@mpe.ellerman.id.au>
References: <20210909075700.4025355-1-eranian@google.com>
 <20210909075700.4025355-2-eranian@google.com>
 <20210909190342.GE4323@worktop.programming.kicks-ass.net>
 <878s04my3b.fsf@mpe.ellerman.id.au>
Date:   Sat, 11 Sep 2021 00:16:20 +1000
Message-ID: <875yv8ms7f.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> Peter Zijlstra <peterz@infradead.org> writes:
>> On Thu, Sep 09, 2021 at 12:56:48AM -0700, Stephane Eranian wrote:
>>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>>> index f92880a15645..eb11f383f4be 100644
>>> --- a/include/uapi/linux/perf_event.h
>>> +++ b/include/uapi/linux/perf_event.h
>>> @@ -1329,13 +1329,18 @@ union perf_mem_data_src {
>>>  struct perf_branch_entry {
>>>  	__u64	from;
>>>  	__u64	to;
>>> -	__u64	mispred:1,  /* target mispredicted */
>>> -		predicted:1,/* target predicted */
>>> -		in_tx:1,    /* in transaction */
>>> -		abort:1,    /* transaction abort */
>>> -		cycles:16,  /* cycle count to last branch */
>>> -		type:4,     /* branch type */
>>> -		reserved:40;
>>> +	union {
>>> +		__u64	val;	    /* to make it easier to clear all fields */
>>> +		struct {
>>> +			__u64	mispred:1,  /* target mispredicted */
>>> +				predicted:1,/* target predicted */
>>> +				in_tx:1,    /* in transaction */
>>> +				abort:1,    /* transaction abort */
>>> +				cycles:16,  /* cycle count to last branch */
>>> +				type:4,     /* branch type */
>>> +				reserved:40;
>>> +		};
>>> +	};
>>>  };
>>
>>
>> Hurpmh... all other bitfields have ENDIAN_BITFIELD things except this
>> one. Power folks, could you please have a look?
>
> The bit number of each field changes between big and little endian, but
> as long as kernel and userspace are the same endian, and both only
> access values via the bitfields then it works.
...
>
> It does look like we have a bug in perf tool though, if I take a
> perf.data from a big endian system to a little endian one I don't see
> any of the branch flags decoded. eg:
>
> BE:
>
> 2413132652524 0x1db8 [0x2d0]: PERF_RECORD_SAMPLE(IP, 0x1): 5279/5279: 0xc00000000045c028 period: 923003 addr: 0
> ... branch stack: nr:28
> .....  0: c00000000045c028 -> c00000000dce7604 0 cycles  P   0
>
> LE:
>
> 2413132652524 0x1db8 [0x2d0]: PERF_RECORD_SAMPLE(IP, 0x1): 5279/5279: 0xc00000000045c028 period: 923003 addr: 0
> ... branch stack: nr:28
> .....  0: c00000000045c028 -> c00000000dce7604 0 cycles      0
>                                                          ^
>                                                          missing P
>
> I guess we're missing a byte swap somewhere.

Ugh. We _do_ have a byte swap, but we also need a bit swap.

That works for the single bit fields, not sure if it will for the
multi-bit fields.

So that's a bit of a mess :/

cheers
