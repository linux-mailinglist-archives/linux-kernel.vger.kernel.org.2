Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EB2437FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 23:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbhJVVJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 17:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbhJVVJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 17:09:09 -0400
Received: from mail-pf1-x462.google.com (mail-pf1-x462.google.com [IPv6:2607:f8b0:4864:20::462])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650F4C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 14:06:51 -0700 (PDT)
Received: by mail-pf1-x462.google.com with SMTP id 187so4698363pfc.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 14:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:dkim-signature:mime-version:references
         :in-reply-to:from:date:message-id:subject:to:cc;
        bh=ImoABBg6541EdX3zFl8zDtW+p0YhC+RBw8rNkgwHIS4=;
        b=Knco+dc/nbw8p9C8apW2iwjVKaYsVy1BGE76bZI/C1lsGswI7V+MKKbUc6CztnSOWH
         70L9wVlnvwpIpxkqVnMwVWurXSpwpt17kQEp/gCUD7y46nC8w1b80zDLcwc+M3gi/M0k
         L4xq7KnRi0xVLJdw0JaMlEFxCdnlad2GMXI0IwzlJpT58T/aywG23+8983+dsilTBrTC
         kyM2WlQ/dllSJIBmFgvIQ9QBjOiCl1xyBS+hVAhxT2YhiOMO9agI4k+aRyYC2AF1LYJ/
         o1A3cSkWfWcuNMsFnMB1vteZnLyk0H9bTgtiLdUTPXm04EovAkSKfs4pFOdQkAEOpRn3
         wnog==
X-Gm-Message-State: AOAM533hIzQslhmpQrlv4b46zqtXfwGj75t7iJ4h26yuI3apA5oX5zHn
        TH09Ph6cdeO0OBuaZeNJrCCkhqMCZ3Vc+TRHz/ifVB0I+Psm+A==
X-Google-Smtp-Source: ABdhPJzNYkHx5+CvsgXkgzwjaXBYGCl/Xe6IyZGPc5EXiZbYQdFf9gm9jAw+QVChF6ZMwzkGtVjNo+PHlR+P
X-Received: by 2002:a62:5a41:0:b0:448:152d:78bf with SMTP id o62-20020a625a41000000b00448152d78bfmr2114516pfb.77.1634936810590;
        Fri, 22 Oct 2021 14:06:50 -0700 (PDT)
Received: from netskope.com ([163.116.131.172])
        by smtp-relay.gmail.com with ESMTPS id qe8sm1524041pjb.8.2021.10.22.14.06.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 14:06:50 -0700 (PDT)
X-Relaying-Domain: riotgames.com
Received: by mail-ed1-f69.google.com with SMTP id r25-20020a05640216d900b003dca3501ab4so4862982edx.15
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 14:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImoABBg6541EdX3zFl8zDtW+p0YhC+RBw8rNkgwHIS4=;
        b=VFmwou63xGBQ7r34dSPf7G5KlE1DUc2W+kayLyAE2/eZMKcB5WubGiZmilCp2KmwZp
         Pk3ga81w4nej3U06VYYL1eYiL4YlaaMIpDXbzav9hcRx2VXw15SOXSHRW3j/5si9dPMA
         4y9wDck3ehrGR1l+e/xf7oBw51iZ8CXpl4HV0=
X-Received: by 2002:a50:e145:: with SMTP id i5mr3152601edl.16.1634936808202;
        Fri, 22 Oct 2021 14:06:48 -0700 (PDT)
X-Received: by 2002:a50:e145:: with SMTP id i5mr3152548edl.16.1634936807940;
 Fri, 22 Oct 2021 14:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211020104442.021802560@infradead.org> <20211020105843.345016338@infradead.org>
 <YW/4/7MjUf3hWfjz@hirez.programming.kicks-ass.net> <20211021000502.ltn5o6ji6offwzeg@ast-mbp.dhcp.thefacebook.com>
 <YXEpBKxUICIPVj14@hirez.programming.kicks-ass.net> <CAC1LvL33KYZUJTr1HZZM_owhH=Mvwo9gBEEmFgdpZFEwkUiVKw@mail.gmail.com>
 <YXJ3WPu1AxHd1cLq@hirez.programming.kicks-ass.net>
In-Reply-To: <YXJ3WPu1AxHd1cLq@hirez.programming.kicks-ass.net>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Fri, 22 Oct 2021 14:06:36 -0700
Message-ID: <CAC1LvL1YCkX=0XwM4WHgSVejcs4RywMsXs--OTaJfsyWELHv+Q@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, x86@kernel.org,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
x-netskope-inspected: true
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 1:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Oct 21, 2021 at 04:51:08PM -0700, Zvi Effron wrote:
>
> > > What's a patchwork and where do I find it?
> > >
> >
> > Patchwork[0] tracks the status of patches from submission through to merge (and
> > beyond?).
>
> Yeah, I sorta know that :-) Even though I loathe the things because
> web-browser, but the second part of the question was genuine, there's a
> *lot* of patchwork instances around, not everyone uses the new k.org
> based one.
>

BPF and NetDev share one: https://patchwork.kernel.org/project/netdevbpf/list/

--Zvi
