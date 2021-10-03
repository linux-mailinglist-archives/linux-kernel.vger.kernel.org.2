Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC057420394
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 21:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhJCTWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 15:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhJCTWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 15:22:21 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9CFC0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 12:20:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id p11so3132828edy.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 12:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x9SABqpRKie2mPDrUwhlRSnKf4/2PfoIZhnOLacOHcY=;
        b=fwRxnKpJDl3IyqA2nmFJ4LIKEfm6yueuX1XC24nRfJOtOUATODtGDH9WiSVqh2io8p
         fdFbQ6GOYOA0SNxY9h4bPgCEjb1LhYIrZdENKjY/tnM2tdGMW80813vmjZWGj31ksuqq
         sf+O7m6mRAUVro1sgm7MAqTJTGjE0LsdEJiLhlXsho6SmOa9ER4oU/d3jWgVZ4ec97qv
         uXoj60Bz2MywPY/3oD1njE/M8aQd7YLVBy7hvFu7zM8sjXmepUl+nI1p66nJbPNnD/OM
         C8XBF8deanREh3mFS0ovJcvlAd0cTwJQBqG4H9Y1rgzeduOPXoI8NN3X3gn7at8HLs7J
         SiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x9SABqpRKie2mPDrUwhlRSnKf4/2PfoIZhnOLacOHcY=;
        b=Hyepd5uYVYCwGkf7WJY9ag3dVEjTDJxhSRZglnnzWTcgcGwA1Cwoe1vJkuna23J+hJ
         q0JdR64CewXiH7vC3jypXp76goJsk3xSnN+R1pcjxuQd29YfGv/tMzKRfrz+W73etD0F
         mEUVsorMLwD1MCf7SvTf7PlIbHT8SwTQMWmlPg4LpOqEffJ3nhgiX3VLuk9SzngpyJTb
         7EpAGq2SLA2ehaRedIlr38+QZP2XKCYfMC10RO7HWimqc29SP/01GcA5Sf8RE60yCBGI
         LQBCwnIKqakvHzGw6gpTkq9PhtHhNVAjIvSK8eq+zPycFPEIjFwIbLQy/mHFasPyGkkn
         dZEA==
X-Gm-Message-State: AOAM531g9noISnjkfpP7rBuA5P3lDL2fokwmX+7pKaC0PYNsfbqH8EWr
        2O8xIdWAaZrhABcV6lORnDbSQfJFhYeR5coutIo=
X-Google-Smtp-Source: ABdhPJxeiNMz/Wy3CjeIvJ8eJbY/octZ0Wqvp1t5pIwM2Ozxo20fMHdxxjJHpe+wfTpxd6wfyG7hcgoXphs9t5xFvUw=
X-Received: by 2002:a17:906:584:: with SMTP id 4mr12550005ejn.56.1633288831764;
 Sun, 03 Oct 2021 12:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211002234313.3209294-1-martin.blumenstingl@googlemail.com>
 <1j35pivzho.fsf@starbuckisacylon.baylibre.com> <CAFBinCCCQebCEdLjYAfWkF4NDPdma8UzVMhHOhZPVreoV2qd2w@mail.gmail.com>
In-Reply-To: <CAFBinCCCQebCEdLjYAfWkF4NDPdma8UzVMhHOhZPVreoV2qd2w@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 3 Oct 2021 21:20:21 +0200
Message-ID: <CAFBinCDzUvwt6XNEVBjhw5E0rEKWzrvjbPvVAgv77vyffE1yfw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/1] ASoC: meson: aiu: HDMI codec control questions
 and issues
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 3, 2021 at 9:17 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
[...]
> documentation on AIU_I2S_SYNC [0]:
I forgot to add the link to my last email, sorry about that - adding
it here to clarify where I got this info from.


[0] https://github.com/endlessm/u-boot-meson/blob/f1ee03e3f7547d03e1478cc1fc967a9e5a121d92/arch/arm/include/asm/arch-m8b/register.h#L2147:L2152
