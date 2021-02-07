Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9598C3127F6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 23:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhBGWrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 17:47:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229564AbhBGWrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 17:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612737948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sbR2pEZXk4sZagvbCH5bkb/zHfvRMOjXS1EeVl71tZQ=;
        b=Z2o22EyqO52LhPemYDjp9Vj+A2vIqjCb8JJYfZn+g3rzMHjNUshzfvKGCz+/YmgaEVVUPo
        uQz4YrH86dRiYxBn2hCspDmIezgSk7m139jNaBmjAZq3p/cdZc9quxJMCeZtOP2UFxy8Qv
        VWqs3m2Q7tmUaHCxpCb7dPi0oWfziEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-zTIFVMTcOCayukN4xCbqVQ-1; Sun, 07 Feb 2021 17:45:46 -0500
X-MC-Unique: zTIFVMTcOCayukN4xCbqVQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54AFA107ACE4;
        Sun,  7 Feb 2021 22:45:44 +0000 (UTC)
Received: from treble (ovpn-113-27.rdu2.redhat.com [10.10.113.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF8DD1010F53;
        Sun,  7 Feb 2021 22:45:42 +0000 (UTC)
Date:   Sun, 7 Feb 2021 16:45:40 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@suse.de>, Dave Hansen <dave.hansen@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [GIT PULL] x86/urgent for v5.11-rc7
Message-ID: <20210207224540.ercf5657pftibyaw@treble>
References: <20210207104022.GA32127@zn.tnic>
 <CAHk-=widXSyJ8W3vRrqO-zNP12A+odxg2J2_-oOUskz33wtfqA@mail.gmail.com>
 <20210207175814.GF32127@zn.tnic>
 <CAHk-=wi5z9S7x94SKYNj6qSHBqz+OD76GW=MDzo-KN2Fzm-V4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi5z9S7x94SKYNj6qSHBqz+OD76GW=MDzo-KN2Fzm-V4Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 10:15:49AM -0800, Linus Torvalds wrote:
> On Sun, Feb 7, 2021 at 9:58 AM Borislav Petkov <bp@suse.de> wrote:
> >
> > It probably is an item on some Intel manager's to-enable list. So far,
> > the CET enablement concentrates only on userspace but dhansen might know
> > more about future plans. CCed.
> 
> I think the new Ryzen 5000 series also supports CET, but I don't have
> any machines to check.
> 
> Hopefully somebody ends up with hardware that supports it and a urge
> to try to make it work in kernel land too.
> 
> I do suspect involved people should start thinking about how they want
> to deal with functions starting with
> 
>         endbr64
>         call __fentry__
> 
> instead of the call being at the very top of the function.

FWIW, objtool's already fine with it (otherwise we would have discovered
the need to disable fcf-protection much sooner).

-- 
Josh

