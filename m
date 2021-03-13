Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA1C33A0FF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 21:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhCMUZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 15:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbhCMUZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 15:25:15 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B42C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 12:25:15 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id r3so42697150lfc.13
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 12:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=272CAvfdNnBRAEObGGz44xaMW40FGoutsX7xZRwN5z0=;
        b=VrdHK7TfbhnIMxJD7Rl/IHggv2rVfZGT0NhZkD0zhn/OTghueRl87jaj1ucW3av5Kv
         b4i7QheIJvExWec8x6+vWF1Z4tV8TkfNDP4Xpm/ccKQ8RsNbDEIDBEyOruakmBL2uRwG
         KLLO0FNTW1B5hfoSfGWmTfRPsWi8j9ti4pNANjPAZe1d9gJvVFbUubfaZ2e73gawoAZZ
         SIxSEyqUCrL9hbGKiwMh1A1i2qWc0c14oNf20TsT2qUzQa6mRZcWqVRNxCsBz0+/cNBr
         yIFDyMoReIqe7bOokkm6U0NAr+2Oh2HP30ci7TgkAB6VeT/kU1/55+Jqn1TtiBCFU1ST
         OSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=272CAvfdNnBRAEObGGz44xaMW40FGoutsX7xZRwN5z0=;
        b=rz7+g0XzvgSTdl76OAVPC83jGYYSYVLgDiOOvtb+CbLuy1+N2yih4Of6JVLPAfyzmk
         12E34E9OezDD+1KQC05WrZIb8BOQvCF/OoBpvcU0drmkN/kzuCJ3EmWv0FgBfeqoh33X
         iF8om91iswn/KmSBqu2a/AYA/saUnyp9HS7AbK/z7eTqMGo7a5+gBTllQYnwxKqccS9E
         0saEasxOrgLP0AtZJIKEc33xV8v3DMa9OJpLHZan5tK8xR9+NySDGB+hJbc4BqAw6bMt
         +FWCd2Nn/WiB3ujzfXZudecMDGja7NKSC0HYuziPeAldi+yt51Ek19a9eO8nz91HjxWx
         jOiA==
X-Gm-Message-State: AOAM532boDpVlhyO1XyLaAVE13E4M0FqCIBJpP3NybGyIQWmsdp0uxlg
        2XvpiuJggtRm3i3JWaKR2yHHn8hZjettDDHrwp4=
X-Google-Smtp-Source: ABdhPJydPIuew2E6A7FdCmpjZE/G3zO5v9jZ2tssDsxNcx5h9YFAkiNEfr6iRPZSikHMVAzbHlScQ4kRcXNFVVP4VEY=
X-Received: by 2002:ac2:520f:: with SMTP id a15mr3202535lfl.223.1615667113664;
 Sat, 13 Mar 2021 12:25:13 -0800 (PST)
MIME-Version: 1.0
References: <1614848881-29637-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1614848881-29637-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 13 Mar 2021 17:25:01 -0300
Message-ID: <CAOMZO5B1syxnqfwkpRBOC3gsUUZFWfG5=fo5KW7QxJWRyKyLXA@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: imx-hdmi: fix platform_no_drv_owner.cocci warnings
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

On Thu, Mar 4, 2021 at 6:08 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> ./sound/soc/fsl/imx-hdmi.c:226:3-8: No need to set .owner here. The core
> will do it.
>
> Remove .owner field if calls are used which set it automatically
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
