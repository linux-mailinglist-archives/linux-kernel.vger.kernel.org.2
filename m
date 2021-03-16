Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2181333E0E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 22:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhCPVz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 17:55:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhCPVzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 17:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615931721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nh7Hy/TLMrRCmo4qA5vxVkdmukdYdB2mSJ5uzKCm8PY=;
        b=J8F/4B3a9XtvRqkYxgFAzlZCwDEs+g9wIWwrGz2AvVrb2MnbRvm17+4SPsoqeVcZa7jST0
        2Z3i7jhT0ZP31iP5b5j+wjHGap4TwEXwIsy0Y9mF+ZcKqNvDYg2VnUmjiZgO0ApllhSikD
        tnN/WdCP7/dk1CFcJ+4KFuqR0qfRuJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-jsbX9TBDM_efgqK7Q4pU2g-1; Tue, 16 Mar 2021 17:55:19 -0400
X-MC-Unique: jsbX9TBDM_efgqK7Q4pU2g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FC9F3E743;
        Tue, 16 Mar 2021 21:55:17 +0000 (UTC)
Received: from krava (unknown [10.40.193.217])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7F3656A047;
        Tue, 16 Mar 2021 21:55:15 +0000 (UTC)
Date:   Tue, 16 Mar 2021 22:55:14 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Align CSV output for summary mode
Message-ID: <YFEpQs4TnnxPPznF@krava>
References: <20210316072900.1739-1-yao.jin@linux.intel.com>
 <YFCtfXlaKbIeEMwk@krava>
 <20210316163421.GQ203350@tassilo.jf.intel.com>
 <YFEBaVNDokSVW/34@kernel.org>
 <20210316200220.GS203350@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316200220.GS203350@tassilo.jf.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 01:02:20PM -0700, Andi Kleen wrote:
> On Tue, Mar 16, 2021 at 04:05:13PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Mar 16, 2021 at 09:34:21AM -0700, Andi Kleen escreveu:
> > > > looks ok, but maybe make the option more related to CVS, like:
> > > > 
> > > >   --x-summary, --cvs-summary  ...? 
> > > 
> > > Actually I don't think it should be a new option. I doubt
> > > anyone could parse the previous mess. So just make it default
> > > with -x
> > 
> > In these cases I always fear that people are already parsing that mess
> > by considering the summary lines to be the ones not starting with
> > spaces, and now we go on and change it to be "better" by prefixing it
> > with "summary" and... break existing scripts.
> 
> I think it was just one version or so?
> 
> FWIW perf has broken CSV output several times, I added workarounds
> to toplev every time. Having a broken version for a short time
> shouldn't be too bad.
> 
> I actually had a workaround for this one, but it can parse either way.
> 
> > 
> > Can we do this with a new option?
> > 
> > I.e. like --cvs-summary?
> 
> If you do it I would add an option for the old broken format
> --i-want-broken-csv. But not  require the option forever
> just to get sane output.

I like that.. also we'll find out how many people are actually parsing that ;-)

jirka

> 
> Or maybe only a perf config option.
> 
> -Andi
> 

