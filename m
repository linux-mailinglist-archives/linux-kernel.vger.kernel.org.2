Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5EAE37497A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhEEU3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29156 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234151AbhEEU3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620246533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ng51bOLhRP5pIpPnq3PcaFjNUv0ZNhMkeb/JrpTtSaA=;
        b=Ez4WiNduBchwWtt8byrxYHw8kmXOaDn66ah7VRbFKoBhsOJtJzJ1XX+jzHAapFqpUMWFQ8
        NgUGVggvnzZ+FcoHoXzLbvJcuHklM34dPXP6veT+hv5oGkbuik/LQc1GkQBLrOL3VEZl/w
        knIkfQ5HRGdu5QFPu3z5QXLiWYkYfwY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-UP97XkagPlOt4-1AwsN5Zg-1; Wed, 05 May 2021 16:28:50 -0400
X-MC-Unique: UP97XkagPlOt4-1AwsN5Zg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C9241A8A64;
        Wed,  5 May 2021 20:28:49 +0000 (UTC)
Received: from krava (unknown [10.40.192.93])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6CCCC5D6A8;
        Wed,  5 May 2021 20:28:47 +0000 (UTC)
Date:   Wed, 5 May 2021 22:28:46 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 1/2] perf header: Support HYBRID_TOPOLOGY feature
Message-ID: <YJL//g4j7RgmSIqW@krava>
References: <20210430074602.3028-1-yao.jin@linux.intel.com>
 <YJFgrKB9ZavgbA1P@krava>
 <YJGgYSXcJbZ2n3H3@kernel.org>
 <YJGifgASdDD7T8Xc@krava>
 <YJKiYziYlLgUmMwq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJKiYziYlLgUmMwq@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 10:49:23AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, May 04, 2021 at 09:37:34PM +0200, Jiri Olsa escreveu:
> > On Tue, May 04, 2021 at 04:28:33PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, May 04, 2021 at 04:56:44PM +0200, Jiri Olsa escreveu:
> > > > On Fri, Apr 30, 2021 at 03:46:01PM +0800, Jin Yao wrote:
> > > > > It would be useful to let user know the hybrid topology.
> > > > > Adding HYBRID_TOPOLOGY feature in header to indicate the
> > > > > core cpus and the atom cpus.
> > > 
> > > > > With this patch,
> > > 
> > > > > For the perf.data generated on hybrid platform,
> > > > > reports the hybrid cpu list.
> > > 
> > > > >   root@otcpl-adl-s-2:~# perf report --header-only -I
> > > > >   ...
> > > > >   # cpu_core cpu list : 0-15
> > > > >   # cpu_atom cpu list : 16-23
> > > 
> > > > hum, should we print 'hybrid:' or something to make
> > > > sure its not confused with something else? like
> > >  
> > > >   # hybrid cpu_core cpu list : 0-15
> > > >   # hybrid cpu_atom cpu list : 16-23
> > > 
> > > But this _core/_atom already got to be enough? I disagreed with that
> > > naming, but neverthless having one or the other present in an output is
> > > a clear mark of this hybrid topology.
> > > 
> > > I.e having that extra hybrid string that wouldn't add information to the
> > > output.
> > 
> > sure when you know that cpu_core/cpu_atom are hybrid pmus ;-)
> > and I guess other arch will come with other names 
> 
> Yeah, its too Intel centric, I thought they would come up with
> cpu_big/cpu_little and map it to core/atom on Intel and whatever other
> BIG/little arches come up with.
> 
> Perhaps:
> 
> root@otcpl-adl-s-2:~# perf report --header-only -I
> ...
> # hybrid cpu system:
> # cpu_core cpu list : 0-15
> # cpu_atom cpu list : 16-23
> 
> ?

'hybrid pmus' would sounds better to me,
but as long as there's hybrid in there I'm good ;-)

thanks,
jirka

> 
> - Arnaldo
> 

