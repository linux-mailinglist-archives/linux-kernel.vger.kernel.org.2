Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F3140FE46
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343883AbhIQQ7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:59:46 -0400
Received: from foss.arm.com ([217.140.110.172]:55646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245434AbhIQQ7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:59:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6F6F1063;
        Fri, 17 Sep 2021 09:58:10 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A69823F59C;
        Fri, 17 Sep 2021 09:58:08 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH v1 11/20] x86/resctrl: Calculate bandwidth from the total
 bytes counter
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
        lcherian@marvell.com, bobo.shaobowang@huawei.com
References: <20210729223610.29373-1-james.morse@arm.com>
 <20210729223610.29373-12-james.morse@arm.com>
 <15febd4d-11d9-8456-60ee-994e66efdc98@intel.com>
Message-ID: <c55d1433-2573-4458-0175-95f2a4b259b8@arm.com>
Date:   Fri, 17 Sep 2021 17:58:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <15febd4d-11d9-8456-60ee-994e66efdc98@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 01/09/2021 22:31, Reinette Chatre wrote:
> Apologies but I find the changelog hard to understand.

No problem, clearly room for improvement!


> On 7/29/2021 3:36 PM, James Morse wrote:
>> mbm_bw_count() maintains its own copy of prev_msr to allow it to
>> calculate the bandwidth as the number of chunks counted since the
>> last time mbm_bw_count() was invoked.
> 
> ok, I understand there is an extra copy

The point I was trying to get across here is mbm_bw_count() is holding a hardware value,
which means it isn't architecture agnostic. Calculating bytes first paves the way to using
an arch helper that returns bytes.

This was originally later in the series, and it looks like it got damaged during a rebase.
I've rewritten it to calculate bandwidth based on the value read by the previous
__mon_event_count(), this is simpler and less noisy for the rest of the series.



Thanks,

James
