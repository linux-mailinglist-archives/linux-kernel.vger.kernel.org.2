Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B18D31F09F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhBRT7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:59:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:60130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232800AbhBRTmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 14:42:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9940264E76;
        Thu, 18 Feb 2021 19:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613677324;
        bh=78G9yU7whOgyuxrcaUj985EzbLwdfbbuc6XCpFV/Lso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dJBz+i3W4aCR999lfFieAe6gUIqBQofhf7++dOGWY5vN1ocNkezUmVUc5RYwy+KDO
         VYePcaXz7hYuut4xBuhAxx2QIVq+K3szJ7VeKtdkqEtkknFx6XeCB2akPp333FDOb7
         NFhbKB+p8IQdmres9TTYB2PDLSkeceowU+zGvApVjdD62mKtOHJMv4Z/hU2HRDYAMb
         guYAN6cBGDr0A2+apjSFj6ccapPvql906Naxy6NEZ9wsofLw+2QILNGcxPb0KUGBuG
         YXYJG+UrHKJKpMyI8FedNUPDWtEjv06dJLa3XdMik2ZPzAW/nRI2RqVIoHGmodTqZq
         DU8ELpoljf0jw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6FEE440CD9; Thu, 18 Feb 2021 16:42:02 -0300 (-03)
Date:   Thu, 18 Feb 2021 16:42:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Nicholas Fraser <nfraser@codeweavers.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
Subject: Re: [PATCH 1/4] perf buildid-cache: Don't skip 16-byte build-ids
Message-ID: <YC7DCg2bHB2+vtSx@kernel.org>
References: <597788e4-661d-633f-857c-3de700115d02@codeweavers.com>
 <YC10WPYjps4Z0H8B@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC10WPYjps4Z0H8B@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 17, 2021 at 08:54:00PM +0100, Jiri Olsa escreveu:
> On Wed, Feb 10, 2021 at 02:17:25PM -0500, Nicholas Fraser wrote:
> > lsdir_bid_tail_filter() ignored any build-id that wasn't exactly 20
> > bytes. This worked only for SHA-1 build-ids. The build-id for a PE file
> > is always a 16-byte GUID and ELF files can also have MD5 or UUID
> > build-ids.
> > 
> > This fix changes the filter to allow build-ids between 16 and 20 bytes.
> > 
> > Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

