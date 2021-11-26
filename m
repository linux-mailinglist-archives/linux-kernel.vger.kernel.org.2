Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35ACA45F535
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 20:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbhKZTfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 14:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbhKZTc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 14:32:57 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B21C061D61
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 10:50:39 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id z6so7227054plk.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 10:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bjNIyDqYXx2lr8TK1DHUT5HNLgHFi11CKevsQYniUmg=;
        b=URGfyaudpPd1cq1W/VaT8kf+OKPWnPXhfKqHJjge/XQhAE8CtautV3zWbFhgvOjLXP
         GG7CMOQotwAofKEw/oBEh5mgHuPi1WfkybexQzcDF5VYx/k8KYytoSnWQzILU6P6f5uu
         BiCejDtbtVyj3Gp2Kzs72OTK2Y6MZLQ8tJxOXcf8p+tPe7vmv0dFCSVgrsmeI8mGQHxk
         g4/oEV0v7/75ygM5COTUK7BnxMZCHMO1MtYCTgD4HhY3DTFH98igFvjUQlX0U5ThNpJu
         MWPi7MVt7r1GRofsjdDIQpTsYuZjhuBUHuPUPFbXSAEGwde7bjuzY2fHr+o7sJBiLs04
         FbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bjNIyDqYXx2lr8TK1DHUT5HNLgHFi11CKevsQYniUmg=;
        b=yRfaWbOhxg1j6UptPkj2qzFSkdiRu3Z/FY32DUTniQgFj0eD1fDi4YVLqDknorwv1S
         1DP69grx5Cg2W8fEHYWdlGhRBvbK6cIU2XJNK2iPPeTp+RuNtvf3fnbbNZb+cCB9SJUi
         dtYKfiO5Y4NPn7cK9iaX80/ZhYFiK/mIEDmY7RL0xTHSo61NzJllvhi14JSxNbQveG7e
         SFS4uSbhM9Bvuz2IeyvW4NckicMWmVF5jSMZ9n36Wa2KhxbbnB9PdF7dSYU3HNg/Duft
         RnhcO2WGLQj/xlQ7KqCIxwK6D/qYtgEHnny6JWMDEJ4V+BTYJHuhFKzIxRtNQGKxftiS
         G1aw==
X-Gm-Message-State: AOAM533fxNQkbEaSSv1czWWRAu6eqruOL9L0a0RlhrjPGedjahnt9R7W
        2/tBtrA+gfOUaIkgjiNrVlTQP2jSbxnDIpbny48=
X-Google-Smtp-Source: ABdhPJwX70l4olwm5qXUC8qIbovOBhzlbx2/gzhYrL6a2LZW9y2x1QxKRHBC0ZqH8Ynb0/oCzHpLY4e6pcfIu8XV40M=
X-Received: by 2002:a17:90b:1892:: with SMTP id mn18mr17606887pjb.178.1637952639448;
 Fri, 26 Nov 2021 10:50:39 -0800 (PST)
MIME-Version: 1.0
References: <20211125193852.3617-1-goldstein.w.n@gmail.com>
 <CANn89iLnH5B11CtzZ14nMFP7b--7aOfnQqgmsER+NYNzvnVurQ@mail.gmail.com>
 <CAFUsyfK-znRWJN7FTMdJaDTd45DgtBQ9ckKGyh8qYqn0eFMMFA@mail.gmail.com>
 <CANn89iJA1JOevgLSK019VYXKkLJsMjV-u9ZHvrgZ+XUypRWwfQ@mail.gmail.com>
 <CAFUsyfLeVGW8etXHuSGvYy_RoS3RGaA1L+NLKnpc7EsSMVORBg@mail.gmail.com> <CANn89iJxMhGfp364rPu6p_ZLrKnM1qWF_NWrw4_oL_KG+piByg@mail.gmail.com>
In-Reply-To: <CANn89iJxMhGfp364rPu6p_ZLrKnM1qWF_NWrw4_oL_KG+piByg@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Fri, 26 Nov 2021 12:50:28 -0600
Message-ID: <CAFUsyfJ33cKFQdUagHQ_b4N80CfBtGQZhyA4CN_JLgEmXEX=DA@mail.gmail.com>
Subject: Re: [PATCH v1] x86/lib: Optimize 8x loop and memory clobbers in csum_partial.c
To:     Eric Dumazet <edumazet@google.com>
Cc:     tglx@linutronix.de, mingo@redhat.com,
        Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
        X86 ML <x86@kernel.org>, hpa@zytor.com, peterz@infradead.org,
        alexanderduyck@fb.com, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 12:27 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Nov 26, 2021 at 10:17 AM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> >
>
> >
> > Makes sense. Although if you inline I think you definitely will want a more
> > conservative clobber than just "memory". Also I think with 40 you also will
> > get some value from two counters.
> >
> > Did you see the number/question I posted about two accumulators for 32
> > byte case?
> > Its a judgement call about latency vs throughput that I don't really have an
> > answer for.
> >
>
> The thing I do not know is if using more units would slow down the
> hyper thread ?

There are more uops in the two accumulator version so it could be concern
iff the other hyperthread is bottlenecked on p06 throughput. My general
understanding is this is not the common case and that the very premise of
hyperthreads is that most bottlenecks are related to memory fetch or resolving
control flow.

>
> Would using ADCX/ADOX would be better in this respect ?

What would code using those instructions look like? Having trouble
seeing how to use them here.
