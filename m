Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81D331A4BF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 19:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhBLSui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 13:50:38 -0500
Received: from mail.codeweavers.com ([50.203.203.244]:46734 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhBLSue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 13:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e0D7/4VpviQormwa11z/jzEJDK8wsl9J3NDPCqGhR9I=; b=hNdfe3JdipqyBAB2SpHPfrTyjm
        iEmkEw5gF4j1oAfsqjOpSNEEnd5zKojplPwH6dPyqzX/URciM5QyA3BD+RprATf9TtxA4EuJP5C/B
        aUYB7rKmBFnXAWuvnskB8ByRzi1YTOjBX5tfjfJoniOtWvLMyTvtkMGnVDchRPdLGZko=;
Received: from [10.69.141.136]
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <nfraser@codeweavers.com>)
        id 1lAdVg-000451-4C; Fri, 12 Feb 2021 12:49:46 -0600
Subject: Re: [PATCH 3/4] perf archive: Fix filtering of empty build-ids
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org,
        Ulrich Czekalla <uczekalla@codeweavers.com>,
        Huw Davies <huw@codeweavers.com>
References: <7708cca1-b8f6-c394-75f1-5f9681d625d0@codeweavers.com>
 <20210212122901.GB1398414@kernel.org>
From:   Nicholas Fraser <nfraser@codeweavers.com>
Message-ID: <8f50e586-ae58-ef4e-a594-e2248203a2a7@codeweavers.com>
Date:   Fri, 12 Feb 2021 13:49:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210212122901.GB1398414@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -40.6
X-Spam-Report: Spam detection software, running on the system "mail.codeweavers.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  The current version of "perf buildid-list" prints missing
   build-ids as blank even when loading perf.data files generated from older
   versions of perf. I've tested with a few older versions. Since perf-archive
    is an external script that calls back into perf, it could in theory find
   a different older version that still returns zeroes. We could make it look
    for a matching perf, e.g. "$(dirn [...] 
 Content analysis details:   (-40.6 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 USER_IN_WELCOMELIST    user is listed in 'welcomelist_from'
  -20 USER_IN_WHITELIST      DEPRECATED: See USER_IN_WELCOMELIST
  -20 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -0.5 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
 -0.1 NICE_REPLY_A           Looks like a legit reply (A)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current version of "perf buildid-list" prints missing build-ids as
blank even when loading perf.data files generated from older versions of
perf. I've tested with a few older versions.

Since perf-archive is an external script that calls back into perf, it
could in theory find a different older version that still returns zeroes.
We could make it look for a matching perf, e.g. "$(dirname "$0")/perf".
Unfortunately that won't work in general because at least on my system
perf-archive is installed to a different path than perf.

Nick


On 2021-02-12 7:29 a.m., Arnaldo Carvalho de Melo wrote:
> Em Wed, Feb 10, 2021 at 02:17:49PM -0500, Nicholas Fraser escreveu:
>> A non-existent build-id used to be treated as all-zero SHA-1 hash.
>> Build-ids are now variable width. A non-existent build-id is an empty
>> string and "perf buildid-list" pads this with spaces.
>>
>> This fixes "perf-archive" to skip missing build-ids by skipping lines
>> that start with a padding space rather than with zeroes.
>>
>> Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
>> ---
>>  tools/perf/perf-archive.sh | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/perf-archive.sh b/tools/perf/perf-archive.sh
>> index 0cfb3e2cefef..133f0eddbcc4 100644
>> --- a/tools/perf/perf-archive.sh
>> +++ b/tools/perf/perf-archive.sh
>> @@ -20,9 +20,8 @@ else
>>  fi
>>  
>>  BUILDIDS=$(mktemp /tmp/perf-archive-buildids.XXXXXX)
>> -NOBUILDID=0000000000000000000000000000000000000000
>>  
>> -perf buildid-list -i $PERF_DATA --with-hits | grep -v "^$NOBUILDID " > $BUILDIDS
>> +perf buildid-list -i $PERF_DATA --with-hits | grep -v "^ " > $BUILDIDS
>>  if [ ! -s $BUILDIDS ] ; then
>>  	echo "perf archive: no build-ids found"
>>  	rm $BUILDIDS || true
> 
> What should we do when using older files? We have to support both cases.
> 
> - Arnaldo
> 
