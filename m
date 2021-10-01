Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC81541ED98
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 14:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353815AbhJAMhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 08:37:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59076 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhJAMhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 08:37:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 340602267E;
        Fri,  1 Oct 2021 12:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633091724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q4IZyw0HKjpWG8FpWoJ5olxESNe0wgvOob+Uvoay5gA=;
        b=aR9pa16jIdPI4SJEmMtogi9KXxKOPLqXq+jfnK5hyBno/SkiLHr+mKWiFso/6WQUSkZm9U
        5UyM77BGzDnuEIUBcDTmV7eRYmQwOVZ3KG44Ma+gTeA0lTaWAFI9/GlRGGORiWJv/k/GD/
        gcXA+dwR4ORMi0rULPStgJyVD3YhhtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633091724;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q4IZyw0HKjpWG8FpWoJ5olxESNe0wgvOob+Uvoay5gA=;
        b=ZS3SDJSlBX0zXwDSe0NqNgvpOJUQHwxe9jAaUVGroyaueV022TY2o193sRfPBEkpa23iWb
        VMNM+4Lwnr8vqjCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C21B13C59;
        Fri,  1 Oct 2021 12:35:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QDXDAYwAV2EaYAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 01 Oct 2021 12:35:24 +0000
Message-ID: <6803f51e-69ea-fed0-112c-e40417836951@suse.cz>
Date:   Fri, 1 Oct 2021 14:35:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [RFC PATCH] mm, slub: change percpu partial accounting from
 objects to pages
Content-Language: en-US
To:     David Rientjes <rientjes@google.com>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20210913170148.10992-1-vbabka@suse.cz>
 <c167ab10-f970-15c-b0e-fd4484ddc637@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <c167ab10-f970-15c-b0e-fd4484ddc637@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/21 07:32, David Rientjes wrote:
> On Mon, 13 Sep 2021, Vlastimil Babka wrote:
>> We could also skip the intermediate step with target number of objects and
>> rewrite the heuristic in terms of pages. However we still have the sysfs file
>> cpu_partial which uses number of objects and could break existing users if it
>> suddenly becomes number of pages, so this patch doesn't do that.
>>
>> In practice, after this patch the heuristics limit the size of percpu partial
>> list up to 2 pages. In case of a reported regression (which would mean some
>> workload has benefited from the previous imprecise object based counting), we
>> can tune the heuristics to get a better compromise within the new scheme, while
>> still avoid the unexpectedly long percpu partial lists.
>>
> 
> Curious if you've tried netperf TCP_RR with this change?  This benchmark 
> was the most significantly improved benchmark that I recall with the 
> introduction of per-cpu partial slabs for SLUB.  If there are any 
> regressions to be introduced by such an approach, I'm willing to bet that 
> it would be surfaced with that benchmark.
> 
> Let me know if we can help in benchmarking.

Mel was kind enough to run it through mmtests machinery for netperf
(localhost) and hackbench and I finally processed the results, see
below. So there are some apparent regressions, especially with
hackbench, which I think ultimately boils down to having shorter percpu
partial lists on average and some benchmarks benefiting from longer
ones. Monitoring slab usage also indicated less memory usage by slab. So
maybe I could try bumping the defaults somewhat as part of the patch,
but certainly not such that we would limit the percpu partial lists to
30 pages just because previously a specific alloc/free pattern could
lead to the limit of 30 objects translate to a limit to 30 pages - that
would make little sense. This is a correctness patch, and if a workload
benefits from larger lists, the sysfs tuning knobs are still there to use.

Netperf

2-socket Intel(R) Xeon(R) Gold 5218R CPU @ 2.10GHz (20 cores, 40 threads
per socket), 384GB RAM
TCP-RR:
hmean before 127045.79 after 121092.94 (-4.69%, worse)
stddev before  2634.37 after   1254.08
UDP-RR:
hmean before 166985.45 after 160668.94 ( -3.78%, worse)
stddev before 4059.69 after 1943.63

2-socket Intel(R) Xeon(R) CPU E5-2698 v4 @ 2.20GHz (20 cores, 40 threads
per socket), 512GB RAM
TCP-RR:
hmean before 84173.25 after 76914.72 ( -8.62%, worse)
UDP-RR:
hmean before 93571.12 after 96428.69 ( 3.05%, better)
stddev before 23118.54 after 16828.14

2-socket Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GHz (12 cores, 24 threads
per socket), 64GB RAM
TCP-RR:
hmean before 49984.92 after 48922.27 ( -2.13%, worse)
stddev before 6248.15 after 4740.51
UDP-RR:
hmean before 61854.31 after 68761.81 ( 11.17%, better)
stddev before 4093.54 after 5898.91

other machines - within 2%

Hackbench

