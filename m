Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CE5351439
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 13:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhDALIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 07:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbhDALHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 07:07:32 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A19DC06178A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 04:07:31 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id by2so763180qvb.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 04:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hr4EJfC6Dy4LxB2ks0ND142hkf8rNwvgR5bFJx1My8=;
        b=IwfvFudKaG7ulKrhClM3/mRjUThVsffOd8fFnuhBPUkS35EDofF6DoNmO2uJl0ZJe5
         w9rFM1Svm6WR0jHPftrVEjfPU1eMR2oS0EwmA/dpM000mgQHQyWSWOa00XbSoRkoTy9a
         AmV8tA/1UITRcKRQzP+3RAU311ay+sDi2dTLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hr4EJfC6Dy4LxB2ks0ND142hkf8rNwvgR5bFJx1My8=;
        b=SuykDWi5tvmt8PB/UrCDGZZ/4IXeM9yKyRIC4GnT2B2eWvWwmGCzcVtWAndNXRBmHj
         FOKbeN8gL4CqG1uek1eMyNhD9w7hyfnXEWJ2S/5QOCYi8yvRNBhvyPY4E4paIdL4Snze
         zQ6WSNVPKOyYO1SUmiEvFXRJ5OCGP2EL4HT9wH/h/TAR+Mcrkb39kTxl2GSLog/Ai54R
         ddXHe/oVOH6xUq1pZYF3vddJZ5+Tkbgj7xxQ/v79KTHWJn0kg4RdU0gGcUGSYJf3Zg/b
         TpIIhuoivdV9WGa8Co1heTg1EdMQimPIY0BFJcJCrAzATK7bg0apfWrPEryeNShX2Udb
         RtIw==
X-Gm-Message-State: AOAM53319yZHUNurrXwdacv/4b13ceqdTB7dJVPrpQ0eKrxeicHwZujp
        dhwVCxzYTCZlmmh7dRdb8vgcwYSCa4bIaoiH3NPXnQ==
X-Google-Smtp-Source: ABdhPJxPeLgGNYuUVol7wcn3UD700JCejRwjzkrn+bZT/fTLQdwdf0L0H88XiIRNF+6k69uJk/9V3D5PfwQ6HMp9Q6E=
X-Received: by 2002:ad4:56e1:: with SMTP id cr1mr7615297qvb.25.1617275251088;
 Thu, 01 Apr 2021 04:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210223061830.1913700-1-daniel@0x0f.com> <20210223061830.1913700-2-daniel@0x0f.com>
 <1614108850.540354.4116103.nullmailer@robh.at.kernel.org> <CAFr9PX=h2JPdAwjYS2849ufH=wnxSti2Dj60fbq4bg8b8=xy_g@mail.gmail.com>
 <CAK8P3a1L62YT1WUxmmfLNmvERo7DbeVwfCHCxuKvxs7Uap+iXg@mail.gmail.com>
In-Reply-To: <CAK8P3a1L62YT1WUxmmfLNmvERo7DbeVwfCHCxuKvxs7Uap+iXg@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 1 Apr 2021 20:07:20 +0900
Message-ID: <CAFr9PXmT-FUUu-yMBWCe52KDHUSF2+Zhr8wk-NdC+cW+_8prKw@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: clk: mstar msc313 cpupll binding description
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh@kernel.org>, SoC Team <soc@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Willy Tarreau <w@1wt.eu>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, 1 Apr 2021 at 20:04, Arnd Bergmann <arnd@arndb.de> wrote:
> I found this is still in patchwork as not merged, and I have not
> seen a replacement. Marking all eight patches as 'changes requested' now,
> please resend.

Understood. I will resend.

Thanks,

Daniel
