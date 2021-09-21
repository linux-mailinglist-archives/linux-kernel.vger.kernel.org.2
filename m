Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99ED14137E4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhIUQ6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:58:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhIUQ6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:58:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70EEE61166
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 16:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632243413;
        bh=J7E4FBmYmH0HVLt3kPf4SSEkXnLkQVeBCOP6qehoNYI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KHcT9SHYln3THAF/JYB+Y5sW3nsdmaWlgBC76YJhWJ7X8Ul0ylG3EuK1fZUonVkBS
         KpUS52dinhtTRILxjWYP0timGRGtuUDWjWdpujW50vfs00F3/xOc7k/cVBNe/Cxm39
         ChoU7qcKG8BRIw0XoJE+XF8/Nd/IRN54zpTC0WRGaPy6pf5onHQ4enxmbrdvy36mTr
         /4lbf7+FgBi9DzFCI+sJatC7v6SnjGidJodgh1fZKq56dvgUU/TxjGSkPt8WAc/Hcz
         750V+ICDPOhXC+AAyAeCMjzVgV2Z0t035+yQQiGbnetha5lsYilWjAGl2YWZv+PVGm
         4lNLstR3J0img==
Received: by mail-wr1-f51.google.com with SMTP id t8so41256973wrq.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:56:53 -0700 (PDT)
X-Gm-Message-State: AOAM53175wXBbqXJX0SrDzS4sAqdvLXyjUdRkWqCDJ4QCYf/wWrvsntk
        HsC7RKR37Zai7/ihW6zGl9fuKF/b012wqCoXw1Y=
X-Google-Smtp-Source: ABdhPJwg6ndiRH+dpHqZGBqlwHoo4aB9n94p9JO6kk9H01MHv2k5Dayi4DcgcR2R3hKcb70YroOIO2G9kVCpyKgHKn4=
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr3508389wru.336.1632243412016;
 Tue, 21 Sep 2021 09:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210920121208.54732-1-arnd@kernel.org> <CAHk-=wi=CZ_fsUwDQCBbgPB4MTFx1ywgyERjFb7DNUk9Pix_Nw@mail.gmail.com>
 <CAK8P3a03VTsdALMORVSWvAY9J8dS=wQjvhf=M0hXGqLLxDYHsQ@mail.gmail.com> <2955101.xlVK0Xs8nM@alarsen.net>
In-Reply-To: <2955101.xlVK0Xs8nM@alarsen.net>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 21 Sep 2021 18:56:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2GMxz_YdFO4BbqD3hDWtbcPxKWvBR9TqmOdzCw6dPkwA@mail.gmail.com>
Message-ID: <CAK8P3a2GMxz_YdFO4BbqD3hDWtbcPxKWvBR9TqmOdzCw6dPkwA@mail.gmail.com>
Subject: Re: [PATCH] [RFC v2] qnx: avoid -Wstringop-overread warning, again
To:     Anders Larsen <al@alarsen.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 5:16 PM Anders Larsen <al@alarsen.net> wrote:
> On Tuesday, 2021-09-21 10:18 Arnd Bergmann wrote:
> >
> > I'm using the gcc-11.1.0 that I uploaded to
> > https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/11.1.0/
>
> I don't have that compiler version, so obviously I couldn't test if the patch
> solves the problem.

To clarify, those cross-compilers are meant to be usable on any
x86/arm64/ppc64le distro from the past 5 years, and should allow
you to build kernels (but no user space) for all supported target
architectures using all supported gcc versions.

I'm not asking you to waste time reproducing the problem (it's already
solved now), just saying you probably could ;-)

       Arnd
