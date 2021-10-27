Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867A443D225
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 22:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243812AbhJ0UMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 16:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238558AbhJ0UMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:12:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF06D60234;
        Wed, 27 Oct 2021 20:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635365405;
        bh=VZhKaZXZL7K0N14lsWIM3QhuQSV7O/5fTZ0QwvhhwJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P0UsPowv+CE3ElhKSBnCWZvuvMhyozq65PdADxyynXmHJTZcnMCsCSNVBM3ZWlGbg
         vk87ig0TgTk2YXwW54bivJu0kPQTOSjHGk5SdWDkUn2ubf6uQIhnBWl4TAP2ptY4aX
         qE/0bmQji10yLs6eiznbJ076IWOLgU4pByNTlAViWgojW59Olti1h5XLCYDi7BtWFV
         n2+q0J6f0NEox1TFs65znu0BvrXF64sDQW5WNnySzfvBtuS6oMvyVq/Oh8oqUMHFCs
         1TC7zhe/lM8wp42uRCGDD1ME4CKoAhZ7nYMwtch2XKHTGJ9oYYnqnekG8S+hFtU8wU
         mTxqHU+qq4dCQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1DA8D410A1; Wed, 27 Oct 2021 17:10:03 -0300 (-03)
Date:   Wed, 27 Oct 2021 17:10:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Joe Mario <jmario@redhat.com>
Cc:     kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/2] perf script: Fix PERF_SAMPLE_WEIGHT_STRUCT support
Message-ID: <YXmyG1RMvKnJte5/@kernel.org>
References: <1632929894-102778-1-git-send-email-kan.liang@linux.intel.com>
 <YVSaT54dsMjJV4dF@kernel.org>
 <YVSzjzV+Jb7loGxI@krava>
 <dc6926ac-4b8f-4421-088b-94436bdc3bad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc6926ac-4b8f-4421-088b-94436bdc3bad@redhat.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 29, 2021 at 04:22:19PM -0400, Joe Mario escreveu:
> 
> 
> On 9/29/21 2:42 PM, Jiri Olsa wrote:
> > On Wed, Sep 29, 2021 at 01:54:39PM -0300, Arnaldo Carvalho de Melo wrote:
> >> Em Wed, Sep 29, 2021 at 08:38:13AM -0700, kan.liang@linux.intel.com escreveu:
> >>> From: Kan Liang <kan.liang@linux.intel.com>
> >>>
> >>> -F weight in perf script is broken.
> >>>
> >>>   # ./perf mem record
> >>>   # ./perf script -F weight
> >>>   Samples for 'dummy:HG' event do not have WEIGHT attribute set. Cannot
> >>> print 'weight' field.
> >>>
> >>> The sample type, PERF_SAMPLE_WEIGHT_STRUCT, is an alternative of the
> >>> PERF_SAMPLE_WEIGHT sample type. They share the same space, weight. The
> >>> lower 32 bits are exactly the same for both sample type. The higher 32
> >>> bits may be different for different architecture. For a new kernel on
> >>> x86, the PERF_SAMPLE_WEIGHT_STRUCT is used. For an old kernel or other
> >>> ARCHs, the PERF_SAMPLE_WEIGHT is used.
> >>>
> >>> With -F weight, current perf script will only check the input string
> >>> "weight" with the PERF_SAMPLE_WEIGHT sample type. Because the commit
> >>> ea8d0ed6eae3 ("perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT") didn't
> >>> update the PERF_SAMPLE_WEIGHT_STRUCT sample type for perf script. For a
> >>> new kernel on x86, the check fails.
> >>>
> >>> Use PERF_SAMPLE_WEIGHT_TYPE, which supports both sample types, to
> >>> replace PERF_SAMPLE_WEIGHT.
> >>>
> >>> Reported-by: Joe Mario <jmario@redhat.com>
> >>> Fixes: ea8d0ed6eae3 ("perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT")
> >>
> >> Hey Joe, Jiri,
> >>
> >> 	Can I have your Tested-by?
> > 
> > Acked/Tested-by: Jiri Olsa <jolsa@redhat.com>
> > 
> > thanks,
> > jirka
> 
>  Acked/Tested-by: Joe Mario <jmario@redhat.com>
> 
>  The "perf script -F weight" command works correctly.
> 
>  And I also verified that when just issuing "perf script", that the weight (cycle latency) 
>  column that was missing with this bug, is now fixed and working properly.

Thanks, applied.

- Arnaldo

 
>  Thanks,
>  Joe
> > 
> >>
> >> Thanks,
> >>
> >> - Arnaldo
> >>
> >>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >>> ---
> >>>  tools/perf/builtin-script.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> >>> index 6211d0b..9f62ac6 100644
> >>> --- a/tools/perf/builtin-script.c
> >>> +++ b/tools/perf/builtin-script.c
> >>> @@ -459,7 +459,7 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
> >>>  		return -EINVAL;
> >>>  
> >>>  	if (PRINT_FIELD(WEIGHT) &&
> >>> -	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT, "WEIGHT", PERF_OUTPUT_WEIGHT))
> >>> +	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT_TYPE, "WEIGHT", PERF_OUTPUT_WEIGHT))
> >>>  		return -EINVAL;
> >>>  
> >>>  	if (PRINT_FIELD(SYM) &&
> >>> -- 
> >>> 2.7.4
> >>
> >> -- 
> >>
> >> - Arnaldo
> >>
> > 

-- 

- Arnaldo
