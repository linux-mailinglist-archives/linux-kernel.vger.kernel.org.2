Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1BE359BBE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhDIKQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233318AbhDIKI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617962923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oNMVN+ZpLxOlEBrMndSNgg2ueOW5AUOLMBDhmanRFKI=;
        b=EOpafZs0sjzV4H25fYRBZMptjwvk5TgwxrzAOID/fQyePCn9dQ7xECr2NxGdE5/576Deo+
        opRvNo2c/ArLRMCSrMzLVqXgU1+1r3aH95NAiMyjjmnRbQoykReDVMg+ej3Cv8LQn5ZAwg
        BDkrnB3SUi1+bG7n9rNwUbLN379+Maw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-ZV6ab0s8PwejAxmhCgL-cQ-1; Fri, 09 Apr 2021 06:08:41 -0400
X-MC-Unique: ZV6ab0s8PwejAxmhCgL-cQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CC11189C441;
        Fri,  9 Apr 2021 10:08:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.207])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1466218400;
        Fri,  9 Apr 2021 10:08:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  9 Apr 2021 12:08:40 +0200 (CEST)
Date:   Fri, 9 Apr 2021 12:08:37 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Fix sys_ioprio_set(.which=IOPRIO_WHO_PGRP) task
 iteration
Message-ID: <20210409100836.GB10447@redhat.com>
References: <YG7Q5C4Rb5dx5GFx@hirez.programming.kicks-ass.net>
 <e8579a4e-2456-a89b-b750-892d265ba053@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8579a4e-2456-a89b-b750-892d265ba053@kernel.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08, Jens Axboe wrote:
>
> On 4/8/21 3:46 AM, Peter Zijlstra wrote:
> >
> > do_each_pid_thread() { } while_each_pid_thread() is a double loop and
> > thus break doesn't work as expected. Also, it should be used under
> > tasklist_lock because otherwise we can race against change_pid() for
> > PGID/SID.
>
> Applied, thanks.

Agreed, but can't resist. We can move the "out" label up and avoid the extra
read_unlock(tasklist_lock). IOW, something like below on top of this patch.

Quite possibly this won't change the generated code, gcc is smart enough, but
this makes the code a bit more readable.

Oleg.

--- x/block/ioprio.c~	2021-04-09 12:00:28.066145563 +0200
+++ x/block/ioprio.c	2021-04-09 12:02:01.817849618 +0200
@@ -123,11 +123,10 @@
 			read_lock(&tasklist_lock);
 			do_each_pid_thread(pgrp, PIDTYPE_PGID, p) {
 				ret = set_task_ioprio(p, ioprio);
-				if (ret) {
-					read_unlock(&tasklist_lock);
-					goto out;
-				}
+				if (ret)
+					goto out_pgrp;
 			} while_each_pid_thread(pgrp, PIDTYPE_PGID, p);
+out_pgrp:
 			read_unlock(&tasklist_lock);
 
 			break;
@@ -159,7 +158,6 @@
 			ret = -EINVAL;
 	}
 
-out:
 	rcu_read_unlock();
 	return ret;
 }

