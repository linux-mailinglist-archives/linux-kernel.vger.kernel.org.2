Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FF639035C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhEYOGZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 May 2021 10:06:25 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:40680 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbhEYOGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:06:19 -0400
Received: by mail-ed1-f54.google.com with SMTP id t3so36346506edc.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 07:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8FeVSXbn7JLFv8182S+pWdq/FWRiXd05crIPFbCBrwU=;
        b=FsvbfqKMjAcwaJ7AME+qzwt9qqJqof1sypsF5i9LAA+mCL0qQCAQ+UBZeGg407wRLs
         cXtxAU9qSTI+JgdP0vYyrYWewND2TDW45sUK/W2AHr5LrwVrFImOYQmQVYITAhyVPuUC
         +KXPbzKe9auNmKl/jbJ+8erCwxDdshIC3LNfAVbKmat5l/4MiWvpxyo7CQtDzIYNj68C
         L1Q78fQUBd/FprBIYbzyhwGtpA5zDN1Jj4d4uCMQY8QvkDL2PPYuki4/RF/1/i7mTR+O
         zck20FiAql+m/5EFAW6PqUkipLgyHLvgDPc2YHKI6G0MDdoRqo3wmhpt2Xcx+785ra2h
         UWSA==
X-Gm-Message-State: AOAM531iOEOOSOPe5gFyGZ/vOqLASF3XLA7pmeEELaW6LO3uoNKOx+Qd
        3Q1q8DBX588mIiM9N3blbMmC6zVgfajW7FtMvbs=
X-Google-Smtp-Source: ABdhPJym9FQuETl/gtlc9R/+QHtsiJ8xknm9pqLhU2ikkEPg/DzCvYeIBTy4bWaMqwKPpIaWoe5WiaDZJA9kwcIk++U=
X-Received: by 2002:a05:6402:5a:: with SMTP id f26mr32048861edu.306.1621951487757;
 Tue, 25 May 2021 07:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-25-chang.seok.bae@intel.com> <de9f67eb-2be7-8950-749e-cc8eef5cc142@kernel.org>
 <CAJvTdK=ZRFxh1=e0q7JbtNDfQWrS1d3TzrMHGiTg2Eaq1LsRSw@mail.gmail.com> <c6b08bd7-816f-4683-9f68-716634d1529e@www.fastmail.com>
In-Reply-To: <c6b08bd7-816f-4683-9f68-716634d1529e@www.fastmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 25 May 2021 10:04:36 -0400
Message-ID: <CAJvTdKmprgO9h=YgvQC9KW5kS6GAvE30t-1MTOyOgozX+ehnLw@mail.gmail.com>
Subject: Re: [PATCH v5 24/28] x86/fpu/xstate: Use per-task xstate mask for
 saving xstate in signal frame
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 12:48 AM Andy Lutomirski <luto@kernel.org> wrote:
>
>
>
> On Mon, May 24, 2021, at 11:06 AM, Len Brown wrote:
> > On Sun, May 23, 2021 at 11:15 PM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > If I'm reading this right, it means that tasks that have ever used AMX
> > > get one format and tasks that haven't get another one.
> >
> > No.  The format of the XSTATE on the signal stack is uncompressed XSAVE
> > format for both AMX and non-AMX tasks, both before and after this patch.
> > That is because XSAVE gets the format from XCR0.  It gets the fields
> > to write from the run-time parameter.
> >
> > So the change here allows a non-AMX task to skip writing data (zeros)
> > to the AMX region of its XSTATE buffer.
>
> I misread the patch. I still think this patch is useless.

This patch allows skipping writing 8KB of zeros in XSAVE, rather than
writing zeros.
This reduces both the cycle count and cache impact of context-switch.
Some might consider that useful, rather than useless.

> > The subsequent patch adds the further optimization of (manually) checking
> > for INIT state for an AMX-task and also skip writing data (zeros) in that case.
> >
> > We should have done this optimization for AVX-512, but instead we
> > guaranteed writing zeros, which I think is a waste of both transfer time
> > and cache footprint.
>
> If no one depends on it, it’s not ABI.

Agreed.
Perhaps in the future we can see if reducing AVX-512 cache footprint
this same way is beneficial.

-- 
Len Brown, Intel Open Source Technology Center
