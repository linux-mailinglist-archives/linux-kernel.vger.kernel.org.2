Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6363DD234
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 10:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhHBIn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 04:43:56 -0400
Received: from foss.arm.com ([217.140.110.172]:60140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232433AbhHBInz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 04:43:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97CC311D4;
        Mon,  2 Aug 2021 01:43:45 -0700 (PDT)
Received: from [192.168.1.13] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CB5F3F719;
        Mon,  2 Aug 2021 01:43:44 -0700 (PDT)
Subject: Re: WARNING: CPU: 112 PID: 2041 at kernel/sched/sched.h:1453
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     CKI Project <cki-project@redhat.com>, linux-kernel@vger.kernel.org,
        nathan@kernel.org, Memory Management <mm-qe@redhat.com>,
        linux-arm-kernel@lists.infradead.org
References: <CA+QYu4oOgrb8n=Qyuky-M0dYPEo_HNMdbNuj2SF4a=aQTE_xvw@mail.gmail.com>
 <d86333e7-bcde-2adb-e566-21ec97cda8bf@arm.com>
 <CA+QYu4rCRR_pNQVxSwGpzcLWJKLUA3F7LAtBiU9hPzz3D0k0Cg@mail.gmail.com>
 <f5b4beb9-4e75-0f4e-da8b-b7ccc12fee68@arm.com>
 <1ea2fa5c-ae81-2389-7f02-2227636582e4@arm.com>
 <CA+QYu4q3k8d60u5BwLy+mhRFjBd0cukiSmWAXRiMN2SbZ1XavQ@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <972ea6f3-a000-84ee-cde0-7dc0f83d59fd@arm.com>
Date:   Mon, 2 Aug 2021 10:43:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CA+QYu4q3k8d60u5BwLy+mhRFjBd0cukiSmWAXRiMN2SbZ1XavQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2021 17:23, Bruno Goncalves wrote:
> On Fri, Jul 30, 2021 at 2:22 PM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 29/07/2021 16:38, Dietmar Eggemann wrote:
>>> On 29/07/2021 14:36, Bruno Goncalves wrote:
>>>> On Wed, Jul 28, 2021 at 5:55 PM Dietmar Eggemann
>>>> <dietmar.eggemann@arm.com> wrote:
>>>>>
>>>>> On 28/07/2021 15:11, Bruno Goncalves wrote:

[...]

>> The task causing this seem to be the new `cppc_fie` DL task introduced
>> by commit 1eb5dde674f5 "cpufreq: CPPC: Add support for frequency
>> invariance" in v5.14-rc1.
>>
>> With `CONFIG_ACPI_CPPC_CPUFREQ_FIE=y` and schedutil cpufreq governor on
>> slow-switching system:
>>
>> DL task curr=`sugov:X` makes p=`cppc_fie` migrate and since it is in
>> `non_contending` state, migrate_task_rq_dl() calls
>>
>>   sub_running_bw()->__sub_running_bw()->cpufreq_update_util()->
>>   rq_clock()->assert_clock_updated()
>>
>> on p.
>>
>> Can you try this snippet? It should fix it.
> 
> Thank you, I've tried the patch and it fixes the issue.

Thanks for testing! Let me send out a proper patch then.
