Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9513744AC6F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245655AbhKILVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245647AbhKILV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:21:28 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19109C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 03:18:43 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso9735581otj.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 03:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5LoGehQZbk+RzosGck6vjT1zJzmg/lTJbstwTe8XeEc=;
        b=ZpjBczssavdT/zzpwmE93UVRYT1pVggy6ZoN3tdcTDQsLCNgWwBXD+Qw5oLlTaBBbm
         fWEdbQM+yBK/UC6g8kWHLM6lfdnG4ucBcJFRA/jaKQKMWeWw8EMfQy+emulns1FFUP7p
         3/61HH6SdsnEoW4qQKwL/y6/srRqdVhVGgXWpcmyIvacXoWeHbB66GHEr5Du6EGTAy0f
         dQw0shxkL/hA/PD0OR/sieBQlFEPW71AtMzdF9Xi7HCbQACFMnJaxNS34CZuy1ETjEZ1
         H9zi7Rv7iRjfD8I/mX3FX8Nln5+6QgQodeRs1tYGlYr+Kdn/Y4CqXy6rPuelgM0NFxDB
         y/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5LoGehQZbk+RzosGck6vjT1zJzmg/lTJbstwTe8XeEc=;
        b=VGqYQhziOZInT9CfXsfoI8c7tZyFtZSK1MD0Yly1ISHqMDOqWYHjSCxMarMBmCdKyV
         /qPffEhaLy9SZTnWdNWFx2x1JNTuX8dVMKn9EZLWLrHESmm5ZKN8SdBuBMsWhtBOR3Gw
         4IM6Q79saqxmzdAKR7nCgorsvCjy3D8fJ6xzP/rHr8MKoGrxzepdL7jwYdMnd3XZPwxi
         Mf4pnmkoEz146iqFVdm3RXSHPuamcH1tyZEcfNia708RDezbZrsYEX6mqvvTDQ0Bv7On
         Pc0+bcmKNgY1r2RQsCFGcI8SYEynGLGzZ6utc1Lt02pehN0Qna0ZhAhCUDuOQGlQaTQv
         5yOw==
X-Gm-Message-State: AOAM533Gnql+KX83qLzFnJtOzMXwVSVzDHXqcby5SV83dg/3t85QHYWk
        B5lJARaZRoBzhExA4IMLac/agFbEWqKjta/g0MVFRg==
X-Google-Smtp-Source: ABdhPJwUCUJdsq++gtqdxVgLL+2uG9niZtv2/dD/V11M0WhSkdg5mu3IOK/qOq/4OB2+/9kMjmAoxhyxVMYjUJifi9I=
X-Received: by 2002:a9d:6348:: with SMTP id y8mr5313708otk.179.1636456722508;
 Tue, 09 Nov 2021 03:18:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1635944413.git.hns@goldelico.com> <e1337857bbcb044edf4b6fdb4af3f6d887793a37.1635944413.git.hns@goldelico.com>
In-Reply-To: <e1337857bbcb044edf4b6fdb4af3f6d887793a37.1635944413.git.hns@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 12:18:31 +0100
Message-ID: <CACRpkdZ9ECS1YXL3NQa-7gF-kbqiutW-K5tM1b1vR5THCnK7SQ@mail.gmail.com>
Subject: Re: [RFC v3 4/6] mmc: core: add new calls to mmc_fixup_device(sdio_card_init_methods)
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tony Lindgren <tony@atomide.com>,
        Bean Huo <beanhuo@micron.com>, notasas@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 2:01 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> This allows to add quirks based on device tree instead of having
> card specific code in the host ops.
>
> We call it just after where host->ops->init_card() can be optionally
> called.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