2-socket AMD EPYC 7713 (64 cores, 128 threads per core), 256GB RAM
hackbench-process-sockets (less is worse)
Amean 	1 	0.5380	0.5583	( -3.78%)
Amean 	4 	0.7510	0.8150	( -8.52%)
Amean 	7 	0.7930	0.9533	( -20.22%)
Amean 	12 	0.7853	1.1313	( -44.06%)
Amean 	21 	1.1520	1.4993	( -30.15%)
Amean 	30 	1.6223	1.9237	( -18.57%)
Amean 	48 	2.6767	2.9903	( -11.72%)
Amean 	79 	4.0257	5.1150	( -27.06%)
Amean 	110	5.5193	7.4720	( -35.38%)
Amean 	141	7.2207	9.9840	( -38.27%)
Amean 	172	8.4770	12.1963	( -43.88%)
Amean 	203	9.6473	14.3137	( -48.37%)
Amean 	234	11.3960	18.7917	( -64.90%)
Amean 	265	13.9627	22.4607	( -60.86%)
Amean 	296	14.9163	26.0483	( -74.63%)

hackbench-thread-sockets (less is worse)
Amean 	1 	0.5597	0.5877	( -5.00%)
Amean 	4 	0.7913	0.8960	( -13.23%)
Amean 	7 	0.8190	1.0017	( -22.30%)
Amean 	12 	0.9560	1.1727	( -22.66%)
Amean 	21 	1.7587	1.5660	( 10.96%)
Amean 	30 	2.4477	1.9807	( 19.08%)
Amean 	48 	3.4573	3.0630	( 11.41%)
Amean 	79 	4.7903	5.1733	( -8.00%)
Amean 	110	6.1370	7.4220	( -20.94%)
Amean 	141	7.5777	9.2617	( -22.22%)
Amean 	172	9.2280	11.0907	( -20.18%)
Amean 	203	10.2793	13.3470	( -29.84%)
Amean 	234	11.2410	17.1070	( -52.18%)
Amean 	265	12.5970	23.3323	( -85.22%)
Amean 	296	17.1540	24.2857	( -41.57%)

2-socket Intel(R) Xeon(R) Gold 5218R CPU @ 2.10GHz (20 cores, 40 threads
per socket), 384GB RAM
hackbench-process-sockets (less is worse)
Amean 	1 	0.5760	0.4793	( 16.78%)
Amean 	4 	0.9430	0.9707	( -2.93%)
Amean 	7 	1.5517	1.8843	( -21.44%)
Amean 	12 	2.4903	2.7267	( -9.49%)
Amean 	21 	3.9560	4.2877	( -8.38%)
Amean 	30 	5.4613	5.8343	( -6.83%)
Amean 	48 	8.5337	9.2937	( -8.91%)
Amean 	79 	14.0670	15.2630	( -8.50%)
Amean 	110	19.2253	21.2467	( -10.51%)
Amean 	141	23.7557	25.8550	( -8.84%)
Amean 	172	28.4407	29.7603	( -4.64%)
Amean 	203	33.3407	33.9927	( -1.96%)
Amean 	234	38.3633	39.1150	( -1.96%)
Amean 	265	43.4420	43.8470	( -0.93%)
Amean 	296	48.3680	48.9300	( -1.16%)

hackbench-thread-sockets (less is worse)
Amean 	1 	0.6080	0.6493	( -6.80%)
Amean 	4 	1.0000	1.0513	( -5.13%)
Amean 	7 	1.6607	2.0260	( -22.00%)
Amean 	12 	2.7637	2.9273	( -5.92%)
Amean 	21 	5.0613	4.5153	( 10.79%)
Amean 	30 	6.3340	6.1140	( 3.47%)
Amean 	48 	9.0567	9.5577	( -5.53%)
Amean 	79 	14.5657	15.7983	( -8.46%)
Amean 	110	19.6213	21.6333	( -10.25%)
Amean 	141	24.1563	26.2697	( -8.75%)
Amean 	172	28.9687	30.2187	( -4.32%)
Amean 	203	33.9763	34.6970	( -2.12%)
Amean 	234	38.8647	39.3207	( -1.17%)
Amean 	265	44.0813	44.1507	( -0.16%)
Amean 	296	49.2040	49.4330	( -0.47%)

