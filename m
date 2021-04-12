Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B9C35D425
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 01:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbhDLXqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 19:46:40 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:41979 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237377AbhDLXqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 19:46:37 -0400
Received: by mail-ed1-f46.google.com with SMTP id z1so17149723edb.8;
        Mon, 12 Apr 2021 16:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1i9uWUka3mSI73hEB1W+fNOiLnbDlOqIbTHdoJYwzU=;
        b=n4i9Ww9bh9z9pbQLkxAzvlDaLqgVQP4e7NtcDJ0MxnZ5+W1RjDk1icQxOox72BcLkA
         TlljEr+NTxwWZDoqb18UFAifgUKebTZOLzhsquAY8xUZe3RlIRTKsek47TdOBmxo3YpE
         hiMvI5tdxgQ3VIqUSQsSY9oRrhIEjCKF+t7aFklK31LuXERicUSBDMw8P/iF5sRVFXfc
         1NjyewcY+pEPsBzcY+mfA7qxkVY76W7dT6wRtqur/1fVTX5WeNtBzgEHlM0ZyIcWMI9T
         dz5WWzXyxL68jMY3UIz21Xeo/bugXJ0zMJN7Rz0wa8mnZdPrb0cDOWZlTiIGmYYsoHXK
         8nnQ==
X-Gm-Message-State: AOAM532r6hmFMfOVuqgyr+pp4aooATcm637n4EoWQQLcFtEAHr0/+xnK
        D+i35HtTZboWXBFny8O9y1qTQYhFC5IjmgUGFsM=
X-Google-Smtp-Source: ABdhPJyfZVhFKp7nVTdtB1Ki3Y5mzqEvc1Cgf07Id/CuBa8DZC237wzbWw92ndMtMuiVYMkW7wyE2fWeVWsp1NokeHE=
X-Received: by 2002:a05:6402:35c9:: with SMTP id z9mr31715003edc.94.1618271177457;
 Mon, 12 Apr 2021 16:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com> <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
In-Reply-To: <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 12 Apr 2021 19:46:06 -0400
Message-ID: <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
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

On Mon, Apr 12, 2021 at 11:21 AM Andy Lutomirski <luto@kernel.org> wrote:

> AMX: Multiplying a 4x4 matrix probably looks *great* in a
> microbenchmark.  Do it once and you permanently allocate 8kB (is that
> even a constant?  can it grow in newer parts?), potentially hurts all
> future context switches, and does who-knows-what to Turbo licenses and
> such.

Intel expects that AMX will be extremely valuable to key workloads.
It is true that you may never run that kind of workload on the machine
in front of you,
and so you have every right to be doubtful about the value of AMX.

The AMX architectural state size is not expected to change.
Rather, if a "new AMX" has a different state size, it is expected to
use a new feature bit, different from AMX.

The AMX context switch buffer is allocated only if and when a task
touches AMX registers.

Yes, there will be data transfer to and from that buffer when three
things all happen.
1. the data is valid
2. hardware interrupts the application
3. the kernel decides to context switch.

There will be no data transfer of AMX architectural state when it is
in INIT state.

As AMX registers are volatile, correct software will always have them
in INIT state before calls, including system calls.

I've addressed turbo licenses already.

> Even putting aside all kernel and ABI issues, is it actually a good
> idea for user libraries to transparently use these new features?  I'm
> not really convinced.  I think that serious discussion among userspace
> people is needed.

At the risk of stating the obvious...
Intel's view is that libraries that deliver the most value from the
hardware are a "good thing",
and that anything preventing libraries from getting the most value
from the hardware is a "bad thing":-)

cheers,
Len Brown, Intel Open Source Technology Center
