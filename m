Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9653436264A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238249AbhDPRGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbhDPRGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:06:03 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D791C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 10:05:38 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id z8so31815382ljm.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 10:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AcDAVQ+0h+jENPZeM69/kZwGZfdDXc/0125nsKSlnZg=;
        b=dnz1bYqVAlRM6259A+dx+Rc2q9Qis0LBOOOmkDKaY6WJu06OAB3WTXaPaSSbSH2kHN
         CUxAYJW2MSUb6KLd9VHkZqoeTvqRIILdDBdw4/TbIMff3ssQa3bNYa96Mu2MipKekQxe
         RdIn9i/ob2oUe8MI005glSrjfmJXy7RQVtkC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcDAVQ+0h+jENPZeM69/kZwGZfdDXc/0125nsKSlnZg=;
        b=rBjzveqS+vEp0UQ4M0LfE7QpW7OoyIhA1jEltkEW3OfWviUjNc/MYRIGtsZ/po9SQw
         1yV9/wnLK1ajW056TNUKda5mFuxjBff/dHkjJyPjISeaQmrQdGLQWh/WcHmrnp+Wds6L
         jJZa9/I+Ui/WgKlMms56bokWvt5Xebek2Q5BL966+5v3Z0/swEcvUk6XD5wVoZh+nldy
         tI3InPXapFY2Rs0qwzhpYVHldLFuF06QVY/ZE8e4iKbGRPTr6lVnx/6mYE4GJ12AU8Ax
         dlrXTQgjOoBuOqJZunAHcwWGiodhwBXI/40tWzcY1tSgzH9/qBx50FShaA5yTte+NQT2
         FWOg==
X-Gm-Message-State: AOAM533v5bESJktA8nv1hTPFgEbPOqkfJrr7lWjTTbjV/sH2fwiQOCO2
        MpxgzYC51z7nTqu6i69mXiv7fuguuxaGzbpN
X-Google-Smtp-Source: ABdhPJx1fjC6ipQX1B/yOav7FXdL8/E6S7LNEIIY4yvNWf6OpRWbD/f/c5R297gwqioM2A+7gB1lcQ==
X-Received: by 2002:a2e:7505:: with SMTP id q5mr3245557ljc.322.1618592736640;
        Fri, 16 Apr 2021 10:05:36 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id t198sm1043597lff.121.2021.04.16.10.05.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 10:05:35 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id r128so18831705lff.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 10:05:34 -0700 (PDT)
X-Received: by 2002:a05:6512:1286:: with SMTP id u6mr3571784lfs.377.1618592734654;
 Fri, 16 Apr 2021 10:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210414184604.23473-1-ojeda@kernel.org> <20210414184604.23473-5-ojeda@kernel.org>
 <YHmTWEAS/QjX++w4@hirez.programming.kicks-ass.net>
In-Reply-To: <YHmTWEAS/QjX++w4@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Apr 2021 10:05:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_zb=K1B-N8mgHmSZDqTLgOm711NRXbTX_OwFAzDYg0Q@mail.gmail.com>
Message-ID: <CAHk-=wh_zb=K1B-N8mgHmSZDqTLgOm711NRXbTX_OwFAzDYg0Q@mail.gmail.com>
Subject: Re: [PATCH 04/13] Kbuild: Rust support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     ojeda@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 6:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> AFAICT rust has try/throw/catch exception handling (like
> C++/Java/others) which is typically implemented with stack unwinding of
> its own.

I was assuming that the kernel side would never do that.

There's some kind of "catch_unwind()" thing that catches a Rust
"panic!" thing, but I think it's basically useless for the kernel.

Typical Rust error handling should match the regular kernel
IS_ERR/ERR_PTR/PTR_ERR model fairly well, although the syntax is
fairly different (and it's not limited to pointers).

                Linus
