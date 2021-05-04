Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895FF3730EA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbhEDTij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:38:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232153AbhEDTii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620157063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5iVVgUy0SDXv9IYkz7ttlGefErcwuOblVtEJb+SJtaU=;
        b=iwwzeaZHGj+ILOKvrK8qUNMTJO924tzIE4Be6lSI7ZtnkKe76vVFLhBbIzS5yBdfp+8T0v
        8ePKJAKU6acBKQrIQJwCfdO1I1gtK6NMzERZc4JjHdNyXoHfQh9z7gzUdnvlr5SEw/sPxk
        cZCEHZ+TRok1E3395ahq8zlOSOo5uJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-nwk_SFf_OLOEv7wl5inw4Q-1; Tue, 04 May 2021 15:37:39 -0400
X-MC-Unique: nwk_SFf_OLOEv7wl5inw4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEF5E107ACCA;
        Tue,  4 May 2021 19:37:37 +0000 (UTC)
Received: from krava (unknown [10.40.192.45])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7D1BF5D9DD;
        Tue,  4 May 2021 19:37:35 +0000 (UTC)
Date:   Tue, 4 May 2021 21:37:34 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 1/2] perf header: Support HYBRID_TOPOLOGY feature
Message-ID: <YJGifgASdDD7T8Xc@krava>
References: <20210430074602.3028-1-yao.jin@linux.intel.com>
 <YJFgrKB9ZavgbA1P@krava>
 <YJGgYSXcJbZ2n3H3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJGgYSXcJbZ2n3H3@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 04:28:33PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, May 04, 2021 at 04:56:44PM +0200, Jiri Olsa escreveu:
> > On Fri, Apr 30, 2021 at 03:46:01PM +0800, Jin Yao wrote:
> > > It would be useful to let user know the hybrid topology.
> > > Adding HYBRID_TOPOLOGY feature in header to indicate the
> > > core cpus and the atom cpus.
> 
> > > With this patch,
> 
> > > For the perf.data generated on hybrid platform,
> > > reports the hybrid cpu list.
> 
> > >   root@otcpl-adl-s-2:~# perf report --header-only -I
> > >   ...
> > >   # cpu_core cpu list : 0-15
> > >   # cpu_atom cpu list : 16-23
> 
> > hum, should we print 'hybrid:' or something to make
> > sure its not confused with something else? like
>  
> >   # hybrid cpu_core cpu list : 0-15
> >   # hybrid cpu_atom cpu list : 16-23
> 
> But this _core/_atom already got to be enough? I disagreed with that
> naming, but neverthless having one or the other present in an output is
> a clear mark of this hybrid topology.
> 
> I.e having that extra hybrid string that wouldn't add information to the
> output.

sure when you know that cpu_core/cpu_atom are hybrid pmus ;-)
and I guess other arch will come with other names 

jirka

> 
> IMHO.
> 
> - Arnaldo
> 

