Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8523F3601E6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhDOFtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:49:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230137AbhDOFtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618465739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xyq65rfreFKEB9lfkpxvSvcjxg72gnBk5bLq+vVlV/M=;
        b=GfNLao9mAPKHe1FnEj8NApMzyR0mAZSwMyX4tUOverLONK9jpZAacWMqgtXQ25QjuJi1vF
        i/POLJkomLaABnUUDLSs9YnREYt659sZdJbfaw9whpmpyPpoQbxO4smiU+u499E5BdWPyU
        VAhCKTMZj3DTSVviKAzyMimcl9ioe0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-nPh4RAZYMqKYedW9X-Keyg-1; Thu, 15 Apr 2021 01:48:55 -0400
X-MC-Unique: nPh4RAZYMqKYedW9X-Keyg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E99FD801814;
        Thu, 15 Apr 2021 05:48:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.91])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3292A6087C;
        Thu, 15 Apr 2021 05:48:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 15 Apr 2021 07:48:53 +0200 (CEST)
Date:   Thu, 15 Apr 2021 07:48:51 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ptrace: is_syscall_success: Add syscall return code
 handling for compat task
Message-ID: <20210415054846.GA25776@redhat.com>
References: <20210414080245.25476-1-zhe.he@windriver.com>
 <20210414150810.GA19371@redhat.com>
 <e2efffb879914176a2eae8b52a3c5c33@AcuMS.aculab.com>
 <20210414165547.GA22294@redhat.com>
 <8288f70d-4c3e-9b51-0794-369ca73579d8@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8288f70d-4c3e-9b51-0794-369ca73579d8@windriver.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15, He Zhe wrote:
>
>
> On 4/15/21 12:55 AM, Oleg Nesterov wrote:
> > I think in_compat_syscall() should be used instead.
> >
> > But this doesn't matter, I still can't understand the problem.
>
> Sorry for not enough clarification.
>
> This was found on an arm64 kernel running with 32-bit user-space application.

OK, but then I think you should add the arm64 version of is_syscall_success()
into arch/arm4/include/asm/ptrace.h and do not touch the generic version ?

Something like arch/arm64/include/asm/syscall.h:syscall_get_error() which uses
is_compat_thread(). Perhaps you can even do

	#define is_syscall_success(regs)	\
		(syscall_get_error(current, regs) == 0)

Oleg.

