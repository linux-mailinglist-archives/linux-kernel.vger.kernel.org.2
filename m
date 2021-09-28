Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B8F41A8EC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 08:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbhI1G0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 02:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239146AbhI1G0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 02:26:46 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11DCC061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 23:25:06 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i25so88514618lfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 23:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZCQae3qtwWWvw1bArGUlcBvlQ7e1v0hnozmBJqr5+wY=;
        b=XFcsrX2mvcmHJqhezqRZDMGZPCIkkaUydPP3SLHxN9StxlmKN5yJXcnHRj8AJAPl1i
         Y5zNIqhkZkspqF1g9ONsNNc8sZh01VX2QCa11ftBN+9421gF887JV0TW55ceNF6dAun5
         EFnP5PmVTGGI16/R1vuPbc9mZ6IdIWhVOpea4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZCQae3qtwWWvw1bArGUlcBvlQ7e1v0hnozmBJqr5+wY=;
        b=KBxh3T7KLImK6ztEwkmjMUroyhzbe8oyZjabL/g3YbE6y9vm1L2IQicSnZk7o82kYc
         s0N8ANqomMDK1S4UD6ZhHUQU4S8bm9rIjPfb3CHGVHNa5Uwy2Y+PJhdaQ6fqjKFwA/Ob
         ecBskBb1JWWQx9dXXh7kQn22f9KtqI2HiZDpjuSXwPXx/sA+zzA2Cy1BThg5LiXRgpPi
         Pj68xDUgT8a1ez4XLM7AhnOsZA1L5i9SeTlua6HdOs4Ns213va8maYeC7JcWmxhP7xRj
         3B6UjTTdlVacfJrWiJf3L3tVWpU4P6pHDVeKXblucG/OqSHoYYgXnku4Nd31nwJKq/8H
         SniA==
X-Gm-Message-State: AOAM5302XoiDUsP0DMZre3nGKWiAxFUxhBeROjkGVMF3wi9kNB2rK0HO
        A1OTunoGIAA/KMoR5ZkxZrXu6VgNkEj9OHI+26kABA==
X-Google-Smtp-Source: ABdhPJwrT8e8JH9/bCx+L/c1ar2wKO4LHtdHouzuP6rp6HRQVrGo7bbWRh3t2y5LGqn5NFCgA24rgPc+SlhWEgvgCrA=
X-Received: by 2002:ac2:4bc1:: with SMTP id o1mr3849019lfq.597.1632810305111;
 Mon, 27 Sep 2021 23:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210928034634.333785-1-senozhatsky@chromium.org>
In-Reply-To: <20210928034634.333785-1-senozhatsky@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 28 Sep 2021 14:24:54 +0800
Message-ID: <CAGXv+5HaZcf-RwGGb7phfKcoTnaeiN2H6b_BvR+qdcRYys=nzA@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2: always set buffer vb2 pointer
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 2:16 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> We need to always link allocated vb2_dc_buf back to vb2_buffer because
> we dereference vb2 in prepare() and finish() callbacks.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

This fixes the breakage from the "videobuf2: support new noncontiguous DMA
API" series on the RK3399 Scarlet if the ChromeOS patch that changes
min_buffers_needed to 0 [1] is not applied.

Since there are other in-tree drivers that have min_buffers_needed=0,
I would recommend getting some more testing.

ChenYu

[1] https://crrev.com/c/3168489
