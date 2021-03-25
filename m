Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379B6349642
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCYQA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhCYQAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:00:13 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0227EC06174A;
        Thu, 25 Mar 2021 09:00:13 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id i22so2236424pgl.4;
        Thu, 25 Mar 2021 09:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZcvhcVz5SG2l7TXInHqovR8N9PaEaZR96rNMcB7kOXk=;
        b=pp1Kf4zTb2NfmDO8cXK0HieHJTNPmvsxJ6ggSSvRUo9kraDTjTaT9V5A4XaGwVEuV9
         PhA5Shv1c+CmSsjqRDA9L687Mj/lU1h5fph7uhcSRgz6YwrNlPE4/PUfGQ5OwfQLkO1G
         L41/AWv57WPnUwkoBUzl9dsA6ZsRy7pPyq/3nzEDf8uHIRU9gQcZo1HdOf1Ov4+oLBJv
         Vj8lOS3yOkKTpxAXlj4ohj/4Wm7Z4entt6uwTGdDs3PZI5PjMSNfoPiEQYzO8Xko8Dgk
         9tV9P5p8Z+XumFarrbu3KrZ++oScPcn8U/Spbn/XFxYefGC7qAop0NrqqmR4CEyIgcyJ
         bV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZcvhcVz5SG2l7TXInHqovR8N9PaEaZR96rNMcB7kOXk=;
        b=m3+GLYRD4fCl3lxMdWwi2rhu5jwIyZDGHR+/+rEo5kTXAfDqY/qoCR3VR0p8IqoUsX
         6HfBDl3ZpM9BPCOZadv82H9I/IB2zYfRWne1fc3JgE/badM8WJNcRos5n6egYLl/9GE2
         6bgAzUC7DufnobjfsFSZJlKeP3HZ5zXoygO4w0Fgi6R/ZFGFys1/jo/xgk55k5DozZc9
         2xO7IREgU86TZ3O+n3IKL9TwRwheVyN+Sp1zrMGpQLdaIhodDrzRTlQA+wa/Rl2y8Hn7
         zbu6UAKuiIxlY00DRoqBOA0tBO8Rrz3BfmRqDuzYU92c+uHRjjxt15Sk8UF45A51te8c
         bZcQ==
X-Gm-Message-State: AOAM531cD+3j3w3jfuF17Rp1rmP5K73nrpzeOalaCXq0USde/fmj8oXB
        p1FJP/8Z5ERCmxotX8l9dyw=
X-Google-Smtp-Source: ABdhPJxCNSdkDyjilxVM+ECwNojpw9K4zwtShTSL38PVGXdGCOLaxgmGKsFkiVZMv1u4RLNOqLm0dQ==
X-Received: by 2002:a62:2a8b:0:b029:21c:3016:3a9f with SMTP id q133-20020a622a8b0000b029021c30163a9fmr8954623pfq.38.1616688012560;
        Thu, 25 Mar 2021 09:00:12 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id b19sm6359351pfo.7.2021.03.25.09.00.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Mar 2021 09:00:12 -0700 (PDT)
Date:   Thu, 25 Mar 2021 16:00:07 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] of/fdt: Check dtb pointer first in unflatten_device_tree
Message-ID: <20210325155954.iun4hdcegi4b3qm2@mail.google.com>
References: <20210324150425.20688-1-changbin.du@gmail.com>
 <CAL_JsqJ0hyZ25jSudh3EW1Fipwbp0AzMAKXG565ZrQxn-_kBKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ0hyZ25jSudh3EW1Fipwbp0AzMAKXG565ZrQxn-_kBKg@mail.gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 10:52:30AM -0600, Rob Herring wrote:
> On Wed, Mar 24, 2021 at 9:04 AM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > The setup_arch() would invoke unflatten_device_tree() even no
> > valid fdt found. So we'd better check it first and return early.
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  drivers/of/fdt.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index dcc1dd96911a..05d439d63bc5 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -1225,6 +1225,11 @@ bool __init early_init_dt_scan(void *params)
> >   */
> >  void __init unflatten_device_tree(void)
> >  {
> > +       if (!initial_boot_params) {
> > +               pr_warn("No valid device tree found, continuing without\n");
> 
> How are you going to see this message if you have no DT?
>
This aligns to what unflatten_and_copy_device_tree() does.
 
> > +               return;
> 
> And the arch is supposed to just continue on oblivious that it has no DT?
>
As checking the arch code(arm, riscv), I suppose so.

> > +       }
> > +
> >         __unflatten_device_tree(initial_boot_params, NULL, &of_root,
> >                                 early_init_dt_alloc_memory_arch, false);
> 
> Soon as you get here with a NULL initial_boot_params, you'll get a
> backtrace and halt.
> 
No, we have returned before.

> >
> > --
> > 2.30.2
> >

-- 
Cheers,
Changbin Du
