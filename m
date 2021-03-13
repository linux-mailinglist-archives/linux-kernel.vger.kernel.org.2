Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A484E339F79
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 18:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbhCMRZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 12:25:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39964 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233635AbhCMRZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 12:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615656343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZHzgzyz05IVQ249p/UoEccGI5UagydHjlQL2rKeWqxI=;
        b=OarQdu0kH7p0/0zAvXDF/KlriBgEbiC3mYnGtPfnsXKY+1ePTG+GH6wmenAVjsGgmFG2XF
        n3eB47BFfMxJnOkj0ZFwpZVIZhJzj1cbZStwrmWKUx3tYQyRZfVviM75/6MagO2MqTvakb
        R8YYa3eDPfReUTgyVi00QvKOsIfTu14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-yGXm4AQ-PwuZEQHpn2PvTg-1; Sat, 13 Mar 2021 12:25:39 -0500
X-MC-Unique: yGXm4AQ-PwuZEQHpn2PvTg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E647A100B3AB;
        Sat, 13 Mar 2021 17:25:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.35])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5D7DF5D9C0;
        Sat, 13 Mar 2021 17:25:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat, 13 Mar 2021 18:25:37 +0100 (CET)
Date:   Sat, 13 Mar 2021 18:25:35 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jim Newsome <jnewsome@torproject.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
Message-ID: <20210313172534.GA3588@redhat.com>
References: <20210312173855.24843-1-jnewsome@torproject.org>
 <m1k0qcglol.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1k0qcglol.fsf@fess.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12, Eric W. Biederman wrote:
>
> I am going to kibitz just a little bit more.
>
> When I looked at this a second time it became apparent that using
> pid_task twice should actually be faster as it removes a dependent load
> caused by thread_group_leader, and replaces it by accessing two adjacent
> pointers in the same cache line.

Heh, I think this code should be optimized for the reader in the first place ;)

But as I said I won't argue, readability is very subjective, I am fine with your
version too.

Oleg.

