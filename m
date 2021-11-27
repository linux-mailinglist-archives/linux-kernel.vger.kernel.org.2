Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4EE4600C8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 18:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355809AbhK0R45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 12:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355851AbhK0Ryz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 12:54:55 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC44BC06173E
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 09:50:11 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x15so52579367edv.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 09:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IvT9A5PgUmmsdPPgmPRktfoLrELQ59r0exofkW/Ii+s=;
        b=NG/FrhUNB8KbyEz2TDL042nDzHzH+VadLD01K1N9pZwyXL8vXfmRFKJMa+97iUJZwW
         KBrgbnqr3+j89Q2pkbY5D0aL+tGvXnmERU/bcRrMS6vcBUu2Sb1eW8UgOn5IAYS51JVg
         i9UpH4LAFB4YhLF1HuYB+dFSkyRJ71mwJ6DUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IvT9A5PgUmmsdPPgmPRktfoLrELQ59r0exofkW/Ii+s=;
        b=HsfVzzIEspeZM+V/e2Z740VenLFykbffkdLTf6nbcTqQ5TAr5cCwh0yQXZDLgWnet5
         WZkODuyNIgRvHOUVHxhR8dAesZUcnSZcJ5U+hnTaaK+GbLGieoC70vlQ41IvlqfLZXzX
         397CiZh11gMNYXlP6bWCuBuU3CnO+5kX1Lhi/81hR3ZZxa4mZL9nbZ8ORGusTG2250bZ
         tUYscH4Ra5IQ/EZw/p5CMhmDk3eSOnZh6fGtQcD7lvpaYGZQs+qnPdBAPOXJtm2CsIU8
         G3zVV6F7NDA7Ve7y7I0daezbFILTz64NF1dz6H1r6zGLd8uaDPGSBmb4sh+WQQr8ccDr
         mUvg==
X-Gm-Message-State: AOAM533e9MEUFM0KgNcNxjyD8qCOS76vedZ6nbIJit+NA2FKxDX0II6Y
        ZURFaMwHRNCHeHCBnTW9jbltAEovVj6iTCfg
X-Google-Smtp-Source: ABdhPJx+eINi3ndOsOIJFyRXBv70CN4RF516+q9h2l2xFv1KjJq3DVzRLmKnWcgcwV8RtUHTQIPJ+g==
X-Received: by 2002:aa7:c301:: with SMTP id l1mr58644930edq.20.1638035410010;
        Sat, 27 Nov 2021 09:50:10 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id cw20sm4489360ejc.90.2021.11.27.09.50.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 09:50:08 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id q3so3359362wru.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 09:50:07 -0800 (PST)
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr22736016wrn.318.1638035407409;
 Sat, 27 Nov 2021 09:50:07 -0800 (PST)
MIME-Version: 1.0
References: <20211127154442.3676290-1-linux@roeck-us.net>
In-Reply-To: <20211127154442.3676290-1-linux@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Nov 2021 09:49:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh9g5Mu9V=dsQLkfmCZ-O7zjvhE6F=-42BbQuis2qWEpg@mail.gmail.com>
Message-ID: <CAHk-=wh9g5Mu9V=dsQLkfmCZ-O7zjvhE6F=-42BbQuis2qWEpg@mail.gmail.com>
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

On Sat, Nov 27, 2021 at 7:44 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> This is the third attempt to fix the following build error.

Thanks, looks good to me.

Should I apply the patches directly, or were you planning on sending a
pull request when everybody was happy with it?

           Linus
