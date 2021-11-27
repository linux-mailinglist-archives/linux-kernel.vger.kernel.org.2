Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC4045FEC1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 14:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354984AbhK0NQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 08:16:05 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:48724 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbhK0NN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 08:13:59 -0500
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id DFADCCC4043;
        Sat, 27 Nov 2021 14:09:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1638018555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/UyMvM3QI29OvYkCsq7IIUqH6nCYa7tbR75T/cLDADQ=;
        b=ZO1GIbanTDXhb+4ooHDQd/B7jvCLahZX9qz1XiOUc8d2lZ8awIhCBm1peK4CwpWIQmI1+W
        34brQ+VO5yOAdSdrN+zEJjQDTA2CjkJoJUi5OzOwt1tz3kM64hxzTvTNLLMsgEO8cja/97
        ENOxQF8tchpmFQPb994v2m9ZKxI30+A=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     akpm@linux-foundation.org, SeongJae Park <sj@kernel.org>
Cc:     john.stultz@linaro.org, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v3 0/2] mm/damon: Fix fake /proc/loadavg reports
Date:   Sat, 27 Nov 2021 14:09:13 +0100
Message-ID: <51190182.RbnaydPRjS@natalenko.name>
In-Reply-To: <20211126145015.15862-1-sj@kernel.org>
References: <20211126145015.15862-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On p=E1tek 26. listopadu 2021 15:50:13 CET SeongJae Park wrote:
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
> From v2
> (https://lore.kernel.org/linux-mm/20211125160830.30153-1-sj@kernel.org/)
> - Cc Oleksandr (Oleksandr Natalenko)
> - Add 'Suggested-by:' for Andrew Morton on the first patch
>=20
> From v1
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

=46or the series:

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thank you.

=2D-=20
Oleksandr Natalenko (post-factum)


