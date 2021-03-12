Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C713339453
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhCLRKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:10:36 -0500
Received: from foss.arm.com ([217.140.110.172]:57570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231906AbhCLRK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:10:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7859511B3;
        Fri, 12 Mar 2021 09:10:29 -0800 (PST)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D787B3F7D7;
        Fri, 12 Mar 2021 09:10:27 -0800 (PST)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH 04/24] x86/resctrl: Add a separate schema list for resctrl
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-5-james.morse@arm.com>
 <8c95f0d5-c543-a5bf-b3b6-df5c7a6f6c3c@intel.com>
Message-ID: <3fd053b1-d25f-dbdd-47f4-54a5b1df349c@arm.com>
Date:   Fri, 12 Mar 2021 17:10:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <8c95f0d5-c543-a5bf-b3b6-df5c7a6f6c3c@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette

On 17/11/2020 21:29, Reinette Chatre wrote:
> On 10/30/2020 9:11 AM, James Morse wrote:
>> To support multiple architectures, the resctrl code needs to be split
>> into a 'fs' specific part in core code, and an arch-specific backend.
>>
>> It should be difficult for the arch-specific backends to diverge,
>> supporting slightly different ABIs for user-space. For example,
>> generating, parsing and validating the schema configuration values
>> should be done in what becomes the core code to prevent divergence.
>> Today, the schema emerge from which entries in the rdt_resources_all
>> array the arch code has chosen to enable.

>> Start by creating a struct resctrl_schema, which will eventually hold
>> the name and pending configuration values for resctrl.
> 
> Looking ahead I am not able to identify the "pending configuration values" that will
> eventually be held in resctrl_schema. With entire series applied there is the name, type,
> num_closid, and pointer to the resource.

Looks like a vestige from an earlier version:
This referred to the staged configuration in a much earlier version, but this has to stay
in the domain structure as its per-domain.

This should refer to the type that is used as an index into the domain's staged
configuration array.


Thanks,

James
