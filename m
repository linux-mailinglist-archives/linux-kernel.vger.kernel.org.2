Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E95D34CDD4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 12:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhC2KTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 06:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhC2KSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 06:18:55 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C058CC061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 03:18:53 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so11783219otr.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 03:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=59bVk1U3eAVs4AcTUq5Uzd81CXfJ27eB6Tb5HoqJbm8=;
        b=O7z2KPqex9OWV7rS0vW975GuYu72swPQwIu0JStsGX+5blMKnxF4JEN969+cGkQcUx
         RRAIZCaWVM6UvKRHQZPbSAZAMbND8NkoPZj/pPMFhyPbCIod4KjhS5UC4fhJK4swTo8L
         eDRakI0I851rDSdJIeBVLxdGygwSBLJYHfMkF3i8SiQEgpgJVGIKsxXFNADOE8H2fF5L
         PARIy4Jj0eTGdOO6EJ+FeENXgGnjvxDjY27eIKTOSzZaakkWxL4PBK8iEtxg00HeeAWC
         fo6/CJzNn2hlMDiGOXpFAH/LcDvVyL7OpeoE5X3fIJ7aXM/HOL+Tc4X7VUUQBJSn5354
         g8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=59bVk1U3eAVs4AcTUq5Uzd81CXfJ27eB6Tb5HoqJbm8=;
        b=DmJyWKJpA0Q66qLJAmFYgERpgoQupHXrqvk2jZ3ZDzClSngEjQA9ed5w/azbYGpB1q
         XOVYJw5GJ/ME6q9okPx6wgZcbHb5db8Uc0rdzAkMS2t48T0K2QebvG/tTgXD5tQZ1hlT
         0nwdDIv/Py7G3N5oC097WuaRLgid/Q1WEJvdbVh2VEPjCFFjmbrFIjtID408Gdn3af+x
         CeDOvpLhaayTJsUOfCJeod1fhVTIISDfzqm03r8f2FGEMasnGe9p+Y9UNnANgSDRXJrA
         UfpYnqmYlCnyICTZPpjbmhKZW4N6jAMzfJ6a5DlOnoOnjiDnu9HGD9AEMEaiLsUhEISQ
         58vQ==
X-Gm-Message-State: AOAM5329R0QNwKGWQUEQoqIzRKfucZvVz17SXAFRbyud09oZ7fa72IcY
        I2umqx/sQktr5myouHqpipGQAa1/taL1bxTwp9/5pg==
X-Google-Smtp-Source: ABdhPJzlGZ/D+OmhIRfsTVba9K6RjVylLGLXIUf2URPu2C4G3q7Koa/dAuoNoQPZI+ZZ6IltV4gHAZx065pDvYORC7g=
X-Received: by 2002:a9d:6249:: with SMTP id i9mr22150688otk.166.1617013133098;
 Mon, 29 Mar 2021 03:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201209094916.17383-1-zong.li@sifive.com> <87v99qyjaz.fsf@igel.home>
 <CANXhq0oLxFK1431WmTj5HRO5k_omYkQZCBTG+HORTk9=W_XyNg@mail.gmail.com>
 <CANXhq0p90Cgha_zLzxamK9mxmVPn3effh_cZq_CTLrcAkKZg2Q@mail.gmail.com>
 <87lfaj7cki.fsf@igel.home> <871rc4on36.fsf@igel.home> <CANXhq0pDge0BPgAjoLrX7Y2qtofb3dhV1_CPHBaCg0o4cEMrbQ@mail.gmail.com>
 <87a6qrk2pw.fsf@igel.home> <CANXhq0rOeAWnRYHAYKJfDeY4kYz6+5mU_dJSqU67+2p9u0STHQ@mail.gmail.com>
 <874kgyfetu.fsf@igel.home>
In-Reply-To: <874kgyfetu.fsf@igel.home>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 29 Mar 2021 18:18:42 +0800
Message-ID: <CANXhq0rE-ZcPBp02Pvozpk_s-j6NhxHUmso75uz6ji9bejO8gA@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] clk: add driver for the SiFive FU740
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Pragnesh Patel <pragnesh.patel@openfive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 5:24 PM Andreas Schwab <schwab@linux-m68k.org> wrot=
e:
>
> On M=C3=A4r 26 2021, Zong Li wrote:
>
> > 1. Boot on openSUSE-Tumbleweed-RISC-V-JeOS-hifiveunleashed.riscv64.raw.=
xz
> > w/ plugging ethernet cable
> >   - It seems that I encountered a different situation with you, my
> > system hung up and I didn't see the boot message you mentioned yet.
>
> That's exactly the issue.  The process is stuck in D.
>

Yes, I could get the network problem by using the defconfig you
provided, the system hung up when executing 'ifconfig' immediately
after installing macb driver module, the network can work by only
reverting the commit 732374a0b440d9a79c8412f318a25cd37ba6f4e2. But the
network is fine by using the mainline's defconfig, this is a little
bit weird, I will check that and try to find the difference.

> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC=
1
> "And now for something completely different."
