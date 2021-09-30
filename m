Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FCB41D20F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 05:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhI3EAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 00:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhI3EAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 00:00:19 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A5BC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 20:58:37 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x27so19444594lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 20:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2l4dHoIfwgMb6BM7hfC3l0nv3vJcUx4BywuU/NezsIY=;
        b=ltE2JyZnf7KRkKOD6Fs0aNM4qMvhNqQXPfQZF3LT8qCz8/sWBX3WyT/o2vlb3POO5M
         pi4Yky+3YRwOUp+6ZKAu55hK/zR7npfVTZ/ROt4/Jh4nNYzfxPu0DH8GbK8BVVZ1k7CW
         QnA7KofIg5u1wSnz0EB3mPeXuZRqbjlXYtUwRsOaZIa9MsaQ433nUJ9UVHn93Rdjr+Yw
         XErBP7m7X0hRA3TVv6rO1ZQNHFCmP5frfJ7JMZWwRJX+/y/BvOr3iPMTMJydzlSDKXsS
         lNI8xVNMlPYedEmwF3DKbIxIJX28iRuugh6a8Y4Yfd+agrjqihwCzJAzXgkpSDQ+kbf/
         ubNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2l4dHoIfwgMb6BM7hfC3l0nv3vJcUx4BywuU/NezsIY=;
        b=TNaypwfHtObAu28mlwczPDzURH7WGxdhaIV1PfUTJfJTaERx0FW9JblLQWhd4qClFp
         3G1f+d+cLxnsasPgytGKUVnSGRelQfnrAZt/mcCYW45FV5KjUT95NvvyJ4ukK4lYTOcg
         1un1gVmdB6VGrC/xGPzNAwsP/ZESMnOXhZXh9lp0BXMg31iBPJnF+J8WVTJTyNN3GNJ3
         WNleAx4h/5VpU+Hs25eMxNNmU+WhvC2s6SvCGgaCE/Co6KuJS3o9PBE5ZBfhi8/1fTH+
         S9GMOA2jmqwShZ8r3ev/tNofEQ7RSwmErs+Sc69a/YPU+nxbJtQUDR6cFrjKmltYN1IV
         Dlmw==
X-Gm-Message-State: AOAM531aErXrGvRWo063B/b7+uy136QrkBdR6fB4vN2mCRm1ESdAYf1g
        UYCFIGI+b32D5CmOwSLkCe+WdUDAEnx09GNmdcRFrQ==
X-Google-Smtp-Source: ABdhPJxUiHZwl2ZEwrVsetpg+NGKuleqfbfAMMzrZj9iiEDLuwxZi2tNP61nwlB8/4wh0CbxcZVkvn20edtBs8IoT1k=
X-Received: by 2002:a05:6512:2206:: with SMTP id h6mr3450790lfu.475.1632974316261;
 Wed, 29 Sep 2021 20:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
 <20210916231325.125533-11-pasha.tatashin@soleen.com> <20210929124513.GD21631@willie-the-truck>
In-Reply-To: <20210929124513.GD21631@willie-the-truck>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 29 Sep 2021 23:57:59 -0400
Message-ID: <CA+CK2bBY-9JAtb1Rs4OJ2mmCtqMEsJ0rJs4a5EXnmj8AejvFYQ@mail.gmail.com>
Subject: Re: [PATCH v17 10/15] arm64: kexec: use ld script for relocation function
To:     Will Deacon <will@kernel.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        madvenka@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 8:45 AM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Sep 16, 2021 at 07:13:20PM -0400, Pasha Tatashin wrote:
> > Currently, relocation code declares start and end variables
> > which are used to compute its size.
> >
> > The better way to do this is to use ld script incited, and put relocation
> > function in its own section.
>
> "incited"? I don't understand ...

I will correct it:
s/incited//


> > +#ifdef CONFIG_KEXEC_CORE
> > +/* kexec relocation code should fit into one KEXEC_CONTROL_PAGE_SIZE */
> > +ASSERT(__relocate_new_kernel_end - (__relocate_new_kernel_start & ~(SZ_4K - 1))
> > +     <= SZ_4K, "kexec relocation code is too big or misaligned")
> > +ASSERT(KEXEC_CONTROL_PAGE_SIZE >= SZ_4K, "KEXEC_CONTROL_PAGE_SIZE is brokern")
>
> Typo: "brokern",

Will correct it.

Thanks,
Pasha
