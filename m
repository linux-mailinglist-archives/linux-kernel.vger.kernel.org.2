Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFBB43CEB1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238165AbhJ0Q1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:27:12 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.82]:42390 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234414AbhJ0Q1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:27:11 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 6AC0F2FC0B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:24:10 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id flikmrRj9G0jLflikmwSvv; Wed, 27 Oct 2021 11:24:10 -0500
X-Authority-Reason: nr=8
Received: from host-79-18-63-114.retail.telecomitalia.it ([79.18.63.114]:46382 helo=[10.0.0.43])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mflii-001LYj-Vg; Wed, 27 Oct 2021 11:24:09 -0500
Message-ID: <575a2d6b-9e37-5566-9343-e77e4f4e8c1f@kernel.org>
Date:   Wed, 27 Oct 2021 18:24:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH V6 08/20] rtla: Helper functions for rtla
Content-Language: en-US
To:     Tao Zhou <tao.zhou@linux.dev>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1635284863.git.bristot@kernel.org>
 <183637700a31169e5d6d1c8a827c5365599ec806.1635284863.git.bristot@kernel.org>
 <YXlcBhnqiKVxV4UX@geo.homenetwork>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <YXlcBhnqiKVxV4UX@geo.homenetwork>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.18.63.114
X-Source-L: No
X-Exim-ID: 1mflii-001LYj-Vg
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-18-63-114.retail.telecomitalia.it ([10.0.0.43]) [79.18.63.114]:46382
X-Source-Auth: kernel@bristot.me
X-Email-Count: 1
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/21 16:02, Tao Zhou wrote:
>> +/*
>> + * parse_ns_duration - parse duration with ns/us/ms/s converting it to nanoseconds
>> + */
>> +long parse_ns_duration(char *val)
>> +{
>> +	char *end;
>> +	long t;
>> +
>> +	t = strtol(val, &end, 10);
>> +
>> +	if (end) {
>> +		if (!strncmp(end, "ns", 2)) {
>> +			return t;
>> +		} else if (!strncmp(end, "us", 2)) {
>> +			t *= 1000;
>> +			return t;
>> +		} else if (!strncmp(end, "ms", 2)) {
>> +			t *= 1000 * 1000;
>> +			return t;
>> +		} else if (!strncmp(end, "s", 1)) {
>> +			t *= 1000 * 1000 * 100;
>                                ^^^
> Ah, 1000 not 100. 

yep, I will fix that. Thanks!

Steven, I am tempted to start placing fixes patches on top of this series. What
do you think?

-- Daniel
