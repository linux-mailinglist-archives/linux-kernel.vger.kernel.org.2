Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA5E32C028
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576111AbhCCSQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:16:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232618AbhCCP5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:57:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4774464EE3;
        Wed,  3 Mar 2021 15:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614786966;
        bh=wgoHDyP80oM7VtydQYSfMASFLCDfizonRAqyXJJzH68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uMCRVH8uWd1atvzcFgD6DSkbyyrEIpgVkFvyOJwcZQNSBmVAWKEParshYhLSYfwye
         J51reQFe/wY//+vNFfTMHYiFxkS8Amnuk9E3fNz1IEulWd20HBKMdopXqJ9XbqK+JS
         mYIz8lnd2GxdqBMoijmk+ETMH06J3FwdngNt0rZXW9amS4hfXsFPDv3YZ6sXbltovG
         aTZKN8HYC+Pzwk/d2zdf8RGfVDaAZWK5by1xdw3tLES0rqKX/H/FTUy5SyObTqjLN3
         Vst0gzNsuoKW5W4FiYtTD4jETfsVsqPv8Q87FCcyPjq8QTqEhzvW6B1r72Gm91grSS
         2XB1YxqTXZqMg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3FFD440CD9; Wed,  3 Mar 2021 12:56:04 -0300 (-03)
Date:   Wed, 3 Mar 2021 12:56:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Nicholas Fraser <nfraser@codeweavers.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        Ulrich Czekalla <uczekalla@codeweavers.com>,
        Huw Davies <huw@codeweavers.com>
Subject: Re: [PATCH 1/2] perf archive: Fix filtering of empty build-ids
Message-ID: <YD+xlHcxqd0SwUrT@kernel.org>
References: <442bffc7-ac5c-0975-b876-a549efce2413@codeweavers.com>
 <YDZZnDBSsRCtekK3@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDZZnDBSsRCtekK3@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 24, 2021 at 02:50:20PM +0100, Jiri Olsa escreveu:
> On Fri, Feb 19, 2021 at 11:09:32AM -0500, Nicholas Fraser wrote:
> > A non-existent build-id used to be treated as all-zero SHA-1 hash.
> > Build-ids are now variable width. A non-existent build-id is an empty
> > string and "perf buildid-list" pads this with spaces. This is true even
> > when using old perf.data files recorded from older versions of perf;
> > "perf buildid-list" never reports an all-zero hash anymore.
> > 
> > This fixes "perf-archive" to skip missing build-ids by skipping lines
> > that start with a padding space rather than with zeroes.
> > 
> > Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/perf-archive.sh | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/perf-archive.sh b/tools/perf/perf-archive.sh
> > index 0cfb3e2cefef..133f0eddbcc4 100644
> > --- a/tools/perf/perf-archive.sh
> > +++ b/tools/perf/perf-archive.sh
> > @@ -20,9 +20,8 @@ else
> >  fi
> >  
> >  BUILDIDS=$(mktemp /tmp/perf-archive-buildids.XXXXXX)
> > -NOBUILDID=0000000000000000000000000000000000000000
> >  
> > -perf buildid-list -i $PERF_DATA --with-hits | grep -v "^$NOBUILDID " > $BUILDIDS
> > +perf buildid-list -i $PERF_DATA --with-hits | grep -v "^ " > $BUILDIDS
> >  if [ ! -s $BUILDIDS ] ; then
> >  	echo "perf archive: no build-ids found"
> >  	rm $BUILDIDS || true
> > -- 
> > 2.30.1
> > 
> 

-- 

- Arnaldo
