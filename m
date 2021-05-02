Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C16370DF4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 18:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbhEBQ1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 12:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhEBQ1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 12:27:36 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A65C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 09:26:44 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id e12so1715971ljn.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 09:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/V69meeiJrOqVSWtH/JmN21Ne8ZqD1vY+1gBq9DI7dM=;
        b=R2dTagUYrZBljcrE2jU0z2avSOWrBzbQ0yrse0H0lEwRlw0z43HRhSNxezYIrikkWq
         3WLDipAD03rUvnIuwElkKmKXe4vbHJ2WUgXNma5Vj5/mTX/FwaUlyhfcAbly+WDrc5F1
         NQI2AoWMXklQYbbOo7vcQs+os0F2wp5uWscQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/V69meeiJrOqVSWtH/JmN21Ne8ZqD1vY+1gBq9DI7dM=;
        b=XY9fO2azKD6LIPVWBokmqhOdAKWYZsQulKHgbuuQU27HWvub6A18U1Qp+kY2IGA7cD
         YhUy8lDqtRfZ+qrUqHnJX+JBm6Oo43TE2MJMOXgp49Zr91cWC2wfiU+Syz0l9JWb22PC
         h+cYZ4jcDAXnNZHhrsZQNECGSBMHwWrpwU46w/3BAef0RzFVJYUXGW+GAn45u0gPiY8B
         qrhpIa+U7/qRpkN5aDaYXjZfYQyXQ+cA31ab7ko0O1eVhiELj8vmPXso9wqVuxKl2rTI
         rT+jrO0CXOEg2aH1h1nZpRBro8PyrxByhs6EmGsbFFL6jHRr/HJisVslmG+8+hWN5ars
         SvwA==
X-Gm-Message-State: AOAM530rVNrF4THNXE+oNPfRHJKA21heTL74hZ+3AIV4oycRkHHvac2A
        fFNDTAZMTMHT2UBpLB1Dg0PbXPwGJqtfdEFT
X-Google-Smtp-Source: ABdhPJwPondzHPJmEvTyGMoiasNY9Y4ZmC4zBvdGqELGt+uplaGm6jmWRL52fedFmF16KHbgoe3jbw==
X-Received: by 2002:a2e:8e64:: with SMTP id t4mr10817715ljk.211.1619972803177;
        Sun, 02 May 2021 09:26:43 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id l7sm971232ljg.30.2021.05.02.09.26.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 May 2021 09:26:42 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id c3so520460lfs.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 09:26:42 -0700 (PDT)
X-Received: by 2002:a05:6512:3763:: with SMTP id z3mr9922460lft.487.1619972802559;
 Sun, 02 May 2021 09:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <YI4AwgZaFSGsTDR9@zeniv-ca.linux.org.uk>
In-Reply-To: <YI4AwgZaFSGsTDR9@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 May 2021 09:26:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWm_a5hHr7Xnx8NNQPq5xjs6cS+APE5k_K1K6F8Wq7eQ@mail.gmail.com>
Message-ID: <CAHk-=whWm_a5hHr7Xnx8NNQPq5xjs6cS+APE5k_K1K6F8Wq7eQ@mail.gmail.com>
Subject: Re: [git pull] work.misc
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 1, 2021 at 6:30 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Mikulas Patocka (1):
>       buffer: a small optimization in grow_buffers

Side note: if that optimization actually matters (which I doubt), we
could just make getblk and friends take s_blocksize_bits instead of
the block size. And avoid the whole "find first bit" thing.

As it is, we end up doing odd and broken things if anybody were to
ever use a non-power-of-2 blocksize (we check that it's a multiple of
the hw blocksize, we check that it's between 512 and PAGE_SIZE, but we
don't seem to check that it's a power-of-2).

This is mostly a legacy interface, I don't think anybody cares, but I
thought I'd mention it anyway..

                Linus
