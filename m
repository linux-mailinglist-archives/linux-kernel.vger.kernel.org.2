Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF104601F5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 23:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356416AbhK0Wha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 17:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356373AbhK0Wfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 17:35:30 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDF6C06173E
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 14:32:15 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r25so54425337edq.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 14:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BXUeAi2+SoZlOAeVxzpmD/hoJP95QxCkovEv8DaX2SQ=;
        b=SlW9NdbVN58YpeREsvTB9WyxAD6XgU0wbSRECOnLAdjp3CjRYvUXyMEc68vSH6ybpX
         IeNIX2UReqfIFSK4Z0S2vK/lC7F07lMqUrgEYglszqNYs8bEnafD4LzlR3S28r9l3VsZ
         c9Ia8cLhA495icUxVghv669/m6jpS3lHDLtfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BXUeAi2+SoZlOAeVxzpmD/hoJP95QxCkovEv8DaX2SQ=;
        b=CRFGUK+T3VHWRWuogxnMPcooaSnDT1DJx09dbRPBZFjV0FODJFmHzkpygMrgoHyzRa
         NqvvRCT8k5vgUXKm4FeyidNUXYdpdm2TxFOQ/JFPItyITpx3G645sDfL2sBE1VFwO+Yb
         bT+oJ5z9unGHqxsiSjSlu93GyKDJcXESlutAI+nW8dUUZ4GUPm+UwJrZShdM5SczLWGq
         xX60tQjAtLqSPA7f9ARkBV5dAPsh1MfW5elP1DAowjxipn68xOdHXFij8ZuNCZluB8qf
         cFhCI9UspglzuWFUIcGqRZT5dxxNoOeQHwCdaabMSmpXPmU/11VtswSt01zMjWhpuTv6
         FhPw==
X-Gm-Message-State: AOAM531k4hy1683YV1wqDlbEZnrmr1kZ6883kPWDTMblrebn8V4eJZmh
        VWmDmzLh0vbK+JgofqvXtWA4lXUuB0bWS7dN
X-Google-Smtp-Source: ABdhPJxuX+t5EoAdpjOlbXCMvOn+LdXgMYRBq9ERTgttuRZtjb7TIBBgZVGi1RpMg+P+mtUnEKwkyw==
X-Received: by 2002:a05:6402:254b:: with SMTP id l11mr60366708edb.225.1638052333273;
        Sat, 27 Nov 2021 14:32:13 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id m25sm6148314edj.80.2021.11.27.14.32.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 14:32:10 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 133so11332406wme.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 14:32:10 -0800 (PST)
X-Received: by 2002:a1c:7405:: with SMTP id p5mr24444897wmc.152.1638052330543;
 Sat, 27 Nov 2021 14:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20211127154442.3676290-1-linux@roeck-us.net> <CAHk-=wh9g5Mu9V=dsQLkfmCZ-O7zjvhE6F=-42BbQuis2qWEpg@mail.gmail.com>
 <228a72fd-82db-6bfe-0df6-37f57cecb31a@roeck-us.net>
In-Reply-To: <228a72fd-82db-6bfe-0df6-37f57cecb31a@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Nov 2021 14:31:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjaVwrf1OQbDSbk1FxqzbtAYQLx16D74TeagXQyb5oEEA@mail.gmail.com>
Message-ID: <CAHk-=wjaVwrf1OQbDSbk1FxqzbtAYQLx16D74TeagXQyb5oEEA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Limit NTFS_RW to page sizes smaller than 64k
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>, Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 2:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Either way is fine with me. Either apply it now and have it fixed in -rc3,
> or we can wait for a few days and I'll send you a pull request if there
> are no objections by, say, Wednesday.

I'll just take the patches as-is and we can leave this issue behind us
(knock wood).

Thanks,

           Linus
