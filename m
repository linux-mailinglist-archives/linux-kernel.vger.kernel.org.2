Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13D933B231
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhCOMIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24808 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230443AbhCOMIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615810090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s+Nngxw33SqYPyz6Zv5oaaQuR0M1LDfJZXkXOYx+XJE=;
        b=FkblyqXqxsrXWz1D+n0vI8i9jz2qt6/ptf94DbPGvO253UXkIeOhItuy818/WhVtF0Q1Zt
        nkZyjf2tDDliQcSbAhwaYAlsejp3a9gRi0Q0mPap9B7V4p1HWEZf9GD82bULbrWmx1Ere4
        mWSaVktccEzQOvPrEbNzJ2fk3xEJELU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-YfkgaUQHPL2QwyjJoYzVEg-1; Mon, 15 Mar 2021 08:08:08 -0400
X-MC-Unique: YfkgaUQHPL2QwyjJoYzVEg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C243800C78;
        Mon, 15 Mar 2021 12:08:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.107])
        by smtp.corp.redhat.com (Postfix) with SMTP id 49DCD5C8AA;
        Mon, 15 Mar 2021 12:08:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 15 Mar 2021 13:08:06 +0100 (CET)
Date:   Mon, 15 Mar 2021 13:08:03 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        gorcunov@openvz.org, security@kernel.org
Subject: Re: [PATCH] prctl: fix PR_SET_MM_AUXV kernel stack leak
Message-ID: <20210315120803.GA13620@redhat.com>
References: <YE53QiJuxsCUeoiu@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE53QiJuxsCUeoiu@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/14, Alexey Dobriyan wrote:
>
> 	prctl(PR_SET_MM, PR_SET_MM_AUXV, addr, 1);
>
> will copy 1 byte from userspace to (quite big) on-stack array
> and then stash everything to mm->saved_auxv.

I too don't understand, memcpy(mm->saved_auxv, user_auxv, len) will
copy 1 byte...

And why task_lock(current) ? What does it try to protect?

Oleg.

