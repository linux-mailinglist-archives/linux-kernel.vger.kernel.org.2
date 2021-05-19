Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AB93896D5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhESTkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:40:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232062AbhESTkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621453122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wZPRcVky04T7tQVCJRvLuBv8fJWb/0C7aJ+fxVvIb4U=;
        b=TY8NpufTV+xDYppCkIxoP1F6mWeREwbyj9JdIRT977HKqnj302qsPlytnqgq2z9XOXGHTJ
        mhZGu8OYUElEG07dOyjFq/i4j8vaZCE5vyVq2HxfWP0PkOq1XInXKJbgr/VE2mGKQq9xEL
        hBiFeZsvTLOl6o8pfsp+VHR6mT2UIq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-odATvJdsPM2kuPoKXxG97w-1; Wed, 19 May 2021 15:38:39 -0400
X-MC-Unique: odATvJdsPM2kuPoKXxG97w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C271501F7;
        Wed, 19 May 2021 19:38:38 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FA175D6AC;
        Wed, 19 May 2021 19:38:38 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 84A5B414860B; Wed, 19 May 2021 16:33:19 -0300 (-03)
Date:   Wed, 19 May 2021 16:33:19 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>, rostedt@goodmis.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, corbet@lwn.net
Subject: Re: [RFC] trace: Add option for polling ring buffers
Message-ID: <20210519193319.GC103930@fuller.cnet>
References: <20210519175755.670876-1-nsaenzju@redhat.com>
 <YKVT+sQTgNpCR/Gt@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKVT+sQTgNpCR/Gt@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Willy,

On Wed, May 19, 2021 at 07:07:54PM +0100, Matthew Wilcox wrote:
> On Wed, May 19, 2021 at 07:57:55PM +0200, Nicolas Saenz Julienne wrote:
> > To minimize trace's effect on isolated CPUs. That is, CPUs were only a
> > handful or a single, process are allowed to run. Introduce a new trace
> > option: 'poll-rb'.
> 
> maybe this should take a parameter in ms (us?) saying how frequently
> to poll?  it seems like a reasonable assumption that somebody running in
> this kind of RT environment would be able to judge how often their
> monitoring task needs to collect data.

+1 (yes please).

> > [1] The IPI, in this case, an irq_work, is needed since trace might run
> > in NMI context. Which is not suitable for wake-ups.
> 
> could we also consider a try-wakeup which would not succeed if in NMI
> context?  or are there situations where we only gather data in NMI
> context, and so would never succeed in waking up?  if so, maybe
> schedule the irq_work every 1000 failures to wake up.

We'd like to reduce overhead on the isolated (as in isolcpus=) CPUs as 
much as possible (but yes this option was suggested).

