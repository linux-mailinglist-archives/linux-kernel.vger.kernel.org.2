Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21AD40317F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 01:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347882AbhIGXYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 19:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348243AbhIGXYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 19:24:14 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAECC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 16:23:07 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id k13so1043312lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 16:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4AZSHciCeRkc4SFERN0y0Itlh8qaafjuwrsmpGqhcQo=;
        b=fBOwWD2WLE2myG54KAI6XuQQSrzg39mpmkmYptBbqejKP4YGfiLD9HC+TI4MxoIWnc
         3yy/vTN59Y+csj+4h90lugFr1+jF57+cT1j4WO1ozL3wsyQ7davRKu4v/8PP3pVFK7rO
         WD8qRZEcInVVRWrOl/30y9YsxkdcuBEHNRFTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4AZSHciCeRkc4SFERN0y0Itlh8qaafjuwrsmpGqhcQo=;
        b=PEl7iAfk1QTU2pvUWgh/TCKCp/MRYjzeZlhcpjQ5aEQEdWzv3DGVEC/9kT/cm0mtXV
         TVBKSNnAkagEw7c4KrAflZ1cl7q6BMDrD/rg8fC5axXY/r8iFW5BzyNzfkVG8T0wrAXQ
         yYXaJ+7JcyuLNFFstxjOt5mDtOVF1HFJO7Rg6JBvXsHZr5aT0bEK1A84ItjxVkod5MeS
         CV1EJ+1M9vMo2XOJY2CdChHWDEFgAf8D+Q/p14Sk97fw59iR7/adzoVJz7niR61R+11g
         abm35bms/7H3z2yJLxfXNGZny5UIIwNV+P2XM50cjVrDg9yYas5T9H/xCOsTy5UQumct
         PiKA==
X-Gm-Message-State: AOAM531C6bJmRRrBE9Mg6PYI0uM/R26DbNCdGlqeIFEnDG7JJJ9as9Fh
        QapyIzVXttA9sFHd0gC+Hxjzp+2JZlMh9rbjjio=
X-Google-Smtp-Source: ABdhPJy9/dyWoj/H2kf1gWGMSa5Ev+QnbXBxQ6D6vvQAJRLqz2zvyy4d7teUnX8qvDN/cIvUu+ISlg==
X-Received: by 2002:ac2:4c0a:: with SMTP id t10mr571606lfq.481.1631056985226;
        Tue, 07 Sep 2021 16:23:05 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id u3sm29360lft.149.2021.09.07.16.23.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 16:23:04 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id z2so1054519lft.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 16:23:04 -0700 (PDT)
X-Received: by 2002:a05:6512:3d28:: with SMTP id d40mr568835lfv.474.1631056983836;
 Tue, 07 Sep 2021 16:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210907195612.321345EED@xen13.tec.linutronix.de>
 <874kaw9mpo.ffs@tglx> <e190b62e3f954cc1804a41149a842641@intel.com>
 <871r609m2i.ffs@tglx> <a883fe85b6b941b9bff44bc4b268bba1@intel.com>
 <87v93c82zn.ffs@tglx> <87sfyg8118.ffs@tglx> <CAHk-=wgDBJY4NGRCbEfjRMW9NRa_8vATkVk0muFFvpgixG=Keg@mail.gmail.com>
In-Reply-To: <CAHk-=wgDBJY4NGRCbEfjRMW9NRa_8vATkVk0muFFvpgixG=Keg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 16:22:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgyHMJrNWdKsCDnjh72_pFaDWX+1D=oB4aT1CaTycbyzg@mail.gmail.com>
Message-ID: <CAHk-=wgyHMJrNWdKsCDnjh72_pFaDWX+1D=oB4aT1CaTycbyzg@mail.gmail.com>
Subject: Re: [patch V2 00/20] x86/fpu: Clean up exception fixups and error
 handling in sigframe related code
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 4:20 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Germany has more ISDN connections than anywhere else in the world! How
> can you possibly complain?

Actually, I take that back. Apparently DT finally got rid of it last
year. My bad.

           Linus
