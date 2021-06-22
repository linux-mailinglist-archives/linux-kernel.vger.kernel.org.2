Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7123AFAF8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 04:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhFVCSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 22:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhFVCSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 22:18:53 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177CEC061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 19:16:36 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s22so27908887ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 19:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uH43oKWAZxpslYVAdfEnkXLzWtnCAv3z3ny62+2EWkM=;
        b=JTALaRfb9HY9P+En5sSGe5RUQambcJhT8v2O/nCquiTozLmbSfB0cF/4OFZzr7DWLQ
         xjrb9mmE4+4tDlOAYjkR35nMFmL1ES4FtH3VhfSluC2VJZOniLhfzRpiRK3dDhJ2XhKn
         4YfYmBnL+/DIHxb0R1E2F4ReoABbaqZ9ay6PjaBVFw4EBvt1zQUFJt5LG/wELvbjIJpF
         SFYrPwIs3/1uMT9UpIQPex9Cz0VhiwtMXOSsMWCFVRCha8odC6JKgEwTOFAx4Yf2lhLb
         5QSYbjfK3DUTOUS+cHZQLwKtieKSOX94YqFCp2dTDgAd73G7gFc0fN4lT4+RfmvJS2Xj
         GMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uH43oKWAZxpslYVAdfEnkXLzWtnCAv3z3ny62+2EWkM=;
        b=QV4daepVzE1jKdBHkrjNnb5BYMJk/ArNckZ/QKMV5D62kc6oRJxxa5yHebLeEy8eD0
         bFtR8ImMY+WyeIZx6lXiJZfppjL0KS7+DPKIlyLzYe7VJ2y8IZWKpa0y9XFEhpRlSYQ8
         JcYCXIWnjvtYzViWSjBTZEwkzID1T1UJXtsPrTA2MtNPGbB19j5UMk2tOlyGthIHqofp
         aPcqOYXxat9mteSn+EHtmxoilWznKxTTcFfNu+xvbFKNr9QdioCA8yhArZ5wJMVfM01T
         cJx/h7CCQHU0kNso2NnzMcBkLlu7G95ZQh+bI0UacpgiklIadHancTif6+kmTs88/F87
         9zpg==
X-Gm-Message-State: AOAM533zilrPZ5DAsM+KGtAk00llqHbdlDM5fQjqsflK4jnjPUMsc1/U
        QaQuhE0sTtb2UTxlNhUK6MZqq0GjHwTsK6dd+Ow=
X-Google-Smtp-Source: ABdhPJxeG9iccGHA6DRH7csV1eHv/FBVdq7lad+GoU0gi82ueW4xDhFF6+9W1CvvNYTqkL/1UuZEnSBlxuaZh/IJhDc=
X-Received: by 2002:a05:651c:54f:: with SMTP id q15mr996055ljp.347.1624328194500;
 Mon, 21 Jun 2021 19:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <1624324395-7260-1-git-send-email-shengjiu.wang@nxp.com>
 <CAOMZO5Bh6J8=E=P1btDdgkYm9bvBN1ituRHLLOtW1cFsheQBdg@mail.gmail.com> <CAA+D8AN4Nch5FMjCDN8vs2+Nqs88k8jvMEBZwQuUdG+9pt1yZA@mail.gmail.com>
In-Reply-To: <CAA+D8AN4Nch5FMjCDN8vs2+Nqs88k8jvMEBZwQuUdG+9pt1yZA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 21 Jun 2021 23:16:23 -0300
Message-ID: <CAOMZO5A=OrHNz0Bye+p3H6UbF2_wq2m9KquWurXez1E0-WBYuA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] ASoC: fsl-asoc-card: change dev_err to
 dev_err_probe for defer probe
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 10:53 PM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:

> so I think we can use the v1 one,  use dev_dbg instead.

Agreed. I have just reviewed v1.

Thanks
