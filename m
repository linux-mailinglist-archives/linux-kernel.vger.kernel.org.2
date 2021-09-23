Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44474167B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243392AbhIWVwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243349AbhIWVwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:52:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D08CC061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:50:34 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p29so31406003lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=amByutOR2CdEe2l/7fltvF7uV72wJ4yp5wwjDLvRveU=;
        b=w9u9JGtMchfj21KjO1EmCGDxVCq7rqexJLfC4tYxoiGFXLzWAZDs+gbKkWx9BFuMaV
         aXBGXcllqF6ttVgXVmWrpNgzqcDgrEZbhvSLGbEykrhlvxc5YVobC1kWzaS+Cm6a9bq5
         RqFpdQDkqmHRL7BTa9zHoRJF8gj7e7JZM6whBmmqpX3ZaOBYHyBvehzFPBlLKdKg9PhT
         ezR5IDGZ6fvRDg7U33kdv+fWeRJyWG7NDhm5MBf8FooaE8RaTS4+o2GO9t6WWRfrPZrt
         WwRwEoTWqF/s+A0LFXuU5huSI88ZyV5llmzZsb11zteFUUzJM27dap9H/kPzW7cTbkFh
         9/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=amByutOR2CdEe2l/7fltvF7uV72wJ4yp5wwjDLvRveU=;
        b=ZKsKlig6YDp03Suc2fX1FQSquBoIZxs95qqIji9WvKO9YtZ8iVvyxH4/HiR5Uu9ubj
         rO6iG0vHpR4tEunLzNZkt3tKwBpJQYbWMcac87URkLbgf9FK2H8MgCf7/AlcjwjlpIXR
         P6bq9OaOYenb4Qsda32fxc8hjhwNvZh95OjPUJTuY3rsWfs5C52iHuVKlriABCA6tYlS
         3K56lsprW8lLhP2nxtsOh5mgq5SubceDMfRCSOnARpcub0JydolhK7O8BbquvmJgEoeO
         Qhhz3tPJvC9WTELxXSzxRA0/lLoOSrb48ZhqimmrN0S31je/mzRuN2wMzsFRqnjM5nUY
         bsuA==
X-Gm-Message-State: AOAM5304oEuB8vlKwv+/rTwkUVneTTMUR2bW5gxxoyy3NIoUjX2ZB3Nm
        JmdZH3+4C0SbEK7yUdGOLlmI3aXmMagqcBLGOphjLoS65vQ=
X-Google-Smtp-Source: ABdhPJwZAdk2Oxl0Vi4AaTLGVlUnWujBeU/2PSlbhwLbFRiKH9Y+MIcrIDZX+4dhRLX9fsmDZ+i57nAnwVu47f6FHq8=
X-Received: by 2002:ac2:4d03:: with SMTP id r3mr6573924lfi.339.1632433832437;
 Thu, 23 Sep 2021 14:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210920072842.30889-1-brgl@bgdev.pl>
In-Reply-To: <20210920072842.30889-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Sep 2021 23:50:21 +0200
Message-ID: <CACRpkdZqdUu61n49dqwzy-u=PQ97OF1-eQoOtbZ3101KC=TPWw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update my email address
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Wolfram Sang <wsa@the-dreams.de>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 9:28 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> My professional situation changes soon. Update my email address.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
