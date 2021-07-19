Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF7D3CED9D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385924AbhGSTQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 15:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385225AbhGSSwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:52:33 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164A8C0617A9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:22:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y42so32098027lfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRKNjK3HDiyg7MZUU6xzfGsB6oi9LOaFsq3T/zTDatI=;
        b=TmVBuZNqv/jmsUcMG14H63atqMF/gg01Eskbcp6RQq2COYAPPbdrQdz8StZJOrWneW
         ViMrEnqGW4PsoFl85gC5x+OljVg9GWa3KzkO/WgOpAXCPkX5jM+3somNUNWooAEL0QZt
         KJxUdnJWdmgiMNzmtO9o+dMnja1cusLmGBQ4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRKNjK3HDiyg7MZUU6xzfGsB6oi9LOaFsq3T/zTDatI=;
        b=UFFjERmyDllL1SOoMiXqCn2TmTi8CkudK5LkYzaVsK9Y9C6CfAWmf46CTrdS81ePm2
         kPPeQXxoeWS4Mnf01ufdEipcOXWiVMDO0Heh4O50ZjTvgDE1qgBSqDNW1Xp0ps2xLJeL
         RSoexUWDiy3jf6aAJi1N4bubdep0g4Tf82DIPJc2xyaCfoU2T/JllmWBd85zAEKK63Bw
         LrUnmK/sHSsCtg6+pprRbK1N2C7qihd2L8FuOOE8At6pOJlk6KHpV/ybntbY71nMfGwM
         VLhSYHfENg4pTaSl+4yCPHFPqKTOgCnM7ZYJhEGtPhvsdfNyJPmWw1oRc7N4ht6JaVTq
         J1bg==
X-Gm-Message-State: AOAM533Ou0Lsb/cM6X6umkke5vV3JqA9GKrYdctl/ddB6vhQO+5fNAEq
        IiqI0YNmR172nuI+NjZFPVLDWt0h2iVNCL/o
X-Google-Smtp-Source: ABdhPJwk1Vl/frRnpz7lN+pnqy8NQgHP7n35Mx/GFpq/4mMAkf1bTFtSKvAKhRhL0kzuuDW9SKZmZw==
X-Received: by 2002:a19:48cd:: with SMTP id v196mr19915181lfa.269.1626723081758;
        Mon, 19 Jul 2021 12:31:21 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 25sm1358872lfr.101.2021.07.19.12.31.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 12:31:20 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id s13so10602635lfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:31:20 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr18099945lfa.421.1626723079907;
 Mon, 19 Jul 2021 12:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210718223932.2703330-1-agruenba@redhat.com>
In-Reply-To: <20210718223932.2703330-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 19 Jul 2021 12:31:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBKeA=obJOc5VRP38=ffm2dCfVmKmy5PLAgs3rysoEtw@mail.gmail.com>
Message-ID: <CAHk-=wjBKeA=obJOc5VRP38=ffm2dCfVmKmy5PLAgs3rysoEtw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] gfs2: Fix mmap + page fault deadlocks
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2021 at 3:39 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> here's an update to the gfs2 mmap + page faults fix that implements
> Linus's suggestion of disabling page faults while we're holding the
> inode glock.

Apart from some wording/naming issues, I think this looks a _lot_
better, and should fix the fundamental and underlying deadlock
properly.

So Ack from me with the trivial suggestions I sent to the individual patches.

            Linus
