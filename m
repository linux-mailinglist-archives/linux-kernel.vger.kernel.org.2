Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1D5341740
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbhCSIUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbhCSIUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:20:21 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A701C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:20:21 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so7776532otn.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K+XmUzuuF5UUkq0/fWT+bp+a3y84PMfii9z5k2/AsMQ=;
        b=HI99Vkz2H61CHC62uwSpju6mRKoYJTVnBttZZmzk4fZPmgg51AQDYFr5YfPKWXZ1cd
         9SYnGnVKPJBDVUtZyxB6QxxDR3cjrpsfz5Fc9SWNVJsSS9oeamHuqzAkaIzB7az+oLLP
         wiOghMMO1xkn3x3a0CRjveSPmjtmaGbIT+2mSf5SnVN7T7JoTog1lxo5iZSmFccTCcxr
         yqIHmcpCPXeTGqqgt+qc0092O+OkAlxD+oreaR93FKH7u6LgEM0339J2copTybxXf+IR
         6A53xAkEUsOG38qtztsU6yF2i89c6U8OGMkU4FlZHcXMizOsC2DNcNfKCdfkHQuz3HYN
         OBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+XmUzuuF5UUkq0/fWT+bp+a3y84PMfii9z5k2/AsMQ=;
        b=QOdLCGCObEoNgorvu7bezdR0/hcxGttn15JI2Wv3KXTdFlMVk5pWgvcoirB4fPJIgq
         QmD3rpNzQmLieaw/gYyxcEOnkMYqWlXtsrPDx65ev/3lBXJVNN+Rj6eFSbFsUqzjFIgS
         thnRbjOW6/cW6oI3tE00CayHNTouoDbuKz4WmI84pWHlS+i56ORixbzjVhXSoRmJTjCy
         XHYWaOZzaa3fosL/l8gKvCRf3o1ePEQ8S7QB3bBc8wrfLptPgszMAiTgwqFoiTFZGtuE
         8LEA8r9PZ+Z0aPvJrMIwOSmwkYcSEGEqv8zGAxHFPlFA5OMb6zqlym+KgqQTTpJ8yCk/
         wrmQ==
X-Gm-Message-State: AOAM533rwCqh3/I5hl7sCFbkduzPmMRo10zfYEhf3m3wLMNa3gOu47YN
        k/Fr6LMc2o8bkBLqLWGGmCtRhhLv9GwJD7PCf1WGHg==
X-Google-Smtp-Source: ABdhPJzHEmcxr7p0F8RTp2/xkLrbEofBVwtdlcTZdeZkLT6okQ8KKnmDtTYXOdyd/5uiHu7QPjpfJmyYZ894FTfbhAQ=
X-Received: by 2002:a9d:6ad6:: with SMTP id m22mr166502otq.160.1616142019973;
 Fri, 19 Mar 2021 01:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201209094916.17383-1-zong.li@sifive.com> <87v99qyjaz.fsf@igel.home>
 <CANXhq0oLxFK1431WmTj5HRO5k_omYkQZCBTG+HORTk9=W_XyNg@mail.gmail.com>
In-Reply-To: <CANXhq0oLxFK1431WmTj5HRO5k_omYkQZCBTG+HORTk9=W_XyNg@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Fri, 19 Mar 2021 16:20:08 +0800
Message-ID: <CANXhq0p90Cgha_zLzxamK9mxmVPn3effh_cZq_CTLrcAkKZg2Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] clk: add driver for the SiFive FU740
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Pragnesh Patel <pragnesh.patel@openfive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:07 AM Zong Li <zong.li@sifive.com> wrote:
>
> On Wed, Mar 17, 2021 at 3:45 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
> >
> > On Dez 09 2020, Zong Li wrote:
> >
> > > Add a driver for the SiFive FU740 PRCI IP block, which handles more
> > > clocks than FU540. These patches also refactor the original
> > > implementation by spliting the dependent-code of fu540 and fu740
> > > respectively.
> >
> > That breaks ethernet on the fu540.
> >
>
> I would check that, thanks for the report.
>

Hi Andreas,

Could you please point me out how to test the ethernet from your side?
I had tried to quick test by using iperf and wget, the ethernet seems
to work fine to me.

Thanks.

> > Andreas.
> >
> > --
> > Andreas Schwab, schwab@linux-m68k.org
> > GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> > "And now for something completely different."
