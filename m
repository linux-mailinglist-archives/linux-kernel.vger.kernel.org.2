Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27CA3BAF14
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 22:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhGDUzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 16:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhGDUzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 16:55:01 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ECCC061765
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 13:52:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q18so28647043lfc.7
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 13:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1kNbjhH0GpClGiRwzQUpR4hJv6EHO3XdnhQiyv1Zn4I=;
        b=DDKedwHAnd/R9xdhNG2krhsT+Nw/0E+PNH+jTyBdnlj/cEeFjebi3V2C3060Nznwiw
         vtlfihLS1N6oGS1nPJo971wzPG320Cr4ei5n8FjoPqsNRC/sBQhpBRy3FWWHn7ysHPW0
         LY6Jmq2nQLEukQRziXJban++K/Kva/xuLIO6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1kNbjhH0GpClGiRwzQUpR4hJv6EHO3XdnhQiyv1Zn4I=;
        b=EQoHp8kdVkXRB8EoD9mR/LbsLN/M3F9j9tl8qvnxHqKnFtT9ZRYfPv5LjYo+iBbZLm
         0OStMdqfOTj+jPKzlpToZEHE6xMrnJ+u829stcVNSZ5LXfS6Te33YGsdD6kIK0RiNS3z
         ymxEMfL9Y5he9C7qvYd2rJOpmu7/rcSZsU3HTG5SVEK1lsHU9Th2hE/lXFWSQ7ph6ICq
         wdq/exh5xbGuxuETat3GbBIHVAW+355pgV3UPhrWXxa6EVXj2XIxk9K5/aCRfgSBAfMk
         +/00KJOdS/I01CxM/E7Drwv1fXyMQy9Az332mLQc1k6UAtZhmlJeLlsfMVVapvZYvM4/
         JWrw==
X-Gm-Message-State: AOAM533dR+yXBNOvLoh3H5/i8qDl+rmfMbRbmb7U50XlJZwTAxQAy0vn
        XAVvH3JORN5eKQsHV0ObDMOa9N6KirOIQJga
X-Google-Smtp-Source: ABdhPJwjVgmnMI6inMN4wbK3Y/0BgYtqG3XTMaB/dQxzXaLIwvArMQymH6g+mUGjPWW/4wzoa3WE3g==
X-Received: by 2002:a05:6512:3caa:: with SMTP id h42mr7792458lfv.613.1625431943767;
        Sun, 04 Jul 2021 13:52:23 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id e16sm877957lfq.295.2021.07.04.13.52.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 13:52:22 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id t17so28774224lfq.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 13:52:22 -0700 (PDT)
X-Received: by 2002:ac2:42d6:: with SMTP id n22mr7866162lfl.41.1625431941847;
 Sun, 04 Jul 2021 13:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210704202756.29107-1-ojeda@kernel.org> <20210704202756.29107-2-ojeda@kernel.org>
In-Reply-To: <20210704202756.29107-2-ojeda@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Jul 2021 13:52:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wisMFiBHT7dLFOtHqX=fEve3JafZjSvbd5cy=MpW4u7zQ@mail.gmail.com>
Message-ID: <CAHk-=wisMFiBHT7dLFOtHqX=fEve3JafZjSvbd5cy=MpW4u7zQ@mail.gmail.com>
Subject: Re: [PATCH 01/17] kallsyms: support big kernel symbols (2-byte lengths)
To:     Miguel Ojeda <ojeda@kernel.org>
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

On Sun, Jul 4, 2021 at 1:28 PM <ojeda@kernel.org> wrote:
>
>
> +       /* If zero, it is a "big" symbol, so a two byte length follows. */
> +       if (len == 0) {
> +               len = (data[0] << 8) | data[1];
> +               data += 2;
> +               off += len + 2;
> +       }

Side note: it might be a good idea at this point to verify that "len" is >255.

Also, why is this in big-endian order?

Let's just try to kill big-endian data, it's disgusting and should
just die already.

BE is practically dead anyway, we shouldn't add new cases. Networking
has legacy reasons from the bad old days when byte order wars were
still a thing, but those days are gone.

           Linus
