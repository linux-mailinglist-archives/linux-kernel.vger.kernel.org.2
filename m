Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AA932B70B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356936AbhCCKsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2361103AbhCBXV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 18:21:58 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28553C061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 15:21:18 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id i14so2952275pjz.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 15:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=/fnSRHcpZD0qpng7JyEtdVj7W482KqkR+RJHHplJhM4=;
        b=LMSdseCbBy9ToXdWDq8iiB9HmAgjz3t4ZxvtOLzUbyLE7Pxg7kmBA5tQAe5zMVYBhX
         Z9VsknD1Yr5PTDhFA9clnJYKElA2duw9RqsfMH23L+SsTpydkXy/hjWlS5Q/CPNG2PKa
         RY0ul5xZDJIKXEBvXqSH3S67g7vPwDARCeeLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=/fnSRHcpZD0qpng7JyEtdVj7W482KqkR+RJHHplJhM4=;
        b=FJyRNgYk/D4XIjXD17/uu7NMEUuvS5AjCusu1V0wDJdkTEvGhfrrtxmxxSJ/aNxjIX
         vhGNOdNQdMtTKJEuczDS676AbpMt13NAJqXcnOSf11fJjAaZ141S2dFbmTC5q0mFPP8b
         tCwQmCh3x1Ow6l7veIw/F1OeNX/C0fawdjNYgkA4EB1yBHg4gkN+YwoAhxhilz68/7bf
         3eAuJvTPwZh7R8phVa2TSkmTqwNImWo/+3nSnFWa59CUQUUdjZCpL2A/oEraDmIlT3h/
         BLwOyqQ2m7ikq1UBVwiG4JnzcvVESX4hZmV/SmzA0OzZ3QVs6+z3f4lNVzVaZWuwzpoi
         5sGg==
X-Gm-Message-State: AOAM5330EW0Wo/MSLkPOgTgDStAk5rJAoEqJD3TztaVqMYZrmD6aJblR
        5Z67wfVxUosV4M3X07KYO3kvFtyIFFC1iw==
X-Google-Smtp-Source: ABdhPJwos7Jp751+K7me4BeRQAnfJ09F778UhQDl1o3HpAwJQtI06/WrlKnad31fCTGW5LVtzzlqTg==
X-Received: by 2002:a17:902:a9cb:b029:e2:f64e:b778 with SMTP id b11-20020a170902a9cbb02900e2f64eb778mr5541383plr.39.1614727277667;
        Tue, 02 Mar 2021 15:21:17 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:2510:ab07:78a:7d78])
        by smtp.gmail.com with ESMTPSA id h20sm21678426pfv.164.2021.03.02.15.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 15:21:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210302081909.GA28599@MiWiFi-R3L-srv>
References: <20210301174749.1269154-1-swboyd@chromium.org> <20210301174749.1269154-8-swboyd@chromium.org> <20210302081909.GA28599@MiWiFi-R3L-srv>
Subject: Re: [PATCH 7/7] kdump: Use vmlinux_build_id() to simplify
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Date:   Tue, 02 Mar 2021 15:21:15 -0800
Message-ID: <161472727569.1478170.5291979496668341424@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Baoquan He (2021-03-02 00:19:09)
> On 03/01/21 at 09:47am, Stephen Boyd wrote:
> > -                             note_sec->n_hdr.n_descsz,
> > -                             BUILD_ID_MAX);
> > -                     return;
> > -             }
> > -             n_remain -=3D sizeof(struct elf_note) +
> > -                     ALIGN(note_sec->n_hdr.n_namesz, 4) +
> > -                     ALIGN(note_sec->n_hdr.n_descsz, 4);
> > +     const char *build_id =3D vmlinux_build_id();
>=20
> It's strange that I can only see the cover letter and this patch 7,
> couldn't find the patch where vmlinux_build_id() is introduced in lkml.
>=20

Hmm not sure. Maybe spam stuff? I will Cc you on the first patch for v2.
