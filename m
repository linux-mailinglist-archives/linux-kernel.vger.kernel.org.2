Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D1C392327
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 01:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhEZXVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 19:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbhEZXVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 19:21:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6707C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:19:48 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id v8so5070386lft.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SzyExkdZDJisG8pysRn2La22AvSF3A+xaAV2oKawjCY=;
        b=K+eT3iOQL6TQoWJ9Eb91W5oaNof5B5a08Ca3OuuyLJHdVjDawZnWQpBBLcLCIazXfW
         FufdORoNlSwGuJDXqRRWNebudGM+IQNavl0OZ3P4fKLf1ieSlWvr1f8Fp0ZKqFtRfIGE
         8TmaX5fKsx2io0idLIpUpgvO0qnVe/Ar9GHZHSsWDQxhbCRJY17+RJpcdTCINmx4eF3o
         5CPN4IxxU0AqPXm1PSjwHMEVCExuTzMDFcMUlkiOaDYrQaZWY0toSPNMEj4orZ6Ombb0
         MehXr8ivP68Cs+BclNy9FQTqrAzoFeMtAjafKmHds1XaBOw5QchxnWAQB2FaXKyCNKec
         OnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SzyExkdZDJisG8pysRn2La22AvSF3A+xaAV2oKawjCY=;
        b=qaF8ziomdDk6t638xJKgio81A0mynVrG22gx6cB+MpluzsHTL28JZKFE6lL/2meCIr
         GHjvDmndqbDwfCxS24LGySMAjNa9EWkPKm8es6RAEJyJe7R4MQm+1HeCgM042tvbzxIT
         ZUeAPaqYZKjG61v7wnUEMqo+NgzkPUOu2Oj9aFEvJDgQ8mBcA/1fE33Q6eyUX+TtSH1v
         Ul2IoDnnWb0KwaGxkAtAs5Uawm8U01mn+CKH8dbrZy8QKHxeM7l2UHKwX30uP+GEOKwG
         w6FvnDb8nBSke+Va6dQ4Bl1ZxGR3TrRDvMmya3rs3FRqCrqcPiHT22SjGEdNqQis4uB5
         18mQ==
X-Gm-Message-State: AOAM530ySf/97wZq9NTyRjGY7Wvl0EKtAzwrteDiYIlixFI8FkUekP9G
        PLuOSJ8AFPvAZojDDGs1B/a9ly96tJpwLDdrGetskQ==
X-Google-Smtp-Source: ABdhPJzhigcPOSlXhhCd+EdX5+HKhFg1BhywBMb15QQ7B7AC0Bv49e9jVWs2N5AuW/gjWRXWJoKiKq/qXYZWlfr5hqw=
X-Received: by 2002:ac2:544f:: with SMTP id d15mr313552lfn.465.1622071187234;
 Wed, 26 May 2021 16:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210524092605.734-1-lakshmi.sowjanya.d@intel.com> <20210524092605.734-2-lakshmi.sowjanya.d@intel.com>
In-Reply-To: <20210524092605.734-2-lakshmi.sowjanya.d@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 May 2021 01:19:36 +0200
Message-ID: <CACRpkdZ2bDDNecLc5sEe36KyJCBqAo5-vZdvwM+V2a33tr4w_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: Add bindings for Intel Keembay
 pinctrl driver
To:     lakshmi.sowjanya.d@intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>, tamal.saha@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 11:26 AM <lakshmi.sowjanya.d@intel.com> wrote:

> From: "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
>
> Add Device Tree bindings documentation for Intel Keem Bay
> SoC's pin controller.
> Add entry for INTEL Keem Bay pinctrl driver in MAINTAINERS file
>
> Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> Signed-off-by: D, Lakshmi Sowjanya <lakshmi.sowjanya.d@intel.com>
> Acked-by: Mark Gross <mgross@linux.intel.com>

So since this thing has device tree bindings I suppose it is one
of those intel-but-not-x86-and-not-acpi things that Andy should
not merge through his tree?

I bet he wants to take a look though, so keep Andy posted.

Yours,
Linus Walleij
