Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9673421D8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhCSQ1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:27:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230041AbhCSQ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616171219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p64iFkslqxnuTZmrG9ex1+VZNpSbfarQfW4/L2fWYZs=;
        b=haPe1CEcLMmHwUmDSJjpblPb6gu/+hI0/lz36/4+2HbmBTfS8k74fHgVHhp1cwDxVcYDOP
        MdnNbjR/0tCYC+kYEMByT+Xwuq6ADZa5smU8rDX28Lwghfbu6a76xx1/VFwhFUEnLwik2G
        E4RSt2/PSlia6ZB1eF/+mQEt+wW/XSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-Tld3CbwTPDKbtt1KjT2dPg-1; Fri, 19 Mar 2021 12:26:56 -0400
X-MC-Unique: Tld3CbwTPDKbtt1KjT2dPg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5E4F107ACCA;
        Fri, 19 Mar 2021 16:26:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.172])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7A15460BF1;
        Fri, 19 Mar 2021 16:26:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 19 Mar 2021 17:26:53 +0100 (CET)
Date:   Fri, 19 Mar 2021 17:26:50 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     qianli zhao <zhaoqianligood@gmail.com>, christian@brauner.io,
        axboe@kernel.dk, Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>
Subject: Re: [PATCH V3] exit: trigger panic when global init has exited
Message-ID: <20210319162649.GA19971@redhat.com>
References: <1615985460-112867-1-git-send-email-zhaoqianligood@gmail.com>
 <20210317143805.GA5610@redhat.com>
 <CAPx_LQG=tj+kM14wS79tLPJbVjC+79OFDgfv6zai_sJ74CGeug@mail.gmail.com>
 <20210318180450.GA9977@redhat.com>
 <m1pmzwb7pd.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1pmzwb7pd.fsf@fess.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/18, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > On 03/18, qianli zhao wrote:
> >>
> >> In addition, the patch also protects the init process state to
> >> successfully get usable init coredump.
> >
> > Could you spell please?
> >
> > Does this connect to SIGNAL_GROUP_EXIT check? Do you mean that you want
> > to panic earlier, before other init's sub-threads exit?
>
> That is my understanding.
>
> As I understand it this patch has two purposes:
> 1. Avoid the BUG_ON in zap_pid_ns_processes when !CONFIG_PID_NS
> 2. panic as early as possible so exiting threads don't removing
>    interesting debugging state.

Yes, this was my understanding too, but the changelog didn't look
clear to me.

And I'd say that it is not that we want to avoid BUG_ON() in
zap_pid_ns_processes() when !CONFIG_PID_NS, we want to avoid
zap_pid_ns_processes() in the root namespace, regardless of
CONFIG_PID_NS.

> It is a bit tricky to tell if the movement of the decrement of
> signal->live is safe.

Agreed, this was my concern. I see nothing wrong at first glance,
but I can easily miss something.

Oleg.

