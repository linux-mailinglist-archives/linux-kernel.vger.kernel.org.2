Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2713499E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhCYTBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCYTBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:01:07 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E02C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:01:07 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so2964729ota.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AI97Rhm27oAU3pmFsCMuigo8bpgh9hq0vsPD+IRPTRU=;
        b=QXo8oH3MYTNT4rHdFRGcVXVXnhWiLnCltyYBMzah6O71VDtJ09gsf+SNL6QLdAM91K
         oo9cud6mBP2PZVWOiDgrvpLZ1qBO/BgudiLi4Q9l75Wi+I5iRNSDlxNvfeq1t0zgRl7A
         Ff2lKSnYxLSVLTxUQWCEYB/gvoAPpy7KCbPAZ5FA2U0bKhchH2xrF90yZiypXbnEsZAC
         4GbPl87QjZcyv9Y3ZG8dTXDqSTO9cxPiEbyTctaCu1YNISymPSYFmyfnqhBkZeKLqyJY
         ZMQEvmodSre9UQi4cs+eBySnvs2sKjUYEh2hdX0cYHtNsdQ4HXGN8mSBZvXYvoiaN5nU
         AL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AI97Rhm27oAU3pmFsCMuigo8bpgh9hq0vsPD+IRPTRU=;
        b=OKx5gzN13w3hSRtAgZ8FF5NguujUh9VdZ6kFt3hHVyahmQ0MZl2/J9ca8NBCg1Uc1A
         f7LsIy+OO9q8ec2C1ouijzZRxZFgEaDIAR9SYg1t0VFrfx860mC5QIAsg+ftWz1OExRR
         RlkLt9C3WyOqqwxOxzht2/Rgn17PHftCKuFB4GmFWHOZrfOImM9FaidIYEiae/a869zL
         ZR1FwBH923SsFfiA/3HRb448Pxb8ZecRUpcT+cDKT1FMajRdPJYSvwYd/768rTr9GPxA
         eX+Ms44InK/puipOKhuTKssCL9lCCypAJUP7nHppwuDGIxzA7d1UQIPmBv8pHr1rS+0F
         mIPw==
X-Gm-Message-State: AOAM532IYAgNnQmxOUfD+sSZSVL73WsbuUlIHwv43PxW1s1WY7Mt6lUM
        5zskFk+/DiXs1vpjaw0Vu/lE6MKWSzTaNVGga3tN2Q==
X-Google-Smtp-Source: ABdhPJzhZDWXqHKmULvSmy2BZTEnkNCkFZZT2m6rxr8crGJ3fbDBBScpn9MgSa3ym+7HsxFAxEwjLmjQuWqXm8RGJUo=
X-Received: by 2002:a05:6830:1694:: with SMTP id k20mr1208716otr.241.1616698866340;
 Thu, 25 Mar 2021 12:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <2ca37e61-08db-3e47-f2b9-8a7de60757e6@amd.com> <20210311214013.GH5829@zn.tnic>
 <d3e9e091-0fc8-1e11-ab99-9c8be086f1dc@amd.com> <4a72f780-3797-229e-a938-6dc5b14bec8d@amd.com>
 <20210311235215.GI5829@zn.tnic> <ed590709-65c8-ca2f-013f-d2c63d5ee0b7@amd.com>
 <20210324212139.GN5010@zn.tnic> <alpine.LSU.2.11.2103241651280.9593@eggly.anvils>
 <alpine.LSU.2.11.2103241913190.10112@eggly.anvils> <20210325095619.GC31322@zn.tnic>
 <20210325102959.GD31322@zn.tnic> <alpine.LSU.2.11.2103250929110.10977@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2103250929110.10977@eggly.anvils>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 25 Mar 2021 12:00:55 -0700
Message-ID: <CALMp9eRvFRhGRvc5OzqJ1fMWuOVokM0NPiXLi6V8jvEaWp9QEA@mail.gmail.com>
Subject: Re: [PATCH] x86/tlb: Flush global mappings when KAISER is disabled
To:     Hugh Dickins <hughd@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        kvm list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Makarand Sonare <makarandsonare@google.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 9:33 AM Hugh Dickins <hughd@google.com> wrote:
>
> On Thu, 25 Mar 2021, Borislav Petkov wrote:
>
> > Ok,
> >
> > I tried to be as specific as possible in the commit message so that we
> > don't forget. Please lemme know if I've missed something.
> >
> > Babu, Jim, I'd appreciate it if you ran this to confirm.
Tested-by: Jim Mattson <jmattson@google.com>
