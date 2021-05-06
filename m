Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5C037544E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhEFNCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhEFNCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:02:13 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC57C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 06:01:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id v6so6930238ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 06:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1o9YU1cRcYXzkHmKraCEMWOkwDyM4TPN0AO5wmmdGTY=;
        b=QGh/DMr3YWyJIdVxRuhgHcwYIwiGHeFKTvJnh/dtmauMQqI1wHd5Evea76xe9greed
         XtlHlw0rF6mL92DCBVZeB2+U7xlO0HJJZqamj5hTGEMkci98EHlifnwnNF0IiKcVuXgf
         cBmN3x8SvgbS7DWu+3Vun+cEPE6P/0YkUqjtLY6Se4NZ9vXx+dAfER56e+NsAzxJFHpl
         Wy/VupXQjfBonvEZeg3XnOwVi/P0sWXhuzY+txk2/wjJOva2ppjDV86zKuVu95wVUgBL
         lZL3AKRPWncJSitolznnmAbmQV7ZDE5fPfQfBgaxygmNRphn0k0jk7jGCdSoqvhkWfQy
         ZC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1o9YU1cRcYXzkHmKraCEMWOkwDyM4TPN0AO5wmmdGTY=;
        b=AyETCfvIxM4zguyBl/Q2kVrRrKxFhb76UDZ1rhorr7RFJnjgyeK6OGbHmZA+UTKBOw
         lm/Ht84kMg0Kwt+CU2GUoPUWIkYd8xO/yvZr5bQE4hUYFkSVOtTJAbR3+0U6rgmI1YUp
         uZhJpbyGgjtiTNimvVSEwbrb5POCJ5HUhkpYQanPNkoVQuEcPgyCqtvFSuOQx4j//W7/
         lXX4ynow6WsXhkPzoCL6UJ0TGyBXeLcm++UFIP9pCZho4JtMsFo9XHTTw6MpgNc+SCtN
         ab2Zf7sUsNYAIdvm7q1XjdKzoh8+WPuPZjrXQ3QfuHvPEaaPpm9+H0Wi/suQ1q5LuYHE
         TELg==
X-Gm-Message-State: AOAM532NwTHCmIieemXeIK4OyaNBy8UAYvDkyNffW/ALA0+XWBhNGDdR
        3htEKMfWgROY4oRNON8Dp/ce28S/nNCw4ifDUxn6Zg==
X-Google-Smtp-Source: ABdhPJxumvyre7G9VDri6pSA5PmkdD26UhUC2qL62jApVicOYFEU8vPDiZEavFOFM6F7HT1ITASFFaIz9QjawzPlJys=
X-Received: by 2002:a2e:889a:: with SMTP id k26mr3177134lji.438.1620306071975;
 Thu, 06 May 2021 06:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-9-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-9-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 15:01:01 +0200
Message-ID: <CACRpkda9fWzeqLvSX4-fr1hcP7KqWrRQGSFvCM2STYNM_FkL9Q@mail.gmail.com>
Subject: Re: [PATCH 08/11] mmc: core: Parse the SD SCR register for support of
 CMD48/49 and CMD58/59
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 6:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> In SD spec v4.x the support for CMD48/49 and CMD58/59 were introduced as
> optional features. To let the card announce whether it supports the
> commands, the SCR register has been extended with corresponding support
> bits. Let's parse and store this information for later use.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
