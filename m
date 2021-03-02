Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F6832B70D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357010AbhCCKsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2361115AbhCBXZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 18:25:28 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AA8C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 15:24:48 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id e9so2961667pjs.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 15:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=cVH5d/wlkVioJQ8yaRjGio3SpYP+21NMWCupiYF1zx0=;
        b=ZZ9TYiWE+HaCf38K23Z0mjbPlwSC7Mpp2LTsWQfleMxBr4rObP317sK7ZdUNxOll0X
         FWLhYARPvJNfcrwwzUbFf3r12KOCKxrrOnA8zjRgEKEYKwcykyv8XfN56OCs9dCV2gif
         cw0yeZCsZBlQpAVqag7uBB+HSMW1CZ9OhFC9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=cVH5d/wlkVioJQ8yaRjGio3SpYP+21NMWCupiYF1zx0=;
        b=aC0evTxnOsOD0NFqTvEDZZL1xLCPAfoRXwIOtUx10DmxLFyz4V2qmObtiZrsvsjaAx
         E3DerxZKdzibdjzS4qRMhhyUOAAek1uMkcL1B0oQYOqijRIoCW9fQzx+15unO8xKejuB
         ostVlPNO1G/8OTFnST7Mm5i2/bXjkWroFQ+9zU+wM2zL+Bf6RruhIWirlUQevA6yZ8wU
         kq65meXmrizXcUKS8cY0lnPd9kYRzRgMP8avViVLfQ+WJBBCvJpOVw4EAqXtrfUw+a5R
         L8fbpCk9F/LLaoVZvK2n21LascZEY7vyBoNqVjFskLRfwTYVXZcVXovu5LJ8rLgIHgdU
         SSKw==
X-Gm-Message-State: AOAM533quyB4Pv25w4UMqtc4jBup4fzdR1yD6ITdB7TbvkJ7plrP+/ZT
        eL9c2v91LRZfiu6iIn2v2gX/Qg==
X-Google-Smtp-Source: ABdhPJx2JFIPDEGodpwstGmoV3rikG48R+IdlndamcWqTTLhtHjYOUQS/fBVQdkv6MgRQBu+0swIng==
X-Received: by 2002:a17:90a:6587:: with SMTP id k7mr6812294pjj.34.1614727488133;
        Tue, 02 Mar 2021 15:24:48 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:2510:ab07:78a:7d78])
        by smtp.gmail.com with ESMTPSA id cv3sm4694590pjb.9.2021.03.02.15.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 15:24:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210301214319.7e54c66f@oasis.local.home>
References: <20210301174749.1269154-1-swboyd@chromium.org> <20210301174749.1269154-6-swboyd@chromium.org> <20210301214319.7e54c66f@oasis.local.home>
Subject: Re: [PATCH 5/7] printk: Make %pS and friends print module build ID
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org
To:     Steven Rostedt <rostedt@goodmis.org>
Date:   Tue, 02 Mar 2021 15:24:46 -0800
Message-ID: <161472748610.1478170.16522080242572382702@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Steven Rostedt (2021-03-01 18:43:19)
> On Mon,  1 Mar 2021 09:47:47 -0800
> Stephen Boyd <swboyd@chromium.org> wrote:
>=20
> > The %pS printk format (among some others) is used to print kernel
> > addresses symbolically. When the kernel prints an address inside of a
> > module, the kernel prints the addresses' symbol name along with the
> > module's name that contains the address. Let's make kernel stacktraces
> > easier to identify on KALLSYMS builds by including the build ID of a
> > module when we print the address.
>=20
> Please no!
>=20
> This kills the output of tracing with offset, and can possibly break
> scripts. I don't want to look at traces like this!
>=20
>           <idle>-0       [004] ..s1   353.842577: ipv4_conntrack_in+0x0/0=
x10 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051) <-nf_hook_slo=
w+0x40/0xb0
>           <idle>-0       [004] ..s1   353.842577: nf_conntrack_in+0x0/0x5=
c0 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051) <-nf_hook_slow=
+0x40/0xb0
>           <idle>-0       [004] ..s1   353.842577: get_l4proto+0x0/0x190 [=
nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051) <-nf_conntrack_in+=
0x92/0x5c0 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051)
>           <idle>-0       [004] ..s1   353.842577: nf_ct_get_tuple+0x0/0x2=
40 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051) <-nf_conntrack=
_in+0xec/0x5c0 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051)
>           <idle>-0       [004] ..s1   353.842577: hash_conntrack_raw+0x0/=
0x170 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051) <-nf_conntr=
ack_in+0x28c/0x5c0 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051)
>           <idle>-0       [004] ..s1   353.842578: __nf_conntrack_find_get=
.isra.0+0x0/0x2f0 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051)=
 <-nf_conntrack_in+0x29d/0x5c0 [nf_conntrack] (3b39eb771b2566331887f671c741=
f90bfba0b051)
>           <idle>-0       [004] ..s1   353.842578: nf_conntrack_tcp_packet=
+0x0/0x1760 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051) <-nf_=
conntrack_in+0x3c8/0x5c0 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfb=
a0b051)
>           <idle>-0       [004] ..s2   353.842578: nf_ct_seq_offset+0x0/0x=
40 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051) <-nf_conntrack=
_tcp_packet+0x26d/0x1760 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfb=
a0b051)
>           <idle>-0       [004] ..s1   353.842578: __nf_ct_refresh_acct+0x=
0/0x50 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051) <-nf_connt=
rack_tcp_packet+0x558/0x1760 [nf_conntrack] (3b39eb771b2566331887f671c741f9=
0bfba0b051)
>=20
>  NACK!
>=20

Heh, OK. Would adding a new printk format work then? From after the cut:

> Yet another alternative is to add a printk format like %pSB for
> backtrace prints. This would require a handful of architecture updates
> and I'm not sure it's worth the effort for that.
>

Or maybe take the approach of putting all the linked in module build IDs
in the "Modules linked in:" section? But as I said in the commit text
that can become quite verbose. Looking forward to your suggestions here.
