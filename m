Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C3F339322
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhCLQX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:23:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42532 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232233AbhCLQXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615566235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xSYDoiB+Sm1xN1cnL2N1sIO4P5NjsZSPzQuHmVBThEs=;
        b=JybJNWnhvs8DFqhjd8ff1x4oNU3yNB8yCfOlfPTt61edc8TnIxYaEhP5kgJSzEpe3gY05k
        m4SZ6eDj4W6EvV4WFDR67TA7aW6PxL1Lh8psWVvxWctBlzrtf2n5EPkGNVO5yZkzMsLPAq
        pzvr/zQ3sVXeTxlGg1bRUpRB7bUl1+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-hXuGadYlOKGq8yyDOb8syA-1; Fri, 12 Mar 2021 11:23:51 -0500
X-MC-Unique: hXuGadYlOKGq8yyDOb8syA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31488A40C0;
        Fri, 12 Mar 2021 16:23:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.14])
        by smtp.corp.redhat.com (Postfix) with SMTP id B02085D9CC;
        Fri, 12 Mar 2021 16:23:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 12 Mar 2021 17:23:48 +0100 (CET)
Date:   Fri, 12 Mar 2021 17:23:45 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Qianli Zhao <zhaoqianligood@gmail.com>
Cc:     christian@brauner.io, axboe@kernel.dk, ebiederm@xmission.com,
        tglx@linutronix.de, pcc@google.com, linux-kernel@vger.kernel.org,
        zhaoqianli@xiaomi.com
Subject: Re: [PATCH V2] exit: trigger panic when global init has exited
Message-ID: <20210312162344.GB27820@redhat.com>
References: <1615519478-178620-1-git-send-email-zhaoqianligood@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615519478-178620-1-git-send-email-zhaoqianligood@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12, Qianli Zhao wrote:
>
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -767,6 +767,17 @@ void __noreturn do_exit(long code)
>  	validate_creds_for_do_exit(tsk);
>  
>  	/*
> +	 * If global init has exited,
> +	 * panic immediately to get a useable coredump.
> +	 */
> +	if (unlikely(is_global_init(tsk) &&
> +	    (thread_group_empty(tsk) ||
> +	    (tsk->signal->flags & SIGNAL_GROUP_EXIT)))) {
> +			panic("Attempted to kill init! exitcode=0x%08x\n",
> +				tsk->signal->group_exit_code ?: (int)code);

See our discussion with Eric, this is not right.
https://lore.kernel.org/lkml/20210310173236.GB8973@redhat.com/

Oleg.

