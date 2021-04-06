Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B22035583E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbhDFPiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhDFPiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:38:51 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF77FC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 08:38:42 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id d2so13427740ilm.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 08:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JEi9pkoyq0DRGmPdjuw9UVMkgpOddRxRIDpF7zpDfNM=;
        b=V8KKchNyj4AhE6nnF7/d2L6cVqqbVOM8Tle3VwM0W5rN2GBBB/S/1hnfwOZ3uUAK26
         8BriLy45W4wsntUZainZBukhOTz5ZUS8rhLesR80oJVp/7cpZeSw4huXuY3CRh9MZH3r
         B7OMUnNSox3cOoktdiGr3JKWineXWoGIth4UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JEi9pkoyq0DRGmPdjuw9UVMkgpOddRxRIDpF7zpDfNM=;
        b=dPE7LQ9NTAxHJtGpgxCD7xFCb+DGxt3ABo35m0s7utkiXHLhe2PTlkIkbEpXDnTzRD
         Zx2cJdzcrb+4Uu1QD5bfJlbA3TkPwjO1vWWUa61w9viiuJLqPmMtk3AxynqozptbwL+y
         nmW1kqPJRHTBJyrUhMTELlLsDgyoRuDlGOSh5ofvDNRmBkTouuOClIRlEM50AeLrJONX
         MktWqi+WVTjN6KXK867r7QSVakKzjS3+CX8IH1UsU+A2bNAKRZWoKlSZLeW8xd8q5KZH
         WFfjSQuvnQJywSQrAIAHlFIDFRTWaTh4kH8dCTcJ5Xd/mkCIZH6QFsoRo/4QKVYQs6Ej
         NavA==
X-Gm-Message-State: AOAM530eW4LoeKaYfsBVYYBNVt77sfaMurCdWLFkyX2NwkyKTsNH8POE
        O+QALf0J3Jf5gFPIxEtJjOCPTImPB1cmNPd6DJFefQ==
X-Google-Smtp-Source: ABdhPJyuasAPHEnCviV1xX228L2aM9NIfQOvh6+nAE2oLo6llEE5yNzoE8dG1l35F+PCj4k7WUbbT8HhrvNHRCuHmp0=
X-Received: by 2002:a92:c9ca:: with SMTP id k10mr9629827ilq.42.1617723522485;
 Tue, 06 Apr 2021 08:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210324022211.1718762-1-revest@chromium.org> <20210324022211.1718762-3-revest@chromium.org>
 <CAEf4BzZEgHyodDqj7exrEo+eBOzHEnsvkc003vxq3dcRVZXE2A@mail.gmail.com>
In-Reply-To: <CAEf4BzZEgHyodDqj7exrEo+eBOzHEnsvkc003vxq3dcRVZXE2A@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 6 Apr 2021 17:38:31 +0200
Message-ID: <CABRcYmKUQcRjQhLgpM6pb4oMWCB2=ov8iL1prxn3B54Or=aC=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/6] bpf: Add a ARG_PTR_TO_CONST_STR argument type
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 11:23 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Tue, Mar 23, 2021 at 7:23 PM Florent Revest <revest@chromium.org> wrote:
> > +
> > +               map_off = reg->off + reg->var_off.value;
> > +               err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
> > +               if (err)
> > +                       return err;
> > +
> > +               str_ptr = (char *)(long)(map_addr);
> > +               if (!strnchr(str_ptr + map_off,
> > +                            map->value_size - reg->off - map_off, 0))
>
> you are double subtracting reg->off here. isn't map->value_size -
> map_off what you want?

Good catch!

> > +                       verbose(env, "string is not zero-terminated\n");
>
> I'd prefer `return -EINVAL;`, but at least set err, otherwise what's the point?

Ah yeah, absolutely.
