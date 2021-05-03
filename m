Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C13137239D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 01:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhECXc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 19:32:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229948AbhECXc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 19:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620084724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j/f3+B4CU9YMYTXz4OiA6lfkrhjlWRJ5BGOH+u8U4PA=;
        b=IJNmxB/4jBa9MZdOEw9Fi4LxqQjwUm3JPinfMwtYVc0+QARmuAvzAM4P+DFss708eaSrIx
        5l1aM6dQZDSXVixX9z9WrrckNPVf7kl0VPjvNvvZTm6SMAdbHvoJtQaKtHbwuWKUSqtDVX
        3C2HR248Tm1dTzNpQUigu3VuiTseuVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-H1OBOYaSN9KXbRtPs9kYLw-1; Mon, 03 May 2021 19:32:02 -0400
X-MC-Unique: H1OBOYaSN9KXbRtPs9kYLw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 306906D241;
        Mon,  3 May 2021 23:32:00 +0000 (UTC)
Received: from treble (ovpn-115-93.rdu2.redhat.com [10.10.115.93])
        by smtp.corp.redhat.com (Postfix) with SMTP id 124F460C05;
        Mon,  3 May 2021 23:31:54 +0000 (UTC)
Date:   Mon, 3 May 2021 18:31:54 -0500
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
Message-ID: <20210503233154.lhumcispdgj5dgaz@treble>
References: <1d06ed6485b66b9f674900368b63d7ef79f666ca.1599756789.git.jpoimboe@redhat.com>
 <20200914195354.yghlqlwtqz7mqteb@treble>
 <20200923033848.GD3421308@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200923033848.GD3421308@ZenIV.linux.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 04:38:48AM +0100, Al Viro wrote:
> On Mon, Sep 14, 2020 at 02:53:54PM -0500, Josh Poimboeuf wrote:
> > Al,
> > 
> > This depends on Christoph's set_fs() removal patches.  Would you be
> > willing to take this in your tree?
> 
> in #uaccess.x86 and #for-next

Hm, I think this got dropped somehow.   Will repost.

-- 
Josh

