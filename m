Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA9933DB9E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbhCPRzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:55:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239451AbhCPRzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615917307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=et+8M4fnfpbY0GeGG05MXy/pGLb3+RZRFKGCfdaC3Sc=;
        b=dRepZzYg9PffAi9n/MCR37OApoL+T18R/mBWoaZJH/9XjjlvVMLb1eAKmINFOuwVXrSFIE
        AMYHy4wAJLvZzwqk1I1vuzYtlF2Usr5h9ubFvBm/5CAH2C4Q6JU1aRI//W4oP5Ypo+Nnhc
        BLvepVxQ2Uy5YbJms3CWkKvxJfHDDuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-X_-hKvDyOCOief-DATOHdQ-1; Tue, 16 Mar 2021 13:55:03 -0400
X-MC-Unique: X_-hKvDyOCOief-DATOHdQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E413760C7;
        Tue, 16 Mar 2021 17:55:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.135])
        by smtp.corp.redhat.com (Postfix) with SMTP id 744255D9C0;
        Tue, 16 Mar 2021 17:54:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 16 Mar 2021 18:55:00 +0100 (CET)
Date:   Tue, 16 Mar 2021 18:54:56 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] task_work: kasan: record task_work_add() call stack
Message-ID: <20210316175455.GA25881@redhat.com>
References: <20210316024410.19967-1-walter-zh.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316024410.19967-1-walter-zh.wu@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/16, Walter Wu wrote:
>
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -34,6 +34,9 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
>  {
>  	struct callback_head *head;
>
> +	/* record the work call stack in order to print it in KASAN reports */
> +	kasan_record_aux_stack(work);
> +
>  	do {
>  		head = READ_ONCE(task->task_works);
>  		if (unlikely(head == &work_exited))

Acked-by: Oleg Nesterov <oleg@redhat.com>

