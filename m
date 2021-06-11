Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB453A4866
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhFKSGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:06:51 -0400
Received: from foss.arm.com ([217.140.110.172]:37360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231639AbhFKSGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:06:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66AF71FB;
        Fri, 11 Jun 2021 11:04:36 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A467C3F719;
        Fri, 11 Jun 2021 11:04:34 -0700 (PDT)
Subject: Re: [PATCH v3 00/24] x86/resctrl: Merge the CDP resources
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
References: <20210519162424.27654-1-james.morse@arm.com>
 <5900da79-b21e-e41c-6348-d9b24cf65967@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <db3053e9-24f0-9716-4ee9-e8b608a16a76@arm.com>
Date:   Fri, 11 Jun 2021 19:04:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <5900da79-b21e-e41c-6348-d9b24cf65967@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 05/06/2021 00:56, Reinette Chatre wrote:
> On 5/19/2021 9:24 AM, James Morse wrote:
>> Thanks to Reinette comments on v2. The major changes in v3 is a juggling
>> of all the commit messages. One patch got merged into its parent, and
>> the msr_param range thing got pulled out into its own patch. Otherwise
>> changes are noted in the commit messages.
> 
> Thank you very much for reworking the commit messages. The additional context do make
> these changes easier to digest.
> 
> On a high level the goal of these patches look good to me but the patches themselves do
> have a few formatting issues and spelling mistakes and while bisectability is a stated
> goal of this work I was surprised to find that one patch ("x86/resctrl: Apply offset
> correction when config is staged") cannot compile.

Huh. I remember thinking I didn't need to retest the whole tree after some minor change,
evidently I was very wrong!


> I started to document the formatting issues but found myself duplicating a lot of what
> checkpatch.pl would already tell you. Could you please ensure that this series gets a
> clean bill of health when using "checkpatch.pl --strict"?

Sure. (I've become so accustomed to ignoring it due to its allergy to assembly, that I
don't bother running it)


> I also recommend the codespell
> option ... there are a few typos in this series that checkpatch.pl was able to pick up.

Aha, that's a new one, my existing way of doing that only works for commit messages.


> It
> would be more efficient to review this series from such a baseline.

Lookout for v4 on monday!


Thanks,

James
