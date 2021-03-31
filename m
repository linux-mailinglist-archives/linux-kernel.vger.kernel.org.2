Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03A734FE35
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbhCaKiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:38:51 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:48280 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbhCaKiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PZ2H+bB94yyCMNnkVrq8RWg2Hq/HMuHFjJ6M40WD60c=; b=C8u7NjYvPuDfCBf2wDxjCt0JDa
        9qRJFznd+SS3lTAmUOHrebIg3k76/+MpBAOOvWR50brONSIeB1YCUml6o4nX2ILRUS9WqBsLYnsuG
        6lYc128bU5H12QWocnItSFqW6oVXvBHcqge35cAvyw04VE0BJLIfovi/FLcaGhCPatzA=;
Received: from 198-48-224-11.cpe.pppoe.ca ([198.48.224.11] helo=[192.168.1.180])
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <nfraser@codeweavers.com>)
        id 1lRYEr-0002D2-Uo; Wed, 31 Mar 2021 05:38:18 -0500
Subject: Re: [PATCH] perf data: export to JSON
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        linux-kernel@vger.kernel.org
References: <4687bbe5-4ff3-af3a-fcec-06d8bfe5591c@codeweavers.com>
 <YFuC5ONRvAPKwtKX@krava>
From:   Nicholas Fraser <nfraser@codeweavers.com>
Message-ID: <2d78b018-df5a-36cb-2f78-d3ca11bf9513@codeweavers.com>
Date:   Wed, 31 Mar 2021 06:38:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFuC5ONRvAPKwtKX@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

Thanks for the review. I've addressed your suggestions; some notes are
below. I'll send a new patch.


On 2021-03-24 2:20 p.m., Jiri Olsa wrote:
> On Wed, Mar 24, 2021 at 09:06:50AM -0400, Nicholas Fraser wrote:
>> [...] We use this to import the data into a tool on Windows
>> where integrating perf or libbabeltrace is impractical.
> 
> hi,
> exciting ;-) and curious, which tool is that?
> 

The tool is called gpuvis. The perf JSON parsing support is here:

https://github.com/ludocode/gpuvis

The idea is to be able to line up samples from perf with GPU trace events, so
you can do things like timebox all perf samples in a particular frame of
rendering.


> we already have zstd support compiled in for compressing samples,
> should be easy to use it for compressing the output of this right
> away

This would require that apps that consume this integrate zstd as well. It's
simpler (both conceptually and from an integration standpoint) to just compress
on command-line if you need with whatever compressor you want. You can even do
this inline by writing to /dev/stdout, e.g.:

    perf data convert --to-json /dev/stdout --force | zstd > out.json.zstd

Since we're transferring to Windows, more likely we'd output the JSON and then
put it in a .zip container.


> I understand not supporting opts.all or opts.tod, but 'force'
> support means just assigning 'force' to struct perf_data

It's not clear to me what 'force' does on 'struct perf_data' since we're only
reading it. I assumed for data export it meant the output file should be
overwritten. I've made it do both in the replacement patch.


Nick
