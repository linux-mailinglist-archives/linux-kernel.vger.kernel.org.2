Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BF0365D5D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 18:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhDTQ27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 12:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbhDTQ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 12:28:58 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A633C06138A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 09:28:25 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id s2so12241841uap.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 09:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q+XSOjXPKQeUlfip/kcHH5wP/0vJ0tXFQPSgekpaeio=;
        b=coPhDDfdhLVpvR7Sd3C8EQwSfM8DeWRGPSBQtm3iJSqbK2JAemnEnMTu349XXh1Ijp
         EG7j9JOrESjtBvSJXSTw/id9jbPxr1W0ESvOTwhBRs32bj2mR3ZEdSM6k/xam3bD2H+N
         q2Zfk08XW7ksj7+GdVyP/RW41mYQ3irD2VX3eIm3urrQukdnFr67wxXzdJ1m5y7mv+Gz
         mBkBMPu4eTZYWsorEhLQVfKl40dmt8JPsFaEgyYRJ+3lQ2rooERYw9kfQjFDwGCKSO0v
         U4cfcQrQ2WzJZJrWoCrvUW4BdYeCMtTX2sf7OJvA8GCeyCxfSMHcjtF/8996HDhhzSw1
         sCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+XSOjXPKQeUlfip/kcHH5wP/0vJ0tXFQPSgekpaeio=;
        b=gqbpLMbvjRQHjhtJO5Xj9cKLkiI4xpa5s9OBwE78V2T4F/8Gwa2c+ydpixIcxKjKT0
         RlrKtbRK776Yb36HKu/jxKz1GK4XKQ7srF5+88ZSw8wQ+svcYsmwV3yNcLI410/Gas+d
         oFViTvonPkdyg900eosLZXFC0n5ByAlq9PgJswxjLpfov7BxbZlZ3bRQBQ0SBls7as4s
         +zBIiZ7Bdg3VpnhMY0oC65Sl15MkDPM1yKztzjXnSYi3mWXJ0O1ch5WHF+1dVPow3JmT
         9hzMQ+PWG+wpDYr5e06GMjrx6VvHCLiJJ0/H/s1Q9H7zWuDjU4HL2MzR6WpKK6qbCR/b
         v01A==
X-Gm-Message-State: AOAM5306ExPEVR5GXcoUrY+V/Mo5237mIBUAwFwoIVYxfXjnSwfUHtNq
        8JMk7OFB+diUxw3rgoi2zcy8JC/tLF9jDT0ZlFm3Aw==
X-Google-Smtp-Source: ABdhPJxqBV+1Z2yG4hPseFOhFrLCyJCDrD4+rW6KXFwKw4k5lbW1Fsw3IVfZ2+KnYax4i75I1zlV6mt/WivYRluCcM0=
X-Received: by 2002:ab0:1e06:: with SMTP id m6mr13583365uak.16.1618936104252;
 Tue, 20 Apr 2021 09:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210416194709.155497-1-egranata@google.com> <20210420070129.GA3534874@infradead.org>
 <20210420060807-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210420060807-mutt-send-email-mst@kernel.org>
From:   Enrico Granata <egranata@google.com>
Date:   Tue, 20 Apr 2021 10:28:13 -0600
Message-ID: <CAPR809tz_2yVvvYUhx629wFJA-+Z67Xx7ZAxNkcwRQbXMm8zvQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_blk: Add support for lifetime feature
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, jasowang@redhat.com,
        pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        axboe@kernel.dk, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I prepared a proposed patch to address these concerns:
https://lists.oasis-open.org/archives/virtio-dev/202104/msg00007.html

Feedback will be much appreciated

Thanks,
- Enrico

On Tue, Apr 20, 2021 at 4:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Apr 20, 2021 at 08:01:29AM +0100, Christoph Hellwig wrote:
> > Just to despit my 2 cents again:  I think the way this is specified
> > in the virtio spec is actively harmful and we should not suport it in
> > Linux.
> >
> > If others override me we at least need to require a detailed
> > documentation of these fields as the virto spec does not provide it.
> >
> > Please also do not add pointless over 80 character lines, and follow
> > the one value per sysfs file rule.
>
> Enrico would you like to raise the issues with the virtio TC
> for resolution?
>
> --
> MST
>
