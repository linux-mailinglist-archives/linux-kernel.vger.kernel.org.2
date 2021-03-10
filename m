Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815D233451E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhCJR2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:28:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233188AbhCJR2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615397286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/HCbdKQtl1hc4k6FOD0WDGWfRfllFHhgAWZ0zbz9Dgw=;
        b=eTN9Md2yhcuQHXQJM4nzfUzsFxFGmR8Kds/Qh2Y5ZzDXNWjIbgszj4aC8Gj4SfD+QyfO+F
        kf0nJNayYGWE0JBB/ZEh/KNJfkdlIQSBq1ivbM+Pg1oAluOMVmNoHly3X5/JXG1hu2hyH6
        Jl9VZH1dH4QCeyD94bEQ0dJMfCycZas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-1omLWBNxMBGLlXEABc3x3Q-1; Wed, 10 Mar 2021 12:27:58 -0500
X-MC-Unique: 1omLWBNxMBGLlXEABc3x3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 625031005D45;
        Wed, 10 Mar 2021 17:27:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id E0A8F772E8;
        Wed, 10 Mar 2021 17:27:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 10 Mar 2021 18:27:56 +0100 (CET)
Date:   Wed, 10 Mar 2021 18:27:53 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jim Newsome <jnewsome@torproject.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
Message-ID: <20210310172752.GA8973@redhat.com>
References: <20210309203919.15920-1-jnewsome@torproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309203919.15920-1-jnewsome@torproject.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09, Jim Newsome wrote:
>
> do_wait is an internal function used to implement waitpid, waitid,
> wait4, etc. To handle the general case, it does an O(n) linear scan of
> the thread group's children and tracees.
>
> This patch adds a special-case when waiting on a pid to skip these scans
> and instead do an O(1) lookup. This improves performance when waiting on
> a pid from a thread group with many children and/or tracees.
>
> Signed-off-by: James Newsome <jnewsome@torproject.org>

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

