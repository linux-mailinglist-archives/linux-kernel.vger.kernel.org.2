Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC383231C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 21:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhBWUFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 15:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbhBWUEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:04:37 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7150C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 12:03:55 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id u4so19114051lja.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 12:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hk+/E/pHN2MNjhjuZXLPTZDF0MC7khkRHQ91pJ8R/w8=;
        b=Kq/Asan3jOr5hhX3BmZWAupe4P0eKcp91aQ/WJzV/cHMe1MNSCk1c/FAELch6T9x5+
         9mxCDT8LJR22DsMYcNutnkEHutZ5NNE0YPnuFNJsfL4lg5SNXhsv6bGmL+53Q76xyknu
         1xZJs3aDZLFleuXf8y5pkC68J0Taa5je053us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hk+/E/pHN2MNjhjuZXLPTZDF0MC7khkRHQ91pJ8R/w8=;
        b=FSxCfgCx8JUUoLGCIwQ51fEs0zxnyge8Z34YwWSTC03jUxGEjW4iXWbOukdTqDmblC
         jafoxsW1PxbZ5f3VCs9OZ2clGI9SABe08Nly/7Fpd6qS1z1JsLZx4TUa6ss//x9PTXRo
         hFpoEQVuIWvG8ACqV0m8/L3DyT7dMkL2PzoKNam9wPS5Cv8tDnBV0VXbBVtewVKr/HOh
         NTOC1vGdwYBTif22SB/ejKanUiEJVr60o8GhZMFJGRZ9r/gqjfxQvOQoVsDUOyNAmTmk
         pu5Q8V6P0bVw/8I4H9eR7PIUhSgyabQzFbDz8cd5oRp733cbdZZD1wUpEU89e9+8xRYh
         tEFQ==
X-Gm-Message-State: AOAM532Lp6Hr4TbHiMUZdI1ey5bQ2Fq06kkC/RjSV6lumJs26bUQ22IM
        IikxmQb6SkVygPmLf26++K4rS40LDNr2ug==
X-Google-Smtp-Source: ABdhPJyi6fl9ujzQcypfyJbskLByfjdpzajn2X9CVQDSUywoiHUc45+o0C3JYnMd1YiP6qRLkquxXw==
X-Received: by 2002:a2e:330d:: with SMTP id d13mr17302628ljc.361.1614110634034;
        Tue, 23 Feb 2021 12:03:54 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id b25sm3114613ljk.74.2021.02.23.12.03.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 12:03:53 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id d24so13116519lfs.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 12:03:53 -0800 (PST)
X-Received: by 2002:a05:6512:398d:: with SMTP id j13mr1949297lfu.41.1614110633076;
 Tue, 23 Feb 2021 12:03:53 -0800 (PST)
MIME-Version: 1.0
References: <YDUibKAt5tpA1Hxs@gunter> <CAHk-=wipCbbXswcFvnrGae01H54dY1+XoaL+9YaiU71zGzko3Q@mail.gmail.com>
 <CAHk-=wh8vHL43v7GWK9MWrWitSmOmrEw1B0AJD9CrhBc4FvpxA@mail.gmail.com>
 <CAHk-=wiuoRKa=F3txoVHvnca+H=7gJyL3SFYwd3549v-sa0+QQ@mail.gmail.com> <20210223200130.GA8059@lst.de>
In-Reply-To: <20210223200130.GA8059@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Feb 2021 12:03:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj27tmZBzFRTZTAEPd6eRBzP5xCkQM+1cuSx7vzv8K4=g@mail.gmail.com>
Message-ID: <CAHk-=wj27tmZBzFRTZTAEPd6eRBzP5xCkQM+1cuSx7vzv8K4=g@mail.gmail.com>
Subject: Re: [GIT PULL] Modules updates for v5.12
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?=EF=BF=BCMiroslav_Benes?= <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 12:01 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Does your build now enable TRIM_UNUSED_KSYMS but previously didn't by
> chance?

Crossed emails.

This is plain "make allmodconfig", so yes, now it will enable TRIM_UNUSED_KSYMS.

This is unacceptably slow. If that symbol trimming takes 30% of the
whole kernel build time, it needs to be fixed or removed.

            Linus
