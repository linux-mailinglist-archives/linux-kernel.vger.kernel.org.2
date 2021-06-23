Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5F23B18B7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 13:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFWLTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 07:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhFWLTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:19:20 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EE8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 04:17:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4G911k5VNVz9sWc;
        Wed, 23 Jun 2021 21:16:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1624447019;
        bh=wmQj+u1hPwTTqYQ6rEMEPSf63LiUs3skDiFe2aRX8Ag=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Je4LaOMmfEcosYnT5UzuA6yIBL35UPkM4HxyXBZTLQk27MBKOCdfgUx8P6w84bylY
         9h6RpFO47/cgwPka7uN7z7lKAquq2yQqx+NBDsGNSZlZCdIc3wT3akQYtExw2ZF768
         ypCO3FtmwAL/8gnxqaty4dXc0SWDbr0ZlKAa0dbQMb5wOtJH7pb1dS9INl1aBJ/ryJ
         9H3gq6Ve3EYUP2hbj986m+nBgohXZsOD4LbI6ohz7hrIBH4o+MTlMoup7LyZq/SPCC
         Hfk/xPq4c23k5Iv+F7YXNXeH6RbTktk0ndPVCKIIJPMm0zMXbSYkB+YS8jbaCpyIzU
         Q/o6xKoZpJWng==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Zijlstra <peterz@infradead.org>,
        kajoljain <kjain@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
        santosh@fossix.org, aneesh.kumar@linux.ibm.com,
        vaibhav@linux.ibm.com, dan.j.williams@intel.com,
        ira.weiny@intel.com, atrajeev@linux.vnet.ibm.com,
        tglx@linutronix.de, rnsastry@linux.ibm.com
Subject: Re: [PATCH v3 0/4] Add perf interface to expose nvdimm
In-Reply-To: <YNLxRz1w9IeatIKW@hirez.programming.kicks-ass.net>
References: <20210617132617.99529-1-kjain@linux.ibm.com>
 <YNHiRO11E9yYS6mv@hirez.programming.kicks-ass.net>
 <cea827fe-62d4-95fe-b81f-5c7bebe4a6f0@linux.ibm.com>
 <YNLxRz1w9IeatIKW@hirez.programming.kicks-ass.net>
Date:   Wed, 23 Jun 2021 21:16:56 +1000
Message-ID: <87fsx825lj.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Wed, Jun 23, 2021 at 01:40:38PM +0530, kajoljain wrote:
>> 
>> On 6/22/21 6:44 PM, Peter Zijlstra wrote:
>> > On Thu, Jun 17, 2021 at 06:56:13PM +0530, Kajol Jain wrote:
>> >> ---
>> >> Kajol Jain (4):
>> >>   drivers/nvdimm: Add nvdimm pmu structure
>> >>   drivers/nvdimm: Add perf interface to expose nvdimm performance stats
>> >>   powerpc/papr_scm: Add perf interface support
>> >>   powerpc/papr_scm: Document papr_scm sysfs event format entries
>> > 
>> > Don't see anything obviously wrong with this one.
>> > 
>> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> > 
>> 
>> Hi Peter,
>>     Thanks for reviewing the patch. Can you help me on how to take 
>> these patches to linus tree or can you take it?
>
> I would expect either the NVDIMM or PPC maintainers to take this. Dan,
> Michael ?

I can take it but would need Acks from nvdimm folks.

cheers
