Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0485736FD4B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhD3PF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 11:05:26 -0400
Received: from foss.arm.com ([217.140.110.172]:49578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229798AbhD3PFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 11:05:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80699101E;
        Fri, 30 Apr 2021 08:04:36 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E2A63F70D;
        Fri, 30 Apr 2021 08:04:33 -0700 (PDT)
Subject: Re: [PATCH v2] sched: Fix out-of-bound access in uclamp
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
References: <20210429152656.4118460-1-qperret@google.com>
 <CAKfTPtAfgVnMYkY_M+SDmNQDb_EsxSctQw-fkt2WJhczZakOjQ@mail.gmail.com>
 <YIu/EjZ8QsEl9sum@google.com>
 <CAKfTPtDOuB0UzZM5OtNzCUABftz_A40Z4W1z9OAORzFitfPDEQ@mail.gmail.com>
 <YIvQoG52Vk96DJQ/@google.com>
 <CAKfTPtB-0N7ogk0snCgj78zDrXRWgFUL=G7MoRDn+Bg8Hnk-PQ@mail.gmail.com>
 <b6737247-ca02-e197-70c7-020952d95c1b@arm.com> <YIwCvkfrPGkyk17d@google.com>
 <CAKfTPtBNsarv7REyNFeU5e=-K6OiaR2hxPFm6Ttca5UcnWB6Wg@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <98a96d35-a6ae-f913-13f9-b5c17689039c@arm.com>
Date:   Fri, 30 Apr 2021 17:04:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBNsarv7REyNFeU5e=-K6OiaR2hxPFm6Ttca5UcnWB6Wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2021 16:16, Vincent Guittot wrote:
> On Fri, 30 Apr 2021 at 15:14, Quentin Perret <qperret@google.com> wrote:
>>
>> On Friday 30 Apr 2021 at 15:00:00 (+0200), Dietmar Eggemann wrote:
>>> On 30/04/2021 14:03, Vincent Guittot wrote:

[...]

>>> Looks like this will fix a lot of possible configs:
>>>
>>> nbr buckets 1-4, 7-8, 10-12, 14-17, *20*, 26, 29-32 ...
>>>
>>> We would still introduce larger last buckets, right?
>>
>> Indeed. The only better alternative I could see was to 'spread' the
>> error accross multiple buckets (e.g. make the last few buckets a bit
>> bigger instead of having all of it accumulated on the last one), but not
>> sure it is worth the overhead.
> 
> I don't think it's worth the overhead.

Me neither.

[...]
