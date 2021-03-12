Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E015C33944A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhCLRHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:07:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40818 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232324AbhCLRHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615568835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oHq45FYaXbnUeF4f7ofGJHUnQNgpRxaf+6Xx6blzWKU=;
        b=YQnEVPnTOxuQylCYRGFLGBQwrsm8KcreTYtejYnd2JiPCfdcm1wP5h2TATW2wb5BUsjOGn
        LHeCcgNWsjZLXAS7+igoOWvVOHVTWDNNR+Z8OTbdDzQyb/XK5NF+g2UtwrRvluo2duTBcr
        JQeFih3o8Fuq20bNSaeuUprZ7j3dSxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-7KbeNha0MzuuayDh_57DaA-1; Fri, 12 Mar 2021 12:07:13 -0500
X-MC-Unique: 7KbeNha0MzuuayDh_57DaA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 366121084D76;
        Fri, 12 Mar 2021 17:07:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.14])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5C7B25D6BA;
        Fri, 12 Mar 2021 17:07:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 12 Mar 2021 18:07:11 +0100 (CET)
Date:   Fri, 12 Mar 2021 18:07:10 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jim Newsome <jnewsome@torproject.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptrace: Allow other threads to access tracee
Message-ID: <20210312170709.GD27820@redhat.com>
References: <20210310205908.23447-1-jnewsome@torproject.org>
 <20210311152123.GC15552@redhat.com>
 <f82d5f3a-63f7-2f3f-0e34-aa53ade15bfc@torproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f82d5f3a-63f7-2f3f-0e34-aa53ade15bfc@torproject.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11, Jim Newsome wrote:
>
> I suppose even if the corruption of the register-values-themselves is
> acceptable, some synchronization may be needed to avoid the possibility
> of corrupting the kernel's data structures?

Yes, the kernel can crash. Just look at the comment above ptrace_freeze_traced().
The kernel assumes that the tracee is frozen, in particular it can't exit.
Say, ptrace_peek_siginfo() can crash the tracee exits and clears ->sighand,
and this can obviously happen if another thread does PTRACE_CONT + SIGKILL.

> Is it "just" a matter of adding some locking? Would a relatively coarse
> lock on the target task over the duration of the ptrace call

Yes I think needs a mutex in task_struct. But honestly I am not sure
it makes sense.... I dunno.

> (which I
> believe is always non-blocking?)

Why? It is blocking.

Oleg.

