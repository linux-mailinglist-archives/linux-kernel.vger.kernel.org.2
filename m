Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1CB32BCF1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349135AbhCCPFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:05:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232694AbhCCK0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614767107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CV3tkp8merYe5w3jgDlwc9oNvGcc86ob13BJ0IDLoJA=;
        b=DufhUQrd91o3yvpW6ozd46tjY/uLdDgLfmvYm+QYN+nSniehJdjar5o1Rznm/Hs4c31lWQ
        8vqKe5VKxgntGf3S2YqSWBBsUtqRYmxaUJ1ybTNzb3Hps79vOsLNeyn/gFaCGzmzmtnni8
        RH7wT0f/x4GSZb4/Wve+z5eA6ZqQGsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-_nJ8wJuPNCmgdVZduZEvbQ-1; Wed, 03 Mar 2021 03:23:25 -0500
X-MC-Unique: _nJ8wJuPNCmgdVZduZEvbQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E991100962A;
        Wed,  3 Mar 2021 08:23:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 356AE60BFA;
        Wed,  3 Mar 2021 08:23:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210303064028.895953-1-weiyongjun1@huawei.com>
References: <20210303064028.895953-1-weiyongjun1@huawei.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     dhowells@redhat.com, Hulk Robot <hulkci@huawei.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] afs: Remove unused variable in afs_req_issue_op()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2025007.1614759802.1@warthog.procyon.org.uk>
Date:   Wed, 03 Mar 2021 08:23:22 +0000
Message-ID: <2025008.1614759802@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Yongjun <weiyongjun1@huawei.com> wrote:

> GCC reports the following warning with W=1:
> 
> fs/afs/file.c:291:6: warning:
>  unused variable 'ret' [-Wunused-variable]
>   291 |  int ret;
>       |      ^~~
> 
> After commit 799fbdf96cd51, this variable is not used in function
> afs_req_issue_op(), so this commit remove it to fix the warning.
> 
> Fixes: 799fbdf96cd51 ("afs: Use new fscache read helper API")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

I've already fixed that and updated my branch, thanks.  linux-next should pick
it up on the next merging.

David

