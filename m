Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CFA3B9E7B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 11:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhGBJqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 05:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhGBJqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 05:46:49 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27BEC061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 02:44:17 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id i189so10923937ioa.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 02:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qqO0BGnrypD/wVeYBOQgNTRPS2etKNdrYj2ZSsBXYfg=;
        b=dNhb3bIORfzreK4J0xC93Os9lEr36Ys/zZxwnbDpW+94sRto0b1L1BP4jqSQegNECG
         W5FXEB5t6LG9AkhADWKUeyLjMIyKJdoJG3TLiKk2ODuPwuZuky8NTOCXLUMpie0wzVNe
         aS8FNLJbKBbRsZfrycDrnyLPCBEFYs887jqsEs+aDX+/axvZyNHnWNJapBfMqBbs6nzC
         fMwWNIJ3EMfTKHQ7y67qFEezLXk55fV8cyjFFu4rcrzdL93M7upuvv3VIxfx2gbPmBfw
         R/2/8uDJjeIBJRP5lwmoUW14zRx27Gos0QyI1ykpIeJzEDPNzDbazZKD6iFGT8AVzY3g
         lFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqO0BGnrypD/wVeYBOQgNTRPS2etKNdrYj2ZSsBXYfg=;
        b=gqHlLBD+9N2qOlalKBKBI3hUIJWIa7cXg0WcQhSW3WeGm3RM3ETwn7VWS/sl645oCY
         aV56GEbxItNjECyetq1MkCx4HgwiNAD3la4pxdstxu8WSUcEk1ghpa0ifYJZESF6D/Ko
         Bk17DlW8HzAz9YXxZW+FoeVQqKJoTuRLCmFlzUJVrtTzlpuOUsCFEV79WJ1u1dqMjVFX
         0EFGZtSaTAPvIrN4eT/h0ihRfiJGyJdzv7DSevi2SVPPnRNWLrIVLkPHhtp5Y+t+RuCN
         tb8zOs8DUPXry50cjZp55r8/KgdhozuFc8qA4T0enPJUB1ex2+sXBsy3rj6YSiSGvPgm
         WYaQ==
X-Gm-Message-State: AOAM533Xd905CBxKl84JlYWNgQRaPD6ta/2bzj1/hs2gQkALI5A7SeN4
        q0u1XouG7ai3dMSq1tvN9MaZzoLLPXmz5CqEns1IXw==
X-Google-Smtp-Source: ABdhPJwHsnB+KUW2qlnPzouDX1gMa0JrdWnV6BCavasMQWHFkVVfnhqZJGcVIHzxeSzpC+HnTrBKT3EvhZ/CeR39Hd8=
X-Received: by 2002:a02:3506:: with SMTP id k6mr3586781jaa.39.1625219057101;
 Fri, 02 Jul 2021 02:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+i-1C0DAr5ecAOV06_fqeCooic4AF=71ur63HJ6ddbj9ceDpQ@mail.gmail.com>
 <YNspwB8ejUeRIVxt@krava> <YNtEcjYvSvk8uknO@krava> <CA+i-1C3RDT1Y=A7rAitfbrUUDXxCJeXJLw1oABBCpBubm5De6A@mail.gmail.com>
 <YNtNMSSZh3LTp2we@krava> <YNuL442y2yn5RRdc@krava> <CA+i-1C1-7O5EYHZcDtgQaDVrRW+gEQ1WOtiNDZ19NKXUQ_ZLtw@mail.gmail.com>
 <YNxmwZGtnqiXGnF0@krava> <CA+i-1C2-MGe0BziQc8t4ry3mj45W0ULVrGsU+uQw9952tFZ1nA@mail.gmail.com>
 <1625133383.8r6ttp782l.naveen@linux.ibm.com> <YN3OEbjzxPgCWN0v@krava>
In-Reply-To: <YN3OEbjzxPgCWN0v@krava>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Fri, 2 Jul 2021 11:44:06 +0200
Message-ID: <CA+i-1C0NADVWC+0tiRTMACqupGpGzK-QZ3sciZq=AYUJL802og@mail.gmail.com>
Subject: Re: [BUG soft lockup] Re: [PATCH bpf-next v3] bpf: Propagate stack
 bounds to registers in atomics w/ BPF_FETCH
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2021 at 16:15, Jiri Olsa <jolsa@redhat.com> wrote:
> On Thu, Jul 01, 2021 at 04:32:03PM +0530, Naveen N. Rao wrote:
> > Yes, I think I just found the issue. We aren't looking at the correct BPF
> > instruction when checking the IMM value.
>
> great, nice catch! :-) that fixes it for me..

Ahh, nice. +1 thanks for taking a look!
