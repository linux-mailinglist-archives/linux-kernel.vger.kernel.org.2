Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D44739FA1E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhFHPQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231919AbhFHPQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623165300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=a9fDmbgDgPt6AGiO4Q2TUHuPCfIacboKs9yVhQgMWzg=;
        b=Q2oZA20wuCeLu7qFHVhzniODx0iZ9aGkY8KervVHgG/Cb5rs5oxuOCviwG6wpHuJWHrcvR
        41PoZy9mHxW3c1o1c8H8AKaiIyNZ/bv8AktPT51oM1OzpF2gQWQRnYNuG3PuJ5oId8cT6m
        EFP/FjYEiAPJaGq5pmnRWl5JYtREzjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-LKUrGzryOwSTLf9IHQZ2xQ-1; Tue, 08 Jun 2021 11:14:58 -0400
X-MC-Unique: LKUrGzryOwSTLf9IHQZ2xQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C111381441E;
        Tue,  8 Jun 2021 15:14:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB71E1001281;
        Tue,  8 Jun 2021 15:14:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
cc:     dhowells@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Can we get a general timed LRU built on the workqueue subsys?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <485280.1623165261.1@warthog.procyon.org.uk>
Date:   Tue, 08 Jun 2021 16:14:21 +0100
Message-ID: <485281.1623165261@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

Would it be practical to get some sort of timed LRU built on top of the
workqueue such that I can, say, queue an item on it without using the
delayed_work struct?

The reason I'd like this is that I want to avoid using delayed_work because it
would increase the size of the fscache_cookie struct by 50% (110% with
lockdep), and then you'd have to multiply that by the number of cookies on the
system - could be tens or hundreds of thousands; could be a million+ in some
applications.

Really, only one timer should be necessary for the entire queue if every item
in the queue has the same timeout length, since it would only need to keep
track of the item at the front of the queue.  This timer could be managed with
timer_reduce() rather than mod_timer() or del_timer()+add_timer().

Each item in the queue would need a timestamp to say when it expires, say:

	struct work_lru {
		struct work_struct work;
		unsigned long expires_at;
	};

There are other places I could use such a thing too, not just for fscache
cookies.

David

