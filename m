Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66BA451C06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354453AbhKPAKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353236AbhKOUza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 15:55:30 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38621C06121D
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 12:40:37 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id e7so23644168ljq.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 12:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uNjovAaYEwEX+9pEiPHL3nyMOKYDJCekov5XCnVxgSM=;
        b=K9LARW9f0PVDjm+kSpfLEsn7QhEtjlOxiiT/vf4RvIztYbfjRBWnViIhK8FBmQZpfF
         139J6qLOAOOwndotjONQjKTcg5TgqflwSq+q56EpdajW1paaUd6B00yH8mfAN4exUPDh
         UQ8d5XxuZo5YrXejK6lvLKfS3jerO5bXuxU1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uNjovAaYEwEX+9pEiPHL3nyMOKYDJCekov5XCnVxgSM=;
        b=w+iwaMXxR/mmXo082NOZAbpB++A1+dW64u1N9YDjwJa8TEokB8oRKWJPZ3bchJTZPi
         onm2T8fAyRmdYfMkpkWaZS+EofKBCJURzN46zM1AJngdsEzAj3M4djO5z8wG6tTMXObs
         u/YvFJSX55kjxT1vMQeT0b1cihT6CmXUGRwaX31hVffzTYcaUvg1smnEgufpUImCo/1c
         OS4xvqINpRrzxOSURQZVLUGn+l+rUNpx+IpgYMT5xKzSHUxoiVQZZvPMOjgh3t6wjHoZ
         aaBn20DSGQ8vhmWO//eyZl4NTZJ0C7kzl4rFbbdCoLbgj6z82UqX0fHgF+A7NQtOIfqR
         GZHw==
X-Gm-Message-State: AOAM5327+z1BJFKqInsyUJCLJY4JEsgbhV2LDYBC2fsGaID1yrLKZj0O
        L7aBYEN/oU61OydJqNRo1Na+vcWd2RkO0RPndJuO4w==
X-Google-Smtp-Source: ABdhPJy46/oA5NQEOvwBsbpyFAKV6VUxSr2NwSGUgy9eBRPnDjHeAl/tOF30YpAfDqsQbO8zFhO+aDFgD1tgvDWeExY=
X-Received: by 2002:a2e:530b:: with SMTP id h11mr1404687ljb.95.1637008835332;
 Mon, 15 Nov 2021 12:40:35 -0800 (PST)
MIME-Version: 1.0
References: <006a01d7cead$b9262d70$2b728850$@lucidpixels.com>
 <a4a88807-8f52-ef9a-c58e-0ff454da5ade@acm.org> <CAO9zADxiobgwDE5dtvo98EL0djdgQyrGJA_w4Oxb+pZ9pvOEjQ@mail.gmail.com>
 <CAO9zADycForyq9cmh=epw9r-Wzz=xt32vL3mePuBAPehCgUTjw@mail.gmail.com>
 <50a16ee2-dfa4-d009-17c5-1984cf0a6161@linux.vnet.ibm.com> <CAO9zADwVnuKU-tfZxm4USjf76yJhTZqWfZw4yspv8sc93RuBbQ@mail.gmail.com>
 <e0c2935d-d961-11a0-1b4c-580b55dc6b59@acm.org> <002401d7d305$082971b0$187c5510$@lucidpixels.com>
 <CAO9zADzWcpwZkfJ5VZGZZJT39KQEUr9yGqqCnP18mk7ZAZxbBw@mail.gmail.com> <3bca3296-d998-98a5-bf8f-53b0720869d3@linux.vnet.ibm.com>
In-Reply-To: <3bca3296-d998-98a5-bf8f-53b0720869d3@linux.vnet.ibm.com>
From:   Justin Piszcz <jpiszcz@lucidpixels.com>
Date:   Mon, 15 Nov 2021 15:40:22 -0500
Message-ID: <CAO9zADzTO+ArYgbUkvAPVD0Ay2+iwmaMpQsysnsBL509oCnsYA@mail.gmail.com>
Subject: Re: kernel 5.15 does not boot with 3ware card (never had this issue
 <= 5.14) - scsi 0:0:0:0: WARNING: (0x06:0x002C) : Command (0x12) timed out,
 resetting card
To:     Douglas Miller <dougmill@linux.vnet.ibm.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 9:16 AM Douglas Miller
<dougmill@linux.vnet.ibm.com> wrote:
>
> The commit I referenced earlier does point back to the commit that
> caused the problem (that I saw). There was a series of commits related
> to IRQ domains, this one seems to have actually caused the problem I saw:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a5f3d2c17b07

Incase anyone runs into this issue, it appears to be fixed in
5.16.0-rc1, no more freezing at boot:

$ uname -a
Linux atom 5.16.0-rc1 #2 SMP Mon Nov 15 15:37:25 EST 2021 x86_64 GNU/Linux

Justin.
