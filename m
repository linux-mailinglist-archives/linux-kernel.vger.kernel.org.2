Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC1837239C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 01:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhECXbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 19:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229825AbhECXbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 19:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620084615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ng33wdCfY0f94Lc0C6VzGYpVIEeCw/ndrKGBDgh+tmI=;
        b=g5bKkN2P0HlN8Jd95CgIukDjICnqZklTPKeO9lkG6cPDZLJbDbDDC9RsMCrZmbjQ5Mz8vK
        Z7kLUky7ZRI/FG4NQeIZ0hTb0SMOVRuKJitMWppWRKJqvJAW8tcu8iuBj5L/cvZLewmXxZ
        sknVJc7KdshwXg86S4xnYEwwJPIhGqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-dHd5MvnbNJOSDI-d5XX5yw-1; Mon, 03 May 2021 19:30:13 -0400
X-MC-Unique: dHd5MvnbNJOSDI-d5XX5yw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFE20107ACC7;
        Mon,  3 May 2021 23:30:11 +0000 (UTC)
Received: from treble (ovpn-115-93.rdu2.redhat.com [10.10.115.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DECC8102AE7E;
        Mon,  3 May 2021 23:30:10 +0000 (UTC)
Date:   Mon, 3 May 2021 18:30:10 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Kaplan <David.Kaplan@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Subject: Re: Do we need to do anything about "dead =?utf-8?B?wrVvcHM/Ig==?=
Message-ID: <20210503233010.x5lzpw4dq3gueg47@treble>
References: <CALCETrXRvhqw0fibE6qom3sDJ+nOa_aEJQeuAjPofh=8h1Cujg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrXRvhqw0fibE6qom3sDJ+nOa_aEJQeuAjPofh=8h1Cujg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2021 at 09:26:33AM -0700, Andy Lutomirski wrote:
> Hi all-
> 
> The "I See Dead µops" paper that is all over the Internet right now is
> interesting, and I think we should discuss the extent to which we
> should do anything about it.  I think there are two separate issues:
> 
> First, should we (try to) flush the µop cache across privilege
> boundaries?  I suspect we could find ways to do this, but I don't
> really see the point.  A sufficiently capable attacker (i.e. one who
> can execute their own code in the dangerous speculative window or one
> who can find a capable enough string of gadgets) can put secrets into
> the TLB, various cache levels, etc.  The µop cache is a nice piece of
> analysis, but I don't think it's qualitatively different from anything
> else that we don't flush.  Am I wrong?

Wouldn't this type of gadget (half-v1 gadget + value-dependent-branch)
would be much more likely to occur than a traditional Spectre v1
(half-v1 gadget + value-addressed-load)?

Also, in section V.A., they identified 37 gadgets.  Has anybody looked
at those yet?

(And this makes me realize my uaccess pointer masking patch [1] never
got merged...)

[1] https://lore.kernel.org/lkml/1d06ed6485b66b9f674900368b63d7ef79f666ca.1599756789.git.jpoimboe@redhat.com/

-- 
Josh

