Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C4742004D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 08:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhJCG1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 02:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJCG1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 02:27:09 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3818C0613EC;
        Sat,  2 Oct 2021 23:25:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g7so50411974edv.1;
        Sat, 02 Oct 2021 23:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kvJcjdfW6jyuT4V41heP52jnVfo5D7zz195baLayYxs=;
        b=RoW3t/45Y4yiWjcd2TM9mvG6zhR0k5VsEc3WUGXs8wXfLLkZQGOFfVq741N2x6JcbX
         bKVQcXjyG+H4XFr2xfqFIiCElo5jZOBM/cccQ3bJwFDkLLIn4oUUNBZI+1xGNBuo99Hn
         5Acs7YFzHr4kYxLEffxXWRmYI7rd4L8c8DRk8TF+xcpdh1+Uz160Z7AXG5dCgnsEv0cV
         QJKypp9EXtE8yi/kS13J61GafSuYHzhsm/8WSUF+nOy3lrAhYlm/xExN75aM8nv38Ho1
         TD2pVbuFq/9n/Im1lVuypfCozisFOg7/KaC3htCq9tcIt6i8hVYePt43TWv56ZReJIc6
         8kQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kvJcjdfW6jyuT4V41heP52jnVfo5D7zz195baLayYxs=;
        b=YHqYgrJ2j8nRSAz5To2Z/wmpi9Y8nOdk8dIlEdTBCuBRllB0xttVD5O/o1mmZezPFp
         yWqLT7L43ROpnrvPMtTeUVY/OQaLxPhLAKKiDHV3QR901Ta67tgLCShQ1WICBvd/0pG/
         weuhv+z5tmL3Ei1xVkQNA/p1hQ0AgwEqSXRc7vtm50+dvK6W1/GDeNckP6m86I84um62
         uEFY4TeHLA1CXnTUmNyj8hIDKCY2J8vQ9hokCBWbV1K4y4uaUejfMZLRoJmJOSBNIZCK
         zdkd7uXBzGflAs74gbitog7e9bxenMgOKznJYedn/+g6paoZJAYeJmnMH1J2vm6tPXI9
         sOdg==
X-Gm-Message-State: AOAM533pg4HqfakgVUX8y9rH/EAjoGjb92TZ/0o00T+RK1CuSslRC4dH
        iUSVYXiK8CE2lbrkGKVr24xaUeMis21fDelQa2Kbnmruk7FIfQ==
X-Google-Smtp-Source: ABdhPJzoRSc47RaOPtpeWuwOEtBSwnWkRWljE4vclzQ106ETaIcZlvuUfO7j0Qkf/AQqbvAw6Izf/Rwv8+JG6auHHsw=
X-Received: by 2002:a05:6402:143b:: with SMTP id c27mr9336197edx.224.1633242320293;
 Sat, 02 Oct 2021 23:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211002210857.709956-1-pauk.denis@gmail.com> <20211003003410.28248af4@penguin.lxd>
In-Reply-To: <20211003003410.28248af4@penguin.lxd>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 Oct 2021 09:24:44 +0300
Message-ID: <CAHp75VegZNh=1+tc9BYhDGzxV6dx4wZDmfx7ET9nXr0+yT3bGQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Update ASUS WMI supported boards.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        matt-testalltheway <sefoci9222@rerunway.com>,
        Kamil Dudka <kdudka@redhat.com>,
        Robert Swiecki <robert@swiecki.net>,
        Kamil Pietrzak <kpietrzak@disroot.org>, Igor <igor@svelig.com>,
        Tor Vic <torvic9@mailbox.org>, Poezevara <nephartyz@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 3, 2021 at 12:37 AM Denis Pauk <pauk.denis@gmail.com> wrote:
>
> On Sun,  3 Oct 2021 00:08:53 +0300
> Denis Pauk <pauk.denis@gmail.com> wrote:
>
> Patches should be applied over
> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git:hwmon-next
> (0889b7c73a4d8eaaa321eafcf66835979ead862a)

You may use --base parameter to git format-patch for this.

-- 
With Best Regards,
Andy Shevchenko
