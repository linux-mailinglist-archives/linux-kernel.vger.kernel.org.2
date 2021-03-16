Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3140F33D56C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbhCPOEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:04:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44552 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235403AbhCPOER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615903456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lZNEQWnU1MKUmFvt5yn1z/1Cxme6xTcqchzQaFGYGPg=;
        b=KFm7mFyCM+Zwd+7uOiukQr79O7gMrthNwakUngbmFTyL93PnfPmxPLGQlFPfwzPXhuDw/X
        ppu307YXu7vxFwxutgd97VeLbynFyZEvInz7xmyCTD+taoJGBAYHvQ2gxFnhbDcbnq+dDv
        1LcblOYiXzMoMRu9mGaKfsNDKXwAcUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-BaZQag2UOUek8MRyCKd6vw-1; Tue, 16 Mar 2021 10:04:12 -0400
X-MC-Unique: BaZQag2UOUek8MRyCKd6vw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A90492508;
        Tue, 16 Mar 2021 14:04:10 +0000 (UTC)
Received: from krava (unknown [10.40.193.217])
        by smtp.corp.redhat.com (Postfix) with SMTP id 028715D9D3;
        Tue, 16 Mar 2021 14:04:07 +0000 (UTC)
Date:   Tue, 16 Mar 2021 15:04:07 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 11/27] perf parse-events: Support hardware events
 inside PMU
Message-ID: <YFC615nTdUR/aLw5@krava>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
 <20210311070742.9318-12-yao.jin@linux.intel.com>
 <YEu9usdFl6VSnOQ7@krava>
 <c40d6187-9391-40de-aea8-7389bb369555@linux.intel.com>
 <YE+balbLkG5RL7Lu@krava>
 <fd88f214-f0a4-87bc-ef52-ee750ca13a8d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd88f214-f0a4-87bc-ef52-ee750ca13a8d@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 09:49:42AM +0800, Jin, Yao wrote:

SNIP

> 
>  Performance counter stats for 'system wide':
> 
>        136,655,302      cpu_core/branch-instructions/
> 
>        1.003171561 seconds time elapsed
> 
> So we need special rules for both cycles and branches.
> 
> The worse thing is, we also need to process the hardware cache events.
> 
> # ./perf stat -e cpu_core/LLC-loads/
> event syntax error: 'cpu_core/LLC-loads/'
>                               \___ unknown term 'LLC-loads' for pmu 'cpu_core'
> 
> valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,config,config1,config2,name,period,percore
> 
> Initial error:
> event syntax error: 'cpu_core/LLC-loads/'
>                               \___ unknown term 'LLC-loads' for pmu 'cpu_core'
> 
> If we use special rules for establishing all event mapping, that looks too much. :(

hmmm but wait, currently we do not support events like this:

  'cpu/cycles/'
  'cpu/branches/'

the pmu style accepts only 'events' or 'format' terms within //

we made hw events like 'cycles','instructions','branches' special
to be used without the pmu

so why do we need to support cpu_code/cycles/ ?

jirka

