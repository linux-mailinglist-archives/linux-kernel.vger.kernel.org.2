Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23393459AE1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 05:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhKWEFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 23:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhKWEFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 23:05:52 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D06EC061574;
        Mon, 22 Nov 2021 20:02:45 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id l7so3079609lja.2;
        Mon, 22 Nov 2021 20:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=4EJY1gkp3LE3gjic7mcz+HotO35IRcV/tRjRxqm868Y=;
        b=VgA8l5At8SFzey4xpUxmZGxxiZZvdh6t7N+GVvLjfcNhs71mvbqoA9z2BVBW3w5Xqg
         55//v/P7k82Fayf7vgKF3cFeoC2AwBrP7R78aqZVkEJRmgBsqA1qMtDd1AmH8zAxGbyV
         uEJ3wu0ZOYJIseDNny8dFH6+UDQbE534UXs6p1qZs/+h51FWyOXKa5NvPRdmPJLC1Hkw
         UX6MA7IueQnURYIna7UOsW4yRmJpsIzcid2mAdg8Aa8EYbDKDwaC+Af2PW2uk4osGgJt
         2ASJPaCE+O655AyGU3Dq0+KAavIXuQfKzfzIyvQrkrrPZzK6AaULR7n96ImBfoLoRQOo
         /4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4EJY1gkp3LE3gjic7mcz+HotO35IRcV/tRjRxqm868Y=;
        b=HSAAJx0mSpt/oE1UvgIHCAjRd2vB2IxLhjK9ZvA9Jusr2C3PpSPvzQD7BB+znN+huA
         GSfy1j9n8aqqVcJH1akWHBHuVUT4VqZqO/a0Ks/79Op9PILPoiihPrg6jWePZhFopMEW
         ttZpPEfmL7kQLAe/e63dmg2LLZnrcgiPW8dcq9ID1gCb9hR5XUDUsa/R0kNuiluae8Tz
         zZN0+xtuFyaKcGI7IRIIUsoaV3bYy0ZrF4jNDsrKFkWvC2LWb7Kup/VKTyW8/L5kA4YT
         gyr2Efyq/SVUPIK/4VmkdEOA7mM/YkHL+AJui1cwG6gVQgJYlEiVwNAyeMyR3/cez1zx
         EFag==
X-Gm-Message-State: AOAM530iGnANHz0F6kxrR7t3wTOMZd7FGv7XfAD9WUGJzXhrwWZMpits
        1OdD3nlJl9pw5GXen/Y4cw4fVB4HJcAl5uxNOcR3/QWo8ZY=
X-Google-Smtp-Source: ABdhPJwqBsO4amMd9roYG7eC+KCWZ7f3lYllVXmC17QXWELsOgSCRjuj6k5YygG3ikjDX/K4byVpi6D96aMlUmJJ0d0=
X-Received: by 2002:a2e:810a:: with SMTP id d10mr1693077ljg.325.1637640163207;
 Mon, 22 Nov 2021 20:02:43 -0800 (PST)
MIME-Version: 1.0
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Tue, 23 Nov 2021 09:32:32 +0530
Message-ID: <CAHhAz+h2OgBMP8Mm+dNPuNEq=DhWdc7Y+dJEvrXz9kAUD7O2GQ@mail.gmail.com>
Subject: x86, nmi: IOCK error
To:     linux-x86_64@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The following message is seen on the console "NMI: IOCK error (debug
interrupt?) for reason 60 on CPU 0.", what does it mean?

Does this likely confirm the CPU is faulty? If so, how to resolve this?

-- 
Thanks,
Sekhar
