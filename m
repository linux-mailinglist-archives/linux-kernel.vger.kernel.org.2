Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFF3344AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhCVQQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231243AbhCVQPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616429737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d9xW4e0ABDahCGPtlmhy6o9ZXwjtcaGWiPhqlG3tVgw=;
        b=FssBN15e0vPQ0x2BVWaHyFeOlxTqjVrCxtJ9RS/hR9iz45IEl9dwzmcs+Uj4HIsyI9rVs2
        MWE9UskB2qnAbB80ezhepwlWqkzjD9zXQVD0Ch5DGU8RQvETRZIWTJ827SffJngCzMgc5A
        0Sr1acQTzm7oHIJgLNhSCsBFS2uoqkw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-Y8-CQZiGMeOGX6cLjLR5tA-1; Mon, 22 Mar 2021 12:15:35 -0400
X-MC-Unique: Y8-CQZiGMeOGX6cLjLR5tA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 105E0108BD0C;
        Mon, 22 Mar 2021 16:15:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.114])
        by smtp.corp.redhat.com (Postfix) with SMTP id 141885B6AB;
        Mon, 22 Mar 2021 16:15:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 22 Mar 2021 17:15:32 +0100 (CET)
Date:   Mon, 22 Mar 2021 17:15:29 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        Stefan Metzmacher <metze@samba.org>
Subject: Re: [PATCH 2/2] signal: don't allow STOP on PF_IO_WORKER threads
Message-ID: <20210322161529.GB20390@redhat.com>
References: <20210320153832.1033687-1-axboe@kernel.dk>
 <20210320153832.1033687-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320153832.1033687-3-axboe@kernel.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20, Jens Axboe wrote:
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2349,6 +2349,10 @@ static bool do_signal_stop(int signr)
>
>  		t = current;
>  		while_each_thread(current, t) {
> +			/* don't STOP PF_IO_WORKER threads */
> +			if (t->flags & PF_IO_WORKER)
> +				continue;
> +

This is not enough. At least task_join_group_stop() should check
PF_IO_WORKER too.

Oleg.

