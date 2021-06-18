Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1D63ACA7D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 13:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhFRL5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 07:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhFRL5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 07:57:37 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB006C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 04:55:27 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id r5so16274052lfr.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 04:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fg1RaSfJDnm+oFtJenKoerkLiZFE4+FFve2MWRbIPq8=;
        b=bGQXWrnHAw1dakSzFzG5w7YPvMRPK9n8R/oUJRdledAo8ktrfduPjgMISVi3LoBaeG
         +EueV/nflnH1P+4IwWVq9+ujSipihpmCmo0KDG21JEepFJEnobIaM6mx6BFrpSdlO41l
         jxhrvk8kcf+9SZMZ8H6gLUdi8XZxJnZXs8ajg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fg1RaSfJDnm+oFtJenKoerkLiZFE4+FFve2MWRbIPq8=;
        b=LaviOpsRfYtlbis5IygheFyUhUtvq688gzBpwVo1FtkbP4gRJ2MBxwYWODVIC3bscb
         B+IYbMPrk4U+jyejWVkNf7sAFvy7e+szUi9bSPiYOFUJp5oGTec5xUgDeVcQSRAB8OR6
         4yHeVGBzOrwxeIjCTGptxOywbqFLUwULO13Yjbyr7JhItClVkKI8AfuiWSjUwqOSD+Zz
         Vrjigjj25sCXtjgjoTzzpX7hZ6Abc8qvxoKQWD/Qe6m6gdGxhNW5mu9hqxvKVfMSZF7u
         NkXYjdFUwDl/EZgzh1huUl9IJ9+In0s7kpwZIVm2F62zbjrxDmgfPDn0vaTjhjOcf1JO
         jHWQ==
X-Gm-Message-State: AOAM531KMNKcZn49MxcyO7Mu5XAtJNznUC/6++vtwe6QDCfmgNnrtxhr
        SxrOABjY+/SRCRnLyBlovj25rLdbWyRjSZNFhg37/A==
X-Google-Smtp-Source: ABdhPJw4CWOVaHmFZ3AuD2s4gaNo5WYGPUvf+kj85rPKZB69FqZZP+Sals7L7eZVEX8geQssux/6sONgBJay+iD3YsM=
X-Received: by 2002:a05:6512:a84:: with SMTP id m4mr2849723lfu.451.1624017326050;
 Fri, 18 Jun 2021 04:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210618105526.265003-1-zenczykowski@gmail.com>
In-Reply-To: <20210618105526.265003-1-zenczykowski@gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 18 Jun 2021 12:55:15 +0100
Message-ID: <CACAyw99k4ZhePBcRJzJn37rvGKnPHEgE3z8Y-47iYKQO2nqFpQ@mail.gmail.com>
Subject: Re: [PATCH bpf] Revert "bpf: program: Refuse non-O_RDWR flags in BPF_OBJ_GET"
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BPF Mailing List <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Greg Kroah-Hartman <gregkh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 at 11:55, Maciej =C5=BBenczykowski
<zenczykowski@gmail.com> wrote:
>
> This reverts commit d37300ed182131f1757895a62e556332857417e5.
>
> This breaks Android userspace which expects to be able to
> fetch programs with just read permissions.

Sorry about this! I'll defer to the maintainers what to do here.
Reverting leaves us with a gaping hole for access control of pinned
programs.

--=20
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
