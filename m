Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E292B3BE9ED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 16:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhGGOoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 10:44:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232052AbhGGOoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 10:44:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBC3F61C37;
        Wed,  7 Jul 2021 14:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625668893;
        bh=HQp6d+sJagEWzQXUtAZhynOsjRq/W3BSJzdzYV76BRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u0uNP3u5ABj5FNTrVaBngry64NdwHGSA1bHzKWE9F2+3tggDXixTXpu8/a7fLxqNm
         PqfKstQAfhs1fyoiqqInoO8PXkbzjeFJ6gXJsi92Ie3Nz/Rr/z4m5pD5CrfOQPChjV
         aOeVidx1wyARLu80EBkizPXOkfofS8MGF9iipUdxztyIzRXv3Xfz6Dguc7kiSMzx56
         487ahrDwQwraRFwTl0jy558MHbqCgnkCjlErqkUCp+nFEGfG1jrCBS6XdUwawE0vNU
         T4zdh+lVbNUJR1xa1bwGwNfr/HZuDERb7IKSVLuoyePPN9oz3l6O0ICb+a1aAAC4D1
         MIAJNGsjU8dBw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3167B40B1A; Wed,  7 Jul 2021 11:41:31 -0300 (-03)
Date:   Wed, 7 Jul 2021 11:41:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf intel-pt: Add a config for max loops without
 consuming a packet
Message-ID: <YOW9G/CYhFegrZ2r@kernel.org>
References: <20210701175132.3977-1-adrian.hunter@intel.com>
 <aaf79640-4882-310a-e1e1-67f7818e82a0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaf79640-4882-310a-e1e1-67f7818e82a0@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 01, 2021 at 10:54:53AM -0700, Andi Kleen escreveu:
> 
> On 7/1/2021 10:51 AM, Adrian Hunter wrote:
> > The Intel PT decoder limits the number of unconditional branches (e.g.
> > jmps) decoded without consuming any trace packets. Generally, a loop
> > needs a conditional branch which generates a TNT packet, whereas a
> > "ret" instruction will generate a TIP or TNT packet. So exceeding
> > the limit is assumed to be a never-ending loop, which can happen if
> > there has been a decoding error putting the decoder at the wrong place in
> > the code.
> > 
> > Up until now, the limit of 10000 has been enough but some analytic
> > purposes have been reported to exceed that.
> > 
> > Increase the limit to 100000, and make it configurable via perf config
> > intel-pt.max-loops. Also amend the "Never-ending loop" message to
> > mention the configuration entry.
> > 
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> 
> Thanks. That is useful.
> 
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied.

- Arnaldo

