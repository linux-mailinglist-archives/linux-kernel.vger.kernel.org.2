Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78BB41A024
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbhI0Ub6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbhI0Ub4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:31:56 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E23C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:30:18 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso26033649otv.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TRuVFJezgwN1Idjgpz4O0hFQqZueH291tcl1IF5+cgc=;
        b=iQNtNnFwObQlhz+wFxru4JWkG2kphRipmJodEdulqbsoyzNSwj+/FPb9Fu0EAj97v3
         zoyagzdQm58H9623FC/TQC8mcz3eZqf+afXSavGJ7R4+S/BaahJhN5eS5XPVOB85fKtz
         MZ14aHWwuOvvSgPITXXi+b7NKe90aAkaOcbXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TRuVFJezgwN1Idjgpz4O0hFQqZueH291tcl1IF5+cgc=;
        b=BiH9vVa6ejKpZt2y7Ml7P/KhdOeHVGW7LyAWf2rRqqunBRGcbEAUtDB3BK2s9SBoar
         qjPjsoq4Lg5ibhqFYq5sqKd+m3UnalDa5UVG4xQyMHs3eKKSvndt32ttuKrb/1tKtP72
         Sjgg9i5+CoGo4eJPbvOJJjVKrBDb3OO0y6nTRoCpm126Z88swU7YrgRFo6+Nowy0vpnl
         8mdMZ5C4awiz1Z4dkh5xSSfgbLQRr0KCWFQT8Ovqhb7eGKl9triAVtETj09b3hThuRLb
         ZETz2/+vZX2xdxH8GX+M7jAjk0ZqopyPFlOeyXcLP5H+987p1sww/uY1rQnSrFsi74K7
         JzJA==
X-Gm-Message-State: AOAM530PCDVBiNNEn1lZDD9FvdwVda5PlovhIX5azKvBHyQL9+UcjUzj
        MahF4jawmVVOCBIz9zmBBQX4LqIqFZbD4Q==
X-Google-Smtp-Source: ABdhPJx2mznJPY4W0RXL+8P6JaTeu0nPlqmsYLxu78sLwiTBNFdtDEiMH2xu8jfdr3bQysk/rGn/Ew==
X-Received: by 2002:a9d:61d8:: with SMTP id h24mr1725556otk.360.1632774616343;
        Mon, 27 Sep 2021 13:30:16 -0700 (PDT)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id g21sm3121219ooc.31.2021.09.27.13.30.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 13:30:15 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id b5-20020a4ac285000000b0029038344c3dso6421044ooq.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:30:15 -0700 (PDT)
X-Received: by 2002:a4a:c18d:: with SMTP id w13mr1560416oop.15.1632774614785;
 Mon, 27 Sep 2021 13:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210914114813.15404-1-verdre@v0yd.nl>
In-Reply-To: <20210914114813.15404-1-verdre@v0yd.nl>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 27 Sep 2021 13:30:03 -0700
X-Gmail-Original-Message-ID: <CA+ASDXN34u8mAVdhbfSK14pG_9qUcPvK4tFEywN4s2grqyu9=g@mail.gmail.com>
Message-ID: <CA+ASDXN34u8mAVdhbfSK14pG_9qUcPvK4tFEywN4s2grqyu9=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mwifiex: Work around firmware bugs on 88W8897 chip
To:     =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 4:48 AM Jonas Dre=C3=9Fler <verdre@v0yd.nl> wrote:
>
> This is the second revision of the patch, the first one is here:
> https://lore.kernel.org/linux-wireless/20210830123704.221494-1-verdre@v0y=
d.nl/
>
> Changes between v1 and v2:
>  - Only read-back the register write to the TX ring write pointer, not al=
l writes
>  - Mention firmware version in commit message+code comment for future ref=
erence
>  - Use -EIO return value in second patch
>  - Use definitions for waiting intervals in second patch

I tested this version, and it doesn't have the same issues v1 had
(regarding long-blocking reads, causing audio dropouts, etc.), so:

Tested-by: Brian Norris <briannorris@chromium.org>

As suggested elsewhere, this polling loop approach is a little slower
than just waiting for an interrupt instead (and that proves out; the
wakeup latency seems to increase by ~1 "short" polling interval; so
about half a millisecond). It seems like that could be optimized if
needed, because you *are* still waiting for an interrupt anyway. But I
haven't tried benchmarking anything that would really matter for this;
when we're already waiting 6+ ms, another 0.5ms isn't the end of the
world.

This doesn't really count as Reviewed-by. There are probably better
improvements to the poling loop (e.g., Andy's existing suggestions);
and frankly, I'd rather see if the dropped writes can be fixed
somehow. But I'm not holding my breath for the latter, and don't have
any good suggestions. So if this is the best we can do, so be it.

Regards,
Brian
