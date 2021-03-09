Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C39332EF1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhCITXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhCITWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:22:39 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3146CC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 11:22:39 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id e7so29116784lft.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 11:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N0kD1kcQzrvfpd7nSYUcOVqOYr5j7K/WTSKvEa5U8Nw=;
        b=b2afgc4asAMQ4tNI3JUz7MaXQr73HLzo+ocjYLblcejIHnSr0vKUZ8Je8qjekn/P/0
         0gLUd5hIiQsD88j+HURA9mboJtzEAs19IJEg+qayVHgs80plLdPj2NXk024L+MW63Qt6
         IzVnYn4ekXksrdlZmgI5lP1w/bJmMu/qMTNJ409y+O1eOycyovxNqR9p5lI9he/9GKfu
         IVC4wtl0st6VJjQg6bW74DvHuqibavvOxmCUjJ+VfrlTRACceF3qUvM9EO4pgHn4/Gct
         sbupjpZVYW6G0GFMj3QJo4V7ukPLgiU0QG/tsakA3vxuk/1g8s+jLK5XHJcgp2GCi4Xy
         YdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N0kD1kcQzrvfpd7nSYUcOVqOYr5j7K/WTSKvEa5U8Nw=;
        b=C1R43HOjhwF+BHk5HfJ+0VZFL/Zlaw3M0dAsNeFMBqurMaGHO0pHckCCbeq9oQU3mk
         yS1qwbJgZgzitNvCUfsn2G7DeQ3aB8Vt0VYMBHjoMjS11bLZOhO0QjunHsGgyN1bPXqt
         u8lDl3yl8kL6LsefYgySt4SVT/Q3sRoaMqliNB7hQAWaDiNuGk6mVSfvhIQoHNyHoq6V
         C9Oi3Cgb+rZn+IOfKcDHThr6aYyRKLjDAl6xHo+M+mLGH3T+HgfzQP29r0PTr7ayeG6m
         axRwyavVn8SJeBDk871eEU9j3vJPmR6AQEaHcdJIilgLUf9IVCYSJbMsEop4aAy6mcMg
         /W9w==
X-Gm-Message-State: AOAM532Pfbxp/LVli4RKjQRyW6KmTBYPtGT1wguTPwjQVQWyfyYM98+3
        MTctzda6+d9b0fxk/UVy29QOIXnSMTR4vg7QCN6l0w==
X-Google-Smtp-Source: ABdhPJycU3ZIgvK1ZdCEFpdjc8wc5b2x2xjo9AZl4B+IO1f7kzu5c1/R9vn2tDQIHS7lptmmFvi5zmnqmH8bT89L6Gk=
X-Received: by 2002:a19:f508:: with SMTP id j8mr17538557lfb.153.1615317757491;
 Tue, 09 Mar 2021 11:22:37 -0800 (PST)
MIME-Version: 1.0
References: <20210206023118.1521194-1-rkir@google.com>
In-Reply-To: <20210206023118.1521194-1-rkir@google.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Tue, 9 Mar 2021 11:22:26 -0800
Message-ID: <CAOGAQep2y2SM3quAcXSghBM3MHak4wtPGzWpZoYcza1ckosX5Q@mail.gmail.com>
Subject: Re: [PATCH] Remove the GOLDFISH dependency from BATTERY_GOLDFISH
To:     Sebastian Reichel <sre@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Lingfeng Yang <lfy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 6:31 PM <rkir@google.com> wrote:
>
> From: Roman Kiryanov <rkir@google.com>
>
> This will allow to use the BATTERY_GOLDFISH driver
> without enabling GOLDFISH.

Hi Sebastian, could you please take a look at my patch?

Thank you.
