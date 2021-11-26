Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C0C45F006
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 15:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353224AbhKZOm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 09:42:29 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:42476 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350522AbhKZOk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 09:40:28 -0500
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id AB15ACBFF9E;
        Fri, 26 Nov 2021 15:37:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1637937433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XsT7BbzclkZONDz+Xm/rpdBzgDHUBzk2CdDy05rQbSo=;
        b=uNN95HhG5FAJuTITzs9HHG9rrtIywK9/Q1JzJT4PJAxnDZ/Y2hqZCrFZw6/Y6CfKm21dp/
        LPPVA/n4Eg9tAPoIQ65K0zWD0I0sBVhb8moHp4ctgiw1llzjVJHT8wt2liPlztsS6BwvOf
        G1rbCyZ8s3vV5NYQjyA142oApkbqJiA=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     akpm@linux-foundation.org, SeongJae Park <sj@kernel.org>
Cc:     john.stultz@linaro.org, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v2 0/2] mm/damon: Fix fake /proc/loadavg reports
Date:   Fri, 26 Nov 2021 15:37:12 +0100
Message-ID: <23071693.Kees4NU7H7@natalenko.name>
In-Reply-To: <20211125160830.30153-1-sj@kernel.org>
References: <20211125160830.30153-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On =C4=8Dtvrtek 25. listopadu 2021 17:08:28 CET SeongJae Park wrote:
> This patchset fixes DAMON's fake load report issue.  The first patch
> makes yet another variant of usleep_range() for this fix, and the second
> patch fixes the issue of DAMON by making it using the newly introduced
> function.
>=20
> I think these need to be applied on v5.15.y, but the second patch cannot
> cleanly applied there as is.  I will back-port this on v5.15.y and post
> later once this is merged in the mainline.  If you think this is not
> appropriate for stable tree, please let me know.
>=20
> Changelog
> ---------
>=20
> >From v1
>=20
> (https://lore.kernel.org/linux-mm/20211124145219.32866-1-sj@kernel.org/)
> - Avoid copy-and-pasting usleep_delay() in DAMON code (Andrew Morton)
>=20
> SeongJae Park (2):
>   timers: Implement usleep_idle_range()
>   mm/damon/core: Fix fake load reports due to uninterruptible sleeps
>=20
>  include/linux/delay.h | 14 +++++++++++++-
>  kernel/time/timer.c   | 16 +++++++++-------
>  mm/damon/core.c       |  6 +++---
>  3 files changed, 25 insertions(+), 11 deletions(-)

I'd appreciate if you Cc me as a reporter since I'm going to test this.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


