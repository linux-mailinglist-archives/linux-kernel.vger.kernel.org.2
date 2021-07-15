Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778383CAAE0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241942AbhGOTPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 15:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242284AbhGOTBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:01:51 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FF8C0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:58:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id c17so10941058ejk.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fYKgvYLgvtSQW10Pkkm7+cl/2v+kKNbnHVNtsf/foy4=;
        b=I1P8lxvHTr2xXP69nPZ/+7IW0uj06lsFuq2VivGUARKQjT/5ggKxzGM/n1ztJmatLe
         TivTuUjTr0xe94W6KYF0CnsoTjtYoNL3fhEORVO+D+sr1IcKbUeKmdOXZtn7JjWlq2lC
         ndCldBAAjucaHQaVBIzY8bnHI15b61gOPyrQBBhncKqmMeCwI1E+z6z35j/8Ch6o1yHr
         TQpeoAET9IMB86aBuFqGpt6K+m2BMNet9rvWt2Vzpk6dvEfeFR98AJ2l2qlRE7kmFb2v
         1oIBGWdwQpP0w8BVr1FVuGhlDBxr52MIK+pj93nepBC0y4FXPK4MWKHfeKBZpIlbgx2l
         zpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYKgvYLgvtSQW10Pkkm7+cl/2v+kKNbnHVNtsf/foy4=;
        b=J7eDwomrJiFWwlbl+dMdFX34nU3kdoggUVJ4z12M3f8sCOHqAHDW6nNLPQOfPelYVS
         BKgAstNYTibfG3SdF8pKNYFZ0s8C8IlaclW6+WkuH5f11gFaJwZb2D+lt25uljgcK8nj
         FoNEzos/2oKAeKnQRA8SWZGTJP0qQs3nRNlqdj6jE3tnNEt2ppVecdN9ZYiN/IGKWcPz
         DI0S5bkINDdgdDD74kC8ZDOyVujaa9r7Yp7ag0DSPdgDYXsAwMQedWUTDNGwKk5NeMI7
         3kyvUOsJ76HlbnwIjH+lWTCSVS3gv2EOQVdJBXnMFwZ/uyX9+TteUdrYBJkKzm0pYdBp
         yAGg==
X-Gm-Message-State: AOAM530BuaBoEbEu5CFfVjHhI9l26+OIkf2aX5GnFJJsX3Ra/ZwrFE/E
        YsmCXBkF9wYyUvtU7HY00xAXdXKLlTO3VCoLJSsOKw==
X-Google-Smtp-Source: ABdhPJyJb8MbkcAOF0uAQweRXiBLqmMU0tzuj8g4DHd1+KDxsnz3qffsAdA3JfM/2GRyO1QcVkQx647Qmhs6PVl7pvs=
X-Received: by 2002:a17:906:8558:: with SMTP id h24mr7138820ejy.519.1626375493122;
 Thu, 15 Jul 2021 11:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626371112.git.zhansayabagdaulet@gmail.com>
 <343394260f599d940cacc37f1dcc0309239ae220.1626371112.git.zhansayabagdaulet@gmail.com>
 <YPB7rBlU1SinK6FR@casper.infradead.org> <CA+CK2bCPMmbr+=h4evTkbJoEFQu_th_NOe0Gp11hU7xz3fLZ8A@mail.gmail.com>
 <YPB+tT0AcOB4UZQ5@casper.infradead.org>
In-Reply-To: <YPB+tT0AcOB4UZQ5@casper.infradead.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 15 Jul 2021 14:57:37 -0400
Message-ID: <CA+CK2bBqFr+_jxr2KU4DWv7GmOztfP8Lc+dKjy=YeUDvotyoBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: KSM: fix ksm_run data type
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 2:30 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jul 15, 2021 at 02:21:21PM -0400, Pavel Tatashin wrote:
> > On Thu, Jul 15, 2021 at 2:18 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Fri, Jul 16, 2021 at 12:01:01AM +0600, Zhansaya Bagdauletkyzy wrote:
> > > > +++ b/mm/ksm.c
> > > > @@ -289,7 +289,7 @@ static int ksm_nr_node_ids = 1;
> > > >  #define KSM_RUN_MERGE        1
> > > >  #define KSM_RUN_UNMERGE      2
> > > >  #define KSM_RUN_OFFLINE      4
> > > > -static unsigned long ksm_run = KSM_RUN_STOP;
> > > > +static unsigned int ksm_run = KSM_RUN_STOP;
> > >
> > > Should this be an enum instead?
> >
> > I think "unsigned int" is OK here, as it is exposed as uint to users:
> > Documentation/ABI/testing/sysfs-kernel-mm-ksm
> >
> > /sys/kernel/mm/ksm/run
> >
> > run: write 0 to disable ksm, read 0 while ksm is disabled.
> >
> > - write 1 to run ksm, read 1 while ksm is running.
> > - write 2 to disable ksm and unmerge all its pages.
>
> The document is out of date then as it does not mention 'offline'.

The offline mode cannot be set externally.

In run_store()
   if (flags > KSM_RUN_UNMERGE)
      return -EINVAL;

>
> Also, why does the call to kstrtouint() specify base 10?  If it is a
> bitmap, then permitting 0x [1] is more natural.  I would expect to see
> base 0 there.

Users can only write 0, 1, or 2, it is not a bitmap from the user's
perspective as the user cannot write: '3' . But, I think it is
somewhat weird that ksm_run is used as a bitmap internally with
KSM_RUN_OFFLINE = 4.

Imo, KSM_RUN_OFFLINE should be placed in a separate boolean from "ksm_run".

>
> [1] or even 0b, although I see that _parse_integer_fixup_radix does not
> support the 0b notation.
