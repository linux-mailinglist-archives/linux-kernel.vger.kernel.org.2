Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9EA3724D3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 06:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhEDENj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 00:13:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52159 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229499AbhEDENi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 00:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620101564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q0ACPl1VAdSU0nEf3aeUyaeDiPkRpjs8Y0P3JP67Ni0=;
        b=D5dbvAj1l5sglm3Mi9ygLcLa4nGTUk+d2MCdhOFRU5FqU6fbDrjW8zkOdceKsaIvMrfj4+
        fh8kRWaRkhI0HpqoA1FVhYmea4VTKqEYpRg4RqPXjqua6rGwXqyBFTZ57qhqKKeRAkA0oP
        Qj608UUZRdd0rcUPdlGMEwGyDrx7eJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-zOEBaDekOs6qeQkHdqsHnA-1; Tue, 04 May 2021 00:12:42 -0400
X-MC-Unique: zOEBaDekOs6qeQkHdqsHnA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A80F2801AD9;
        Tue,  4 May 2021 04:12:40 +0000 (UTC)
Received: from treble (ovpn-115-93.rdu2.redhat.com [10.10.115.93])
        by smtp.corp.redhat.com (Postfix) with SMTP id 81C191A874;
        Tue,  4 May 2021 04:12:35 +0000 (UTC)
Date:   Mon, 3 May 2021 23:12:35 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20210504041235.25mq7il525oiimc6@treble>
References: <1d06ed6485b66b9f674900368b63d7ef79f666ca.1599756789.git.jpoimboe@redhat.com>
 <20200914195354.yghlqlwtqz7mqteb@treble>
 <20200923033848.GD3421308@ZenIV.linux.org.uk>
 <20210503233154.lhumcispdgj5dgaz@treble>
 <YJCVzX2aZmu8GaD/@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJCVzX2aZmu8GaD/@zeniv-ca.linux.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 12:31:09AM +0000, Al Viro wrote:
> On Mon, May 03, 2021 at 06:31:54PM -0500, Josh Poimboeuf wrote:
> > On Wed, Sep 23, 2020 at 04:38:48AM +0100, Al Viro wrote:
> > > On Mon, Sep 14, 2020 at 02:53:54PM -0500, Josh Poimboeuf wrote:
> > > > Al,
> > > > 
> > > > This depends on Christoph's set_fs() removal patches.  Would you be
> > > > willing to take this in your tree?
> > > 
> > > in #uaccess.x86 and #for-next
> > 
> > Hm, I think this got dropped somehow.   Will repost.
> 
> Ow...  #uaccess.x86 got dropped from -next at some point, mea culpa.
> What I have is b4674e334bb4; it's 5.8-based (well, 5.9-rc1).  It
> missed post-5.9 merge window and got lost.  Could you rebase to
> to more or less current tree and repost?

No problem, I'll refresh it against the latest.

-- 
Josh

