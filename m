Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB2232EB6C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 13:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhCEMoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 07:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbhCEMnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 07:43:23 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FFAC061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 04:43:21 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id f12so1920053wrx.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 04:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QmF+mvS+MLxLt6q3dQkoY40EhjIBy/NHIII8iIh6APQ=;
        b=bHjAZhufUbVM2E/Px0qJ/imHzNvX1/O2wSS2s49c1PdMwr1NmNHqMaRuXPcczu75l9
         cW/D3D1RXj7tRr/0BCgFgr3wTTOPAG+xNNlvxNQrqXzIGNK+SZWuaXTSoSUiBIWa+S75
         yb22bkzeZebfMKeo2Qggt9fImoNaTxorpFA2uz/VeoQ+vIUp3UtPiz6rUM3A1LkqT9k1
         AWe2V923LfTkrqUKrKNUr7LGNGhG3MbtYhwzxDLBGyXliY7mzZj2xN9grbtA4+WIAhcn
         5hAAqGcR5kAZbirU0GnDm82xIOnBXGY4GcPxKby2cJu2M601j3KI8S9FT+DOdPbMr0Ep
         S5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QmF+mvS+MLxLt6q3dQkoY40EhjIBy/NHIII8iIh6APQ=;
        b=pZY8I8Di1jqtZJy7qGd911ISxMHiblakW1HR4e5iuGo/hJySHAffzOc7aScYYkDgjG
         nRv4NVyejl1urAyZ9S4AUVKQLBwLN4AArwg4DodiK5w7mHSc3ZhhT9nL/W9lm0lz0TCx
         zuNyupp1ADEHn1bkFvgCvinjqgpGLvR+vv54u1lTzeXJAXam8Qk8Bt1pLKyZPRgVt4My
         0Ajvzo2aRT6yHPRFSJvF4HI/r3WIToAuDsEopWs6PV+4lhMkFhd7nOaOg1CXdMhqx9PZ
         xiXjTXiajLIijD5PawsLSskA23jTqbvXY47pUBRjMbCT5wdNxp7eQE/0ZMT6Y4IiLzjK
         lXaA==
X-Gm-Message-State: AOAM531JMpUB0ZQyPfKfGWuANMVAnZNr+ZoWRwD1B4t4pruIpLlg8N6F
        dIGuFMOMQcWKOggg5DG8eoCHDG+GPIdD634UqS0=
X-Google-Smtp-Source: ABdhPJwXjMQOM5nzdg/7g/bbUofDP/d6h+41pogdgtczYu3CsbmEQu+kYS+mJ/MZKSwvcgtaRzjf4pLIUt6BcHQLzpU=
X-Received: by 2002:adf:d84d:: with SMTP id k13mr9527969wrl.164.1614948200745;
 Fri, 05 Mar 2021 04:43:20 -0800 (PST)
MIME-Version: 1.0
References: <1614770488-12861-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1614770488-12861-1-git-send-email-shengjiu.wang@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 5 Mar 2021 14:43:08 +0200
Message-ID: <CAEnQRZCvYe6n_8MFwfz_MyanJLqH2VAqkgcZ7K9NJkqBPg=r1A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: wm8962: Relax bit clock divider searching
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, ckeepax@opensource.cirrus.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, gustavoars@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        patches@opensource.cirrus.com,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 1:15 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> With S20_3LE format case, the sysclk = rate * 384,
> the bclk = rate * 20 * 2, there is no proper bclk divider
> for 384 / 40, because current condition needs exact match.
> So driver fails to configure the clocking:
>
> wm8962 3-001a: Unsupported BCLK ratio 9
>
> Fix this by relaxing bitclk divider searching, so that when
> no exact value can be derived from sysclk pick the closest
> value greater than expected bitclk.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
