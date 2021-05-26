Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD3539166B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 13:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhEZLqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 07:46:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229799AbhEZLqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 07:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622029502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4/lN1LWPVHF8DMARxXibJHBzKvJjfwqch7aoJljZd6o=;
        b=dXu/O9nJoj4R/V3XZiYFV8wmnIAbq+qDeRWPiHoz9u7nxSdQxOxQIFi5/8VYha6Ftu4SiN
        5FoTMtTQ+y1DS0BZ/Qld2mTCsi1T3dgvM4bpws1bgUFaKb7rBYy9osHGQZ8yTYN1s0ymgA
        4DS2nPIlWjHi1igPWDefhNRaT37k2O0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-9XuZL9oGPjSC1ovMexHrCw-1; Wed, 26 May 2021 07:45:00 -0400
X-MC-Unique: 9XuZL9oGPjSC1ovMexHrCw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38A11803620;
        Wed, 26 May 2021 11:44:59 +0000 (UTC)
Received: from krava (unknown [10.40.195.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B90910074E0;
        Wed, 26 May 2021 11:44:56 +0000 (UTC)
Date:   Wed, 26 May 2021 13:44:56 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 4/5] perf mem: Support record for hybrid platform
Message-ID: <YK40uLOZC+4qGMl3@krava>
References: <20210520070040.710-1-yao.jin@linux.intel.com>
 <20210520070040.710-5-yao.jin@linux.intel.com>
 <YKvgFVVywalr+Owr@krava>
 <3d9e738d-b972-056b-d0bc-35ed1aaefbad@linux.intel.com>
 <aa5f0be5-c939-3c26-9d2a-3a073449bf98@linux.intel.com>
 <6d6f1040-6c96-7d1d-c766-5fb0057e1cc4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d6f1040-6c96-7d1d-c766-5fb0057e1cc4@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 09:51:34AM +0800, Jin, Yao wrote:
> Hi Jiri,
> 
> On 5/25/2021 3:39 PM, Jin, Yao wrote:
> > Hi Jiri,
> > 
> > > > >       rec_argv = calloc(rec_argc + 1, sizeof(char *));
> > > > >       if (!rec_argv)
> > > > >           return -1;
> > > > > +    /*
> > > > > +     * Save the allocated event name strings.
> > > > > +     */
> > > > > +    rec_tmp = calloc(rec_argc + 1, sizeof(char *));
> > > > > +    if (!rec_tmp) {
> > > > > +        free(rec_argv);
> > > > > +        return -1;
> > > > > +    }
> > > > 
> > > > why not do strdup on all of them and always call free instead?
> > > > that would get rid of the rec_tmp and tmp_nr
> > > > 
> > > 
> > > That is also one method. Let me try it.
> > > 
> > 
> > If we do strdup on all of them, such as,
> > 
> >      if (e->record)
> >          rec_argv[i++] = strdup("-W");
> > 
> >      rec_argv[i++] = strdup("-d");
> > 
> >      if (mem->phys_addr)
> >          rec_argv[i++] = strdup("--phys-data");
> >      ....
> > 
> > That looks too much strdup used here. So I choose to use a rec_tmp[] to
> > record the allocated string and free them before exit the function.
> > 
> > Or we record the start index and end index in rec_argv[] for the
> > allocated event string, use strdup on them and call free before exit the
> > function.
> > 
> 
> This method looks also not OK.
> 
> The rec_argv[] is changed in cmd_record() for some complex command lines.
> 
> For example,
> 
> ./perf mem record -- ./memtest -R0d -b2000 -d64 -n100
> 
> Before cmd_record(), rec_argv[3] = "-e".
> After cmd_record(), rec_argv[3] = "-d64"
> 
> Even we do strdup on all of rec_argv[], but the entries are probably changed
> in cmd_record(), so we can't free the entries at the end of __cmd_record().
> 
> Maybe we have to use the original way which just records the allocated event
> string to a temporary array and free the whole array at the end of
> __cmd_record().
> 
> What do you think?

ok, it was worth to try ;-)

thanks,
jirka

