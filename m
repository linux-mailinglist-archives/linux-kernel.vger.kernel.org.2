Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29938348123
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbhCXTCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237604AbhCXTBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:01:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D43C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:01:42 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so1666138pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=1OSWou9Gc43hegRQPIX63whqdsDHhalUq1mpnTcOh74=;
        b=b+1PD6kKO3vZSOUJV9itwdX4do/nvqZiZTUKui1QN0hK6hGkrMwwEqIi/7PhL+Mivi
         AqBoY+VpCPf0dbYlFC10kXm7Ffsfp2ENvHWbZrWoIjfACvKODgcOqNyTQx8MX9N2T8mn
         fP12mUSNaVe1YUbASX/szirrwHZ/Yhl4DQyKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=1OSWou9Gc43hegRQPIX63whqdsDHhalUq1mpnTcOh74=;
        b=bKy9YH5xLZfrISojOBIG1jZLmYxeoIrqVJcPlJvGCK2RdQagTmh5hhKqMtDkgNGXoa
         E4V4KO3hvvoSLPkanfjfuiAV1ZDWoNGzqfNZpN0BMqpIAjjsiIHPA0h+6khkQsHPjtgo
         k/QGk9r02SYYdvjAkW6juy2+Qc1vIUv7JchDzX8t1aVSM5IkW07HVEMiA4qBuU2E1yaE
         iTWD8r2eMRl0lFTeZBjFZAYzx4OSr/DE/vQ1pQZ/xpPrQDv5Ri1fANvPMMuneu9ybecl
         FobqujfEb0NsG0rMkwX60d0d+4RWiHLnp7vwKR2BvcEAFBwBO84KJFfr0aGo09AnFcRi
         CsLw==
X-Gm-Message-State: AOAM5324kacQOKZyZmSwVTopLEvnBUVxv2PH0gxob5vZOO9/za/TQwjO
        r3+NB26cJDEurW3HlMK7TCW6NA==
X-Google-Smtp-Source: ABdhPJwJtZIj0+vq7pulOjkr/B8y18b68nocg8Fc4dhRUBFWLRcaRWvhuGY/RXPZ0MfBqy7D1J5CqA==
X-Received: by 2002:a17:90a:8c08:: with SMTP id a8mr4969716pjo.136.1616612501764;
        Wed, 24 Mar 2021 12:01:41 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id 63sm3598801pfg.187.2021.03.24.12.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 12:01:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YFshElW7XI+ekhfy@smile.fi.intel.com>
References: <20210324020443.1815557-1-swboyd@chromium.org> <20210324020443.1815557-4-swboyd@chromium.org> <YFshElW7XI+ekhfy@smile.fi.intel.com>
Subject: Re: [PATCH v2 03/12] dump_stack: Add vmlinux build ID to stack traces
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthew Wilcox <willy@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Wed, 24 Mar 2021 12:01:39 -0700
Message-ID: <161661249929.3012082.15491956778039943919@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Shevchenko (2021-03-24 04:22:58)
> On Tue, Mar 23, 2021 at 07:04:34PM -0700, Stephen Boyd wrote:
> > Add the running kernel's build ID[1] to the stacktrace information
> > header.  This makes it simpler for developers to locate the vmlinux with
> > full debuginfo for a particular kernel stacktrace. Combined with
> > scripts/decode_stracktrace.sh, a developer can download the correct
> > vmlinux from a debuginfod[2] server and find the exact file and line
> > number for the functions plus offsets in a stacktrace.
> >=20
> > This is especially useful for pstore crash debugging where the kernel
> > crashes are recorded in the pstore logs and the recovery kernel is
> > different or the debuginfo doesn't exist on the device due to space
> > concerns (the data can be large and a security concern). The stacktrace
> > can be analyzed after the crash by using the build ID to find the
> > matching vmlinux and understand where in the function something went
> > wrong.
> >=20
> > Example stacktrace from lkdtm:
>=20
> Can we drop the noise from the example and leave only important part(s)?

Do you mean cut after the CPU line?

>=20
> >  WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNIN=
G+0x28/0x30 [lkdtm]
> >  Modules linked in: lkdtm rfcomm algif_hash algif_skcipher af_alg xt_cg=
roup uinput xt_MASQUERADE
> >  CPU: 4 PID: 3255 Comm: bash Not tainted 5.11 #3 aa23f7a1231c229de20566=
2d5a9e0d4c580f19a1
