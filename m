Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA9A436D41
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 00:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhJUWLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 18:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhJUWLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 18:11:49 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F148CC061348
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 15:09:32 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 188so2841765iou.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 15:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDG3iiziPOySitNwmdsVMVAIu3/rlQJnhu7jNm7K7Bo=;
        b=RucnM1yz1XdJ1eASSUQJHRNOeBmTyMbBe4qvQxieyS7amWMU6W6Vc3i6r55az9n5L3
         2/mEUJN4lzO+y435rDOai9jKRsbnTWwX2+hfWbji9hGOS5UavGM0nDtEmkvX4HDO/wUO
         Y3omamXoF9tKwGc8I41YUSeHuY3bqwUBjlTpPpTYIvwOT2O/A+MKS/d3gIiS35RcKOdY
         mTJ/eYsa0X3GkAsO4N6V/G0EDmuL1IjJUs30xDTultluSfGxtBqTavvMbSyFHY465pgU
         yzgcsN4lfjBybMGEPOGKsOf4Mvu7OsJj9+Dvi9ElBxNBLL4MKMaBGKuVvAQ9SEWhewxo
         Hx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDG3iiziPOySitNwmdsVMVAIu3/rlQJnhu7jNm7K7Bo=;
        b=6Fywkr23gokrPyuyIC1ztC3eSh6cie334li/7wn2TfXJAiYu5qxHhw6O7BPBKONosg
         pTIhmjoV5JIL8zoJcOuD7ub7T5TdhO776ooRx4Vb5IrgnUvJgZGPgc9BW0nLHIetzn/K
         jt/lM5dDsR4uz7PbRq9LUloMpTrNWdp9m2kmgK2XF+ko3fcDPzZlHdKJxVkt4ou1TwKZ
         aPQZWGE1bAEj8qtN3EtObmSlNWeWmHn6l3Cx60zdV2NCw929TkQag/vn2e7V7uZBeC4t
         TdvnY6fEC17ZvTLkKP/ba6yTN0Uc7oxPQVb7cT+Kf3O6ahfkY43D5DeeGYjA+WVac5sI
         8HgA==
X-Gm-Message-State: AOAM531uYb88NhplqmFQypB/eAhMKHkIcoP/IZ+9xRjc2g092TF4l0UA
        1+3gqXgtQllMplAXDGx9k/btfqUt960Qvh09R4gp55TtSU4=
X-Google-Smtp-Source: ABdhPJzkk236ecBC3UE0DWmoaOVnH7wPOps6LyGFwI/+KM3GdAkFKA5xpZ3au4uozL3z+axwa+LxVG13IfjgBT6YafU=
X-Received: by 2002:a05:6602:2d4e:: with SMTP id d14mr6046489iow.172.1634854172483;
 Thu, 21 Oct 2021 15:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210928192142.5525-1-liumh1@shanghaitech.edu.cn>
In-Reply-To: <20210928192142.5525-1-liumh1@shanghaitech.edu.cn>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 22 Oct 2021 00:09:21 +0200
Message-ID: <CANiq72kn2q7ZhyDaTao1Uy2KV-_-2xp=3hZebiQ9qpkE6Xg4wg@mail.gmail.com>
Subject: Re: [PATCH -next] drivers/auxdisplay/cfag12864bfb.c: remove
 superfluous header files from cfag12864bfb.c
To:     Mianhan Liu <liumh1@shanghaitech.edu.cn>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 9:21 PM Mianhan Liu <liumh1@shanghaitech.edu.cn> wrote:
>
> cfag12864bfb.c hasn't use any macro or function declared in linux/delay.h,
> linux/string.h and linux/uaccess.h.
> Thus, these files can be removed from cfag12864bfb.c safely without
> affecting the compilation of the drivers/auxdisplay/ module

Applied, thanks!

Cheers,
Miguel
