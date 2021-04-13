Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D876935E6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347701AbhDMSqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346390AbhDMSq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:46:26 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB75C061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:46:05 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id v6so26292459ejo.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BMGgkIUNC5wWSbI0C1p7AMY+wrQiOl3v5uY4HYbC/nA=;
        b=mRHHof94dBTjnv2kql1qxtKewllGuJC7CJTPW+gffF3hjEG/vYqShSSh9lDYIGDTZW
         +2f5H5GYi9BMd979sRs2hichgCR1CFTVXFx13NO7FvDVI1Kp44mYBorL/ls0WUNneyyB
         /JTqivyXzzjZJpZ4llQutwzxtvBSsTvz4bB3cPR+5JNtBakN5/VYtzIvJdaEBUethCfG
         0bGzPtJhwx5x3rsBUsU7MaC+/gPylvCadXuMIBW3DaK/KN5FffKAyDdlMyUcpNVBXuQ7
         DjYoNZT+Jj4RHjC8Bt37cCXI9UPgPC0qZ9/z4htSGHq1+v/huhtfkdApmWjZxdcIOxk1
         DnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BMGgkIUNC5wWSbI0C1p7AMY+wrQiOl3v5uY4HYbC/nA=;
        b=qvChCi9zon3rJ28SJ4FOEzKeUNa9vAQcM5q2wiAn+sWm8WCXDQRuyz7GgySYBm1hqi
         8AAz7pbfLQqOLQY46fh7+s1U0l9BKi82npcaoZZzvQWGp7zLP7DJcQB3XerY48IyrggR
         0C4yqfOcfJnJcoGT11AzP091Rbixg6yPsbQ0kDzNFBekBnCDWyHruPp8Ocfk6UF0q/hY
         6EEc+qB83k6ewlFDQIECm6+LX5LY8cGFtO9J0NHx3XrwtDWpCjvnB2owieRhMEgTmm6l
         bgAi6Lgf/+ZB7qb2O5bYcWaaq2BM8J+RtGS+Z07aN3bEhNd17kDTxbmJKT4tEmg9EJMO
         ReKg==
X-Gm-Message-State: AOAM533++91JBMR8RbTCjHQFBivgrKfj4rRzJVYQs4C0sFw1dJYpf7RT
        pcoRyLUfqWRTOwBpYvcGzdo1UwOsP0deQAqMBzjQcA==
X-Google-Smtp-Source: ABdhPJwOAKdwimwdXmyd9YZC1Lo2ZFNJZlqxhMHcPG2WDWSOeFiYrvVfHRaqwggt18Drl/Opi1c9PgTsxhMlYzmPg5Q=
X-Received: by 2002:a17:906:48c4:: with SMTP id d4mr14395692ejt.548.1618339563693;
 Tue, 13 Apr 2021 11:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210412130938.68178-1-david.edmondson@oracle.com>
 <20210412130938.68178-6-david.edmondson@oracle.com> <YHRvchkUSIeU8tRR@google.com>
 <cuno8eisbf9.fsf@oracle.com>
In-Reply-To: <cuno8eisbf9.fsf@oracle.com>
From:   Aaron Lewis <aaronlewis@google.com>
Date:   Tue, 13 Apr 2021 11:45:52 -0700
Message-ID: <CAAAPnDGy2MZF2QVTTdNQgQC3Sh9mOjJx-cetn2nZ4cu6-h1Zvg@mail.gmail.com>
Subject: Re: [PATCH 5/6] KVM: SVM: pass a proper reason in kvm_emulate_instruction()
To:     David Edmondson <david.edmondson@oracle.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> > Depending on what you're trying to do with the info, maybe there's a better
> > option.  E.g. Aaron is working on a series that includes passing pass the code
> > stream (instruction bytes) to userspace on emulation failure, though I'm not
> > sure if he's planning on providing the VM-Exit reason.
>
> Having the instruction stream will be good.
>
> Aaron: do you have anything to share now? In what time frame do you
> think you might submit patches?

I should be able to have something out later this week.  There is no
exit reason as Sean indicated, so if that's important it will have to
be reworked afterwards.  For struct internal in kvm_run I use data[0]
for flags to indicate what's contained in the rest of it, I use
data[1] as the instruction size, and I use data[2,3] to store the
instruction bytes.  Hope that helps.

>
> I'm happy to re-work this to make the exit reason available, if that's
> the appropriate direction.
>
> dme.
> --
> And you're standing here beside me, I love the passing of time.
