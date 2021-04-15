Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CF73604D4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhDOItE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhDOItD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:49:03 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97302C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:48:40 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id s16so18196203iog.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IGpQmD8z18WLh24i3s/c04WSZmqln4MYd6I/+Ba9nTk=;
        b=gZmtcy+eX8ObZZFLaI6Ns1fmn0cWQTW+BKgfKD2iXzO4w/C5K8rsNDtwtLkCavP3Jd
         XI6AbAqT0Fse4062/D7Wo1yf+oCuoc4Rc+zkovlGQZlYwQx+XKdzAuLLjULdDdiBJQio
         egMdgYlBdh/VL7LGQc2JWLukOLfJCp71p+tuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGpQmD8z18WLh24i3s/c04WSZmqln4MYd6I/+Ba9nTk=;
        b=lW9rRW3bGm522C1FcBmQsB2jsmGtxmbwkWbq4gQLthipyReo/MccpN1RcBxYhhd5Vv
         mG5rzXUMWJbku5yVP49d/Tfmz/rxmb1wC0jQRr0e4lEjos6QGjieSrribvlvedw/PGNO
         hEsa/bCs7IQcJ0XYMLjblW3PqA/888cFYWaTMP35y4/HfjG1nykWb4eyGJzSzuZ+9mRD
         qamw/HoKMrpe/IjTAsyTCGImq8KAj3XhpMXR+29fg7iJE4Udo9IXF31oUCKgD73q/37v
         p/2sHUxMTovv8EZRdktb+eZn6BMGxiAv+jHRhCVQhewL/T01GOmDcuD7DeKF9Uwz3tBx
         rbGA==
X-Gm-Message-State: AOAM530j7WBfKWaC1UsRu0pdkoiJ9uEuopHDotSez0yRJjSldCVQihBU
        SgA6v5MnJGezWnw9xAFWoVwIPgBuhCrCIW4FVrG+1Q==
X-Google-Smtp-Source: ABdhPJyqiY4Ia67vLGdEOkZLYYDMrE5kUb0hhhGrkKPhlpv+wW/ourPqX/Ka+p/fjnaN28eLFO88M6YcfUQIeYfxDnw=
X-Received: by 2002:a05:6638:2515:: with SMTP id v21mr1942822jat.110.1618476520114;
 Thu, 15 Apr 2021 01:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210414155632.737866-1-revest@chromium.org> <20210414185744.y6x4pmnkqph5tmnb@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzYT6mvExWGKGBgrfJP9FCWc9uzcYK_mh5_-ZTUYAATZLA@mail.gmail.com>
In-Reply-To: <CAEf4BzYT6mvExWGKGBgrfJP9FCWc9uzcYK_mh5_-ZTUYAATZLA@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 15 Apr 2021 10:48:29 +0200
Message-ID: <CABRcYmLdJoHB5tYsAV+huToqh0d1p5LhusQRNgrVRVNgobjkjg@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix the ASSERT_ERR_PTR macro
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 2:28 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Wed, Apr 14, 2021 at 11:58 AM Martin KaFai Lau <kafai@fb.com> wrote:
> > On Wed, Apr 14, 2021 at 05:56:32PM +0200, Florent Revest wrote:
> > > It is just missing a ';'. This macro is not used by any test yet.
> > >
> > > Signed-off-by: Florent Revest <revest@chromium.org>
> > Fixes: 22ba36351631 ("selftests/bpf: Move and extend ASSERT_xxx() testing macros")
> >
>
> Thanks, Martin. Added Fixes tag and applied to bpf-next.
>
> > Since it has not been used, it could be bpf-next.  Please also tag
> > it in the future.

Sorry about that, I'll make sure I remember it next time :)

> > Acked-by: Martin KaFai Lau <kafai@fb.com>
