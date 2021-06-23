Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEA03B1CF1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 16:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhFWO62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 10:58:28 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:53757 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhFWO6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:58:25 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mtf39-1l7o7t2Jpv-00v3oc; Wed, 23 Jun 2021 16:56:06 +0200
Received: by mail-wm1-f52.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso1448502wmj.4;
        Wed, 23 Jun 2021 07:56:06 -0700 (PDT)
X-Gm-Message-State: AOAM532xvIJkbLxPQbRvFV6a2qL37FEe2CT3GZO5y8gwT9msTlX7Shux
        isbro0puFKX4Hv3fWqcpqbioP8Okt2AvU2NQzyA=
X-Google-Smtp-Source: ABdhPJzafhhjEf8nSk8niHtzMDWxxzI15xS2dnjYEimcvuPJ2y5V0ClCeBL7TZnyk7CcCJXbfzqrdRkOkr5XcD2joZc=
X-Received: by 2002:a7b:ca48:: with SMTP id m8mr11269137wml.75.1624460166162;
 Wed, 23 Jun 2021 07:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210623141854.GA32155@lst.de> <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org>
In-Reply-To: <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Jun 2021 16:53:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a28_0KJpcLRQrDhFk8-ndxmfk7-Q2_qcRRiYkyh-NNZUQ@mail.gmail.com>
Message-ID: <CAK8P3a28_0KJpcLRQrDhFk8-ndxmfk7-Q2_qcRRiYkyh-NNZUQ@mail.gmail.com>
Subject: Re: how can we test the hexagon port in mainline
To:     Brian Cain <bcain@codeaurora.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sid Manning <sidneym@codeaurora.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:P63oQCUbHVtfb+9EYH9S8LE915vQq+Uh3T2gYiv1fbohIdod2p0
 cdJzSFrVseF2tsdEfbq6ad+1gC0ClftFTjp+aG1hIu2ymYdCkjZlh1UCdntRiCAm8a9vNCT
 E0ivPTc/1RTfiuQ1jK2L1At1ElgbETpU54nmYCCCODI/TN48lsfBzYnn51PpmioWb1ILonX
 7cbFPwiiaL7VmK62vd6Vw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:s/SjI0iK2Bk=:jl1inrr8N+HL91zzM0uggG
 ngcAs8mlNKF+sHvhagcQsHQPTMxrgNYk4InmPpz6Ia73LtvRfdTSkTo9fDKBBtKVQ2djHgwax
 rob5n/5MH5PsYPHH9T/oNj9M4Ptt3+ROKh+rlK6VZw7hKlAz1rQ+HlJqnPZbxPQd7/n7RZC27
 8A6DOX+NOE1zn6Hiqw1c5DGTlM9IZkGd1wkW/h/9EsOhg2fuCZl+uJbVhmwcdCYGTnJfNWIUO
 FvooZaaFNh2Fzj0D0sRh35rgq8i/bvEfu2gxklQWU56f6LDmcRehttP8gE7jJj4nKljw8FQ4L
 fKusOGf1ZOn+js05Xm94GZu0FsfTKzzrMY11uVJyxe6ZuNxVKpsA9U5QOJk4hvgfYhryMlrZ+
 4qMepfsj67AqZi/xvlX+utRxo8I1Zk8MA6iIm7qdqwMbzm5rOnJ9/7pjX/Uz6dXYSlkbsCNNa
 pPZJoPqIpZN0Fhk2/3hZTfxA/fJaHEs3u+OQp47qIcXO+rGCnPuwwxDMYtnY/TkVh3CPYj+4I
 iIypXQo7Blim7pi8iCLa14=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 4:39 PM Brian Cain <bcain@codeaurora.org> wrote:
>
> > -----Original Message-----
> > From: Christoph Hellwig <hch@lst.de>
> ...
> >
> > Hi all,
> >
> > the oldest supported gcc version in mainline is gcc 4.9.  But the only
> > hexagon crosscompiler I can find is the one Arnds website points to here:
> >
> > https://mirrors.edge.kernel.org/pub/tools/crosstool/
> >
> > which is a non-upstream gcc 4.6.1 port.  How are we supposed to even
> > build test hexagon code?
>
> We have provided a clang-12-based toolchain here:
>
> https://codelinaro.jfrog.io/artifactory/codelinaro-qemu/2021-05-12/clang+llv
> m-12.0.0-cross-hexagon-unknown-linux-musl.tar.xz

How close is this to the mainline clang builds from https://apt.llvm.org/?

The last time we talked, there were still a couple of bugs that prevented
me from building an unmodified kernel with an unmodified clang toolchain,
but I think you planned to address those. Are any changes left that did
not make it into the 12.0 release?

> Could we update https://mirrors.edge.kernel.org/pub/tools/crosstool/ to
> point here?

I'm happy to edit the index page on
https://mirrors.edge.kernel.org/pub/tools/crosstool,
but could you provide a stable URL that will keep pointing to the latest version
in the future so I don't have to update it for each new build?

        Arnd
