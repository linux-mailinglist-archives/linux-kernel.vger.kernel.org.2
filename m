Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E053704BC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 03:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhEABvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 21:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhEABvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 21:51:32 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFEEC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 18:50:42 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 10so369281pfl.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 18:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ozd6VF4VBSI5hJlHvANgfOYMt6KOui3CNQPSfuNTfQ8=;
        b=b+JDT3AWwu9N0GRp5QhVwxqHKUG78K+dd+wSEbWugHxKKnwu3m1yiL+Gsp6Ljf4iKb
         JMR/EO2vlaN7r4EMQMmJ+uvLlo1dGDZZD1vk/c+S5KKC5UvyQ6ZhuIdQwK6EfkDJIh0U
         ShmOUstjS2MMSweHvXYV+UgNKxjleveEecH9qInlFICsUAK5KFSoth9Zw7fu5uMLnMkQ
         gIGS6t5N7uo6V9kCntttT49ngYKMamBWkS0CYdW7F8DB1ZbpnMIVj/Z0ZfomUDDz8BE2
         F8QLNZJd0hys1dWa5ILcTW1ndM4uPsnW3ez0LxoThRt7oLcS3QYbs6VLIxNdzGOmp8qL
         Qn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ozd6VF4VBSI5hJlHvANgfOYMt6KOui3CNQPSfuNTfQ8=;
        b=DPAJGO7FKCY3xDYmj3Z9VgyR3ptCDjMe/TrZtziYPB/Tt9VpG58DKt/sB46FcnzwvA
         H1MJ8LreDWRpOAeLGF5MUhIwTBjFbPIEdcblMu/mb0u54fXuw+CW0jw8p6ECwlt1uUTs
         bOGTU6eEGNeROzVpUsGgfFjK1+zmfSpRKkCHtgBE1dhvN/4evPRGKgfx6H5iTmfWyku3
         pOkUxu+T6PGrF6oh2zFUC9fmYHKXQu9dSJnMJxSV852zEiXvy3oDJN01iYdfvAdlDLgg
         ch1C2ptTNaMlNt9zKIX2Z/qY/840FTkZYArF6kvbsEX9Gk5I4nVy/Ol6LsBFRM7zg4bk
         YIQQ==
X-Gm-Message-State: AOAM532y5CFgiVwcuUwyUyy8OD6CC1EAhtn/Ixl76vj6dCQvHgUUrF4B
        pfYkW1eBTo7OPgBBR/MrA734kNkd5try2A8iIxrRhw==
X-Google-Smtp-Source: ABdhPJwojJeOuN6oE6yy/4ZraukwNSHvsD+eP0ETgWX24l0YudXi/7UALMh1waxOAAlx1TfV/6juez2qo0MfyNOmz3c=
X-Received: by 2002:a63:a1d:: with SMTP id 29mr7324748pgk.271.1619833842289;
 Fri, 30 Apr 2021 18:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210430131733.192414-1-rsaripal@amd.com> <20210430131733.192414-2-rsaripal@amd.com>
 <CAAeT=Fw-nt5h3DhRCQr8Ma71NiP7dHB+WD2hie_55SpCHR=mDQ@mail.gmail.com> <e53887f8-c09d-28db-5041-bf8822370c46@amd.com>
In-Reply-To: <e53887f8-c09d-28db-5041-bf8822370c46@amd.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Fri, 30 Apr 2021 18:50:26 -0700
Message-ID: <CAAeT=FyAmSxKy5cpGLBH_kqDohXeQOdi4r02KjQO_vycq=4y=Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] x86/cpufeatures: Implement Predictive Store
 Forwarding control.
To:     "Saripalli, RK" <rsaripal@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, Borislav Petkov <bp@alien8.de>, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Considering KVM/virtualization for a CPU that has X86_FEATURE_PSFD
> > but no other existing feature with MSR_IA32_SPEC_CTRL, if a host
> > doesn't enable PSFD with the new parameter, the host doesn't have
> > X86_FEATURE_MSR_SPEC_CTRL.  Then, it would be a problem if its
> > guests want to use PSFD looking at x86_virt_spec_ctrl().
> > (I'm not sure how you will change your previous KVM patch though)
>
> Reiji, you are correct that X86_FEATURE_MSR_SPEC_CTRL should be enabled so KVM guests can use PSFD
> even if host does not use it.
> I have this change in my KVM patch.


Thank you for the response. Yes, that sounds good.

Thanks,
Reiji
