Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4437D35E77D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 22:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348161AbhDMURB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 16:17:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhDMURA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:17:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F316161242
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 20:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618345000;
        bh=018/wT7YNp41Opa/wOlmQasGzutY4YJko3lMFOUYFkU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uFTx73jL2VN8tGeX/xS4VRQQEnRCaJMsw+8u4HZa2mlUUgFPXWNvef27/irWxa38o
         oXuYsjbNHVxp/mdgNSFtZbmRRlsVUms/ULYQsQIwyRNDVloi5PGrQEeOEyp04wVxdM
         yw5ZyTNQlZCPppcmp1f+5QI40eAq3mydIZZLIpsmo/4S9nB9dvkn3yANO54pmA81n+
         itSuME8eZYjKe2dRFcAQChPsuWRUyK60CCxB7iQF7PrtudQ9rM20m6FNjpDBxnHiNX
         etlD+IcrURJKi2o7VUaEN0Xm+wUdCQ2wA6ke1athykkb2kgWJh7gj/ZDcp1Hk9Zg0O
         DhVUAMpsqp8Wg==
Received: by mail-ed1-f54.google.com with SMTP id 18so20925459edx.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 13:16:39 -0700 (PDT)
X-Gm-Message-State: AOAM530Py8j/kzdMTHLgBkE1sZcCcVXhGRvfuVBXVttJ5LD/ojmvXVkY
        c2qoeS/k/6QNXYWQGGpuON3/2XJQzaCL3BNz2F0boQ==
X-Google-Smtp-Source: ABdhPJz7z2X87zi2gHmfkAhv+g3fXHvwguoTjKVadVygUMK05U6oCXWxRpoCYKJtJ7EbRn8B3ifu6UmLIDXROcSXykE=
X-Received: by 2002:a05:6402:30ae:: with SMTP id df14mr36407363edb.97.1618344998640;
 Tue, 13 Apr 2021 13:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com> <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
 <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
In-Reply-To: <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 13 Apr 2021 13:16:27 -0700
X-Gmail-Original-Message-ID: <CALCETrVvapzL79BQNEvOupMHHzriR+n97955tRA+TPE6rgRC4Q@mail.gmail.com>
Message-ID: <CALCETrVvapzL79BQNEvOupMHHzriR+n97955tRA+TPE6rgRC4Q@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Len Brown <lenb@kernel.org>, Willy Tarreau <w@1wt.eu>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 4:46 PM Len Brown <lenb@kernel.org> wrote:
>
> On Mon, Apr 12, 2021 at 11:21 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> > AMX: Multiplying a 4x4 matrix probably looks *great* in a
> > microbenchmark.  Do it once and you permanently allocate 8kB (is that
> > even a constant?  can it grow in newer parts?), potentially hurts all
> > future context switches, and does who-knows-what to Turbo licenses and
> > such.
>
> Intel expects that AMX will be extremely valuable to key workloads.
> It is true that you may never run that kind of workload on the machine
> in front of you,
> and so you have every right to be doubtful about the value of AMX.

I fully believe that AMX will be amazing when used for the right
workload.  The problem is that a library may have no way to tell
whether a workload is the type of computationally intensive workload
for which it makes sense.  Imagine you have a little function:

int matrix_times_vector(int dim, float *out, const float *matrix,
const float *vector);

A clever library might use AMX for this.  If dim == 4 and the caller
is planning to call it in a long, tight loop, maybe this even makes
sense.  If dim == 4 and it's being called once, AMX is probably a
losing proposition.  With previous technologies, at least the impact
was limited to the function itself and maybe once per call to the
caller.  But now, with AMX, the program that invoked this takes a
performance and memory hit *forever* if it uses AMX once.

Beyond that, we have the signal handling issue.  One solution, going
off of what WIlly mentioned, is:

bool amx_begin(void *signal_save_buffer);
void amx_end();

In the amx_begin() region, if you get a signal, the AMX state is saved
in the buffer.  Outside the region, if you get a signal and AMX is in
use, the kernel will either unceremoniously kill the task or will
deliver SIGYOUBLEWIT. [0]

I'm really hoping some userspace people can chime in.


[0] We really ought to have a SIGSIGNALFAILURE or something for the
case where normal signal delivery fails.  This is the userspace
equivalent of #DF.  SIGYOUBLEWIT could be folded in.  There would be a
flag in the signal frame saying "don't even try to sigreturn".
