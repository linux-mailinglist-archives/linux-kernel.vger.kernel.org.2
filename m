Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4F7327961
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 09:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbhCAIhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 03:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbhCAIg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 03:36:28 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF841C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 00:35:47 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id d5so13968300iln.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 00:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=KKv852sVQnXnUt2Mn3kIZ+FZlQyet/KaJu64VXBEcbo=;
        b=UNdB/3zhBNjCr68E1K+BVi7Zrvu3owUaJf0wsfp+YxTtspFbGixTZFX3Av7RcaGaSx
         XEg1rg7pIjMh+4gbkODbCWznRL1TKzjtyrAIb2cHZHtHCntMGeNp7OBbSU8LiK+DHjqh
         M/q//6gulayybuVu7iwL0KmmbWAKfd6G/dJiyyAZPQb9h+slioqhk8PNz70uF8codw2N
         HDTTJ5Sg/2TgK6o4/6VW+cXEywbD3JMnoh/rTmOk5Dn3mNwnSbl4ZDo4CH2ZQEWhNUb3
         +ALQpY8v2eflpXhhuoqdSFFl6hfa0y+WdQDQvp6neAVjwNGeprsNHh4krTw106/iutS1
         Hl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=KKv852sVQnXnUt2Mn3kIZ+FZlQyet/KaJu64VXBEcbo=;
        b=c3LGeGDaNBgTqZo+/xoQjGVPj1/ILE0je0Y0AYEITpsN1lsiY+hV9Dp+DSDiN103cQ
         c2/YY5P442xTuHUR0PAr4DxT5SCE/K8M4ZKT6yiNa6WlYvdByUx7AWlMv0xXdoYAnYRY
         QywBdQVmwiRGHvD2tDJxDtC4bPHQDAdU5MyAal+7qHGvbBPnXGnCBtuy+wom26EjpBQD
         R9IZhdbxhzUO0Bkjur3kfl4fUsgVcJmrrcBy7ZXCAG8CgVqPrMz6ddKaEpDO8K3AcD+e
         gjLBMkoZ7mVvqEurmJZs4hSPPv/emR1j+tHCwafEjyktxHLj1y+8r4OP+VMpBL1jsTTN
         w6KA==
X-Gm-Message-State: AOAM533xaU5Wk9N9aGhLA3IPl5P/o+UnDFmqRVZxzueKt7O5Pq7DO5Mz
        2jobWYUiZvBKEG8JShHh0hICzhmKZ1hCrlxmuKpmN+NBAlQkEg==
X-Google-Smtp-Source: ABdhPJwMfWHmrTRiuExVu8hzeMFZ+HbkJE7aUw+9GyD+4KqJnFiIRcXWaICnsorbmPRhZhapT+EEQMZ6/QYztM4P2Fo=
X-Received: by 2002:a92:c7c2:: with SMTP id g2mr12538301ilk.209.1614587747399;
 Mon, 01 Mar 2021 00:35:47 -0800 (PST)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 1 Mar 2021 09:35:11 +0100
Message-ID: <CA+icZUUjVnBjC4AJTT9LYS4J+QbuQZUVj5XdW+iPmjxxuODVmA@mail.gmail.com>
Subject: Linux 5.12-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please CC me I am not subscribed to LKML ]
[ Original post see [0] ]

Hi Linus,

Thanks for Linux v5.12-rc1 and all involved people.

[ Delayed merge-window ]

I wondered why there was approx. for 6 days no commits and got an
answer from an LWN posting "5.12 Merge window delayed".
Unsure, if there was a posting to LKML?

Anyway, if you are not able to make your work someone else should jump
in like Greg did once.
When Stephen could not do his work someone else jumped in and did the
Linux-next work.

There should be a clear communication and alternative workflow in such
situation.
Why not post such delays on <kernel.org> (if this is the official website)?

[ News - Clang-LTO ]

Always I read your "RC" announcement and would like to see some
pointers to interesting new stuff.
( I know "interesting" is very POV. )

Thanks for pointing to the several clean-ups in Linux v5.12-rc1.

As someone active on ClangBuiltLinux - we have now Clang-LTO support
for arm64 and x86-64.

Some issues I have seen and reported:

[ Issues - iwlwifi / iwldwm ]

I know of a call-trace for users of iwldwm device.
You will need "iwlwifi: avoid crash on unsupported debug collection"
patch (see [2]).

[ Issues -usb / xhci ]

I reported xhci-resets every 10min in "[xhci] usb 4-1: reset
SuperSpeed Gen 1 USB device number 2 using xhci_hcd" thread (see [3]).
No response, yet.

Some ideas and feedback from me, myself and I.

Have more fun!

Regards,
- Sedat -

[0] https://marc.info/?l=linux-kernel&m=161455865730695&w=2
[1] https://lwn.net/Articles/846406/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git/
[3] https://marc.info/?t=161417912800001&r=1&w=2
