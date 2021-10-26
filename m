Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F238A43BCAA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 23:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbhJZVwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 17:52:18 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.4]:46255 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237437AbhJZVvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 17:51:53 -0400
X-Greylist: delayed 1278 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Oct 2021 17:51:52 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 5EE9ED8E01
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 16:25:53 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id fSTSmP67w6dDyfSTTmzDXu; Tue, 26 Oct 2021 14:51:13 -0500
X-Authority-Reason: nr=8
Received: from host-79-18-63-114.retail.telecomitalia.it ([79.18.63.114]:60832 helo=[10.0.0.35])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mfSTR-0021ZQ-Aa; Tue, 26 Oct 2021 14:51:05 -0500
Message-ID: <46ffc66d-26da-7ac5-0f3f-e86594d2b60c@kernel.org>
Date:   Tue, 26 Oct 2021 21:50:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH V5 10/20] rtla/osnoise: Add osnoise top mode
Content-Language: en-US
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1635181938.git.bristot@kernel.org>
 <6252864d71e1864f60c25c716bc773861929e3fb.1635181938.git.bristot@kernel.org>
 <YXgtnEPcT8vay1wI@geo.homenetwork>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <YXgtnEPcT8vay1wI@geo.homenetwork>
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
X-Exim-ID: 1mfSTR-0021ZQ-Aa
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-18-63-114.retail.telecomitalia.it ([10.0.0.35]) [79.18.63.114]:60832
X-Source-Auth: kernel@bristot.me
X-Email-Count: 29
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/21 18:32, Tao Zhou wrote:
>> +	if (params->stop_us)
>> +		osnoise_set_stop_us(tool->context, params->stop_us);
> osnoise_set_stop_us() also need to check return value feels by me.
> 
>> +
>> +	if (params->stop_total_us)
>> +		osnoise_set_stop_total_us(tool->context, params->stop_total_us);
> The same here. Also need to check the return value.
> 
> PATCH 10 also has these two places(call the two functions) that not check
> the return value.
> 
> Or I am wrong.


You are right, reviewing that.

Thanks!
-- Daniel

> 
> 
> Thanks,
> Tao
> 

