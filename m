Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D602244B49F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 22:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbhKIV2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 16:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhKIV2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 16:28:47 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B7FC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 13:26:00 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id k37so789158lfv.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 13:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pEy8zRbX4M0WulD1O3v1mhyXPMQ6YHtrHY83BsLR0g=;
        b=m4GdQSz+6PKu49f3JNqC0i9Ir+h0KyfXoFOYlFH4WhD4aZ1lWy7xNAp6CdaNqcc6Om
         PJoUfVnVTHKpTKfuhhBnTWP5OeSjqM3u5moYAj4FACkujCsLl2Av2YXANeQOmGZASu57
         Pc1Fju4Fx9mhlkloszkJRUhsrcIwm73AFRVazYvQ+0h2kDIiKGX31LGPt0CcLPDM3jrn
         ikXuEC0R8rCJjqWYR1fJ3Zny40fRohWvauCds4E70RsEIrNf190nFlSGHg1GcqIdMEZm
         Su9pp5hly9gWq4FLASd3z49GVs7dWSMcy6QVWUvhB/k7WeLty9YlGb3t8FUUw3PloGyD
         ToDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pEy8zRbX4M0WulD1O3v1mhyXPMQ6YHtrHY83BsLR0g=;
        b=U1FLsGlH565yxFI313ZHadWc4KljVsKw7VrjbGqX2X4xJn+8KW2mH1ObZQpbooa1p3
         4JbwuChMZOUZiH0r5jr7wgr3d7STFTABvCotR+ytHV48mDIINSVn1O6Ru8o8eXsd8V3B
         dt9Dnzi1bd4kuK5Vb6S1IQYe/JPeeTTsFktrmihzeeg+jmdCrrPq/AlvyL46kfLm73sq
         gRFN8uvYIIa2L74x+Hz6crSQMvrEiSEwFcRsfPdGk7TeYUcC2W24qsJ5S4TeRVpOMXuO
         nRuNpU/fKqJ6m5ejrOtueFlNfcwwO2n/i1WBfIWtkLzvezw1ptAoKwc5zZLKbcvwu53w
         +8qA==
X-Gm-Message-State: AOAM532TOAr0l8Hmq3ZuOk+hVFWsUdl8Qexu76LxGEAhs2pw6OAPhypl
        ow1tcLsEVtOtQtaqp4y5/uRHwsvCkvoQ5GQTK611iQ==
X-Google-Smtp-Source: ABdhPJzAuZ0fJiDD4u+9qnqI2MbQh8ZPVDGKUAVD3PQQU+dwZoFDORUfzFz1zfA/o6wRbHl6wwGW32ZCEBhXHLlM5Zw=
X-Received: by 2002:a05:6512:110e:: with SMTP id l14mr72283lfg.550.1636493159120;
 Tue, 09 Nov 2021 13:25:59 -0800 (PST)
MIME-Version: 1.0
References: <20211105171023.989862879@infradead.org> <20211105171821.654356149@infradead.org>
 <20211108164711.mr2cqdcvedin2lvx@treble> <YYlshkTmf5zdvf1Q@hirez.programming.kicks-ass.net>
 <CAKwvOdkFZ4PSN0GGmKMmoCrcp7_VVNjau_b0sNRm3MuqVi8yow@mail.gmail.com>
 <YYov8SVHk/ZpFsUn@hirez.programming.kicks-ass.net> <CAKwvOdn8yrRopXyfd299=SwZS9TAPfPj4apYgdCnzPb20knhbg@mail.gmail.com>
 <CAGG=3QVecQroYbJ05AGk2f0pe=QOtWuZHyQowzG0i7os8E9fdg@mail.gmail.com> <20211109212116.GW174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211109212116.GW174703@worktop.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 9 Nov 2021 13:25:47 -0800
Message-ID: <CAKwvOd=3wFr=juT7hXPowHBvOTVPTW7LuB6XwHzURGd=GXkK1Q@mail.gmail.com>
Subject: Re: [PATCH 20/22] x86,word-at-a-time: Remove .fixup usage
To:     Bill Wendling <morbo@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz, llvm@lists.linux.dev,
        linux-toolchains@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 1:21 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 09, 2021 at 12:59:12PM -0800, Bill Wendling wrote:
> >
> > Adding attributes to labels shouldn't be difficult, as you mention. In
> > the case of cold/hot, it's adjusting some of the metadata that already
> > exists on some basic blocks. It might be enough to allow the normal
> > block placement algorithms to move the hot and cold blocks around for
> > us. The question becomes how many attributes does GCC allow on labels?
>
> I'm aware of 3: unused, hot, cold. Also:
>
>   https://gcc.gnu.org/onlinedocs/gcc/Label-Attributes.html

Re: unused:
Being able to selectively disable -Wunused-label via
__attribute__((unused)); seems useful, too.
-- 
Thanks,
~Nick Desaulniers
