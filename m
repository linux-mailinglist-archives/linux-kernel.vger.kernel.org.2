Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1576358B3B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhDHRVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:21:08 -0400
Received: from foss.arm.com ([217.140.110.172]:55416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231716AbhDHRVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:21:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B0A7106F;
        Thu,  8 Apr 2021 10:20:48 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 129FF3F792;
        Thu,  8 Apr 2021 10:20:45 -0700 (PDT)
Subject: Re: [PATCH v2 02/24] x86/resctrl: Split struct rdt_domain
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20210312175849.8327-1-james.morse@arm.com>
 <20210312175849.8327-3-james.morse@arm.com>
 <9cb3f9c9-8295-6e40-9f98-1944b9b3c59b@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <c8c1a559-9045-a28c-46c0-dddeb9b38a14@arm.com>
Date:   Thu, 8 Apr 2021 18:20:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <9cb3f9c9-8295-6e40-9f98-1944b9b3c59b@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 31/03/2021 22:36, Reinette Chatre wrote:
> On 3/12/2021 9:58 AM, James Morse wrote:
>> resctrl is the defacto Linux ABI for SoC resource partitioning features.
>> To support it on another architecture, it needs to be abstracted from
>> the features provided by Intel RDT and AMD PQoS, and moved to /fs/.
>>
>> Split struct rdt_domain up too. Move everything that that is particular
> 
> s/that that/that/
> 
>> to resctrl into a new header file. resctrl code paths touching a 'hw'
>> struct indicates where an abstraction is needed.
> 
> Similar to previous patch it would help to explain how this split was chosen. For example,
> why are the CPUs to which a resource is associated not considered a hardware property?

Similarly, because the meaning of those CPUs doesn't differ or change between architectures.

I've expanded the middle paragraph in the commit message to explain why the arch specific
things are arch specific:
| Continue by splitting struct rdt_domain, into an architecture private
| 'hw' struct, which contains the common resctrl structure that would be
| used by any architecture.
|
| The hardware values in ctrl_val and mbps_val need to be accessed via
| helpers to allow another architecture to convert these into a different
| format if necessary.
|
| After this split, filesystem code code paths touching a 'hw' struct
| indicates where an abstraction is needed.

and similarly changed the kernel doc comment.


Let me know if you prefer some other struct name.


Thanks,

James
