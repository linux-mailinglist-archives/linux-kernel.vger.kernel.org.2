Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5148D35FED0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 02:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhDOAXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 20:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhDOAXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 20:23:22 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03EDC061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 17:22:59 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id r20so25173698ljk.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 17:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yXZNUo89r2h1yes0UyVOBhU7OBJhuW/Q19qWBxn/2nM=;
        b=rXj+cH/RJJkrB/AlmWQGkz1A8EbtqNB8KsnTCaMCUwWaZA1N7BmjNBTIwkXkA4mZbo
         sVrXJkLciidxw0LrI6ww5V+5d02ksBfZlhmr45AvcPXr6nRSoBNgInd6OLWlbh1GyYCc
         zNvfXQNGJfy4PyfXfL7Xcojhh5kHWQWSoHm/rpq8xLCUOL3lJpJRhfewGiGhvArNBGAY
         NyBLc8ZYmgurVBwz7FzkK4PY9dOl07m/dOSZc75lfLCg38Bfxu9P5cbB7oY2MsiL5RMz
         EEPWWKaiHm+TAR/UqXwcno6h3cgNtJRkd+Ro07iV83uZKO4Wy55/U5cfFm+nq2mkRH+E
         FRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yXZNUo89r2h1yes0UyVOBhU7OBJhuW/Q19qWBxn/2nM=;
        b=MTXIkt/SePfUmECsXA7xzFRniwuGbgOCuI8npYspRub11jaM2DzoMtrIM1I1iSegvU
         JjcuNk8wudaA0JVNP+CozFwXVkUGmt1vDnNm37zNEfkktrQK/SxbdKMWdToDj/WIyHN5
         H9P7ZcA3GEdOJS8wr1fIdNh5rwRjZp/r0/y6EchbDNeJd1xSWkzYoGxdv8Q0i/eLrWjN
         sMDno+zFQCI7/ViPxRhMkEKAU+1io/f8eQHHNWezeC8o/KJNGtg6Ct+GDCHqsHOhqdqX
         OQ6KX4h/dfmIX/vdHR1vEMnwvaHyajTLmqESyCcaC7s23r0DviBUdEkAM1fybesxCTQH
         0Y4g==
X-Gm-Message-State: AOAM533q5aljiMRQELmKI5xy/11nyN+LadEoLrvK9FmrBsn9xnUtp8Wo
        lunWEqFVvfOLt/WlUdxTTJkKpxwVdhBvODbQbh3J9Q==
X-Google-Smtp-Source: ABdhPJwuIf84XGcLpyrpotifCJFS1sv3n4h0mHFn320uKh8eaoB7u9uNPGDcrrYVDBF0cLM74gjBTXavRVGSwP/cZNE=
X-Received: by 2002:a2e:b817:: with SMTP id u23mr304996ljo.116.1618446178052;
 Wed, 14 Apr 2021 17:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210414184604.23473-1-ojeda@kernel.org>
In-Reply-To: <20210414184604.23473-1-ojeda@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 14 Apr 2021 17:22:46 -0700
Message-ID: <CAKwvOdm8s7Yp8e=8tpscY805-bjQWyoNVzhFZnH4KL-q9ZP4Hw@mail.gmail.com>
Subject: Re: [PATCH 00/13] [RFC] Rust support
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 11:47 AM <ojeda@kernel.org> wrote:
>
> From: Miguel Ojeda <ojeda@kernel.org>
>
> Some of you have noticed the past few weeks and months that
> a serious attempt to bring a second language to the kernel was
> being forged. We are finally here, with an RFC that adds support
> for Rust to the Linux kernel.
>
> This cover letter is fairly long, since there are quite a few topics
> to describe, but I hope it answers as many questions as possible
> before the discussion starts.
>
> If you are interested in following this effort, please join us
> in the mailing list at:
>
>     rust-for-linux@vger.kernel.org
>
> and take a look at the project itself at:
>
>     https://github.com/Rust-for-Linux

Looks like Wedson's writeup is now live. Nice job Wedson!
https://security.googleblog.com/2021/04/rust-in-linux-kernel.html
-- 
Thanks,
~Nick Desaulniers
