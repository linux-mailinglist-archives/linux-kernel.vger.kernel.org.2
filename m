Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA5D34FE1B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbhCaKcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:32:53 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:47716 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbhCaKc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jywqj0/5nQRmSaiOrkFqF+uW06+SNK77MOTnPl8WwRo=; b=vnxS5fg14bkCdasD1bCZCalAF7
        SJ7JoCLhsP2KpgqpKFMnsEgA+2oT37pG7g1mCMPHWUgyfZb5eUF5L1a3+VLEhAoYiowUyGYhty2Rd
        GYuaqhqi6BGaU8PqndtutXNV4CRTtsRPzCBTqaKePiqpTBrI7edVB4eGwJG8Pe7MiIiU=;
Received: from 198-48-224-11.cpe.pppoe.ca ([198.48.224.11] helo=[192.168.1.180])
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <nfraser@codeweavers.com>)
        id 1lRY9B-00020L-Ge; Wed, 31 Mar 2021 05:32:25 -0500
Subject: Re: [PATCH] perf data: export to JSON
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        linux-kernel@vger.kernel.org
References: <4687bbe5-4ff3-af3a-fcec-06d8bfe5591c@codeweavers.com>
 <YFs/B0/S7IEKeL/Y@kernel.org>
From:   Nicholas Fraser <nfraser@codeweavers.com>
Message-ID: <8114de32-9874-450e-8d48-8fd4389449fa@codeweavers.com>
Date:   Wed, 31 Mar 2021 06:32:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFs/B0/S7IEKeL/Y@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

Thanks for the review. I'll send a replacement patch with your suggestions.

On 2021-03-24 9:30 a.m., Arnaldo Carvalho de Melo wrote:
> Do you plan to output the headers too? I think we should, for
> completeness.

I've added the headers, at least the ones that seemed important or easy to
output. The result looks like this:

	"headers": {
			"header-version": 1,
			"captured-on": "2021-03-30T19:24:22Z",
			"data-offset": 304,
			"data-size": 35000,
			"feat-offset": 35304,
			"hostname": "foundry",
			"os-release": "5.11.8-arch1-1",
			"arch": "x86_64",
			"cpu-desc": "Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz",
			"cpuid": "GenuineIntel,6,142,10",
			"nrcpus-online": 8,
			"nrcpus-avail": 8,
			"perf-version": "5.11.gf40ddce88593",
			"cmdline": [
				"/usr/bin/perf",
				"record",
				"vkcube"
			]
	},

(I've thus far avoided outputting anything we don't use; I'm unlikely to design
a useful format for data if I don't have a real use case for it. We will
probably make use of some of the headers though so it's worth doing now.)

Nick
