Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442063564D3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 09:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346199AbhDGHNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 03:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhDGHNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 03:13:13 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666E0C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 00:13:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id r8so9288199lfp.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 00:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=1duyocgLk2hEhX2K9ALNo/yISDtpiTKPyYC4EC6WDJM=;
        b=jiLUdMSCffdrH06JKNega4yKrS+G2VAC4YoYqQNb/V53MLen81N5I17AR9NhsrtTW+
         9RJyWPAyq5m3onQsxc9Dylkg80u17q8zDdbm7Sk1AESTFEekJEN6qQ5xqMw3DWK5Bxh2
         VHnMbNNjSr1WHcRWkShdQow+tMoxEzolhu53gI97XLYk2BAZ8xECwsBF5j9YRk5BDDZm
         7khxd9fDm31zdwT94haP2fgzIvr3mCc4qFPRJJCutZ3qLcNT0q/cYGcTdcCZSACPkEG2
         0Rq2wS3JTC/z2kuBgStDrEMilR4WZWiU3ITbD2pKliWOs09M6vi0Kbj/isXf8+e8Wi/E
         BeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=1duyocgLk2hEhX2K9ALNo/yISDtpiTKPyYC4EC6WDJM=;
        b=XlwqyZQZ+CW6VSpFcFEei/f2dzOiraV3D2/CmHrCVzynuLkulC2qmZjAi4jqkf5ObR
         MSm63L12h7S20Y2eKqm5sRDOaLdG/H+N/eQ9/Fy+Xzq+HHKeN7/4W3ePLvqW2j+5oBlD
         KEdACQPKex6NjgdzlMZFJalJm6qDiw79QGBNsU0sc6s6bTs5n9TmlsnquikiKOHxlRYM
         DwOdL5JihhRfwj5VWS01iwfsg0aWPK5DYAZPgIVAle2lki+Z7r1GebRf4YwSkSRAAKa5
         q7VdoGOMtHAQPsKuQrH8BLP1xTuYjgmqy/T3d/RAQ2nwffdaPNDrRXEiU5Q0/4GYwR8Y
         a/YQ==
X-Gm-Message-State: AOAM533X2s9hNb/NaeBj+67/v5FbngycFChXT69j94uTZMKDwT41uh++
        LaP7U3DcewN8hpW2hCAEWM4=
X-Google-Smtp-Source: ABdhPJxBy5dXrEOlwkezRdPm5zALAijWjyrwxex6qoDNaSY1p3AYn3ps9CKp9kls2kXFbsLq5/OvHA==
X-Received: by 2002:ac2:5684:: with SMTP id 4mr1584522lfr.378.1617779581947;
        Wed, 07 Apr 2021 00:13:01 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id g13sm2456027lja.124.2021.04.07.00.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 00:13:01 -0700 (PDT)
Date:   Wed, 7 Apr 2021 10:12:58 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
Cc:     melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        rodrigosiqueiramelo@gmail.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH V4 0/2] Add virtual hardware module
Message-ID: <20210407101258.72261c5d@eldfell>
In-Reply-To: <cover.1617602076.git.sylphrenadin@gmail.com>
References: <cover.1617602076.git.sylphrenadin@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8TxTFn5ZIDfMBvvPli94ZI="; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8TxTFn5ZIDfMBvvPli94ZI=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Apr 2021 11:41:50 +0530
Sumera Priyadarsini <sylphrenadin@gmail.com> wrote:

> This patchset adds support for emulating virtual hardware with VKMS.
> The virtual hardware mode can be enabled by using the following command
> while loading the module:
>         sudo modprobe vkms enable_virtual_hw=3D1

Hi,

every time I see this cover letter subject, I start wondering "what is
this virtual hardware module, yet another one?" and then I read the
cover letter and realise it is about adding an option to VKMS.

The next time you revise this series, could you perhaps clarify the
subject?

