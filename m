Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6F93454F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhCWBZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhCWBZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:25:04 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986C3C061574;
        Mon, 22 Mar 2021 18:25:03 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id o66so8632423ybg.10;
        Mon, 22 Mar 2021 18:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f8S/OZMy1ZuTFVTtPrzYCVy9HkceuxE1m3tw3XNzM7I=;
        b=uqC/+8H5yU86IXnUTpqQ2Ns41SxOwcIzfG1b+wDoZUekKFUf/Kmln1YzzfOi8I+9WM
         Dw0GfNWt5H2pDLdCw8CBBpUU1j1j4AawgIOxF6i+akb7bKkP2ZiD2GoDBDmsVoe+Ihc7
         +hC8DYBmaLAZ9jXwbM+/E61OhTFKYXfHQHOoa72Rc5xQy6h52+h9e68SCUvcQNm5YvMC
         sAIwst985ndf/sW/zbaQCQm6FvD5LckF2iZCOLlA+WGODjcC8hU4P8AoRnslVU7gWTpo
         JQHHJQLf3H/NinOyfi5rXZNgzB1BDbNHkc49CRmp5hxm+mWlpMJS7NH7leptB98XMn/a
         8Lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f8S/OZMy1ZuTFVTtPrzYCVy9HkceuxE1m3tw3XNzM7I=;
        b=RdEUwau+hTWYSEXWGTscWiaLXEzUP2nPmMumYT/XlLms2Y/qzNBc1bRepEemAp1Dc+
         d14yqXXs0+pe0zRRkxrVJtikr6pfai0vtVAUzkPV69xFr6hSSGxRWrsYeOWWT7jvzYUY
         aKgLT22R283jGFucusxz7O+L9c+FqS0NQ647TU1bMXWrF7fWO1pN5xSVy02AGFGBc9qb
         eSh76gry8HUEKXp+13VMinF74lHM4o4/C3mW0mvGr1A8VwVpocFXNmnCcp5+H+p+S4GB
         7AHiHA/ck71KntCmXCQc1pJKBP8XbDvgPj0bbLMg+gR3lpCYRURYssAx1mIyTD+UWZg1
         knSg==
X-Gm-Message-State: AOAM532TLqHMMJ6E+lfBAUTPXth7aUq0cGGHh4ddkwsscW02FAS0T8Ks
        k7MGqaLWeDmaW3xpp0VGqqripXblvcB1J05ZW7k=
X-Google-Smtp-Source: ABdhPJxgUMrVhPrx0ZaOc5eKlIX0FQntvzKZu2RgUqHRxRJ22QZs45MWqztOfwXogp9U0Txs9k1c6hsIs843Y4350Vs=
X-Received: by 2002:a25:3b55:: with SMTP id i82mr2077985yba.422.1616462702937;
 Mon, 22 Mar 2021 18:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAMmOe3SaBn9+XzjhZC8QxmZnHQkvB0R=nV4NaRRyMRF6EfcvvA@mail.gmail.com>
 <CANiq72m=kDd97+n1Zxwi5+7M8cwreoq1P_u5YZ25Dcyx40jNdA@mail.gmail.com>
 <CAMmOe3TNt2vgX=fp77yvOx7s3+CeDonkd=Unb-y2hau66M-fsg@mail.gmail.com> <CANiq72kMnWWucUC1zy2x1GNqYOV5wS1HeHvK0xfUbFM5eTxrgA@mail.gmail.com>
In-Reply-To: <CANiq72kMnWWucUC1zy2x1GNqYOV5wS1HeHvK0xfUbFM5eTxrgA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 23 Mar 2021 02:24:52 +0100
Message-ID: <CANiq72k_gvPhgb-bJ4RpYXgOJALk3Hwc=oAbSLzg8WDq81vFjw@mail.gmail.com>
Subject: Re: drivers/char/rust_example fails to load
To:     Joshua Abraham <j.abraham1776@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        rust-for-linux@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 1:20 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> I'll take a look at fixing those soon.

For those that may read this or run into the same issue: this started
with the LLVM 12 upgrade in rustc nightlies. Therefore, please avoid
the very latest nightlies (>= nightly-2021-03-05) until [1] is
resolved.

To automatically setup a known-to-work nightly for Rust for Linux (the
one we use the most in the CI), run:

    rustup default nightly-2021-02-20

[1] https://github.com/Rust-for-Linux/linux/issues/135

Cheers,
Miguel
