Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0BF453498
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhKPOur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 09:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbhKPOui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 09:50:38 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84253C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 06:47:41 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id r11so25138726edd.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 06:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mgaqjk8sgzbSZfMvDCSzKXjRpwlwJK3+PAYiZNEuOBE=;
        b=nV/7kFKtbhV4ChQ9ucaq7lglpxHn2UyUeU00RAxwvn0aQn9ywvmJO1dJCH2H3rlnT/
         RPoVFac2heZmhtOPq+gwUaBv9O6eqNaFfyIczRVZI5bg3d92EZYiHpEf7uwk2pAHpVPd
         nIeRMcDdxUZr4zE1jkv6OMYH0zk1YjndhjSNI/4Aj3t2l3q5XcWVseL9+06iStE9i+W/
         Go5Bmj+H6j0Gnml6h6TttWRId+7o9bPnnQTul5yNBmwDKVxY2Tu5sI3iFP+F6rXQqXuI
         y3Vjz6ozUASBDVNrCXCMtODVVvyRn1WCL69AnOEI4TCcrA2Ii4tYtG0jUFsLAOm8ty2V
         Uc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mgaqjk8sgzbSZfMvDCSzKXjRpwlwJK3+PAYiZNEuOBE=;
        b=WQEPTTlGhI2Qa4j116OzUDAZKQ1NSAsGd3jRUnhZSm4tCf8r5iin7wH6mSukfafH+c
         H0SZAZ0oc2vtggW6nTxntf6ysl4ReTPkXp0tFRh0IxVAYSzdaQSTAcg5AOoKSyaika9k
         MT1NcibIhbXD1mmD7fVT1WIzOiruU3T2GlgM3arq2M7wR9RNhCrFAWPRZqurEEd5Iwy2
         6xltB59BdmARPHQeARCcfjKcS3lMe6dNcGoTZG0Jgw6gGs1DWsv7RtR99cvu9r+CUVhM
         tmPEoj5wrPD1ZqB1gKpIfGIG+wPchq7+IZuAygm1mY3QbmXJYu9W3I3TF+UcNMFcu1y7
         1iSQ==
X-Gm-Message-State: AOAM530lFC7KlULv2W0ORywEZvU7vef9bkkPXhMgSTCaxaid6zE8OUOp
        YOGQ59+6VshNthIyhQQN3tyWPQO6A4MAtxRx/L3Eyg==
X-Google-Smtp-Source: ABdhPJxz70hgLYrABSLSFXH5Gg+bcgsU1RfiTzsk+WCrJ+nxltCEmGAkIEe4gDw2GOEMoqO92TBYbIsiqbdWyf4FlJ0=
X-Received: by 2002:a17:906:3b84:: with SMTP id u4mr10651360ejf.310.1637074060018;
 Tue, 16 Nov 2021 06:47:40 -0800 (PST)
MIME-Version: 1.0
References: <20211116143842.75896-1-andrzej.p@collabora.com>
In-Reply-To: <20211116143842.75896-1-andrzej.p@collabora.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Tue, 16 Nov 2021 11:47:28 -0300
Message-ID: <CAAEAJfANEficRLg2JCvOmv_pv9j9tEVPPsph4n4TYkeBjeUWiQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/12] VP9 codec V4L2 control interface
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     linux-media <linux-media@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Heiko Stuebner <heiko@sntech.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 at 11:38, Andrzej Pietrasiewicz
<andrzej.p@collabora.com> wrote:
>
> Dear all,
>
> This patch series adds VP9 codec V4L2 control interface and two drivers
> using the new controls. It is a follow-up of previous v7 series [1].
>
> In this iteration, we've implemented VP9 hardware decoding on two devices:
> Rockchip VDEC and Hantro G2, and tested on RK3399, i.MX8MQ and i.MX8MP.
> The i.MX8M driver needs proper power domains support, though, which is a
> subject of a different effort, but in all 3 cases we were able to run the
> drivers.
>
> GStreamer support is also available, the needed changes have been submitted
> by Daniel Almeida [2]. This MR is ready to be merged, and just needs the
> VP9 V4L2 controls to be merged and released.
>
> Both rkvdec and hantro drivers are passing a significant number of VP9 tests
> using Fluster[3]. There are still a few tests that are not passing, due to
> dynamic frame resize (not yet supported by V4L2) and small size videos
> (due to IP block limitations).
>
> The series adds the VP9 codec V4L2 control API as uAPI, so it aims at being
> merged without passing through staging, as agreed[4]. The ABI has been checked
> for padding and verified to contain no holes.
>
> [1] https://patchwork.linuxtv.org/project/linux-media/list/?series=6393
> [2] https://gitlab.freedesktop.org/gstreamer/gst-plugins-bad/-/merge_requests/2144

Due to GStreamer monorepo, the MR has been moved to

https://gitlab.freedesktop.org//gstreamer/gstreamer/-/merge_requests/1012

Thanks,
Ezequiel
