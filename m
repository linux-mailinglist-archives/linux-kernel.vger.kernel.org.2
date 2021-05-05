Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC423373DEB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 16:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhEEOtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 10:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28288 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233362AbhEEOt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620226112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=48UBqymDPDXkR8q4vDaT7FtTeIi5/cgoRyHmO54k5TI=;
        b=KnLGa8Q6YRQsEi4uYZqCDr32MVfq85KrzDP4ncZAE1B8cnSjpKaXcTqS6KU5kFToHdZf7z
        CkG7G0UCQdEmKqVmbC8TRxOyPEi2dV6EpWMKFPY6s2m88KFxqhsO8/a8quHiYXnM2rMt0P
        OEZVZ2b1Whwsgb+BwLCEctBVoOjc2lU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-x_ViNySROj2fLDh5lSpKng-1; Wed, 05 May 2021 10:48:31 -0400
X-MC-Unique: x_ViNySROj2fLDh5lSpKng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75467835DE1;
        Wed,  5 May 2021 14:48:29 +0000 (UTC)
Received: from treble (ovpn-115-93.rdu2.redhat.com [10.10.115.93])
        by smtp.corp.redhat.com (Postfix) with SMTP id 16C3D5C1C5;
        Wed,  5 May 2021 14:48:22 +0000 (UTC)
Date:   Wed, 5 May 2021 09:48:22 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Al Viro <viro@zeniv.linux.org.uk>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 3/4] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20210505144822.muxfkxo5vajzgycu@treble>
References: <cover.1620186182.git.jpoimboe@redhat.com>
 <5ba93cdbf35ab40264a9265fc24575a9b2f813b3.1620186182.git.jpoimboe@redhat.com>
 <20210505142542.GC5605@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210505142542.GC5605@C02TD0UTHF1T.local>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 03:25:42PM +0100, Mark Rutland wrote:
> On arm64 we needed to have a sequence here because the addr_limit used
> to be variable, but now that we've removed set_fs() and split the
> user/kernel access routines we could simplify that to an AND with an
> immediate mask to force all pointers into the user half of the address
> space. IIUC x86_64 could do the same, and I think that was roughly what
> David was suggesting.

True.  On 64-bit arches it might be as simple as just clearing the
most-significant bit.

-- 
Josh

