Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEBB3754AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbhEFNXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:23:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230381AbhEFNXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620307364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FQjaa15o2fK61wUjT8Q/Wis3ZEDIoJxzmVyjAFUonbA=;
        b=IRlFeZpSw5yrbhugRA/IA+uNMXcK618VZIoUQ3Z5XsQQEx6bqjwiLCDFxIG+knR6ZoZOYd
        2jySzmcRg5sUNy24ScZXtUsHB8f6H4pmK4T50j1I0kL4V5LDN/1sH5eV6paklD6bZIDo63
        ykAdTg24rAYoddS19+uHHsgxCDWW2Rg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-CNlBKJxgNJuRGfAj_TJ8tg-1; Thu, 06 May 2021 09:22:40 -0400
X-MC-Unique: CNlBKJxgNJuRGfAj_TJ8tg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2AC1801817;
        Thu,  6 May 2021 13:22:38 +0000 (UTC)
Received: from krava (unknown [10.40.193.227])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6DD8219D9F;
        Thu,  6 May 2021 13:22:36 +0000 (UTC)
Date:   Thu, 6 May 2021 15:22:35 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 2/2] perf header: Support hybrid CPU_PMU_CAPS
Message-ID: <YJPtmyzTEe/IUID4@krava>
References: <20210430074602.3028-1-yao.jin@linux.intel.com>
 <20210430074602.3028-2-yao.jin@linux.intel.com>
 <YJFjTCsk9dCd6QP7@krava>
 <c0bd3baa-3209-23f3-7058-c6908434de2d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0bd3baa-3209-23f3-7058-c6908434de2d@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 12:59:08PM +0800, Jin, Yao wrote:
> Hi Jiri,
> 
> On 5/4/2021 11:07 PM, Jiri Olsa wrote:
> > On Fri, Apr 30, 2021 at 03:46:02PM +0800, Jin Yao wrote:
> > > On hybrid platform, it may have several cpu pmus, such as,
> > > "cpu_core" and "cpu_atom". The CPU_PMU_CAPS feature in perf
> > > header needs to be improved to support multiple cpu pmus.
> > > 
> > > The new layout in header is defined as:
> > > 
> > > <nr_caps>
> > > <caps string>
> > > <caps string>
> > > <pmu name>
> > > <nr of rest pmus>
> > 
> > not sure why is the 'nr of rest pmus' needed
> > 
> 
> The 'nr of rest pmus' indicates the remaining pmus which are waiting for process.
> 
> For example,
> 
> <nr_caps>
> <caps string>
> "cpu_core"
> 1
> <nr_caps>
> <caps string>
> "cpu_atom"
> 0
> 
> When we see '0' in data file processing, we know all the pmu have been processed yet.
> 
> > the current format is:
> > 
> >          u32 nr_cpu_pmu_caps;
> >          {
> >                  char    name[];
> >                  char    value[];
> >          } [nr_cpu_pmu_caps]
> > 
> > 
> > I guess we could extend it to:
> > 
> >          u32 nr_cpu_pmu_caps;
> >          {
> >                  char    name[];
> >                  char    value[];
> >          } [nr_cpu_pmu_caps]
> > 	char pmu_name[]
> > 
> >          u32 nr_cpu_pmu_caps;
> >          {
> >                  char    name[];
> >                  char    value[];
> >          } [nr_cpu_pmu_caps]
> > 	char pmu_name[]
> > 
> > 	...
> > 
> > and we could detect the old format by checking that there's no
> > pmu name.. but maybe I'm missing something, I did not check deeply,
> > please let me know
> > 
> 
> Actually we do the same thing, but I just add an extra 'nr of rest pmus'
> after the pmu_name. The purpose of 'nr of rest pmus' is when we see '0' at
> 'nr of rest pmus', we know that all pmus have been processed.
> 
> Otherwise, we have to continue reading data file till we find something
> incorrect and then finally drop the last read data.

you have the size of the feature data right? I think we use
it in other cases to check if there are more data

> 
> So is this solution acceptable?
> 
> > also would be great to move the format change and storing hybrid
> > pmus in separate patches
> > 
> 
> Maybe we have to put the storing and processing into one patch.
> 
> Say patch 1 contains the format change and storing hybrid pmus. And patch 2
> contains the processing for the new format. If the repo only contains the
> patch 1, I'm afraid that may introduce the compatible issue.

maybe you can have change of caps format in one patch
and storing/processing hybrid pmus in another?

jirka

