Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBF532BEDF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386084AbhCCRqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:46:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1445317AbhCCOby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614781828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AF/cO6VaBJofp/QUMtJYV0k7TaZxcJvBGeU6hF/UnYw=;
        b=fwHLWU/lM2QmjVzVUEAHV+hyLi2aLwVL7ZqC3XwpeuBlr5ACxAe3f5GtjRda/xhF1AJwbb
        QMLtI9rUSlwbR/uWTmeP2fhszZh2JrS5glHtc7GaA87fIe69YMyZ1GvF8/UTiZ+uT8JJdT
        +Fx+B35aOEiHarVNqBZgW/6Zfi+0btM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-OgE7VCHMOe2QcvRlX4M40w-1; Wed, 03 Mar 2021 09:30:24 -0500
X-MC-Unique: OgE7VCHMOe2QcvRlX4M40w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DF5580196E;
        Wed,  3 Mar 2021 14:30:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id A76A063633;
        Wed,  3 Mar 2021 14:30:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  3 Mar 2021 15:30:22 +0100 (CET)
Date:   Wed, 3 Mar 2021 15:30:19 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sergei Trofimovich <slyfox@gentoo.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        "Dmitry V . Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] ia64: fix ptrace(PTRACE_SYSCALL_INFO_EXIT) sign
Message-ID: <20210303143018.GB28955@redhat.com>
References: <20210221002554.333076-1-slyfox@gentoo.org>
 <20210221002554.333076-2-slyfox@gentoo.org>
 <20210302233925.081075e0@sf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302233925.081075e0@sf>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02, Sergei Trofimovich wrote:
>
> > --- a/arch/ia64/include/asm/syscall.h
> > +++ b/arch/ia64/include/asm/syscall.h
> > @@ -32,7 +32,7 @@ static inline void syscall_rollback(struct task_struct *task,
> >  static inline long syscall_get_error(struct task_struct *task,
> >  				     struct pt_regs *regs)
> >  {
> > -	return regs->r10 == -1 ? regs->r8:0;
> > +	return regs->r10 == -1 ? -regs->r8:0;
> >  }
> >
> >  static inline long syscall_get_return_value(struct task_struct *task,
> > --
> > 2.30.1
> >
>
> Andrew, would it be fine to pass it through misc tree?
> Or should it go through Oleg as it's mostly about ptrace?

We usually route ptrace fixes via mm tree.

But this fix and another patch from you "ia64: fix ia64_syscall_get_set_arguments()
for break-based syscalls" look very much ia64 specific. I don't think it's actually
about ptrace, and I didn't even try to review these patches because I do not
understand this low level ia64 code.

Can it be routed via ia64 tree? Add Tony and Fenghua...

Oleg.

