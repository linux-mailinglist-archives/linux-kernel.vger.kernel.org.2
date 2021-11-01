Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00491441BD5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 14:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhKANlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 09:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhKANlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 09:41:44 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB6CC061714;
        Mon,  1 Nov 2021 06:39:11 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id m21so17172638pgu.13;
        Mon, 01 Nov 2021 06:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T1SuG6omwX4jHf9ObVREsw81tCKAtJ4gq5pIVSAuqKs=;
        b=gx/1SnU1oprmoKv/Cn7RmkU2CQ8NbIG4ajuuhiJSFuHoo4GILmh5jTtyy4R5Zt3zRG
         /jkyNNVoufEhV+GDKgba+K493UCo5gq1o+5Y3L2qeJ83lo6bo+27+FO8poE+9cUlJoOP
         r6QhXVaeFwLnQoqL3FPf3aMUt5KCvwJjUfkoeCVeqGPmvl02V9NC+YlaZ9EXzlDZluUQ
         HFZBxUF7BFn/uulob18GrKsyRjcjH9J7IcqyDbu3zpcWvqmXZwybFgQXVAO1OAAVKORm
         wig6eEImQbkL02q0XOAzzHpXIYG+MyzUGLlPGcEWATfgUe6cU+MXpo+RNcZ8AnPDKG2P
         giKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T1SuG6omwX4jHf9ObVREsw81tCKAtJ4gq5pIVSAuqKs=;
        b=nYDCMw0ZCBJ7jpHRCLUUw6w0CP530Sz6zit89Sw69LPWvEGMSbKAimdqGwVDHYoJun
         2GacWGbbweSRQNMlL1/ax964PDth38AZp9l3iUl5a6hzTA46Tjtp363qXLfPxQUqp24l
         50KcYeWhXR3xKwzc7nvwY6kgi+qrtzGN84IS127kMrbdYz7JKjK0qhHFbZUU0WNU7SOm
         82XsJbyAIhjZqG8gNE/SSwpHVqapnLCP6SnGx25sCRpS/VBNmd7tvgdME5fvwZwZyYYV
         n/Mf0bdhNSJ2qWC8wFT6h0Iif+/Bgm3yhTJs7XY4m+AuAYTOBumcGzgHLmzfWNCCxhMH
         SqcA==
X-Gm-Message-State: AOAM532ci/z7+ULBhv+Lc2e3STS4LjqAS79u++/q4RWQNxrvTuKbT+Ov
        lKpl9wa0xKWGnn8ldxT0pvj+dZZL8PLKpVczhFZA36eYe/c=
X-Google-Smtp-Source: ABdhPJwC5ZJWwaaUwsKGZKVeTjDGF2qlmYMsxUwjkqc7gO6VNVyx3bO8F9LFNM5BqR7qH7iomvFvZjfKJgr98OPgN6o=
X-Received: by 2002:a05:6a00:1681:b0:46f:6fc0:e515 with SMTP id
 k1-20020a056a00168100b0046f6fc0e515mr28551253pfc.11.1635773950511; Mon, 01
 Nov 2021 06:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
 <b22b772c23f531708a9bc025d56c0312a53bd6c9.1634630486.git.mchehab+huawei@kernel.org>
 <878ryosocf.fsf@meer.lwn.net> <f0269915-4863-9ed6-dedd-592f2e308f46@redhat.com>
 <CAJy-AmnHht4=sNyQ5r78MwfOpMF8dRqrct8fasVX-ULadfMNvg@mail.gmail.com>
In-Reply-To: <CAJy-AmnHht4=sNyQ5r78MwfOpMF8dRqrct8fasVX-ULadfMNvg@mail.gmail.com>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Mon, 1 Nov 2021 21:38:59 +0800
Message-ID: <CAMU9jJoSVeXThH6vKjKKEvrMQ5f_Yu7Z9PD99Oxk1-MHVLLb5w@mail.gmail.com>
Subject: Re: [PATCH v3 16/23] docs: translations: zh_CN: memory-hotplug.rst:
 fix a typo
To:     Alex Shi <seakeel@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wu XiangCheng <bobwxc@email.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Shi <seakeel@gmail.com> =E4=BA=8E2021=E5=B9=B411=E6=9C=881=E6=97=A5=E5=
=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Oct 20, 2021 at 3:08 PM David Hildenbrand <david@redhat.com> wrot=
e:
> >
> > Dumb question that probably has been asked a couple of times already:
> > why do we even maintain a translated doc in-tree?
> >
> > Every time I do an update on the original doc, I for sure can only gues=
s
> > which translated parts need updating. And I really can only update when
Dear David

Thank you very much for your contribution, in fact, we are always updating =
the
translations and improving the speed of the sync, so If you are not
good at Chinese
and want to get the sync faster, please CC us when you send the patch.

> > "deleting", not when rewording/adding. So we'll be left with stale doc
> > that will have to be updated manually by $whoever.
>
> cc to the translation maintainers and translator would be helpful?
Alex,Maybe we should provide a translation guide in English, e.g::

  Dear developers, if you have trouble updating the Chinese documentation a=
fter
  updating the original documentation, please CC the translator of
that documentation
  and the maintainer of the Chinese documentation, and the relevant
documentation
  will be updated soon.

>
> > I don't feel very
> > confident about this. No translated doc is better than outdated
> > translated doc.
>
> Uh, I don't know other languages, but in Chinese, 15 years before
> translated books are still selling well in China. :)
> https://item.jd.com/1075130482.html  ->  Linux device driver
> https://item.jd.com/10100237.html  -> Understanding linux kernel
Yes, I just bought a LDD3 last week.! >_<


Thanks,
Yanteng
