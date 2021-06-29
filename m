Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83943B6F1F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 10:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhF2IP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 04:15:27 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:33115 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhF2IP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 04:15:26 -0400
Date:   Tue, 29 Jun 2021 08:12:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1624954376;
        bh=Wt1VzxpUKhVa3HzTLpE5SfzFn/YP4YxfPtnwrLRl/ko=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=kT+JW4ZQ/XLWZcl11bQR37x0+KSRaeQZh+kE4omXiV6BfWIXtXDd9WyZtDYY/JY9Q
         1zd79RntcYijrdG1waxiPh2nou/ZvBfvcZypHdKrnM3PwLNucQr0OzCcTVrq4rh8Ni
         m00QGUE0GcaCzer16iFx8ghVLePzrSLxcbmBR4jKdOIvbVxdAc9OX7/52DB/6bp8/J
         0WoLL0L4vGQIbORx3tk9vDc6XpknNlwi+5ZDIdukmY8s898XGiSCv8U8BfB9vVj2WN
         cqt8zTHmvFnErL8LXt3H3nz10WMmR/gSmecxKqQLAOoPnTlcU59248/yhsU0VgsSln
         j3LySWnSFt73Q==
To:     Pekka Paalanen <ppaalanen@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Werner Sembach <wse@tuxedocomputers.com>,
        amd-gfx@lists.freedesktop.org, tzimmermann@suse.de,
        intel-gfx@lists.freedesktop.org, sunpeng.li@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, rodrigo.vivi@intel.com,
        alexander.deucher@amd.com, christian.koenig@amd.com
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v4 12/17] drm/uAPI: Add "preferred color format" drm property as setting for userspace
Message-ID: <jIDQ2rRRMWlhDDPf08Z8xZlEE8HTBx7fHsylFdK0joSSFVyES8D444Giyiji9zbIm7dU4QpbsXZLvIDTbGW0wEoUWKsMEI4evizn0UdGMvM=@emersion.fr>
In-Reply-To: <20210622101516.6a53831c@eldfell>
References: <20210618091116.14428-1-wse@tuxedocomputers.com> <20210618091116.14428-13-wse@tuxedocomputers.com> <20210622101516.6a53831c@eldfell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 22nd, 2021 at 09:15, Pekka Paalanen <ppaalanen@gmail.com> =
wrote:

> yes, I think this makes sense, even if it is a property that one can't
> tell for sure what it does before hand.
>
> Using a pair of properties, preference and active, to ask for something
> and then check what actually worked is good for reducing the
> combinatorial explosion caused by needing to "atomic TEST_ONLY commit"
> test different KMS configurations. Userspace has a better chance of
> finding a configuration that is possible.
>
> OTOH, this has the problem than in UI one cannot tell the user in
> advance which options are truly possible. Given that KMS properties are
> rarely completely independent, and in this case known to depend on
> several other KMS properties, I think it is good enough to know after
> the fact.
>
> If a driver does not use what userspace prefers, there is no way to
> understand why, or what else to change to make it happen. That problem
> exists anyway, because TEST_ONLY commits do not give useful feedback
> but only a yes/no.

By submitting incremental atomic reqs with TEST_ONLY (i.e. only changing on=
e
property at a time), user-space can discover which property makes the atomi=
c
commit fail.

I'm not a fan of this "preference" property approach. The only way to find =
out
whether it's possible to change the color format is to perform a user-visib=
le
change (with a regular atomic commit) and check whether it worked
after-the-fact. This is unlike all other existing KMS properties.

I'd much rather see a more general approach to fix this combinatorial explo=
sion
than to add special-cases like this.
