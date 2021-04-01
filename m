Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F62D3513FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbhDAKzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:55:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234062AbhDAKyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617274420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AeIuul5ZcJWK6eSi1peQ3Q3v2fRek8mT72TwlcJLzZg=;
        b=Lzcd2AeKwcPSJj8NaoIQD3UMXlomRjbiGtw/iQEt5iVFfvqk3d6znMcdOLJCIAQyYdTV+U
        +c/gbTLzGu53XCPMSvKKf/9jMvJKeVJYtQMI2PUDu/+7+LbpmWq5co6TVfsEfHIAxgnVDT
        lsb/L9V4IHjGEUtg7IBF12z41eEaUhE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-JYIJMMwvPASGaTacegJYRw-1; Thu, 01 Apr 2021 06:53:38 -0400
X-MC-Unique: JYIJMMwvPASGaTacegJYRw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13AE483DD34;
        Thu,  1 Apr 2021 10:53:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9297117B15;
        Thu,  1 Apr 2021 10:53:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  1 Apr 2021 12:53:36 +0200 (CEST)
Date:   Thu, 1 Apr 2021 12:53:26 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+b804f902bbb6bcf290cb@syzkaller.appspotmail.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] possible deadlock in register_for_each_vma
Message-ID: <20210401105305.GA18680@redhat.com>
References: <00000000000030aca605be6e0102@google.com>
 <20210327042150.7460-1-hdanton@sina.com>
 <20210328025217.7312-1-hdanton@sina.com>
 <20210401092907.1098-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401092907.1098-1-hdanton@sina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01, Hillf Danton wrote:
>
> If I dont misread it,  the lockdep chain will likely evolve from
>
>    event_mutex -> uprobe.register_rwsem -> dup_mmap_sem -> mm.mmap_lock ->
>    event_mutex
> to
>    dup_mmap_sem -> mm.mmap_lock -> dup_mmap_sem
>
> after this patch as both uprobe_register() and uprobe_unregister() would take
> dup_mmap_sem.

Hmm, please correct me, but I don't think so. I think mmap_lock -> dup_mmap_sem
is not possible.

Oleg.

