Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CC33838FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346395AbhEQQF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344286AbhEQPoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 11:44:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54D4861D20;
        Mon, 17 May 2021 14:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621262596;
        bh=iH1753AkMmzMFnrNJ4C/WylYC6aZOwPygucDv8g2sGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JBcvgm13fZyycqcfNx4ZA3YPtHEX5CGYJS9HGk25YYdkgP2Ae2QL380bZCv7jtS34
         NfpZKBoEOYQmvrMFjGZi2Z9u4PUumsFdcmvD6pG6g3NLf1LO/wlpXHQOC6pP0nZcMo
         RsKO++8PYrRsgAo4NhqAaW87o1hlIaBLJsgGTDEwfhkBMXOrM/tQky8SDx1HcM5Elp
         HCuPr/IIjgA1WfNSvRyiBDnOrP+UfRFufp0ebdhbTUnmMd26bkag8zD4mAjrFrLcWW
         xklB9vetjh++oKdLV98JIV1eX3cKHJQde7VbK57o2pc3A53IGbt5IaHH0P1bYEq+fm
         RsogRC/vo9jrQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7AC8D4034C; Mon, 17 May 2021 11:43:13 -0300 (-03)
Date:   Mon, 17 May 2021 11:43:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        leo.yan@linaro.org, al.grant@arm.com, branislav.rankov@arm.com,
        denik@chromium.org, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] perf cs-etm: Handle valid-but-zero timestamps
Message-ID: <YKKBAeQMAo5CIily@kernel.org>
References: <20210517131741.3027-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517131741.3027-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 17, 2021 at 04:17:38PM +0300, James Clark escreveu:
> Changes since v2:
> 
>  * Fix typo in last commit message
>  * Add reviewed-by tags from Leo Yan

Thanks, applied.

- Arnaldo

 
> This patchset applies on top of "[PATCH v3 0/2] perf cs-etm: Set
> time on synthesised samples to preserve ordering"
> 
> James Clark (3):
>   perf cs-etm: Move synth_opts initialisation
>   perf cs-etm: Start reading 'Z' --itrace option
>   perf cs-etm: Prevent and warn on underflows during timestamp
>     calculation.
> 
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 45 ++++++++++++++-----
>  tools/perf/util/cs-etm.c                      | 20 +++++----
>  2 files changed, 46 insertions(+), 19 deletions(-)
> 
> -- 
> 2.28.0
> 

-- 

- Arnaldo
