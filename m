Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE58435D4CA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 03:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240639AbhDMBZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 21:25:54 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:41748 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbhDMBZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 21:25:52 -0400
Received: by mail-ed1-f50.google.com with SMTP id z1so17363395edb.8;
        Mon, 12 Apr 2021 18:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2nZBBjCW38M6YvTtdW4Do00fkaUO+lYuclBOKFX4SFA=;
        b=Sv5PZJATG9Rm/+aN0kSs0CZPtXOt37LWQ2mUMCkF6CG8fJVtesrqIThitEDiCLW0Jv
         C4x0dzDCIYq2T8f8pqkjYzTzYY7xVsVfX1no9VqNJSz/kZxy3hG7vLiyUR2GOT4c8M/F
         c8zLCSFRn43Az5QBbtAZDMir1grtl0GAIcX2bnF8lRwua9iaRXVyWpXQaD/rPmWgvYSE
         TAAXRtY0Nq5mcSRGoCWOXddlE8owJnzCpqAyCYw/RUYI522bWb35azaTFUCm36/clroq
         NiP7KU9Xz1MqAOgJ5l4X82gEfsP9fAXkpqAFgeaG6p/W8vyDuEwMjO2RotRmuhC8uuU8
         u7JQ==
X-Gm-Message-State: AOAM533GSeLsILuDYViFx21qhvviMP/kaE8Su8qFZ1c+yukE2Vn07LPE
        JkDHMUiMXJluV+09RH0lbIe8MBLRX2ICymgBlzU=
X-Google-Smtp-Source: ABdhPJzpqNLOMTH25ybCMHxXnc3Tw91J/D/oz9lhrIdTSd1fbE3T4TQ7nNlmQ8zA21cMhNq5/RE6jAWhFf6C0X/5JWs=
X-Received: by 2002:a05:6402:2208:: with SMTP id cq8mr32118881edb.122.1618277132711;
 Mon, 12 Apr 2021 18:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com> <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
 <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com> <87a6q3yr5g.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87a6q3yr5g.ffs@nanos.tec.linutronix.de>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 12 Apr 2021 21:25:21 -0400
Message-ID: <CAJvTdKmu-eWjSkBMgVh3BE6M38LPTSPk1oER2PKRQFUgqWYV6g@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Thomas Gleixner <tglx@linutronix.de>
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

On Mon, Apr 12, 2021 at 8:17 PM Thomas Gleixner <tglx@linutronix.de> wrote:

> I'm fine with that as long the kernel has a way to detect that and can
> kill the offending application/library combo with an excplicit
> -SIG_NICE_TRY.

Agreed.  The new run-time check for altsigstack overflow is one place
we can do that.
Let me know if you think of others,

thanks,
Len Brown,
Intel Open Source Technology Center
