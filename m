Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A6735F94F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhDNQ4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27737 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233980AbhDNQ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618419361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0XekfZf+wewTDqvutKV+4wFsWL6CSPJUUNNw63RFcjk=;
        b=fasna2/RbXSUU3s3J0U12h1YUpwpVTEv0/TDM6I0BKSdH9zG6Zj9HOr1TknExiubVMlAnn
        ZRoZGDZBvzg3j/eaPvund+5A4pa579K4me1FVs2pMw0opVxFW0mngepL+vCmYp46L3YNj7
        y/V42Jy4T7QTae4mtP90yG3QVyNtelY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-0TGPAZATPW-ACxAz1fKdHg-1; Wed, 14 Apr 2021 12:55:58 -0400
X-MC-Unique: 0TGPAZATPW-ACxAz1fKdHg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78F6E8189DE;
        Wed, 14 Apr 2021 16:55:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.65])
        by smtp.corp.redhat.com (Postfix) with SMTP id E773B60877;
        Wed, 14 Apr 2021 16:55:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 14 Apr 2021 18:55:50 +0200 (CEST)
Date:   Wed, 14 Apr 2021 18:55:47 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     He Zhe <zhe.he@windriver.com>, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ptrace: is_syscall_success: Add syscall return code
 handling for compat task
Message-ID: <20210414165547.GA22294@redhat.com>
References: <20210414080245.25476-1-zhe.he@windriver.com>
 <20210414150810.GA19371@redhat.com>
 <e2efffb879914176a2eae8b52a3c5c33@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2efffb879914176a2eae8b52a3c5c33@AcuMS.aculab.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14, David Laight wrote:
>
> From: Oleg Nesterov
> > Sent: 14 April 2021 16:08
> >
> > Add audit maintainers...
> >
> > On 04/14, He Zhe wrote:
> > >
> > > When 32-bit userspace application is running on 64-bit kernel, the 32-bit
> > > syscall return code would be changed from u32 to u64 in regs_return_value
> > > and then changed to s64. Hence the negative return code would be treated
> > > as a positive number and results in a non-error in, for example, audit
> > > like below.
> >
> > Sorry, can understand. At least on x86_64 even the 32-bit syscall returns
> > long, not u32.
> >
> > Hmm. And afaics on x86 is_compat_task() is only defined if !CONFIG_COMPAT,
> > so this patch looks wrong anyway.
>
> And, as with the other patch a x64_64 64bit process can make both types
> of 32bit system call - so it needs to depend on the system call entry type
> not any type of the task.

I don't understand... but iirc is_compat_task() used to check TS_COMPAT and
this is what we need to detect the 32-bit syscall. But it looks deprecated,
I think in_compat_syscall() should be used instead.

But this doesn't matter, I still can't understand the problem.

Oleg.

