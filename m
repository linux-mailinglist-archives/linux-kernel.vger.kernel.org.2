Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA49532ADEC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360167AbhCBWRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350882AbhCBUhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 15:37:03 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678D6C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 12:35:56 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id t25so14674515pga.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 12:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=GR6yU28G1HKJ78lZizrMN9qHFzFhN+MzfySba7gxHDc=;
        b=KjMq/5eyUeHC39bU9w5fCqWOSy27ohsBa0o2Xm+JAp0ntLNRsY/v1pF+6wnNRv/wa5
         znlDzA5bOIx9ZBiSqdKPLw5MF+4hTn2FUrzxqDyLGz9w4BjfT4MYy7ZzdnRhSyYSsw2a
         MBZV2de8IqdIs5tUoc9J3g14ieDHHV7ZSRKjkFubqmOtg3TtjkTHS7DYNgYXULK4w2p/
         Ab3sYVahoQAySAbdIDkQi22bmLh1vQGJSIlL9lx1sGEU1NFR1oxnkp5wv/5GdmUfELZ2
         OzsfLq73HGkaFcHvkpRLiilPfRIztSl+YyNbSwrw+8zGGb1waTFoYA9AcziZWzNLZmkB
         Ur4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=GR6yU28G1HKJ78lZizrMN9qHFzFhN+MzfySba7gxHDc=;
        b=bZlvuBT1VUnzK9xJw3CVOxWo3TdiPGJ2YW9QEGfCf8arhnl7ei1j3iVV/B7UjDKl0Q
         5V6hDLJUqWMcZ741O6TKRrfyK8xGsaWedWOajRNwjMHIuB32Rfhao+EDAoJeZqcKqKQP
         esFS59HgxpFghGOO8kOdtGmtdBlxwkO78bGW9mGxvohaaFqQNgeU65rkoR0h7KZTWkQ4
         AxICdgDoNxDvu8HnwVgC/TIcOKTML+e3Zl5/FzbvjhLdBkwCnzRTpCu1Y2f7J0NDCK+D
         k+tYWvHFuYS7YZdXEnLQ4EgW4Bq09hV+VsHdV5YTfBktsUMycTOrEpZV2XlZYnRtGEC4
         zkrw==
X-Gm-Message-State: AOAM533ZtdI+RnYAZz1RCwf4K3dQBPcB94779zx91dW+nxVDI11Oedb/
        6C+fE3uQExukNtSY7Id17yplzg==
X-Google-Smtp-Source: ABdhPJxwxNv+nFrnp4UUkzY7jjAO194jemxbtSKFVs8rvJ7JnYL17y+JbRF8NhfDbC0kEhjptP0nWg==
X-Received: by 2002:aa7:8c49:0:b029:1ed:c1dc:4421 with SMTP id e9-20020aa78c490000b02901edc1dc4421mr4920533pfd.43.1614717355885;
        Tue, 02 Mar 2021 12:35:55 -0800 (PST)
Received: from ?IPv6:2600:1010:b02b:fd90:e1d3:88b3:9a99:4873? ([2600:1010:b02b:fd90:e1d3:88b3:9a99:4873])
        by smtp.gmail.com with ESMTPSA id j20sm4386803pjn.27.2021.03.02.12.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 12:35:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: Why do kprobes and uprobes singlestep?
Date:   Tue, 2 Mar 2021 12:35:54 -0800
Message-Id: <F8EFE97F-B738-4CDF-A7E0-B1F73152CD7F@amacapital.net>
References: <20210302202508.GA21871@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <20210302202508.GA21871@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 2, 2021, at 12:25 PM, Oleg Nesterov <oleg@redhat.com> wrote:
>=20
> =EF=BB=BFOn 03/01, Andy Lutomirski wrote:
>>=20
>>> On Mon, Mar 1, 2021 at 8:51 AM Oleg Nesterov <oleg@redhat.com> wrote:
>>>=20
>>> But I guess this has nothing to do with uprobes, they do not single-step=

>>> in kernel mode, right?
>>=20
>> They single-step user code, though, and the code that makes this work
>> is quite ugly.  Single-stepping on x86 is a mess.
>=20
> But this doesn't really differ from, say, gdb doing si ? OK, except uprobe=
s
> have to hook DIE_DEBUG. Nevermind...

Also, gdb doing so isn=E2=80=99t great either.  Single stepping over a pushf=
 instruction, signal delivery, or a syscall on x86 is a mess.

>=20
>>>> Uprobes seem to single-step user code for no discernable reason.
>>>> (They want to trap after executing an out of line instruction, AFAICT.
>>>> Surely INT3 or even CALL after the out-of-line insn would work as well
>>>> or better.)
>>>=20
>>> Uprobes use single-step from the very beginning, probably because this
>>> is the most simple and "standard" way to implement xol.
>>>=20
>>> And please note that CALL/JMP/etc emulation was added much later to fix t=
he
>>> problems with non-canonical addresses, and this emulation it still incom=
plete.
>>=20
>> Is there something like a uprobe test suite?
>=20
> Afaik, no.
>=20
>> How maintained /
>=20
> Add Srikar who sent the initial implementation. I can only say that I am g=
lad that
> ./scripts/get_maintainer.pl no longer mentions me ;) I did some changes (i=
ncluding
> emulation) but a) this was a long ago and b) only because I was forced^W a=
sked to
> fix the numerous bugs in this code.
>=20
>> actively used is uprobe?
>=20
> I have no idea, sorry ;)
>=20
> Oleg.
>=20
