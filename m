Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B9D42BF0E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 13:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhJMLjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 07:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231208AbhJMLjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 07:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634125054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Q1uj+xycIDtoo2HHvnO92qdohILxo/PDfUXBVZcT2E=;
        b=RMt10QfgZODIMF+pDFomB1ZdXkbtJlL3xZdmNz33X2acZjdQ/uvW7loGlJUN/HhE4JU0bW
        8gNaHNXxUSdtsbBqHOlcHgGl7rM2WGlNJTvq7VQ6033zLqkGtFHCaC64Y0IF7Il/BXRWoU
        4rxS3Q/1FsUQ2MzfWBtiqf0y/TFQsuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-Uc6PD-_cMNi5GBQ83NWEdw-1; Wed, 13 Oct 2021 07:37:31 -0400
X-MC-Unique: Uc6PD-_cMNi5GBQ83NWEdw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FB8D10168DE;
        Wed, 13 Oct 2021 11:37:30 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F257590BA;
        Wed, 13 Oct 2021 11:37:11 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 9C9CF4188580; Wed, 13 Oct 2021 08:37:06 -0300 (-03)
Date:   Wed, 13 Oct 2021 08:37:06 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch v4 1/8] add basic task isolation prctl interface
Message-ID: <20211013113706.GA92593@fuller.cnet>
References: <20211007192346.731667417@fedora.localdomain>
 <20211007193525.755160804@fedora.localdomain>
 <YWWIHkoAdTkzU0TP@hirez.programming.kicks-ass.net>
 <20211013105637.GA88322@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013105637.GA88322@fuller.cnet>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 07:56:37AM -0300, Marcelo Tosatti wrote:
> Hi Peter,
> 
> On Tue, Oct 12, 2021 at 03:05:34PM +0200, Peter Zijlstra wrote:
> > On Thu, Oct 07, 2021 at 04:23:47PM -0300, Marcelo Tosatti wrote:
> > > Add basic prctl task isolation interface, which allows
> > > informing the kernel that application is executing 
> > > latency sensitive code (where interruptions are undesired).
> > > 
> > > Interface is described by task_isolation.rst (added by
> > > next patch).
> > 
> > That does not absolve you from actually writing a changelog here.
> > Life is too short to try and read rst shit.
> 
> The rst is concise and contains all necessary information.
> 
> Changelog is on the patch header (I would appreciate reviews of
> the interface itself, not sure why the changelog is important).

Err, changelog is on the patchset intro.

