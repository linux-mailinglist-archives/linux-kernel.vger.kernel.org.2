Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71069372CB7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 17:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhEDPGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 11:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhEDPG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 11:06:29 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13058C061574;
        Tue,  4 May 2021 08:05:35 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id d29so6447942pgd.4;
        Tue, 04 May 2021 08:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=prwHP+1gSNqeuawI8i6wJx12SWw1HcWMRKZ3M8c8VJU=;
        b=WCyg6ZLgLaHzRmk2LpWVaxRojL0BtJkEjiativnbhxwmvz3IWuF1dmYOC7T6EyHHtW
         0liKUd5eM34YLFGntKKF0RcBtcASzb9lTV57JtwvLvFqSkTblK1SvK/D8zXiH+Q7o7Ci
         R46ZcUhwmbAGwLZe1Ih5s/IedmH0NlyAtDxDaMXLnyZ/Co2VIASEMJJy3w2jvDrlbhQP
         vltYsawkLwcUhzxfSwm0T/qGVfLGQvdwndNN1MHe4Mw3VrjL6MS6SSEpUm15yQQP+G6e
         3pcicEdfXI5I7cdy0Qrd6l1qiM9Jpcta+25jqEIPlgb4DFBMRICuAnfdKnc4gtTWTv/y
         D1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=prwHP+1gSNqeuawI8i6wJx12SWw1HcWMRKZ3M8c8VJU=;
        b=ev0ynIA0tsDAPqpMyRsvbOc45SQLya1pqTKNgQoavCRYy9mlRPhPHDiyAa5RlyQGkY
         vDH/jlUfLES4hKzxRgBdFoXpsWJkdgSCP7jL3h36IOQKgQhI4LisWjbGZJg0hD2Laej/
         /xeEHUUXSBbL4yrD+UqR3TNKC1pp2G7cbAKEZW4E/dmEaptIGaw0V04JW3A+I9mFLQ4p
         VX0CC8XqhOh88SE7TmCbTY+JxYvDu6K5MxSow0lV17VNXweZzGG1AcCCbMmJT5I9DO/U
         eE26Rvo8saWnlmvFKYSOPsbWID2sCtOf19wEq8fcgbYwZZD3+LA+e9Mdityf+bMF9YwD
         WPUg==
X-Gm-Message-State: AOAM533j9ifuAC6PiVM2FfO12g5VMySIh+le8WyhyWbtXMMhKhkABk9Z
        TXod8vcnjnj1GYPcO8y3ZACSrMiRbpzMmoPkUAg=
X-Google-Smtp-Source: ABdhPJyd8HSJpj/i5SiJqhsUV+ST4lylnm00n5xy3feHopm/OYi6YWpZ+BjccgeYobis+vzFPzLs9hthnKJwk8z9sQI=
X-Received: by 2002:a17:90a:d90c:: with SMTP id c12mr5776803pjv.129.1620140734459;
 Tue, 04 May 2021 08:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210504123139.45101-1-wsa+renesas@sang-engineering.com>
 <CAHp75VdqEa+mRDzwUVix7bY=2R=O0WOwXuLjv=mE4MGGOobYBw@mail.gmail.com>
 <20210504125130.GA43834@ninjato> <CAHp75VfHsMg78vTxEw910ez+28OeNEhzwUQehOHkZxAqePkadQ@mail.gmail.com>
 <20210504131714.GB43834@ninjato>
In-Reply-To: <20210504131714.GB43834@ninjato>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 May 2021 18:05:18 +0300
Message-ID: <CAHp75Vf59LDsh0D2+Cd429Z01BApz8niFyg_HU_NG-D4mhuH8g@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: samsung-laptop: set debugfs blobs to read only
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 4:17 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > Linus has (had?) a strong opinion about it. My point is to reduce the
>
> OK, I see. Thanks for the pointer!
>
> > churn since two patches fixing the very same parameter in a row seems
> > too much to me.
>
> I'd still prefer that and having a seperate patch fixing the whole
> driver. IMO better than having a mixture of octals and defines.

You can convert the rest as well. And point out that only blobs are RO.
Whatever, the main idea is to do both things either with one patch or
two in a series at the same time.

-- 
With Best Regards,
Andy Shevchenko
