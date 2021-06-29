Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBD03B771A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 19:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbhF2RYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 13:24:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45275 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbhF2RYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 13:24:04 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lyHQS-00034B-QX; Tue, 29 Jun 2021 17:21:32 +0000
Subject: Re: [PATCH][next] trace: osnoise: Fix u64 less than zero comparison
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20210629165245.42157-1-colin.king@canonical.com>
 <c74e711e-71c9-df9c-8406-b9e92ef12da0@redhat.com>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <e36f61af-4fbe-42cf-f26d-229f940e8fc9@canonical.com>
Date:   Tue, 29 Jun 2021 18:21:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c74e711e-71c9-df9c-8406-b9e92ef12da0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2021 18:19, Daniel Bristot de Oliveira wrote:
> On 6/29/21 6:52 PM, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The less than zero comparison of the u64 variable 'noise' is always
>> false because the variable is unsigned. Since the time_sub macro
>> can potentially return an -ve vale, make the variable a s64 to
>> fix the issue.
> 
> Ops! concurrent bug fixing.

Well, shows static analysis is doing it's thing and I'm not being
vigilant enough by spotting that Dan found it earlier :-)

> 
> Dan Carpenter reported the same bug (and another problem), and I was working in
> the patches... I saw yours after sending his ones:
> 
> https://lore.kernel.org/lkml/acd7cd6e7d56b798a298c3bc8139a390b3c4ab52.1624986368.git.bristot@redhat.com/
> 
> The patches do the same fix, but there it also:
> 
>  - Made also max_noise s64 (it is snapshot of noise).
>  - Arranged the declarations in the inverted christmas tree.
> 
>> Addresses-Coverity: ("Unsigned compared against 0")
>> Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Steven, can we merge the flags?
> 
> -- Daniel
> 
>> ---
>>  kernel/trace/trace_osnoise.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
>> index 38aa5e208ffd..02c984560ceb 100644
>> --- a/kernel/trace/trace_osnoise.c
>> +++ b/kernel/trace/trace_osnoise.c
>> @@ -1040,11 +1040,11 @@ static void osnoise_stop_tracing(void)
>>  static int run_osnoise(void)
>>  {
>>  	struct osnoise_variables *osn_var = this_cpu_osn_var();
>> -	u64 noise = 0, sum_noise = 0, max_noise = 0;
>> +	u64 sum_noise = 0, max_noise = 0;
>>  	struct trace_array *tr = osnoise_trace;
>>  	u64 start, sample, last_sample;
>>  	u64 last_int_count, int_count;
>> -	s64 total, last_total = 0;
>> +	s64 noise = 0, total, last_total = 0;
>>  	struct osnoise_sample s;
>>  	unsigned int threshold;
>>  	int hw_count = 0;
>>
> 

