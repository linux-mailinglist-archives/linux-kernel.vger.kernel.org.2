Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DD1322FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhBWRpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:45:16 -0500
Received: from mail-40131.protonmail.ch ([185.70.40.131]:13992 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbhBWRpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:45:11 -0500
Date:   Tue, 23 Feb 2021 17:44:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1614102268;
        bh=BfG9OrbmBqNgKkcmelq97SJlZ+CtFojaf6Sw7blBg4M=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=k+vipebctkBPk5Y5rqzJxjWp6xU5O2k6NKU+w2LmQM8zg+dCS2eHV0eb0kv2yQY0+
         HVX44ICA2J1K8E87n/HqLAI2RvAHxRc5wwSM1P8+RYFoszkZWR3Qob4vnzuwrpO6Wm
         Fe1Ws0w6+6ivYkrlcZyMFI7KOh4LGpjgKCVIEDHiLgPt8swSv8KkMhtzKmq0Smm1mW
         sxZKpdM75tqH2ldtaWqHnZdK0yuqolDlj2z/4hA9gYnpNmyAf9B0o8uIkT15MoUhFA
         cmvCcgqfiSL1DtdrxMGzLcjK3S/KkFHOui/sj7dI37j4dp1h16btFxHq2aL1tqcsKi
         q5kuW9jem5ZFw==
To:     Alex Deucher <alexdeucher@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Stylon Wang <stylon.wang@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dave Airlie <airlied@linux.ie>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amdgpu/display: initialize the variable 'i'
Message-ID: <SPaFghh3lWax7Iwge3u3t7hAegI3wGyl7euN4azxZEVvTky4UCXmPq7QQSFFd38dgg3kgkhuJpjB_D3ob7Tqf5Oc2DGKCwHZIWzfit15Uyg=@emersion.fr>
In-Reply-To: <CADnq5_MXK_H-g4GReU1dGca2PAXsGjbzg47kcWjXFQ4DrYG8tg@mail.gmail.com>
References: <1614021931-4386-1-git-send-email-jrdr.linux@gmail.com> <32vjVDssCxltB75h5jHin2U3-cvNjmd_HFnRLiKohhbXkTfZea3hw2Knd80SgcHoyIFldMNwqh49t28hMBvta0HeWed1L0q_efLJ8QCgNw8=@emersion.fr> <20210222234457.GA36153@24bbad8f3778> <yHvp7KbQD2pF5dR6krMc_Zuq9a8GxkYSSiIpjBenuiCjwpFmFxpAOpfzhp0DfHQhH2Z3P81-CGpwmmXp0zjifT93vBXXYd5kJsSucQgXFZI=@emersion.fr> <CAP+8YyGdr0jkf5_K8ofKMzZn5Koy_vkxyKKHkyVDqDz2sWvL_g@mail.gmail.com> <CADnq5_MXK_H-g4GReU1dGca2PAXsGjbzg47kcWjXFQ4DrYG8tg@mail.gmail.com>
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

On Tuesday, February 23rd, 2021 at 6:42 PM, Alex Deucher <alexdeucher@gmail=
.com> wrote:

> yeah, fdo ran out of disk space so I moved to gitlab:
>
> https://gitlab.freedesktop.org/agd5f/linux/-/commits/drm-next

Ah, thanks for the info, my bad!
