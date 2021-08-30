Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEE83FBE80
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbhH3Vsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbhH3Vsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:48:30 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7485C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 14:47:35 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id i28so28345653ljm.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 14:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upjM0F4locNu58v0ailBAjyyAFQ+p3B+pcot7UB1a9Q=;
        b=f73YzCfJR48M2xW1b1DOhZviw8GcxEv+0kqSXSnP2lbO+R57Pu1qpqEUYh8vt0VYb0
         YO4CPAduv+mi0ulHtsRAtPlF7nxyjRkSBNP4DSn2aiyi8JT+9v0vxNZw9MqSI5NQBzLN
         BuN7+DBs8gUR/4S+1oH342Oan8CD8IYCoYA3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upjM0F4locNu58v0ailBAjyyAFQ+p3B+pcot7UB1a9Q=;
        b=bu40ad3M1YpKy/DYcMeSIv49E/nM/VO0KVXKLuWMHBvuC3c3BIJq0rXZqgeKjmdrb4
         8GcDxwO6v7vwzhcy3SX1xhAX0q1//+TEq/5DOx5Fy0fB4JR1J94Qc7rpk9gaEHmBRTKo
         yJgVHDTK+TtafV2QqxBZt8TyCer93W07e0u2FeBcjfkFYl34OY4fiWKNcLoSS3UBVnxu
         fwM1vYIInc5KCHBRrNRYgLcPyFC5Xve8MSVQ4knOIZFlfB2hKbB/nT06ytGmJx1QwnfW
         SszMjgTtr1V1KskVbFxUwA3MbcAQ2p4tWwhoHYuJ9g5r4vbwH8CswzwrEtj+tybfCxQV
         IYDQ==
X-Gm-Message-State: AOAM532kShQx+JFZQAzCAFM3rvgdwqxHMR2Vl5sCGP5TwVlPdLEdMURw
        6Pf7pY485FRWQnkGMxYbAt81gudoE2sm8zr1zEc=
X-Google-Smtp-Source: ABdhPJxbToc0+bh/QjqIDabfgQhZrleK0XbP5TKdA3CJN1FDXpuFidi/i/e2fulv3TGqv8oPSaoTag==
X-Received: by 2002:a2e:8403:: with SMTP id z3mr22952803ljg.298.1630360052987;
        Mon, 30 Aug 2021 14:47:32 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id e1sm1508917lfj.85.2021.08.30.14.47.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 14:47:32 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id m4so28322524ljq.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 14:47:32 -0700 (PDT)
X-Received: by 2002:a2e:8808:: with SMTP id x8mr22716130ljh.220.1630360052206;
 Mon, 30 Aug 2021 14:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <163031993120.58256.1250660796395121952.tglx@xen13.tec.linutronix.de>
 <163031993245.58256.17381067625019238476.tglx@xen13.tec.linutronix.de>
In-Reply-To: <163031993245.58256.17381067625019238476.tglx@xen13.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Aug 2021 14:47:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixTU55dA6iz1JYG0eAviYqQY0su_QOQSu52jrQV92r+Q@mail.gmail.com>
Message-ID: <CAHk-=wixTU55dA6iz1JYG0eAviYqQY0su_QOQSu52jrQV92r+Q@mail.gmail.com>
Subject: Re: [GIT pull] irq/core for v5.15-rc1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 3:44 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Core changes:
>
>    - The usual set of small fixes and improvements all over the place, but nothing
>      outstanding

Heh. Welcome to the most confusing language on earth, and the
completely different meanings of "stands out" and "outstanding".

I would hope that some of the fixes are outstanding (or at least good
enough), even if none of them stand out.

              Linus