The idea of having a mode where VKMS behaves like a virtual hardware
driver is good, IMO. I do think "vblank-less mode" describes it better
though, because I would assume things like USB display drivers to work
like this too, and VKMS is already a virtual driver anyway.

To clarify, as a userspace programmer what I would expect "vblank-less
mode" to be is that the DRM driver completes pageflips and modesets at
arbitrary times, perhaps always immediately or perhaps with a variable
delay that depends on how much processing is needed for the update.
Also vblank events do not fire and vblank counters do not advance. Is
this correct?


Thanks,
pq

>=20
> The first patch is prep work for adding virtual_hw mode and refactors
> the plane composition in vkms by adding a helper function vkms_composer_c=
ommon()
> which can be used for both vblank mode and virtual mode.
>=20
> The second patch adds virtual hardware support as a module option. It
> adds new atomic helper functions for the virtual mode
> and modifies the existing atomic helpers for usage by the vblank mode
> This gives us two sets of drm_crtc_helper_funcs struct for both modes,
> making the code flow cleaner and easier to debug.
>=20
> This patchset has been tested with the igt tests- kms_writeback, kms_atom=
ic,
> kms_lease, kms_flip, kms_pipe_get_crc and preserves results except for
> subtests related to crc reads and skips tests that rely on vertical
> blanking. This patchset must be tested after incorporating the
> igt-tests patch: https://lists.freedesktop.org/archives/igt-dev/2021-Febr=
uary/029355.html
>=20
> Sumera Priyadarsini (2):
>   drm/vkms: Refactor vkms_composer_worker() to prep for virtual_hw mode
>   drm/vkms: Add support for virtual hardware mode
>=20
>  drivers/gpu/drm/vkms/vkms_composer.c | 88 +++++++++++++++++-----------
>  drivers/gpu/drm/vkms/vkms_crtc.c     | 51 +++++++++++-----
>  drivers/gpu/drm/vkms/vkms_drv.c      | 18 ++++--
>  drivers/gpu/drm/vkms/vkms_drv.h      |  4 ++
>  4 files changed, 109 insertions(+), 52 deletions(-)
>=20


--Sig_/8TxTFn5ZIDfMBvvPli94ZI=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmBtW3oACgkQI1/ltBGq
qqdM0hAAmnlL9dhIQ0JJyfdKGqHPrJf2I89HJWh1aROB2K/N0nTIA+GSpXqEV2zA
N1Cr+Blw4zHVvTZFCg30lVpxNKVWYYb6xBaToJXi1TqI+1T6wmy3KULlg/JUlYTs
99EDZmfD8w5mLYvWuXZZrFQLluJPUztLr6KGWMkaB7l1e+NTioauxxP0vwRUjftp
UBqWJrbVq5XXwAOyjvXd4PnJJMxsOhH5w23b+8YnjNslfLBmXL2ns4wctKt3F+hk
bAaCXtmsK2Oaq/z4t9wFXkgcwUT8/wEEExbhaPt3QJj+ncte+WRCtso3AdlURFEi
LTQUhPJp+BKHCiWI99QtB00nOccRF74Uu31uzTM/BoMAcTgX4gbv4VQBCOZ7pyt9
StVAfmLtSlklAFOZxYVcY+ovP93i2QlmXygr38gbI0y6vamYN654PM9ml+xTeXEh
87eQeLmE9VGjS+BpsRtm+UZqYh6J9cBR/ZSA2fXFRzTkzS7fD1IS/+6jfYa3uCjf
sI1LFnjA1q5zwIb64R3td5rD8DfbYS9XMQiU4ih2/9rFkKpdQhaMzAPM3agOxB0C
YOB6fFVNqbt+Kvx+BFt5IeEDjmCp/WebNMKceQLfhgmV8xLl5U20irCB4fCh+27z
bqwUbirxnZ2LI6Yp/xty/7L2/5Ra67IGixTUQ7K6lNWqAUZHaH4=
=42dw
-----END PGP SIGNATURE-----

--Sig_/8TxTFn5ZIDfMBvvPli94ZI=--
