Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7AE326404
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhBZOYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBZOYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:24:14 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C1FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 06:23:33 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id r25so9813543ljk.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 06:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oOYcT5OKcHJaHOdcT14cRM+X7PCsGLP/nAp9x9dFxLk=;
        b=Ba+92zWhTRcrtoXY8k5nboZqMyiZguX8SqCgqR8EGCirF8g3aQgz00w8TQbJBZnG+Y
         C392KLTy8zGeWMSdApvADsI0IgcYtXD/Buz/VjjCTmBbgBSWAWrz0nY4ZwtqrptAJWWg
         G5BzV058d/6EPxx5bR31uH1yTi6CLzKchwT7xlEDKtsh4OZA2N74oDEc2o2wtOMaijAw
         eo5GM6x/Mt5PeuezSZ/B11kcz27SeRe80rFjhwDV1vKbMiik7yXrorqBXNH+PuewMaSg
         RJdiWxGotr2atuD29qSZA8QTOSDBPIeh2hSC58+uVKMEd3CJObZxCQ0y1usR4d0dbFJx
         Tckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oOYcT5OKcHJaHOdcT14cRM+X7PCsGLP/nAp9x9dFxLk=;
        b=NbT1p9hBTxfEX0miSQFpZMGAv0j+8JgU6HgZZj4bSuTdSPqsM42ZSaB4MI9hFSvqFb
         9OE59GjMUO1wz48QVSVrOWFnfn3A8CDXrAT0e1fS1WsrphPuUwoTXyaWFFcveDtR1Xpi
         BchsaBKaO++C33IruJW1bn4pcoFXx4tsGCODQFw33hS/vDfU9RJTLxxLp03iUd1HC/sZ
         jbKWOAUB1WZIxhDZMsUItpEizKy3tY97l/WpHee0RaS0QTHXK15j9MrItI/3CtcElI+D
         C9Z5qDyxygGlMT+N0BTlvtfntpcbYirjypxpp/aQ5YnM+24s12WnXMsaKbl++++904UQ
         z39w==
X-Gm-Message-State: AOAM530A0PapwYH8kc2H7ArdtSalx/xZIAwW9RMfIdKEUSN1YL955CRH
        MrqcsUGQJS/e5HJjaPSF912yzcGqorGEHkA78LBt7A==
X-Google-Smtp-Source: ABdhPJw3bsYC9qSy+Bu+6SK9Aniw5/kMVL8cX63rTgEZ2wVk1XDHE7pwniMU1s7X5CCIue3DiJu/7QYODHQagRxL/vs=
X-Received: by 2002:a2e:5c02:: with SMTP id q2mr1845698ljb.81.1614349411430;
 Fri, 26 Feb 2021 06:23:31 -0800 (PST)
MIME-Version: 1.0
References: <20210226021254.3980-1-shy828301@gmail.com>
In-Reply-To: <20210226021254.3980-1-shy828301@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 26 Feb 2021 06:23:18 -0800
Message-ID: <CALvZod4eE+nD=26SY6z6G3+Lzhucu3ERG7-ufLHPtsRXvXe8Fw@mail.gmail.com>
Subject: Re: [PATCH] doc: memcontrol: add description for oom_kill
To:     Yang Shi <shy828301@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 6:12 PM Yang Shi <shy828301@gmail.com> wrote:
>
> When debugging an oom issue, I found the oom_kill counter of memcg is
> confusing.  At the first glance without checking document, I thought it
> just counts for memcg oom, but it turns out it counts both global and
> memcg oom.
>
> The cgroup v2 documents it, but the description is missed for cgroup v1.
>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
