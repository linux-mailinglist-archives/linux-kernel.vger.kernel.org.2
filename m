Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FBD367717
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 04:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhDVCDJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Apr 2021 22:03:09 -0400
Received: from mx21.baidu.com ([220.181.3.85]:55680 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229706AbhDVCDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 22:03:08 -0400
X-Greylist: delayed 944 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Apr 2021 22:03:08 EDT
Received: from Bc-Mail-Ex13.internal.baidu.com (unknown [172.31.51.53])
        by Forcepoint Email with ESMTPS id 99CC11396A4A963E4274;
        Thu, 22 Apr 2021 09:46:48 +0800 (CST)
Received: from BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38) by
 Bc-Mail-Ex13.internal.baidu.com (172.31.51.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.4; Thu, 22 Apr 2021 09:46:48 +0800
Received: from BJHW-Mail-Ex15.internal.baidu.com ([100.100.100.38]) by
 BJHW-Mail-Ex15.internal.baidu.com ([100.100.100.38]) with mapi id
 15.01.2242.008; Thu, 22 Apr 2021 09:46:48 +0800
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: RE: [PATCH][resend] perf x86 kvm-stat: support to analyze kvm msr
Thread-Topic: [PATCH][resend] perf x86 kvm-stat: support to analyze kvm msr
Thread-Index: AQHXMcT1qS2UcW6jEU+zCGd99HRjYaq/zwqA
Date:   Thu, 22 Apr 2021 01:46:48 +0000
Message-ID: <a9a29f801740491bb97e765ff58a9772@baidu.com>
References: <1618470001-7239-1-git-send-email-lirongqing@baidu.com>
In-Reply-To: <1618470001-7239-1-git-send-email-lirongqing@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.198.62]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping

-Li

> -----Original Message-----
> From: Li,Rongqing
> Sent: Thursday, April 15, 2021 3:00 PM
> To: linux-kernel@vger.kernel.org; namhyung@kernel.org; jolsa@redhat.com;
> alexander.shishkin@linux.intel.com; mark.rutland@arm.com;
> acme@kernel.org; mingo@redhat.com; peterz@infradead.org; Li,Rongqing
> <lirongqing@baidu.com>
> Subject: [PATCH][resend] perf x86 kvm-stat: support to analyze kvm msr
> 
> From: Lei Zhao <zhaolei27@baidu.com>
> 
> usage:
>     - kvm stat
>       run a command and gather performance counter statistics
> 
>     - show the result:
>       perf kvm stat report --event=msr
> 
> See the msr events:
> 
> Analyze events for all VMs, all VCPUs:
> 
> MSR Access Samples  Samples% Time%  Min Time Max Time  Avg time
> 
>   0x6e0:W   67007  98.17%   98.31%  0.59us   10.69us  0.90us ( +-
> 0.10% )
>   0x830:W    1186   1.74%    1.60%  0.53us  108.34us  0.82us ( +-
> 11.02% )
>    0x3b:R      66   0.10%    0.09%  0.56us    1.26us  0.80us ( +-
> 3.24% )
> 
> Total Samples:68259, Total events handled time:61150.95us.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> Signed-off-by: Lei Zhao <zhaolei27@baidu.com>
> ---
>  tools/perf/arch/x86/util/kvm-stat.c |   46
> +++++++++++++++++++++++++++++++++++
>  1 files changed, 46 insertions(+), 0 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/kvm-stat.c
> b/tools/perf/arch/x86/util/kvm-stat.c
> index 0729204..c5dd54f 100644
> --- a/tools/perf/arch/x86/util/kvm-stat.c
> +++ b/tools/perf/arch/x86/util/kvm-stat.c
> @@ -133,11 +133,56 @@ static void ioport_event_decode_key(struct
> perf_kvm_stat *kvm __maybe_unused,
>  	.name = "IO Port Access"
>  };
> 
> + /* The time of emulation msr is from kvm_msr to kvm_entry. */ static
> +void msr_event_get_key(struct evsel *evsel,
> +				 struct perf_sample *sample,
> +				 struct event_key *key)
> +{
> +	key->key  = evsel__intval(evsel, sample, "ecx");
> +	key->info = evsel__intval(evsel, sample, "write"); }
> +
> +static bool msr_event_begin(struct evsel *evsel,
> +			       struct perf_sample *sample,
> +			       struct event_key *key)
> +{
> +	if (!strcmp(evsel->name, "kvm:kvm_msr")) {
> +		msr_event_get_key(evsel, sample, key);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool msr_event_end(struct evsel *evsel,
> +			     struct perf_sample *sample __maybe_unused,
> +			     struct event_key *key __maybe_unused) {
> +	return kvm_entry_event(evsel);
> +}
> +
> +static void msr_event_decode_key(struct perf_kvm_stat *kvm
> __maybe_unused,
> +				    struct event_key *key,
> +				    char *decode)
> +{
> +	scnprintf(decode, decode_str_len, "%#llx:%s",
> +		  (unsigned long long)key->key,
> +		  key->info ? "W" : "R");
> +}
> +
> +static struct kvm_events_ops msr_events = {
> +	.is_begin_event = msr_event_begin,
> +	.is_end_event = msr_event_end,
> +	.decode_key = msr_event_decode_key,
> +	.name = "MSR Access"
> +};
> +
>  const char *kvm_events_tp[] = {
>  	"kvm:kvm_entry",
>  	"kvm:kvm_exit",
>  	"kvm:kvm_mmio",
>  	"kvm:kvm_pio",
> +	"kvm:kvm_msr",
>  	NULL,
>  };
> 
> @@ -145,6 +190,7 @@ struct kvm_reg_events_ops kvm_reg_events_ops[] = {
>  	{ .name = "vmexit", .ops = &exit_events },
>  	{ .name = "mmio", .ops = &mmio_events },
>  	{ .name = "ioport", .ops = &ioport_events },
> +	{ .name = "msr", .ops = &msr_events },
>  	{ NULL, NULL },
>  };
> 
> --
> 1.7.1

