Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64173BF613
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 09:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhGHHQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 03:16:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230404AbhGHHQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 03:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625728445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aTVrKeNSZQYZXjn+U2KrdBcF3WfqOs66nwM/5SMqCdw=;
        b=TSSdMntVnKRxEDx7lz7jdYOma51JlVFim6r8e+6okk8SFPXsqZ1VOyF3TVqeOhY7omFZzP
        qDEf8oDLFIa24nAQcTrdpS9A3NNB1LP36lvDUGFy5hxqvcoO7iVNOHmnTcxhO1u5OMj5AB
        wlB5qQjwet7Nc63vvkK2W+9JJjiyANo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-thd_CwFgO0yjDP7m6NA6iA-1; Thu, 08 Jul 2021 03:14:03 -0400
X-MC-Unique: thd_CwFgO0yjDP7m6NA6iA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FDD91084F40;
        Thu,  8 Jul 2021 07:14:01 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-115-5.ams2.redhat.com [10.36.115.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FEBF5D9D3;
        Thu,  8 Jul 2021 07:13:50 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
References: <20210623192822.3072029-1-surenb@google.com>
        <87sg0qa22l.fsf@oldenburg.str.redhat.com>
        <CAJuCfpEWpvw+gW+NvBPOdGqUOEyucFoT8gdC2uk18dMBQFbhqw@mail.gmail.com>
        <87wnq1z7kl.fsf@oldenburg.str.redhat.com>
        <CAJuCfpFt55Dw1uW3S6_AincNfPaAtwdi6iXYVvFr7x3fvt4uzw@mail.gmail.com>
        <87zguxxrfl.fsf@oldenburg.str.redhat.com>
        <CAJuCfpEUXz-oHi5Ho8nGAKtFV6ArQDx9yQwrdTzYgHr5+6=YaQ@mail.gmail.com>
Date:   Thu, 08 Jul 2021 09:13:48 +0200
In-Reply-To: <CAJuCfpEUXz-oHi5Ho8nGAKtFV6ArQDx9yQwrdTzYgHr5+6=YaQ@mail.gmail.com>
        (Suren Baghdasaryan's message of "Wed, 7 Jul 2021 23:39:34 -0700")
Message-ID: <874kd5xopf.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan:

> Sending SIGKILL is blocking in terms of delivering the signal, but it
> does not block waiting for SIGKILL to be processed by the signal
> recipient and memory to be released. When I was talking about
> "blocking", I meant that current kill() and friends do not block to
> wait for SIGKILL to be processed.
> process_reap() will block until the memory is released. Whether the
> userspace caller is using it right after sending a SIGKILL to reclaim
> the memory synchronously or spawns a separate thread to reclaim memory
> asynchronously is up to the user. Both patterns are supported.

I see, this makes sense.

Considering that the pidfd sticks around after process_reap returns, the
issue described in bug 154011 probably does not apply to process_reap.
(This relates to asynchronous resource deallocation, as discussed before.)

Thanks,
Florian

