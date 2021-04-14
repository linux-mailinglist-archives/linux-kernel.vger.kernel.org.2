Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A347735FB90
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353342AbhDNTU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353268AbhDNTUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:20:02 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B39C061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:19:40 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g8so35068907lfv.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2NCuqqnTNRZqz4gVa7VmF8X9q5BSGA2MnI49n6bMs7A=;
        b=dCmT2JevlN2Um24EUlGKuB1noKIv7ps6g0KvoFc8NO7f9Egls/Mith+iaPjQtsQfnr
         V3m5Niy5LYKZYm6IIrt5kn+7wbQBG2dzlRjqlgBgfDXYfOc9ZchG7DC8UHzaS3kiP/3M
         I5Wq5Fh4vLEyyOX6IyyZ6+LRoWZP+OivJSbUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2NCuqqnTNRZqz4gVa7VmF8X9q5BSGA2MnI49n6bMs7A=;
        b=baxGoKYNxmdQHZNlqhpEi6L1YSUAagwgI6vXECZYrSK+vFtREQ0QgI7IJzfXzC3vDS
         o+YWV6ldTFV5UWb4WEDq0/ci6pqSJQ9+vU8e5eSiHg7CAbXZDDl7r12DDfo3CDvQ0Z74
         jYrNs34Ut49OCYH7omjWxK0WrYP1QUWXp6qBCGBSB4uBXg9kapGNnpIe97pq6ouwZqSg
         jjAd+p2KGHt+fCFQo2alng3QDW9C4DLQTRJITH42iYs35Z19EMW8I49zERyv3qGk2OYh
         tBY/zARVM5N8JqOovRAuMlXKoMuZRSUg57glt8xv8Vz7vlm1Qh5zvvpAEMZz3IXP2f4V
         sB9w==
X-Gm-Message-State: AOAM532kD+r+/h15HOzJ73dLigc4efrgMmQr69Eo1juuOiQ5LOjeleeM
        9CRn/bJIG/aOfn5p6vy1GAIkR+J0TbRFvBpT
X-Google-Smtp-Source: ABdhPJwcN/4MdPjTmxdQN+IYpdgYrXD463Q0NHrNhiTwuPtoEgrjwk3aJ89H68pnIryUe6TTZzqw9Q==
X-Received: by 2002:a19:6143:: with SMTP id m3mr25749644lfk.639.1618427979033;
        Wed, 14 Apr 2021 12:19:39 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id x42sm148980lfu.244.2021.04.14.12.19.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 12:19:37 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id f41so11671619lfv.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:19:36 -0700 (PDT)
X-Received: by 2002:a05:6512:31c7:: with SMTP id j7mr18301122lfe.41.1618427976755;
 Wed, 14 Apr 2021 12:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210414184604.23473-1-ojeda@kernel.org> <20210414184604.23473-6-ojeda@kernel.org>
In-Reply-To: <20210414184604.23473-6-ojeda@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Apr 2021 12:19:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJvJJtd2mpYpx5+zn_hPrSOqGqi-Pxb7e+h+anhsLnQg@mail.gmail.com>
Message-ID: <CAHk-=wgJvJJtd2mpYpx5+zn_hPrSOqGqi-Pxb7e+h+anhsLnQg@mail.gmail.com>
Subject: Re: [PATCH 05/13] Rust: Compiler builtins crate
To:     ojeda@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 11:46 AM <ojeda@kernel.org> wrote:
>
> We also need a helpers C source file to contain some forwarders
> to C macros and inlined functions. For the moment, we only need it
> to call the `BUG()` macro, but we will be adding more later.

Not being a Rust person, I can only guess based on random pattern
matching, but this _looks_ like these "panicking intrinsics" panic at
run-time (by calling BUG()).

Is there some way these things could cause built-time link errors
instead, so that if somebody uses 128-bit shifts, or floating point
ops in the rust code, they show up as build failures, not as run-time
ones?

Hmm?

          Linus
