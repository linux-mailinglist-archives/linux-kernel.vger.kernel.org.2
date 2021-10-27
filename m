Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E5643CEFB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242992AbhJ0QwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:52:24 -0400
Received: from foss.arm.com ([217.140.110.172]:45342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242994AbhJ0QwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:52:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EF44106F;
        Wed, 27 Oct 2021 09:49:57 -0700 (PDT)
Received: from [10.1.196.31] (eglon.cambridge.arm.com [10.1.196.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FB603F70D;
        Wed, 27 Oct 2021 09:49:55 -0700 (PDT)
Subject: Re: [PATCH v2 10/23] x86/resctrl: Remove architecture copy of
 mbps_val
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
References: <20211001160302.31189-1-james.morse@arm.com>
 <20211001160302.31189-11-james.morse@arm.com>
 <81977073-3b1b-b8e1-6aec-828225e3a531@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <c87201b6-2bad-4424-6280-5ee6ea47fea2@arm.com>
Date:   Wed, 27 Oct 2021 17:49:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <81977073-3b1b-b8e1-6aec-828225e3a531@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 15/10/2021 23:27, Reinette Chatre wrote:
> On 10/1/2021 9:02 AM, James Morse wrote:
>> The resctrl arch code provides a second configuration array mbps_val[]
>> for the MBA software controller.
>>
>> Since resctrl switched over to allocating and freeing its own array
>> when needed, nothing uses the arch code version.
> 
> With the previous changes this is true, that this array is no longer used. Even so, the
> code removed in this patch is not just the usage of the array but also its management ...
> especially how and when it is reset. While the array is no longer used I think it is still
> important to ensure that all the array management is handled in the new mpbs_val array.
> Perhaps just help the reader by stating that the values of the new array never needs to be
> reset since it is always recreated while the previous array stuck around during umount/mount.

I've split those changes out as a separate patch which appears at the end of the series,
meaning the lifecycle stuff is unchanged by this point.


Thanks,

James

