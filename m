Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B0842E8E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 08:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhJOGZg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Oct 2021 02:25:36 -0400
Received: from mail-ua1-f54.google.com ([209.85.222.54]:36810 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbhJOGZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:25:34 -0400
Received: by mail-ua1-f54.google.com with SMTP id e10so11357563uab.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 23:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cj1vfKTbWBgindpWlIKN3ENuln6j1Vta1kOip6OU7u4=;
        b=QtXT92WfMfyBwFK7s6HSUYFlcbHioNP/gT4Yb9qpwHGQzQWkPsUtpuHi3375S4+sdO
         /F53n+0cc3V0OgUJ7kSB02JV96vrgL6Y5LzaLxoNM1RACJf8e6LFI7LV6Naas7yIyJQb
         g7dVlDZxVU3hlLjMd1N1euumEEaSAjIWmOBnFKTIkEpxzt1Fb8wzOxJOSFdoR3mIdMpt
         UV+s740XhdW+WX+e7CFTUkv6O10AsdsWtiYHM7mw40gha538wdUqkhzrkEF232X5rylo
         7RYhHaKmE/ilbJ7561Iiz8DqqBq+0qfrYizfMBSgdkH6SteKXK4vUSNsodRWYJrboxX+
         at9A==
X-Gm-Message-State: AOAM532Dw3KRwjgoNuO8MSuPJZVHqPb26s0FS/Tavj2XgUo22QsW8uxY
        sq3W83UPc8vFyj1KBLE4KMtwojfRD/EunA==
X-Google-Smtp-Source: ABdhPJxqhsNuOzqN1Mq8uSExukASfbBrE78QV7lOSy+PAEABq+Kyr7PcBsvORM7a7NSpNvf9C/ib/w==
X-Received: by 2002:a67:cb87:: with SMTP id h7mr12306250vsl.0.1634279007786;
        Thu, 14 Oct 2021 23:23:27 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id m184sm3111072vsc.6.2021.10.14.23.23.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 23:23:27 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id e2so15957955uax.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 23:23:27 -0700 (PDT)
X-Received: by 2002:a67:d111:: with SMTP id u17mr12166090vsi.37.1634279007509;
 Thu, 14 Oct 2021 23:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211014212906.2331293-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20211014212906.2331293-1-niklas.soderlund+renesas@ragnatech.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Oct 2021 08:23:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW71ux2Z--j1yR2FEYmyHJ3uQHBf-iq-+DLB9Wgz_Qj=g@mail.gmail.com>
Message-ID: <CAMuHMdW71ux2Z--j1yR2FEYmyHJ3uQHBf-iq-+DLB9Wgz_Qj=g@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_mailmap=3A_Fix_text_encoding_for_Niklas_S?=
        =?UTF-8?Q?=C3=B6derlund?=
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

On Thu, Oct 14, 2021 at 11:29 PM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> There are a commits that mess up the encoding of 'ö' in Söderlund, add a

are commits?

> correct entry to .mailmap.
>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
> Hi Geert,
>
> Would it be OK for you to pick this fix thru your tree?

I guess so, would renesas-arm-dt-for-v5.16 be suitable? ;-)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.16.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
