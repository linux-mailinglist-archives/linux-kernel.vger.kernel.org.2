Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7414549F2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 16:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbhKQPis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:38:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233227AbhKQPir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:38:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8C7961AA3;
        Wed, 17 Nov 2021 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637163348;
        bh=OuaD96fIOOXLyTPPp8vpyCZiO/jkDD7kPNV8j5cecBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=plGamUx1h92lMVSgf1g1RZONuaJl8DZMagxPPApD/4mqRCB5FIKIqgedoM8MKEC6B
         lxo8ObJ960djto3DT38/MGHarg3u19HdJBRoN/tF/BRSsYL/oH1BweC6hgppJ/Pg2y
         6k3pVfDK+C3VVXb10c+yv+jW8GMnYzOBjbHlYGiw9iw/aD4Dq9nOcSfZHSP+3kbSs0
         T8xad2lYn2r9HxkAWz1fDme3zwH9a3rRfmIDDbUR0Yf6+y9+Z2Ppp6pZ8BntDwGLgG
         v/hAuorYyMrvOl9CbOJ+OG3CYENUjl+DVnxnagcwuVu5u3OAs7oEg4qrBJdxr/MaAo
         wCtrOr9CothXA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3627B4088E; Wed, 17 Nov 2021 12:35:46 -0300 (-03)
Date:   Wed, 17 Nov 2021 12:35:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     German Gomez <german.gomez@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [FYI][PATCH 1/1] perf tools: Set COMPAT_NEED_REALLOCARRAY for
 CONFIG_AUXTRACE=1
Message-ID: <YZUhUjuqzwhoqQM/@kernel.org>
References: <YZT63mIc7iY01er3@kernel.org>
 <20211117144110.GC4771@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117144110.GC4771@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 17, 2021 at 10:41:10PM +0800, Leo Yan escreveu:
> On Wed, Nov 17, 2021 at 09:51:42AM -0300, Arnaldo Carvalho de Melo wrote:
> > As it is being used in tools/perf/arch/arm64/util/arm-spe.c and the
> > COMPAT_NEED_REALLOCARRAY was only being set when CORESIGHT=1 is set.
> 
> Thanks for the patch, Arnaldo.
> 
> This patch looks good to me.  But I cannot reproduce the build failure,
> if without CORESIGHT=1 I still don't see the build failure.

Strange, here it broke when building on ubuntu:16.04-x-arm64 and ubuntu:18.04-x-arm64
I.e. cross building from x86-64 to arm64.
 
> I think we should apply below code as well, if COMPAT_NEED_REALLOCARRAY
> is enabled for AUXTRACE, it will be applied for cs-etm as well.  For
> this reason, we can remove the redundant definition for CORESIGHT.

Isn't it possible to ask for:

	make NO_AUXTRACE=1 CORESIGHT=1

?
 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 07e65a061fd3..2dbf086d1155 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -477,9 +477,6 @@ ifdef CORESIGHT
>    $(call feature_check,libopencsd)
>    ifeq ($(feature-libopencsd), 1)
>      CFLAGS += -DHAVE_CSTRACE_SUPPORT $(LIBOPENCSD_CFLAGS)
> -    ifeq ($(feature-reallocarray), 0)
> -      CFLAGS += -DCOMPAT_NEED_REALLOCARRAY
> -    endif
>      LDFLAGS += $(LIBOPENCSD_LDFLAGS)
>      EXTLIBS += $(OPENCSDLIBS)
>      $(call detected,CONFIG_LIBOPENCSD)
> 
> Thanks,
> Leo
> 
> > Fixes: 56c31cdff7c2a640 ("perf arm-spe: Implement find_snapshot callback")
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: German Gomez <german.gomez@arm.com>
> > Cc: James Clark <james.clark@arm.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: John Garry <john.garry@huawei.com>
> > Cc: Leo Yan <leo.yan@linaro.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/Makefile.config | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 07e65a061fd3a13b..afd144725a0bf766 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -1010,6 +1010,9 @@ ifndef NO_AUXTRACE
> >    ifndef NO_AUXTRACE
> >      $(call detected,CONFIG_AUXTRACE)
> >      CFLAGS += -DHAVE_AUXTRACE_SUPPORT
> > +    ifeq ($(feature-reallocarray), 0)
> > +      CFLAGS += -DCOMPAT_NEED_REALLOCARRAY
> > +    endif
> >    endif
> >  endif
> >  
> > -- 
> > 2.31.1
> > 

-- 

- Arnaldo
