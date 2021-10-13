Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC71142CC87
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhJMVKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:10:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32112 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229771AbhJMVKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634159287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3WNwfE3UA1GE1htBdimBENBrvRnFUAVO3nMv6ljsFsk=;
        b=RrP4OVGHsi/JRwv8CiI+5pdReU4TPp5QcPYdEb/rWTBBtlGhVVJe1ovtHdTI1E0ZQ15iAv
        P1beYHLtymG5xDt/VDKdOrfRPL02OiCH8x4ctb2z3YM6FDPoizzidF4vWtYn8SQtoBWyqs
        uqnPeR3rThDUCjcLiEaNyrD/dqlsQFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-njfqCk-OP0ixNwcKJ9spsw-1; Wed, 13 Oct 2021 17:08:04 -0400
X-MC-Unique: njfqCk-OP0ixNwcKJ9spsw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3566802C87;
        Wed, 13 Oct 2021 21:08:02 +0000 (UTC)
Received: from llong.remote.csb (unknown [10.22.33.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AFA3694B5;
        Wed, 13 Oct 2021 21:08:02 +0000 (UTC)
Subject: Re: [PATCH V2 0/3] misc patches for mutex and rwsem
To:     Yanfei Xu <yanfei.xu@windriver.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20211013134154.1085649-1-yanfei.xu@windriver.com>
From:   Waiman Long <longman@redhat.com>
Message-ID: <9484e09b-4fba-2b8d-5922-75a830531b48@redhat.com>
Date:   Wed, 13 Oct 2021 17:08:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211013134154.1085649-1-yanfei.xu@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/13/21 9:41 AM, Yanfei Xu wrote:
> [patch1] locking:remove rcu_read_lock/unlock as we already disabled preemption
> v1->2: also remove the unnecessary rcu_read_lock/unlock in rwsem
>
> [patch2] locking/rwsem: disable preemption for spinning region
> [patch3] locking/rwsem: fix comments about reader optimistic lock stealing conditions
> These two patches were sent to mailing list some weeks ago, but it seemed
> to be missed, so send them again.
>
> Yanfei Xu (3):
>    locking: remove rcu_read_lock/unlock as we already disabled preemption
>    locking/rwsem: disable preemption for spinning region
>    locking/rwsem: fix comments about reader optimistic lock stealing
>      conditions
>
>   kernel/locking/mutex.c | 22 +++++++++++++++-------
>   kernel/locking/rwsem.c | 28 ++++++++++++++++++----------
>   2 files changed, 33 insertions(+), 17 deletions(-)
>
The patches look good to me. Thanks!

For the series,

Acked-by: Waiman Long <longman@redhat.com>

