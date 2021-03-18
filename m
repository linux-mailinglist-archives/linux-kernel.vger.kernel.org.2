Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B39A33FC4C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 01:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCRAjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 20:39:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24200 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230001AbhCRAir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 20:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616027927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GECCpMvIhgcBgbgr8Z4aI3SN098wZYPTAAQdQQy5b2M=;
        b=gUVSGMup/HdP6YBCSMAzchzEnkgvcuiGVLLf65EF9UJZmo5oThKn32tujZuIRor44RsSNT
        m85L+5fPQHo0JQLVUMiwL8KeslRD4xAdgr501xiM0mDkxcNtRCTYGMQky2i7pgUbrqr69L
        A+KPgZ3HGXG75V5R4eQzWm6pfCVsF88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-QYVdhUsqOiO6eyMY8RihLw-1; Wed, 17 Mar 2021 20:38:45 -0400
X-MC-Unique: QYVdhUsqOiO6eyMY8RihLw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFEFD1013721;
        Thu, 18 Mar 2021 00:38:43 +0000 (UTC)
Received: from treble (ovpn-112-220.rdu2.redhat.com [10.10.112.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 58DA360C13;
        Thu, 18 Mar 2021 00:38:42 +0000 (UTC)
Date:   Wed, 17 Mar 2021 19:38:39 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v4 3/9] x86/entry: Convert ret_from_fork to C
Message-ID: <20210318003839.ag3hetynstt6n2l4@treble>
References: <cover.1616004689.git.luto@kernel.org>
 <f7ed7fa5b222afa2d2820e1d8c83fdc3fdd57af2.1616004689.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f7ed7fa5b222afa2d2820e1d8c83fdc3fdd57af2.1616004689.git.luto@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 11:12:42AM -0700, Andy Lutomirski wrote:
> ret_from_fork is written in asm, slightly differently, for x86_32 and
> x86_64.  Convert it to C.
> 
> This is a straight conversion without any particular cleverness.  As a
> further cleanup, the code that sets up the ret_from_fork argument registers
> could be adjusted to put the arguments in the correct registers.
> 
> This will cause the ORC unwinder to find pt_regs even for kernel threads on
> x86_64.  This seems harmless.
> 
> The 32-bit comment above the now-deleted schedule_tail_wrapper was
> obsolete: the encode_frame_pointer mechanism (see copy_thread()) solves the
> same problem more cleanly.
> 
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