2-socket Intel(R) Xeon(R) CPU E5-2698 v4 @ 2.20GHz (20 cores, 40 threads
per socket), 512GB RAM
hackbench-process-sockets (less is worse)
Amean 	1 	0.5027	0.5017	( 0.20%)
Amean 	4 	1.1053	1.2033	( -8.87%)
Amean 	7 	1.8760	2.1820	( -16.31%)
Amean 	12 	2.9053	3.1810	( -9.49%)
Amean 	21 	4.6777	4.9920	( -6.72%)
Amean 	30 	6.5180	6.7827	( -4.06%)
Amean 	48 	10.0710	10.5227	( -4.48%)
Amean 	79 	16.4250	17.5053	( -6.58%)
Amean 	110	22.6203	24.4617	( -8.14%)
Amean 	141	28.0967	31.0363	( -10.46%)
Amean 	172	34.4030	36.9233	( -7.33%)
Amean 	203	40.5933	43.0850	( -6.14%)
Amean 	234	46.6477	48.7220	( -4.45%)
Amean 	265	53.0530	53.9597	( -1.71%)
Amean 	296	59.2760	59.9213	( -1.09%)

hackbench-thread-sockets (less is worse)
Amean 	1 	0.5363	0.5330	( 0.62%)
Amean 	4 	1.1647	1.2157	( -4.38%)
Amean 	7 	1.9237	2.2833	( -18.70%)
Amean 	12 	2.9943	3.3110	( -10.58%)
Amean 	21 	4.9987	5.1880	( -3.79%)
Amean 	30 	6.7583	7.0043	( -3.64%)
Amean 	48 	10.4547	10.8353	( -3.64%)
Amean 	79 	16.6707	17.6790	( -6.05%)
Amean 	110	22.8207	24.4403	( -7.10%)
Amean 	141	28.7090	31.0533	( -8.17%)
Amean 	172	34.9387	36.8260	( -5.40%)
Amean 	203	41.1567	43.0450	( -4.59%)
Amean 	234	47.3790	48.5307	( -2.43%)
Amean 	265	53.9543	54.6987	( -1.38%)
Amean 	296	60.0820	60.2163	( -0.22%)

1-socket Intel(R) Xeon(R) CPU E3-1240 v5 @ 3.50GHz (4 cores, 8 threads),
32 GB RAM
hackbench-process-sockets (less is worse)
Amean 	1 	1.4760	1.5773	( -6.87%)
Amean 	3 	3.9370	4.0910	( -3.91%)
Amean 	5 	6.6797	6.9357	( -3.83%)
Amean 	7 	9.3367	9.7150	( -4.05%)
Amean 	12	15.7627	16.1400	( -2.39%)
Amean 	18	23.5360	23.6890	( -0.65%)
Amean 	24	31.0663	31.3137	( -0.80%)
Amean 	30	38.7283	39.0037	( -0.71%)
Amean 	32	41.3417	41.6097	( -0.65%)

hackbench-thread-sockets (less is worse)
Amean 	1 	1.5250	1.6043	( -5.20%)
Amean 	3 	4.0897	4.2603	( -4.17%)
Amean 	5 	6.7760	7.0933	( -4.68%)
Amean 	7 	9.4817	9.9157	( -4.58%)
Amean 	12	15.9610	16.3937	( -2.71%)
Amean 	18	23.9543	24.3417	( -1.62%)
Amean 	24	31.4400	31.7217	( -0.90%)
Amean 	30	39.2457	39.5467	( -0.77%)
Amean 	32	41.8267	42.1230	( -0.71%)

2-socket Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GHz (12 cores, 24 threads
per socket), 64GB RAM
hackbench-process-sockets (less is worse)
Amean 	1 	1.0347	1.0880	( -5.15%)
Amean 	4 	1.7267	1.8527	( -7.30%)
Amean 	7 	2.6707	2.8110	( -5.25%)
Amean 	12 	4.1617	4.3383	( -4.25%)
Amean 	21 	7.0070	7.2600	( -3.61%)
Amean 	30 	9.9187	10.2397	( -3.24%)
Amean 	48 	15.6710	16.3923	( -4.60%)
Amean 	79 	24.7743	26.1247	( -5.45%)
Amean 	110	34.3000	35.9307	( -4.75%)
Amean 	141	44.2043	44.8010	( -1.35%)
Amean 	172	54.2430	54.7260	( -0.89%)
Amean 	192	60.6557	60.9777	( -0.53%)

hackbench-thread-sockets (less is worse)
Amean 	1 	1.0610	1.1353	( -7.01%)
Amean 	4 	1.7543	1.9140	( -9.10%)
Amean 	7 	2.7840	2.9573	( -6.23%)
Amean 	12 	4.3813	4.4937	( -2.56%)
Amean 	21 	7.3460	7.5350	( -2.57%)
Amean 	30 	10.2313	10.5190	( -2.81%)
Amean 	48 	15.9700	16.5940	( -3.91%)
Amean 	79 	25.3973	26.6637	( -4.99%)
Amean 	110	35.1087	36.4797	( -3.91%)
Amean 	141	45.8220	46.3053	( -1.05%)
Amean 	172	55.4917	55.7320	( -0.43%)
Amean 	192	62.7490	62.5410	( 0.33%)
