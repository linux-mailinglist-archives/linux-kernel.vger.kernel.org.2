Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDA635FBB1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353417AbhDNTe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353404AbhDNTe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:34:57 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F148C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:34:35 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id o16so24525568ljp.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+qlBpfKKNNSmiIVDWZAwm2J5XBPYb6crTXEI3M0nwo=;
        b=VgiHLTWI3FosiEpCVUDwPU9YJez9f9/W7OcDyGRWAVmbGZSYPWyC/lw/A8EwBL9ftK
         liArfTuPen3tkf1eQSyheZ4w4SwmZAyOVnVWF6E8SqyJGlCejb7Dr9Y8seU8GmIElaDu
         glo7f1q5erTsGKyDwy5UyrL8uODJ+xbE+9wDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+qlBpfKKNNSmiIVDWZAwm2J5XBPYb6crTXEI3M0nwo=;
        b=J+J1CtywVI//st5tE5LMavq7SxtncxDGgTpZhP65Cb+G1ZknJhVyyoxMnSGaZ6hiyH
         Lp/wLsASswbOeZyrW6/ZN0alIWZ87VtyJau3EQPvbUmmdDd+POBdC/wzKfKrrTS2K5VG
         iMZvc4K27RCE8ecFS3L8dHuqLyHAn8lsfC6qP42vAD3QlmT5XkfvAdANnxA0sxS+XtQ+
         fsVVm/ESh+GjQMJ93vRlR1OkOZWP76azyyhbDK/RmIk0mj4s9TnS9gfAnH6ROBduNCMj
         Svp+QF9sNpZFpACr5z8N0EaJ6sbtdl8PHFPjAzoYD6hEOA9KZMHurhHoIYmFBk8tTpkq
         Rz5g==
X-Gm-Message-State: AOAM532HuuoDNVQy4hVZneZdfVgTwFPETM29NtT2K2Q3yIE9dUGadE+z
        FGdvEHI/R6IstjCOAj8jd0N9DKJhFenNL1lj
X-Google-Smtp-Source: ABdhPJw4suRN/8Fr/pzitm7VKkJcMMf/fNHwER8gkL+7ZT5QT33lsryClDvoR/T+TYcX54WuhR/4LQ==
X-Received: by 2002:a2e:5416:: with SMTP id i22mr22927425ljb.403.1618428873527;
        Wed, 14 Apr 2021 12:34:33 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id i17sm159663lfl.250.2021.04.14.12.34.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 12:34:33 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id r128so8104679lff.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:34:32 -0700 (PDT)
X-Received: by 2002:ac2:4947:: with SMTP id o7mr22894176lfi.253.1618428872725;
 Wed, 14 Apr 2021 12:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210414184604.23473-1-ojeda@kernel.org> <20210414184604.23473-10-ojeda@kernel.org>
In-Reply-To: <20210414184604.23473-10-ojeda@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Apr 2021 12:34:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdZ1KksHHHuekeAx9kKFXEyt+rg0P=yRD1Bia_01wucg@mail.gmail.com>
Message-ID: <CAHk-=wjdZ1KksHHHuekeAx9kKFXEyt+rg0P=yRD1Bia_01wucg@mail.gmail.com>
Subject: Re: [PATCH 09/13] Samples: Rust examples
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

On Wed, Apr 14, 2021 at 11:47 AM <ojeda@kernel.org> wrote:
>
> From: Miguel Ojeda <ojeda@kernel.org>
>
> A set of Rust modules that showcase how Rust modules look like
> and how to use the abstracted kernel features.

Honestly, I'd like to see a real example. This is fine for testing,
but I'd like to see something a bit more real, and a bit less special
than the Android "binder" WIP that comes a few patches later.

Would there be some kind of real driver or something that people could
use as a example of a real piece of code that actually does something
meaningful?

               Linus
