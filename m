Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E75348B67
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 09:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhCYISy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 04:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhCYISm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 04:18:42 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2EDC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 01:18:41 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id f26so1992263ljp.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 01:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=unhzrUlUmxwMo4jU+o1qS+odD5qv386ZSHOjsI10bcg=;
        b=KW+CwKvpsTmTXENRiHTcGBk+qdowqv7nij4ijO8bcKk0+nnnkCUBATgOTB40qpIiy2
         qPyEes6ddLFjiNJVxiLceQFKjOCf34PuJq9FFiq7FzpDBOF65i9Ipb/U14FjTGEeBV7R
         eJJpddCVwcb0HV2NCJygpgPQhgYGHhZfNexDnbfDgyDN2YzbqvEuAvFLYErj/LQvNsbk
         p/UXbEXWlwdb6DhVU3uM3udvSquMD4S3bMBZaT1hbTvkMeS/DUV9iPqH/QA7Jq0rtkG3
         qKIYoSKP/Rve+Mkxc/1giDgxcTHyMGR+2zPRow2jZ+ITLHX1/3zil+TDBFszcWI3vkXD
         MRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unhzrUlUmxwMo4jU+o1qS+odD5qv386ZSHOjsI10bcg=;
        b=TxzC9KIXqw/OQoWCRa9oCkQ2J1QqzYjDXOz1+ujQpMd6AXA3TPcKbjbkD4XUEwIFqh
         7Zp6p9pKTam8Rdr4+WbmTnXKeoOuPJhIW8/L8KwyOEAU+v+8KKkEAXBAuEtGOIOl7WRy
         Hd/WO6kaRuR450l/l5DsMa6sZ5iaNvs4AFi9BQAox0o/e130ERRpbRNIaMU+e+7fvUo+
         55BIsns7BrtiZBDEVpzYRXyUNQti+Zl2DT2L0DQQ1VTvFSxWH+xHr+SM+KkYfvRWjHcx
         YYuhuIEn320ph0oTOKCOgYqR5tzzlLg3VIcdLakc5cKpLOyAk0Ms9WoFpZNHx6IuRGfQ
         6yKw==
X-Gm-Message-State: AOAM531VbGP/rL3Eh4OhB5L4uaUJVsT57Fg53IERLZ4OYUhkw1OHMErY
        V0XtpUwV5/SD9VtBBtWVaK8PwxmtZQ0uL2Lu7V2CDQ==
X-Google-Smtp-Source: ABdhPJz0GzVY64RszF7GBBC+BDXbk6Gq5VBz8iBMXhq6HISdgBwxj4LgMrMlFmbqi4hFQveaCR0pmnCpNjorxi3YHXk=
X-Received: by 2002:a2e:700a:: with SMTP id l10mr4847470ljc.368.1616660320111;
 Thu, 25 Mar 2021 01:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210323153626.54908-1-andriy.shevchenko@linux.intel.com> <20210323153626.54908-7-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210323153626.54908-7-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Mar 2021 09:18:29 +0100
Message-ID: <CACRpkdZY3nugyG7ie5tDmuipjjY30F1VfTSwMNhK5Hwt-BQ0kw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] usb: gadget: pch_udc: Provide a GPIO line used on
 Intel Minnowboard (v1)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 4:36 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Intel Minnowboard (v1) uses SCH GPIO line SUS7 (i.e. 12)
> for VBUS sense. Provide a DMI based quirk to have it's being used.
>
> Fixes: e20849a8c883 ("usb: gadget: pch_udc: Convert to use GPIO descriptors")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
