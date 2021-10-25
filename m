Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB4A438CED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 03:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhJYBPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 21:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhJYBO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 21:14:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5390BC061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 18:12:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g8so4223009edb.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 18:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C+ecm+t2PsReTz6De6QOhCuZZsxdJqQBgK7vEegwMuM=;
        b=WEqLmWzDOX6QrqtFA5QIgOR5wjRm+JCAf99IwnVz5q2Wi+41Ep2VDqUZX/KLOB2Wq5
         duRgfXwHFkQ3EdHrgl9P4A1pIitqtYIdlX9BCisBEgKhTnugGnERhixIDUGF40Qi1L17
         hr7LagynymmsJkgY4UIT6uN7GalDTyFrpJCQm7h0Xf8U+KwpSjBYLU419fOiKUDJmk32
         d6cgk6E4U8vNmQW/y5Vz/CB6T+qMbVYJT0bMrQ2ovyBH2CtyhWK3wQ8/IxTK2xUM6CAX
         xunNLmibV2ixTcr9gt3/Jt3XbsLl3t44N+avlEgUKW0qV9YBK2UKB8Is/1D2tdbFSu+R
         QPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C+ecm+t2PsReTz6De6QOhCuZZsxdJqQBgK7vEegwMuM=;
        b=ZRoxJd1+Oy5NhHZK/UPfPT3g+uWqYqNq5Cup1G8042xMmyNvdH8k1tlEQ1M/wY/YVD
         RElnM+vMuqujcoxy1/WVMxXQLrwzHnUwCxx+OoK0BGgSjZ8HWisNt/ZBPcvNU7/6zKCB
         J+Z4QNH5bZdMZ52zyzxAmYmnm/H2+4H4AESCVsVSbQIFko3f3ARjww7z2TZ8V3k41GqG
         IrqMK2AZuRSDcOe+x/nPh45o5/cCjFOfds0A+6Cv8b8gjQxd1mqJLpMJsxyOe+dKlsRm
         Hv7vBAKWI+VK+rjaGQWXTkHGoC2YsJC4Uy26o24SZfgBZvxjnPzN+5dvkcJT5vTXpapd
         SwZw==
X-Gm-Message-State: AOAM53334ljyfMBHpkxTRYHXvVZNpdxH3YFOiRAL/ilZqF/revXY/jjl
        ZCzJIKqEs1PNel+s3XYsQPxxylfJBEsLwMGJqNw=
X-Google-Smtp-Source: ABdhPJy97jYbxK5dor/maO8rTF/AfWltfXK/H+KUbkMlti5Bg3qbCSqAqT1WuqNvLeMXEnWRcFB7cRFKWXk3lRNbLy0=
X-Received: by 2002:a17:907:3da7:: with SMTP id he39mr18612364ejc.554.1635124355353;
 Sun, 24 Oct 2021 18:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-51275835-4c34-4099-85f5-13c6dbef4e19@palmerdabbelt-glaptop> <750f6239-154d-9190-24ff-ece033add638@infradead.org>
In-Reply-To: <750f6239-154d-9190-24ff-ece033add638@infradead.org>
From:   Daniel Mangum <georgedanielmangum@gmail.com>
Date:   Sun, 24 Oct 2021 21:12:24 -0400
Message-ID: <CAA=qMX65_rV8DndydsvT3y9ZMkQ37PNjDFuKcmdbB1mRNdVMNg@mail.gmail.com>
Subject: Re: [PATCH] riscv: cacheinfo: fix typo of homogenous
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback folks! I have sent a v2 patch.

Dan


On Sat, Oct 23, 2021 at 4:36 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 10/23/21 1:30 PM, Palmer Dabbelt wrote:
> > On Fri, 08 Oct 2021 13:56:25 PDT (-0700), georgedanielmangum@gmail.com =
wrote:
> >> Updates 'homonogenous' to 'homogenous' in comment.
> >
> > I don't really know spelling that well, but checkpatch says
> >
> >     WARNING: 'homogenous' may be misspelled - perhaps 'homogeneous'?
> >
> > when applying this.  It looks like they're both words, but "homogeneous=
" is the right one?
> >
>
> Internet search to grammar.com says:
>
> To summarise, Earlier, homogenous was used as a scientific term, mainly i=
n biology, but now it is almost obsolete, being replaced by homologous. Whe=
reas, homogeneous is a common word, very much in use and means having simil=
ar or comparable characteristics.
>
> Several web sites agree that homogeneous is currently preferable.
>
> >>
> >> Signed-off-by: hasheddan <georgedanielmangum@gmail.com>
> >> ---
> >>  arch/riscv/kernel/cacheinfo.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cachein=
fo.c
> >> index 90deabfe63ea..ff98546b1152 100644
> >> --- a/arch/riscv/kernel/cacheinfo.c
> >> +++ b/arch/riscv/kernel/cacheinfo.c
> >> @@ -29,7 +29,7 @@ static struct cacheinfo *get_cacheinfo(u32 level, en=
um cache_type type)
> >>      /*
> >>       * Using raw_smp_processor_id() elides a preemptability check, bu=
t this
> >>       * is really indicative of a larger problem: the cacheinfo UABI a=
ssumes
> >> -     * that cores have a homonogenous view of the cache hierarchy.  T=
hat
> >> +     * that cores have a homogenous view of the cache hierarchy.  Tha=
t
> >>       * happens to be the case for the current set of RISC-V systems, =
but
> >>       * likely won't be true in general.  Since there's no way to prov=
ide
> >>       * correct information for these systems via the current UABI we'=
re
>
>
> --
> ~Randy
