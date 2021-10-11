Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E21429A03
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 01:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbhJLABu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 20:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhJLABt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 20:01:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AADC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 16:59:48 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id c16so25202058lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 16:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OgVSO9l8+qaj3s+luNrigHMuS+kRVTnezRpRHPjbW94=;
        b=DKTICZkUM6+mQG0DkILdTYZfNfrDqAhQovODFervf5Lp8oEVb8SilHueb0cyn8u/xv
         XjaotArwSiIRg2V2JD0UdseT1WBdQdkROwO52I5s0Do4CGlHHCCiAQXRoQiTuYhiPvbW
         Ui91qkKHYi4ttDBdjPrMIDhbomocs37Ov8yPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgVSO9l8+qaj3s+luNrigHMuS+kRVTnezRpRHPjbW94=;
        b=yaimWrForwip93/Cnp3bpyb/tXTC0QRD0igi6DgTPrDUdCCYmcr9WunSM3pcWy+gFO
         g0nnMElzF5WvRQ0REjf3w8veZIxroTSm9CWRvXFU7mqeqTLsA30pC5fpFb3nzuNd17GC
         pRqH0qOki7/qxrjSdKexvKyP22NNLD+h4m9VkIJKtfPW0UhdAEy2/+HLa5YSVJHFBld8
         Q3Ned9s3LhldihoC/j7pEoaLvdocpQyJhtDwkJp1oZxm+/hz21/xNitrBmOvVBFX8PoG
         xASL68G1A58XC3/85rhNJY6o1mUdaqxARNFAZpoj5A7CSvG48pwTJpd40dyhDwMEnMxO
         dTcg==
X-Gm-Message-State: AOAM530G99/g4jIyFbLHoqme83OMu+tOncmMuykdB/UwdeOSQds7CSTX
        RqH769cFBQ+JXi2Afq5gE0pr6nQSKj5EqakR
X-Google-Smtp-Source: ABdhPJzUVuLyYhRhhrCHRGUKqLho4/6nq7QxjGb11AIDoMrC6Yddg1wDs0dWzPJU44nDJC6NXDQOLg==
X-Received: by 2002:a2e:a303:: with SMTP id l3mr18799740lje.242.1633996786067;
        Mon, 11 Oct 2021 16:59:46 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id e8sm861910lft.308.2021.10.11.16.59.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 16:59:44 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id r19so77511482lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 16:59:44 -0700 (PDT)
X-Received: by 2002:a05:6512:139b:: with SMTP id p27mr30802647lfa.173.1633996784057;
 Mon, 11 Oct 2021 16:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh5p6zpgUUoY+O7e74X9BZyODhnsqvv=xqnTaLRNj3d_Q@mail.gmail.com>
 <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk> <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk> <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSqOUb7yZ7kBoKRY@zeniv-ca.linux.org.uk> <YS40qqmXL7CMFLGq@arm.com>
 <YS5KudP4DBwlbPEp@zeniv-ca.linux.org.uk> <YWR2cPKeDrc0uHTK@arm.com>
 <CAHk-=wjvQWj7mvdrgTedUW50c2fkdn6Hzxtsk-=ckkMrFoTXjQ@mail.gmail.com> <YWSnvq58jDsDuIik@arm.com>
In-Reply-To: <YWSnvq58jDsDuIik@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Oct 2021 16:59:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNWOY5QW5ZJukt_9pHTWvrJhE2=DxPpEtFHAWdzOPDTg@mail.gmail.com>
Message-ID: <CAHk-=wiNWOY5QW5ZJukt_9pHTWvrJhE2=DxPpEtFHAWdzOPDTg@mail.gmail.com>
Subject: Re: [RFC][arm64] possible infinite loop in btrfs search_ioctl()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 2:08 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> +#ifdef CONFIG_ARM64_MTE
> +#define FAULT_GRANULE_SIZE     (16)
> +#define FAULT_GRANULE_MASK     (~(FAULT_GRANULE_SIZE-1))

[...]

> If this looks in the right direction, I'll do some proper patches
> tomorrow.

Looks fine to me. It's going to be quite expensive and bad for caches, though.

That said, fault_in_writable() is _supposed_ to all be for the slow
path when things go south and the normal path didn't work out, so I
think it's fine.

I do wonder how the sub-page granularity works. Is it sufficient to
just read from it? Because then a _slightly_ better option might be to
do one write per page (to catch page table writability) and then one
read per "granule" (to catch pointer coloring or cache poisoning
issues)?

That said, since this is all preparatory to us wanting to write to it
eventually anyway, maybe marking it all dirty in the caches is only
good.

                Linus
