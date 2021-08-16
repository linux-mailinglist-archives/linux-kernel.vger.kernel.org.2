Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4976E3ECF00
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhHPHL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbhHPHL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:11:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010BCC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 00:11:27 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id d16so7537154ljq.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 00:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K1MP/CLQ5UxOhTtXkR4NWOKZQUDna/VXaqmZ5Y18D+Y=;
        b=dv4s8wYRv2UexG5fYe/L9LefRe2lJY2AlCbdse1UgIPHE5tFl4/+9gzjG1+20V78Y7
         XFuieXknWYc1tLKwQXAjEVv8RK65X5Bx7FaNsk3UjQjpq09Z85GgcDa/pr0hg3Od1IkP
         LDHM3JNzHl/+mrYSlGA+TPbiptx+ajmIft7bM9Z4UvHqp5BUP6WzRSQvWXpcrgHK6Nw2
         /JZ55NGMyfaG2OLnF/pE3tthDNGGbeTg+oLJULUAvNt5iR+KNZrmzUgfh9NPTeET5VG4
         hhuXfsSwd9VG1coXJBUPPJoh/K7/pMYw0p4l736zMLNx5S2BrUZb+bRxIQe0D4/055Fu
         UNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K1MP/CLQ5UxOhTtXkR4NWOKZQUDna/VXaqmZ5Y18D+Y=;
        b=I7Ls95QtD5iHXDX06PxWkfmQ3b1uXRTvNkCUvs9IgIR40dcrUVWWlOPFfM6KAQfbom
         4XPAc5B9SFQp7JzgIxCNUiARSlRbgQB9OuDoiyWJOsgOx2yf840loFs5//lx8+h4aK10
         imAJIK9Q5QrdliyfUCc3ImVNWaJz0j1/D5bApZRvnCfvnOi0S8AqfR6NI9hhgYsOUyc3
         EuORFMGCBmdPlu6MUS4n69ChtqtbrvrDU4hhPIYfiuMkEYoTgTVHmMWi9sh+QLMH2vQK
         w8YEYNO4PYnwKixAxTyYrbjswpdtIT1KWDcP97G+n8PHhiME2jG7vwGsbgigyNwlD3SY
         DYHg==
X-Gm-Message-State: AOAM533oF+L9Oxz6Pc9fCOSY5JaVhXgMMjcRdvLnvVwgAq2anJe2SVkz
        d6vERiYNy3KDrzLjIju+srETG3eWOQ0jM4iZHYY=
X-Google-Smtp-Source: ABdhPJxzchjcXdTB0dGFPYdZFPWFClqWlEArFtzNwGoDEFnWTpe3bAsEm+C54IrQR9MnM1ahgquwwvVdQmKX83Wh9sg=
X-Received: by 2002:a2e:2d01:: with SMTP id t1mr11200831ljt.400.1629097885325;
 Mon, 16 Aug 2021 00:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210809185449.2565768-1-daeho43@gmail.com> <425daf77-8020-26ce-dc9f-019d9a881b78@kernel.org>
 <CACOAw_xTh_HZizaVzDNjnVswu_OQwOjzEWRNxouGtM9E5qj6Pg@mail.gmail.com>
 <071534dd-cf10-38d3-b83b-c833f9c0a70a@kernel.org> <CACOAw_ye4y-njHbewXsvVr3gTT4URsw7VH4HM_D_g=zntwjtdA@mail.gmail.com>
 <dc21e445-126d-ef74-3d09-c5a71782ed2a@kernel.org>
In-Reply-To: <dc21e445-126d-ef74-3d09-c5a71782ed2a@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 16 Aug 2021 00:11:14 -0700
Message-ID: <CACOAw_x1F6Uu3p9RA8S7XBXnEYsnjPFY0JSG_VqBLrUjqAGeCA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce blk_alloc_mode mount option
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I agree with you. But still I think "fragment" mode should work even
in low free space conditions.
Otherwise, it will be seeking the free blocks again and again like a busy loop.
Or we can change the block allocation way into adaptive mode under low
free space even staying in "fragment" mode.

If we can handle this, we might use "fragment" mode for both
simulating after fragmentation and making the filesystem fragmented.
