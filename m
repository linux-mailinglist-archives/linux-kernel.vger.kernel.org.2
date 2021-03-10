Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3CE334535
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbhCJRdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:33:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50760 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233145AbhCJRcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615397566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=58ntsYjRUyWKxftkmOsw5t+goH6gjLTWKbgL1ZhWpSk=;
        b=fECFOlOXLtVx0jd3OQ5xJLvPkPi5UuWo9/epZ0dD9MBcELxUJWzvnHln4/2s5RPqu/E6Xd
        rJwgtLzoznwkBwDD2XKrVox430DayTjX4qRtxfrl7crNuZazZHCxPQBUghhJ+Ej1CvbRFQ
        0Y0lqwywCukXBlkGGK95CDrVzkIlZ48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-OJQdNBbIM46PZQ8s5JxdEQ-1; Wed, 10 Mar 2021 12:32:42 -0500
X-MC-Unique: OJQdNBbIM46PZQ8s5JxdEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA599107466D;
        Wed, 10 Mar 2021 17:32:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9048960C5F;
        Wed, 10 Mar 2021 17:32:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 10 Mar 2021 18:32:40 +0100 (CET)
Date:   Wed, 10 Mar 2021 18:32:37 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     qianli zhao <zhaoqianligood@gmail.com>, christian@brauner.io,
        axboe@kernel.dk, Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>
Subject: Re: [PATCH] exit: trigger panic when init process is set to
 SIGNAL_GROUP_EXIT
Message-ID: <20210310173236.GB8973@redhat.com>
References: <1615296712-175334-1-git-send-email-zhaoqianligood@gmail.com>
 <20210309182657.GA1408@redhat.com>
 <CAPx_LQEQto2fget=kCnfjSCdAp9XCwc2AWgzwxpbxdyCgNs5Mg@mail.gmail.com>
 <m1lfavufep.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1lfavufep.fsf@fess.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10, Eric W. Biederman wrote:
>
> 	/* If global init has exited,
>          * panic immediately to get a useable coredump.
>          */
> 	if (unlikely(is_global_init(tsk) &&
> 	    (thread_group_empty(tsk) ||
>             (tsk->signal->flags & SIGNAL_GROUP_EXIT)))) {
> 		panic("Attempted to kill init!	exitcode=0x%08x\n",
>                 	tsk->signal->group_exit_code ?: (int)code);
> 	}
>
> The thread_group_empty test is needed to handle single threaded
> inits.

But we can't rely on thread_group_empty(). Just suppose that the main
thread exit first, then the 2nd (last) thread exits too.

Oleg.

