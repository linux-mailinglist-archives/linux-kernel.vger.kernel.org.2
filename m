Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4607133FC49
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 01:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhCRAhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 20:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51248 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229472AbhCRAgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 20:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616027795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PmggMa6Ael0aQpsVHT/9vxqm2CX/Cafs/oi+6oAZAnw=;
        b=EXyaSfkcrA3i5Clptni5Sx/cLbakTqZRIAoS2Nutk7fgEMekUNt47KiukUzG9j9lix4R5n
        OflKbnj/rgW2Z207lZEZw/uukJjdIYR0xZcOtJU8G+EVSU3uqZerDtKC7H3SOzIEfbyGIk
        Ay8QLUrLvAie99qoTQaXZEdo09WpJZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-jaIyHjflPTaDpBNYjXxZdg-1; Wed, 17 Mar 2021 20:36:30 -0400
X-MC-Unique: jaIyHjflPTaDpBNYjXxZdg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36F79801817;
        Thu, 18 Mar 2021 00:36:29 +0000 (UTC)
Received: from treble (ovpn-112-220.rdu2.redhat.com [10.10.112.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D40F85D6CF;
        Thu, 18 Mar 2021 00:36:27 +0000 (UTC)
Date:   Wed, 17 Mar 2021 19:36:25 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v4 2/9] x86/kthread,dumpstack: Set task_pt_regs->cs.RPL=3
 for kernel threads
Message-ID: <20210318003625.necz6ygibfqocicz@treble>
References: <cover.1616004689.git.luto@kernel.org>
 <cbe4b7d77b62419749c5ab242ab0270026dc5062.1616004689.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cbe4b7d77b62419749c5ab242ab0270026dc5062.1616004689.git.luto@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 11:12:41AM -0700, Andy Lutomirski wrote:
> @@ -163,6 +163,19 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
>  	/* Kernel thread ? */
>  	if (unlikely(p->flags & PF_KTHREAD)) {
>  		memset(childregs, 0, sizeof(struct pt_regs));
> +
> +		/*
> +		 * Even though there is no real user state here, these
> +		 * are were user regs belong, and kernel_execve() will

s/were/where/

> +		 * overwrite them with user regs.  Put an obviously
> +		 * invalid value that nonetheless causes user_mode(regs)
> +		 * to return true in CS.
> +		 *
> +		 * This also prevents the unwinder from thinking that there
> +		 * is invalid kernel state at the top of the stack.
> +		 */
> +		childregs->cs = 3;
> +
>  		kthread_frame_init(frame, sp, arg);
>  		return 0;
>  	}

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

