Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EF130C97A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhBBST1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238353AbhBBSQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:16:22 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164F6C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:15:42 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id m22so17649529ljj.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/MWbkPLCL9CFKof8bZd6gd8Z2vCJySSsKevLs2Kls/s=;
        b=hI2p3QaIWuox11WRTsIOwV8N4BHLb0KlgJGZJnfI7iTeuKwXHj8kagcgHXMpwqdN4G
         XtdoSMRiCDHb904N32WDbLL3UdrsUgNT3DggPmqp9pce9pMLYfAMPYNY9TANUZSKS8Tv
         enOgBNM8CfJsRualblnjidKdyWXTqZ6cQe1h4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/MWbkPLCL9CFKof8bZd6gd8Z2vCJySSsKevLs2Kls/s=;
        b=Y2mHPkU2OrPuetxP6D1FgE3h4sTyo5lvdihbYqUxJMohGmac/T3LYlRYQNKAZca90o
         tIlurS5Frd0JsW8v8CyG3j1qA3NdRLXhvUfLINgvL1XbVAoD5Ra3pG8J9BsSZah1Jj5G
         oDf7gPoFmVtGDD888QvvuGe2dBADl/g+23bfKG0VN8BiGy3e/sENj9fXalMFmaHgjmuF
         djd2GJ0pqHaC/u6PGibyGQWMcbGTA/3cl0kPQWChzEvZ9DGKx6yeR38dWgc5dNaqWGnQ
         cnIDGhuBVPNoe0Tw7QijURh6f5qyJEKydy7p6TRYeyVc7PaTop+EtPZ45rBg3sm4Neyr
         axWQ==
X-Gm-Message-State: AOAM5323ZG4Q5Ok4loIorb5n8zNeunNgiU1aOAjJzaGZ7RSdKmqw97JT
        huECVjtLAbR6ApsU9bUBGj6phc6HHEYvmA==
X-Google-Smtp-Source: ABdhPJwP8Hi/OdjmzNW20HVhrayJwfBlk0YEX54RfUkRGc/YJnTLaOHrUP8BzxNSMW3fz2i0S9Pung==
X-Received: by 2002:a2e:8986:: with SMTP id c6mr13540541lji.315.1612289739686;
        Tue, 02 Feb 2021 10:15:39 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id z1sm3410234lfc.303.2021.02.02.10.15.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 10:15:38 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id s18so25083336ljg.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:15:38 -0800 (PST)
X-Received: by 2002:a2e:b1c8:: with SMTP id e8mr6748318lja.251.1612289737770;
 Tue, 02 Feb 2021 10:15:37 -0800 (PST)
MIME-Version: 1.0
References: <20210201174555.GA17819@redhat.com> <CAHk-=wjKeFHBn60eJJjvJOW2+bdtwbeSb12R+=PBQJSSHe+FbA@mail.gmail.com>
 <CAHk-=wjJerA3xGtK8HdEcdAnmaaTz-iVvc_xqokzNTBivKomVQ@mail.gmail.com> <20210202155548.GB20059@redhat.com>
In-Reply-To: <20210202155548.GB20059@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Feb 2021 10:15:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wit0wigE-D=r08=HyB4qSK-=+So8y9boeoc_o6Yavb_qg@mail.gmail.com>
Message-ID: <CAHk-=wit0wigE-D=r08=HyB4qSK-=+So8y9boeoc_o6Yavb_qg@mail.gmail.com>
Subject: Re: [PATCH RESEND v4 0/4] x86: fix get_nr_restart_syscall()
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 7:56 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> There is the "erestartsys-trap-debugger" test in ptrace-tests suite.
> Do you mean you want another test in tools/testing/selftests/ptrace ?

No, I guess it's fine if it's caught by the ptrace test suite - we'll
hopefully get fairly timely "guys, you broke it" reports.

Is that ptrace erestartsys-trap-debugger.c test new, or has it just
always failed? Or is the problem that it is so expected to fail that
we wouldn't get reports of it anyway (this clearly fell off your radar
for a long time)?

IOW, my only worry is that this is somewhat subtle (understatement of
the year), has been around forever, and if we care about this debugger
case, we should have _some_ way to make sure that if it gets broken
again we at least get notified some way in a reasonably timely
manner...

               Linus
