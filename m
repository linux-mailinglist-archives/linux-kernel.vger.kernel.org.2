Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA68459491
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 19:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240208AbhKVSSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 13:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhKVSSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 13:18:18 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A26C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 10:15:11 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z5so81050293edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 10:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GSXDv13Hd6kdiTvKbHLRazEKpI53Nhhk4fTZJBkhotE=;
        b=aguIN9liU8B3RcumZ/vkFmu2nw43orSqh5ueJfbQ5HKjxIp5Na7w5eJfbX6QqXVbGQ
         HvHao947tl+zSgEMPWJ7WiLcqD+ngc9i8cptB+AtawXHs4zprygZAGJ1Sfm6oPU+7hlf
         jXkYYOvD2t2SkRGktJ+rYHHbNLa9sy/F3BrjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GSXDv13Hd6kdiTvKbHLRazEKpI53Nhhk4fTZJBkhotE=;
        b=Lmn51SguqFZW2AVcA9ZryYBPCBJ97cjlauZ+nCLH5wNIGysKz0b8LBac60En1fUGp3
         I9+grOrYANnaO0reOgJJiKAtoURYj5YPHaS9PbCMTvdUDRwUjKtCbaCVW3hpMSTiHXUq
         2Tm+ZJGGB8YsWprA/U5Lh8raulB9yVmD/17giW/Iq9YQUNRbtus78f4D1Y+YyTOYyjIB
         n2h3WgWmzW9zL+E9i6brGdI0UtDgFKfKF9QNVu8SJAyZlLVwZlXdURAnZRKt8mumsYEM
         kAjaT0QSFJBk39I76nKTnn9NmaH5q79xMHmlakbLtD3+0hOmMsMKbitnts5nfSzsSzc0
         wguw==
X-Gm-Message-State: AOAM531890pFJ3iQlRvhziyVtAH/r6Z3jhwJjTiGCDV75A/yZbtLpQrG
        XXjjySEAzSCc1IFnhkqpM+OkIdgYICyPNqvS
X-Google-Smtp-Source: ABdhPJwroBuTc2aZVlafq7AnMmrdFgQ0TQZ8ARieKnwOyXkhTo2QIhx9q0pfBPVX2f/ZEsVG8MTrFQ==
X-Received: by 2002:a17:907:6e8e:: with SMTP id sh14mr44144530ejc.536.1637604909545;
        Mon, 22 Nov 2021 10:15:09 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id w3sm4483676edj.63.2021.11.22.10.15.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 10:15:08 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id d24so34399955wra.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 10:15:08 -0800 (PST)
X-Received: by 2002:adf:cf05:: with SMTP id o5mr42401390wrj.325.1637604908261;
 Mon, 22 Nov 2021 10:15:08 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgMLMKjQUFoAA+chpZqaLJgpnUHsOJtBzWgFepT_DEwSw@mail.gmail.com>
 <20211122013853.GA1859143@roeck-us.net>
In-Reply-To: <20211122013853.GA1859143@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Nov 2021 10:14:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wieUx=pwpk7xUh9q+uT_pDHa+2cpzMZtpHP_WMYHTU3Zg@mail.gmail.com>
Message-ID: <CAHk-=wieUx=pwpk7xUh9q+uT_pDHa+2cpzMZtpHP_WMYHTU3Zg@mail.gmail.com>
Subject: Re: Linux 5.16-rc2
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2021 at 5:38 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> powerpc:allmodconfig
>
> fs/ntfs/aops.c: In function 'ntfs_write_mst_block':
> fs/ntfs/aops.c:1311:1: error: the frame size of 2240 bytes is larger than 2048 bytes
>
> Stephen marked NTFS_RW as BROKEN in -next.
> Would something like "depends on BROKEN if PPC" be acceptable ?

Yeah, let's do it that way, and keep it simple until somebody cares
about something more fancy.

              Linus
