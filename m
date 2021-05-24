Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E9138F24D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 19:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhEXRem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 13:34:42 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:42665 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbhEXRej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 13:34:39 -0400
Received: by mail-ed1-f50.google.com with SMTP id i13so32912487edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 10:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+n9yg+goLBaQvbvHl/hoKrLBCytign7IMIE4oimtlBM=;
        b=S7eD63GE8pzTLncp05+PPPnlxgfNBzIfwQ3R8nsuhB1frbIGbPMRclGbRSsvtcFIWr
         uwlkEaQH1WSgDvjv9y5+wq66ecMtFXj/w5cuTOZXzesVB8qz0ohwg87CziNirrAVLQXf
         Nr0dINO1lV/V5zb3gB0Fyzb6D/wB+vu5EyQkYMOBitK/wWU/OHHSP68xWg0joNWpsrM8
         AmmzMCUfrg6gVTEP9uqmYUEU73Qmh0dq4Qui8iZKqnOInxE7Mar3zzVakQh1K+DMJdxf
         Rg8ukIF0m9G5qIakcfHtuXx9TNW2oQHs0BAusYC6yiKCmCCgLCmars+0p6tcG/lBU+ru
         LXlg==
X-Gm-Message-State: AOAM532ulytcFX0oiKJ4WwpD2CbdUMwqjWB3lkuuy/w9n3GyTS4Zks88
        kYB5LoeaA124xlZTeYMKE8kZiTzW4lSEZGhdkUk=
X-Google-Smtp-Source: ABdhPJxQgN2lJG6lMexQV8lfSnZxbKIwspv1jOmvOZb/OmIjoF5fzT494oWy6ZpbO+j4AIN1Z5aP/6RSAykDXGvNn30=
X-Received: by 2002:a05:6402:190e:: with SMTP id e14mr27254431edz.146.1621877589566;
 Mon, 24 May 2021 10:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-29-chang.seok.bae@intel.com> <1980c78b-d51b-c186-9179-f3c72692ad8a@kernel.org>
 <ff72d7cd-e36d-06d8-d741-645a0504bf65@intel.com>
In-Reply-To: <ff72d7cd-e36d-06d8-d741-645a0504bf65@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 24 May 2021 13:32:58 -0400
Message-ID: <CAJvTdKmQjTmOCwUBk+3dhYzOdsZBadqVdqFUPKRMkfcTccJHuA@mail.gmail.com>
Subject: Re: [PATCH v5 28/28] x86/fpu/amx: Clear the AMX state when appropriate
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Chen, Tim C" <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 10:10 AM Dave Hansen <dave.hansen@intel.com> wrote:

> On 5/23/21 8:13 PM, Andy Lutomirski wrote:
> >
> > Can we do this just when going idle?
>
> Chang, you might also want to talk with folks that do scheduler
> performance work (I've cc'd Tim).  I know we're always fighting to trim
> down the idle and wakeup paths.  There might be no other alternative,
> but unconditionally forcing an AMX XRSTOR on return from idle might be
> considered nasty.

I'm not excited about burdening the generic idle path with a CPU
feature specific check
that would need to be checked on every idle entry.

thanks,
Len Brown, Intel Open Source Technology Center
