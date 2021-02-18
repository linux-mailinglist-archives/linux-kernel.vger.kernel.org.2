Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B8231F0A6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhBRUAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 15:00:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232804AbhBRTqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 14:46:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 973BD64E76;
        Thu, 18 Feb 2021 19:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613677513;
        bh=UchEpOi5pKxlvSP/2GAgaxqqfJyyZcIjALoqAp1RjFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gwhbHkQpCag57Pq9CnvL+jn5ViKr0UmbFLdwiYC6lvnZcrsFmG3vJVKUsKwOurhIX
         RLvSRChjk5bfl506dZN1rgiRuWZZ8bzHRmHYC/gAMSEVcDfGNcQH1qcfb0cwzO3XLW
         TmtaJSTW+3jYFOdCkG09jRuzp0DtxRF69cpMm7KcXv4IBay4q+7OXaVVBdi2M49AQm
         50kf6xg6QcI1nsnAJqf9NOQnfuwfxSyW5Xgbdith3ir3F4do87Q7B9W+xeYcY3QOQr
         r02NdFM+Bh+Yf17OdH5G4uLKOR0SWNoC7960kUvI+Popyz4+eRCG8fkGLO56lOQUOV
         5oZ2gTiJWD4pA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7E58140CD9; Thu, 18 Feb 2021 16:45:11 -0300 (-03)
Date:   Thu, 18 Feb 2021 16:45:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nicholas Fraser <nfraser@codeweavers.com>
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
Subject: Re: [PATCH 1/2] perf report: Remove redundant libbfd checks
Message-ID: <YC7Dx9v17Dk33ZY6@kernel.org>
References: <d1c87379-8837-a5e7-eb44-f063ca0f4766@codeweavers.com>
 <94758ca1-0031-d7c6-6c6a-900fd77ef695@codeweavers.com>
 <YC7CetsRKrZXf8WE@kernel.org>
 <59cd6ab8-52d8-f19f-669c-afef5c9ac8e9@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59cd6ab8-52d8-f19f-669c-afef5c9ac8e9@codeweavers.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 18, 2021 at 02:42:17PM -0500, Nicholas Fraser escreveu:
> 
> On 2021-02-18 2:39 p.m., Arnaldo Carvalho de Melo wrote:
> > you forgot the:
> > 
> > Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
> > 
> > I'm adding it, ok?
> 
> Ah yes sorry about that, to be explicit here it is:
> 
> Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
> 
> > 
> > I'm also addressing Jiri's remark about spaces surrounding |
> > 
> 
> Thanks. I included this fix in my follow-up patch though so
> you might get a conflict.

I'm pushing to tmp.perf/core what I have, I think there are missing
patches and the latest test isn't applying. can you please take a look
and perhaps refresh patches?

I'll start the tests now so that I can move all this to perf/core
proper.

- Arnaldo
