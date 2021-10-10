Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB9D4283FF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 00:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhJJWMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 18:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhJJWMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 18:12:00 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4262CC061570;
        Sun, 10 Oct 2021 15:10:01 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id k3so7594507ilu.2;
        Sun, 10 Oct 2021 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FPgDcHI6jCohL7NYe6pCSSPcB+UxcNl5RYrrIok+MR4=;
        b=ieH6I6QeUSmzUGIxlqJSTFrcD1enykkClDoi9sn64HprJG0xXGD65O1wIqh2mmHekW
         ER9lVwC7BRbNI8xtFfpS95uW+vr3lTDu+OlBmtIXUsYn0ATl8YXd6w8wpotX8Dn24/Ta
         w7799jIgOsgkfE7YlKpgFZDChpzt3ZCcKY3RHiFAwrUt6SuDS6DXFXtJeY/Vw8vCn+0j
         TB/7AoHILq45mLpX2ATjvg7Ua8Z5jhH2Zs+myDcDNQn4NsjSQcBcVKJIWRu5YVGbBPH5
         2VbmWlAE911BmiXVPwtzx+Z3Gb14LsME1qoZZqRSq70XNkWo7z7hCYluTdfDStFuZyLT
         ny0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FPgDcHI6jCohL7NYe6pCSSPcB+UxcNl5RYrrIok+MR4=;
        b=t2thW38V3w3Bxelu87jLFULjKeUysaUVukwiyqo2jKN8aMgjux9DaM6KlROYnl3yuT
         8jw2XP3bf7l+ixVLpP+9RED7VrhPys9+vTXFX9Pb7hgcw8H3L1LglQB54OCdV/RH/cV2
         wb2KrpXoHglSmSefna7aZ+YaU1plbz7Z6ynP0RYD+igzdKLS2xWgyFoSR0JkVzhj4Fdt
         xoigc1imHASo3936oCaiIdU7N9yijNBmsoWDOEe4SdL8nTK9MVj0MfJrEoOIc8xGB0Qe
         wGMEcN6dOYqIe96+p7gUNVeOzGbqXXeGbC/R7m8n5qwC/ESqHfaLOYUIyILLFv0T7dSZ
         Itpg==
X-Gm-Message-State: AOAM530OfOQDykK4GAsWtPkqRc3GvXXtip92o5ZgEV+cKp0ja+HmURzF
        tbbrO6mLSHDNfXCCA16jr8fMz+2MQQWgkogcsoE=
X-Google-Smtp-Source: ABdhPJx6qRgibjm1tdC1QoB+BxJVBXvnqStO66i17vW7IZ+buxcYCR5XFzvyi+dyB1L+M9zqQwDf27JEacAMZf+VtMI=
X-Received: by 2002:a05:6e02:8a7:: with SMTP id a7mr17333776ilt.246.1633903800579;
 Sun, 10 Oct 2021 15:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211010210513.343925-1-pauk.denis@gmail.com> <20211010210513.343925-2-pauk.denis@gmail.com>
In-Reply-To: <20211010210513.343925-2-pauk.denis@gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Mon, 11 Oct 2021 00:09:49 +0200
Message-ID: <CAB95QAS863M9Lu3e0Um25PQi_7gxWp4=EyN8j7ioB7eN-G7--g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     andy.shevchenko@gmail.com, platform-driver-x86@vger.kernel.org,
        Tor Vic <torvic9@mailbox.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Changes in v4:
>  - implement wmi driver instead platform driver.

There are many ASUS boards where the required function is present but
does nothing. With the WMI module alias the driver will be attempted
to load for those boards (and rejected by the _probe() function). Is
it a good thing?

Eugene
