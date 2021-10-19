Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80D8433C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhJSQkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhJSQkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:40:10 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC58C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 09:37:57 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id s3so19140068ild.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 09:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6t/Abb1t7Ma+rRsvvF9TdbdBKQylPQQzkmHAyaESkuY=;
        b=EkUnN1K4UhwyaTgfUqj+lwIT4lM5oL6cUEAGXMIJCz2IWt1hoCBfeurGlkSPnv+kG5
         1vSX5CnD3fB67/FLu2N0mwyprhqr62Jd5EJHzID51c4KLuRtK+0fjU5ojTm9vS8Jeoxx
         YUtSK+7WraB5vzLn8Yvt2CQRfPOkTTeiFE5ZUnZOpI8p021aw5fjLCNTIv6lQnGWaMXN
         oQbv8DD9Tyx31ZFzBiNu7eKKb80Wwqu5QBdQi3NVH9k60SbpMhrXsUWwR2Cs+HNbZoDa
         D3B/YFR9qbJYYiskOr217dPcBNmN9M+sSMBubg6Y96cjpfa4qweQLagZ+t+YkkZquywY
         4IuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6t/Abb1t7Ma+rRsvvF9TdbdBKQylPQQzkmHAyaESkuY=;
        b=pVNmyLN8MDAoSHsV55xFVstkIi4RXaWGBYWbY24BdLrdd2RPWcxuioo04zRTPEbD58
         QH8QAs6a0bdayflulEr51pB1wCxKkZgtFxoARLLaEhWLc3IiNRCPvS7Ob/5Yu1V8S/zC
         fDQNJNmO6RIEJmdttdCFooTc4yI9U6+nMW2ZdxEZxDlGoZp9iPAXgA1o8/VlEacHP7bZ
         1PK2Z992dWKml6k7h2HIuwZSwyLxQdrGVr29YcoH4BkPbdKJQpmzqTxKAl3CDhm5o1YS
         gJht8U2k5eT6hWBSBjpc1+nBCXfBI4igVhlaA4hcuYoKmdfjCrWaZv3TQycahsgCpD30
         LTaQ==
X-Gm-Message-State: AOAM533YABAGeV1NTMjVRkRPjwqR13ZDp9JJtnVl9YC1hEP4LZXOh04R
        4Dm/XJmqKaxCiEuCCgY/DGNAZlghdHLES17ZybwtpuDi
X-Google-Smtp-Source: ABdhPJz5M3DYaud9n4FfY+q2xvt10oMFxOGacDFsZgl890duLTTvyVd1SwHAj9/bhsjE4TcNS7YbKfJF/sKEyDM/tRU=
X-Received: by 2002:a05:6e02:1688:: with SMTP id f8mr19475049ila.72.1634661476645;
 Tue, 19 Oct 2021 09:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211001161705.13361-1-andriy.shevchenko@linux.intel.com> <YV8jtBpZhlO6LOcX@smile.fi.intel.com>
In-Reply-To: <YV8jtBpZhlO6LOcX@smile.fi.intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 19 Oct 2021 18:37:45 +0200
Message-ID: <CANiq72n1kwa8LmMVMVem6hdth+h73_6wnhVQ-Tk401Sp2UaC3w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] auxdisplay: panel: Switch to use module_parport_driver()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 6:45 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Miguel, any comments on this?

Is it tested?

Cheers,
Miguel
