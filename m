Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941A644497A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 21:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhKCUZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 16:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhKCUZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 16:25:29 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27F8C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 13:22:49 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id t38so3537612pfg.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 13:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=war2vLNsX4MuuEy+BH5ykt95jrelUN2V35yRJh6JU0E=;
        b=UJDrYxrWXfrx5x/y3KQ68EsoIV6SWBiFuAzyHA0Y6x+omiy1Mnz5FgobTRXsiJ80Px
         uswxNW4wCJOKj7j4CTmf8lvK3F9kr7KAO4obXNih0VqrYJ2/46fODxb6CsDz8meAn5+c
         mmQ3iX4UxuyJlNkcCeemMmdQb1R0OdA/4opquspkWGP1kUd53Gd+2y6WrTeEy/h40loY
         pci50hXBTI+eReQevk/i8nm61GuFHauMwM0DhAJKCkUB19m1oP4muuZ4DQB1kUh943/F
         1OXYnJZvzNhA97FnWk7HT7TXkClkWnc5jOI/A9Od3TL+KlyTE1cW4wIVpd6+fuSLb1J4
         4PgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=war2vLNsX4MuuEy+BH5ykt95jrelUN2V35yRJh6JU0E=;
        b=sq7cYtxcgRyNNUcs3DnsiIZgpQSlmU0gMfUtt8GQ/f76ukeFLzPXM7B45ENPSAwgGf
         YUqNbxXtH3F78REQS/xN6eZwU+HAAxjbZugSZxOwhygCe9Rwnfiyb6BZn2g05A5VyVmo
         XUd4W40Le+4oDOwKaCJ5TCghmztdZi0/vKPtLkQSKtVN4sPRfpYKydt0XJmy9/rdKxFx
         v0Fu+XlNkikEpOorgHBfcXmtolq+doxeguBODayppryy8c29mzi05UWyio/h78pGydZB
         fcckKcIIbQ2ONZnsIDhrj2u/RWhGOLIySYJS9VvaISHgqp8h2Ym6fSMQMZZvJvz7o6r+
         hFqA==
X-Gm-Message-State: AOAM531cJA21I6FVCfEgC00HwrtpHLeJCi4QwtLqgBcMCuUWTKyxfAsP
        53qDsp8Klnn4qwraDbF9ge6StIdYot2oEltreuo=
X-Google-Smtp-Source: ABdhPJwB2bxpcq+yzNAM9yngHR4Nu3rBYMbJJHh54xUDLxGA0VzPkHTnaxx1Ayr0eqzegbxWIfo/Hs/sNQpqPVzZLcE=
X-Received: by 2002:a05:6a00:24d0:b0:492:727a:8905 with SMTP id
 d16-20020a056a0024d000b00492727a8905mr4022590pfv.79.1635970969427; Wed, 03
 Nov 2021 13:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
 <20211027162615.1989004-1-goldstein.w.n@gmail.com> <20211027162615.1989004-2-goldstein.w.n@gmail.com>
 <YXmIP2EPg12N7foP@zn.tnic> <CAFUsyf+Y76TxLnxMSfHiNqY3OOZPtBR4m_EbTcow=N65nvGdKA@mail.gmail.com>
 <YXmQSG7BYCcZ6jqZ@zn.tnic> <CAFUsyfKVistpw8eL9L6qwypac7JL9ecAL2W4reZtAMOq7xL+2g@mail.gmail.com>
In-Reply-To: <CAFUsyfKVistpw8eL9L6qwypac7JL9ecAL2W4reZtAMOq7xL+2g@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Wed, 3 Nov 2021 15:22:38 -0500
Message-ID: <CAFUsyfLp6hqc1KOupFKLMoFHhDmEOQDZsMxEBF7BFABRYmH9-Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86/xstate: Make AVX512 status tracking more accurate
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, X86 ML <x86@kernel.org>,
        hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 1:21 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> On Wed, Oct 27, 2021 at 12:45 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Wed, Oct 27, 2021 at 12:37:16PM -0500, Noah Goldstein wrote:
> > > What about just splitting off a field for 'AVX512_ZMM_Hi256'?
> >
> > Let's please not perpetuate this into what it cannot become anyway. The
> > more stuff we add to it, the more people will start using it and we're
> > stuck with it forever. And soon that thing will be worthless anyway.
> >
> > So what's the point...
>
> Got it and done in V5.

Ping.

>
> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > https://people.kernel.org/tglx/notes-about-netiquette
