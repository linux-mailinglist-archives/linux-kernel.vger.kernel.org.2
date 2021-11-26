Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E746345E885
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 08:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359245AbhKZHib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 02:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359200AbhKZHgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 02:36:31 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82340C0613F6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:32:22 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id z6so8077982pfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/AAtVNxSEEMIS2MWinkvg2Tqw1EN5wSqX+XDPy/nWgI=;
        b=rUX7EPkOpCeOT0XDzv3zPUO65mVufrZATtBDv60kEPRIqIXnd367uOnp27jiHhW1RH
         pfZDsfZurY3opAdcGf9KbD0CAfhLVt2lc23p8w5m5g7ZsI1vPM3dDlMayAl8unNLuaAi
         G7XpZttHEAyra0B8n1oEx1fJSRyN5ROr1twSvleukoCpfjG3iT1ywnNB2G438p+WUIys
         BpRXFIC11cFbUlGHe9PDWmgBInA1QAq8cAUe8RW5pHox17z+ePwRAIRe0iXrndMiPpku
         1llMHJ4ZOUODS2L0ni5PspcTSM8HJ1XdmckmEqkByum9Rjj5mNFqQ6aAS4S/l9AgDrq8
         E8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/AAtVNxSEEMIS2MWinkvg2Tqw1EN5wSqX+XDPy/nWgI=;
        b=Y2h+u9XGLUx3Y178WuX5hhHMlzo7NhxKzUBnHpPpEfXlaPY7Z2k67CHfdxMyb5ZDGn
         TOfVfJ4qOHwtOL7fx+1q07yfm5r8LilYwOHUUsHZqIHqzZYgWVseAIkwuuNIlfFZvYfV
         h/Mxog8bfugk0udDD1TbGuemZ9WKxtmeoCQIb5M6c2AzK9sYwXENoIJcFCcrQB085vo8
         WlNA5/1yRespYtN/HAxNodc4WiaUd2m8PFJf/cqwCMr+ojvtbvL4QgNmjwb6jWYTSmEP
         Pb/jar27je6/UPD3VuoZZ4KFTJnhcRq5KbOlRK5wcHD4ZX1OQqHycAQNIWfbdrQLncvI
         1eGQ==
X-Gm-Message-State: AOAM532vorNQqFzrmpWbQGTCuyjNf2QCuk0DG6GjSu3VhlSeEZJty3a4
        9E53MVGuuOjL2gzMsvVKzMxYlA==
X-Google-Smtp-Source: ABdhPJxBCLapsVbR8S32cbgSLGdf670vLzwnMC/H4p+iIY7hAahthtNMoj8b3XEDxeZJspFRP89tZA==
X-Received: by 2002:a65:4b87:: with SMTP id t7mr19646091pgq.115.1637911941740;
        Thu, 25 Nov 2021 23:32:21 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:5eda:d984:1426:91ca])
        by smtp.gmail.com with ESMTPSA id d12sm4112656pgf.19.2021.11.25.23.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 23:32:21 -0800 (PST)
Date:   Fri, 26 Nov 2021 15:32:17 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        cujomalainey@google.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v5 3/3] mailbox: mediatek: add support for adsp mailbox
 controller
Message-ID: <YaCNgRHFSoHv4toK@google.com>
References: <20211126071432.21990-1-allen-kh.cheng@mediatek.com>
 <20211126071432.21990-4-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126071432.21990-4-allen-kh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 03:14:32PM +0800, allen-kh.cheng wrote:
> diff --git a/drivers/mailbox/mtk-adsp-mailbox.c b/drivers/mailbox/mtk-adsp-mailbox.c
[...]
> +static bool mtk_adsp_mbox_last_tx_done(struct mbox_chan *chan)
> +{
> +	struct adsp_mbox_ch_info *ch_info = chan->con_priv;
> +	void __iomem *reg = ch_info->va_reg;
> +
> +	return readl(reg + MTK_ADSP_MBOX_IN_CMD) == 0 ? true : false;

The expression "readl(...) == 0" should be already a boolean.
