Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573F54002DE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 18:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349786AbhICQFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 12:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhICQFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:05:24 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F8BC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 09:04:24 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id u21so4906149qtw.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 09:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oFByfckPed0afqM3C5lA3YeO4bgypLoOuCHr02h2KGs=;
        b=Y+80ODUmlFRTJ6E7M/b3i+RtBRcQMSS0W+KX55JJy/98Ozw73nOUpKIr2yHeZvq1sh
         Bud1M8TtzedFk6zt4AyFMVOS60QC8yEZGqxCMvSkQkIxGYD2Py9joIwi8XZkPa5ubbgX
         ZOKYAFmegEL5DU9kAKc61b6wiy4Itk+8gT1mxSKV3WGR208/qVoMIU9tx86MzUC0IA3Y
         PwfyIJkDCiCbsHi0O1+ianhYfCJ6WZlxm1Ttk4qYHl7hE9sruWQgY9/uerlWkV2FZFYO
         VtzGMh1/dCQ20SKxBc9EbWoyDREeKJJ5h0wP/zjv2JPMWbs+iQnbq3nlLLMLvevKtvm9
         ptpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oFByfckPed0afqM3C5lA3YeO4bgypLoOuCHr02h2KGs=;
        b=UxfxQJN8mqPcOb/NgaFe62xAVyV+kDm8/Q5YfBef/nFjlRvdci6UVyf0m3t/lIGOok
         voRKyfzroWFsHyuwBfBYY56A9pdKdYdc681B/aw/jC5LgD2xcavxGJvnwe/rhHXWRpHG
         5fq+o/+4osxPr3krp6X2EgVH50X66OHfXiW3r3ZTnMu9/tJkUcKtP+N4/eYV72UAlMLs
         a13oABMoy4rmwDvt+TTq4F0+Qy1oO2GrGjMFvwXoJNqXh3t+wolMGYOGmzWYz4DtPC5d
         3H+CXOfIrPZUh0Plrk1IRkh/d/hAxM+JU18Qo+dDT7FT7idjP9x/J5XgqEVXR2QyatFz
         N7oA==
X-Gm-Message-State: AOAM533ZKZIiA2gmnj5pvasnJPKZeEJIcQbitZM/g/DM0+ag/4W22c4K
        JSGx+CDkolnK4T+4TT78F86GTu9kdTYS6wC1iD+Hqg==
X-Google-Smtp-Source: ABdhPJzmqbCkxAWqGWaVPB9odFokgqPNK1GvNBIdAJ7sdCEnbCAeahVsBhtLIzRerq5Wyw8YU3BIZpiturv5Rttr4/I=
X-Received: by 2002:ac8:51cd:: with SMTP id d13mr4470222qtn.49.1630685063087;
 Fri, 03 Sep 2021 09:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210902000154.1096484-1-imran.f.khan@oracle.com>
 <20210902000154.1096484-3-imran.f.khan@oracle.com> <85f4f073-0b5a-9052-0ba9-74d450608656@suse.cz>
In-Reply-To: <85f4f073-0b5a-9052-0ba9-74d450608656@suse.cz>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 3 Sep 2021 18:03:46 +0200
Message-ID: <CAG_fn=Wvt8ZNx6kS4sn5660AFkHoVVjvurz7jhE6aw3tzZY8+A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] lib, stackdepot: Add helper to print stack entries.
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Imran Khan <imran.f.khan@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 9:55 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 9/2/21 02:01, Imran Khan wrote:
> > To print a stack entries, users of stackdepot, first
> > use stack_depot_fetch to get a list of stack entries
> > and then use stack_trace_print to print this list.
> > Provide a helper in stackdepot to print stack entries
> > based on stackdepot handle.
> > Also change above mentioned users to use this helper.
> >
> > Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Alexander Potapenko <glider@google.com>

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
