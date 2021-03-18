Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7FA33FD0D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 03:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhCRCHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 22:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhCRCHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 22:07:43 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F7DC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 19:07:43 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id v192so834952oia.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 19:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cBOic09Ji2sUr7lSL2XtTwyzCrDuTRmAgWURvlhvtG0=;
        b=Ndyrp+nu/db70ubdGOP4GiYnNhiVuTIguQnDDahQbyBGQtCYZkmBwbFRrQ0REfFdj2
         dRkdkq4cgKCrJ8QfojElCvKbvTvOOx4+f16SDDder/3dQUojGoLn8e1GIaj4tmukiFd6
         a4QwSiqMelJNPB48P0pbFRbE+P/KM6MHbvLTe+tmVJbozYvI6PqWLDPBILZM84FJTWUW
         lZ00OaIwe0tRb/hp5VmnHACLpUaOuqKvERUGxgLjPUbbSfEwfwmv3yGkidDsLkSHf5Ta
         r4CdscMpJb/kl0YwPHEaEdBuDNozUW8qyLuBqNZRgD94Ul84FkiCjiDZwUJjpYA9dyeZ
         El/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cBOic09Ji2sUr7lSL2XtTwyzCrDuTRmAgWURvlhvtG0=;
        b=S3o1WZxzr9/O83KrDfJVM6AjG0iNTEfn1QPbqXDF5gUGdn55L41CY+UMc0I+jtaa9T
         E/BH3A/wg7rzNH6LjY7s2tV8iH2orvDUxWsGsBIpmuBAPzipXBpLbR/D/sqmS7pojwHI
         /UYBGLpUL2bw1b7LX6iZLiwC5wGkTidGN+rJlZ2rN6sqlAywOCbKgaGkSjszlShtQjIl
         JMNpLTbJ98JKAZ8fn52faQ4dcHw/L82i/vpK4mzKCGA8tTQixsxTvcNoxq2Xi27hYvnJ
         rLC+LhSeJ1waF71IzYshq2CuuXG3Bi3N8b03B08G+55oJxoQmhu23IGRecMFCPFeGAus
         +hgA==
X-Gm-Message-State: AOAM531WAKpIMstCntTsc5iYqXoSkxctgGKEy+7cCesuw26PEYyuMsx3
        x2NyToI1fH655G+bj0jFcIsxSNPBGxUHt6MnmBvoRQ==
X-Google-Smtp-Source: ABdhPJyIpml/gdyY9dmtxfJlp6jCFpscTMsFU75hsrbdN3tUsgB4w6NmCOGaxfR8kIRzYDCQD946laEs77CtO2uP5Ko=
X-Received: by 2002:aca:1c02:: with SMTP id c2mr1352536oic.31.1616033262714;
 Wed, 17 Mar 2021 19:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201209094916.17383-1-zong.li@sifive.com> <87v99qyjaz.fsf@igel.home>
In-Reply-To: <87v99qyjaz.fsf@igel.home>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 18 Mar 2021 10:07:30 +0800
Message-ID: <CANXhq0oLxFK1431WmTj5HRO5k_omYkQZCBTG+HORTk9=W_XyNg@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] clk: add driver for the SiFive FU740
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Pragnesh Patel <pragnesh.patel@openfive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Yash Shah <yash.shah@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 3:45 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Dez 09 2020, Zong Li wrote:
>
> > Add a driver for the SiFive FU740 PRCI IP block, which handles more
> > clocks than FU540. These patches also refactor the original
> > implementation by spliting the dependent-code of fu540 and fu740
> > respectively.
>
> That breaks ethernet on the fu540.
>

I would check that, thanks for the report.

> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
