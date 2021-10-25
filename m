Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A3643A876
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 01:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbhJYXuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 19:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbhJYXuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 19:50:14 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10283C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 16:47:51 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id o26so16447634ljj.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 16:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0MHONJ1Tiqh/QXhH03y+bZKGvViBQu6ZRWiSgU9PGS0=;
        b=dDQGCv0xFFdG2csGc5FZKB8kDb2ebyiukFDaUkTvM6JaJNVr7CYuqrmfQzbEu1vA2c
         mmE+fGSDa0VHqXbtaZcZhEZJtzTceEbHAvHPHBlYBaVSD2lpOnswV5w2ceXgdnwdfkIc
         djJ0KBHxIvXKNC0FcEL7++GtN+qwVqBPM++rM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0MHONJ1Tiqh/QXhH03y+bZKGvViBQu6ZRWiSgU9PGS0=;
        b=23qpA4mE7/TD8UKkZEKSeDVdX6L3DuJ7zdFcX4HSH+Ips1KVhqmnCPig1C8MI+dNt8
         cKxW0JqxJFG2mYnnG7TNYQLnPz+PEYWzanse+9p3U/zQprEQkbHCckn2xcmlQTy+zF+8
         l4jvFZwLv7DEGsmXcASdLij/XE0z3bNxP7HavBLW1bT0idI91jX824xLw5aVGBYcR88P
         jNoFHOiXVcJZDL6WoCAugaMyRaFTsizKyVsWAqg66Ne5OFdRzKYA9V3lzZTih475z6mQ
         Rk5nJWAwjwZe1Ndqb+PBI8ftiL2NqMECXtj8+1V1JCXTG+9WjEJuOHMNrBLvfx4jGr6D
         Nk0A==
X-Gm-Message-State: AOAM5320zYGmET7X3BmArAgy+glR6Yt8RxVUeeTOBo1lpjLo9JEo4GVd
        wzUqfWEKNyIM4HnsddKrytB0EWtJekZDAa0+
X-Google-Smtp-Source: ABdhPJwAzUqZsr/tCa4aGlqVnXRKJJi0ZoW6p72TrTvAk5dMQjQ9LjEm/Liffvkv2V7IvNBAdrr3Ew==
X-Received: by 2002:a2e:a584:: with SMTP id m4mr22941170ljp.489.1635205669242;
        Mon, 25 Oct 2021 16:47:49 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id p3sm1769391lfa.293.2021.10.25.16.47.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 16:47:48 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id o11so19707435ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 16:47:48 -0700 (PDT)
X-Received: by 2002:a2e:a407:: with SMTP id p7mr22997653ljn.68.1635205668568;
 Mon, 25 Oct 2021 16:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wi1+boAQyckdiYXuBkybN4H_7OT569MwgyetWAfTExeEA@mail.gmail.com>
 <20211025233919.GA2394574@roeck-us.net>
In-Reply-To: <20211025233919.GA2394574@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Oct 2021 16:47:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxKG79X-Wz3xcFQtsB5XpK_Rn4oRr=h9uTL=OCHZ5=9w@mail.gmail.com>
Message-ID: <CAHk-=whxKG79X-Wz3xcFQtsB5XpK_Rn4oRr=h9uTL=OCHZ5=9w@mail.gmail.com>
Subject: Re: Linux 5.15-rc7
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 4:39 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Build results:
>         total: 154 pass: 154 fail: 0
> Qemu test results:
>         total: 480 pass: 480 fail: 0

Thanks for verifying that the rc6 failure case was fixed (and not
replaced with any new ones, yay!)

               Linus
