Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BB531A877
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 00:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhBLXxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 18:53:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20799 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229980AbhBLXxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 18:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613173910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d9EOww0gRZcoT59lB4jZaAA8xsmsbTWpvHMYDAlGJbY=;
        b=CSpja1jh/tfqbvJqPGdCKEUCs7TdPj7cxu1f8ILYV4oRjA20AlPqsxFTlPXODD4z6R1+m+
        NU0iMm9q9/fyxEI1t4cOecBV9K+F9OywuR40KCtFQzAmt52rUvUopKjm6LudAmMkwNSE8u
        wIQ9jeoOC1ifx1hzxWmMELtWdZqmOgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-fGk8qRpMOp22Bc9XePYfXw-1; Fri, 12 Feb 2021 18:51:48 -0500
X-MC-Unique: fGk8qRpMOp22Bc9XePYfXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E1F5192CC41;
        Fri, 12 Feb 2021 23:51:47 +0000 (UTC)
Received: from treble (ovpn-120-169.rdu2.redhat.com [10.10.120.169])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B54FC5C23D;
        Fri, 12 Feb 2021 23:51:46 +0000 (UTC)
Date:   Fri, 12 Feb 2021 17:51:45 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ken Moffat <zarniwhoop73@googlemail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: objtool segfault in 5.10 kernels with binutils-2.36.1
Message-ID: <20210212235145.t4jgnkyiztrbqlnp@treble>
References: <CANVEwpb2oyYFbXkCaeuhnr0s1LH8ojf_WDoStcLYoB1eXWhgRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANVEwpb2oyYFbXkCaeuhnr0s1LH8ojf_WDoStcLYoB1eXWhgRw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 05:16:56PM +0000, Ken Moffat wrote:
> Hi,
> 
> in 5.10 kernels up to and including 5.10.15 when trying to build the
> kernel for an x86_64 skylake using binutils-2.36.1, gcc-10.2 and
> glibic-2.33 I get a segfault in objtool if the orc unwinder is
> enabled.
> 
> This has already been fixed in 5.11 by ''objtool: Fix seg fault with
> Clang non-section symbols'
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/?id=44f6a7c0755d8dd453c70557e11687bb080a6f21
> 
> So can this be added to 5.10 stable, please ?
> 
> Please CC me as I am no-longer subscribed.

Hi Ken,

I agree that needs to be backported (and my bad for not marking it as
stable to begin with).

Greg, this also came up in another thread, are you pulling that one in,
or do you want me to send it to stable list?

-- 
Josh

