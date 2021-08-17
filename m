Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0113EE667
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 07:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbhHQF7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 01:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbhHQF7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 01:59:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE0DC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 22:59:14 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so4662817pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 22:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=dQisk5/c9LVCcy1HAz4ONWGiiJi823Q9v5VbiiIG+Bc=;
        b=YtV+IgzUIN2vDHlGtx9nJADAwIVufluKh2UiMVxJU4IdktVnJTmUT1V3d97kFYCgER
         dUTzO9+YO/FdHkHZagXa4PGJhdDGD61LO5Zvmybkl+Kf4jZJYU1SnWw7DZcpTe6+8xf7
         i56lv3fFxtu0tA3ap/4j9hOydpaZasiMl+KqVnHzHlgaBqG6Z7T+LCspkHVf7df2Pz46
         KPWpUNKqRNm5QTBqhJRyJXObrjEMf3M+IvLU1f28BcM6mfxFGJZNqhbtMPVWKSy2lnDr
         GYu4i88t2VGt7TSryQhU8G8y7zjz2o8zp7bjfdLBJe5Lv7tKt3EIZJ+8PLbWmb1XFFrw
         YctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=dQisk5/c9LVCcy1HAz4ONWGiiJi823Q9v5VbiiIG+Bc=;
        b=FWyIym4uP1a6x4Qju+5eYRfagoSLoby2FlwByVl2DXOS68EGiAf26B//8KwSId+Yrf
         kf6bk45mfPheyEI3uMKyqcUZkQ+VtTfk+0CgA1MYpppRbWp/v1DGkSGyoDw0PpuEIYh5
         tJxWjnzzZ95fWjYgxaDdXsnyOUZvWtWoVUbcnPbYrUdJKeDpOUX7YeN331wMbN/alo41
         46MEcegn+CDbtLySubAa4AYAItLgQJ1sQaAKbbXVYMyvBDk7DKxsBthzXAElx4NthFRC
         ET3O50bdkYcoSnOb5C5dmGsmJYitgiCmwbEPOyedYs3alpkLT57xISKe7GDrV1wloFvp
         /NTw==
X-Gm-Message-State: AOAM5321oaubcLJNytVweJR4YbcpsdhZ8iNZpn8NuZkmabn36Ya5/mnO
        tM6shgJ7ssjIRCyCe1Zurek=
X-Google-Smtp-Source: ABdhPJxr0MwNK4v8M7UNaRnYmKAD3Xt8NlPrz6a98GolJrPy/tjiMEIIyQdDToJaRmyP1qgHk5erUw==
X-Received: by 2002:aa7:8ec1:0:b029:3cd:cd3c:b85c with SMTP id b1-20020aa78ec10000b02903cdcd3cb85cmr1934374pfr.15.1629179953591;
        Mon, 16 Aug 2021 22:59:13 -0700 (PDT)
Received: from ?IPv6:2804:431:c7f0:30b2:5c9e:50:88f3:269a? ([2804:431:c7f0:30b2:5c9e:50:88f3:269a])
        by smtp.gmail.com with ESMTPSA id b17sm1197470pgl.61.2021.08.16.22.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 22:59:12 -0700 (PDT)
Message-ID: <1cf050db5d37f6e515cd25e26f4e8940960c12d0.camel@gmail.com>
Subject: Re: [PATCH v5 06/11] powerpc/pseries/iommu: Add
 ddw_property_create() and refactor enable_ddw()
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        kernel test robot <lkp@intel.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 17 Aug 2021 02:59:14 -0300
In-Reply-To: <1ab60060-1435-f77a-d2df-84019e7625a2@linux.ibm.com>
References: <20210716082755.428187-1-leobras.c@gmail.com>
         <20210716082755.428187-7-leobras.c@gmail.com>
         <1ab60060-1435-f77a-d2df-84019e7625a2@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Fred, thanks for this feedback!

On Tue, 2021-07-20 at 19:49 +0200, Frederic Barrat wrote:
> 
> >         kfree(window);
> >   
> > -out_clear_window:
> > -       remove_ddw(pdn, true);
> > +out_del_prop:
> > +       of_remove_property(pdn, win64);
> >   
> >   out_free_prop:
> >         kfree(win64->name);
> >         kfree(win64->value);
> >         kfree(win64);
> >   
> > +out_remove_win:
> > +       remove_ddw(pdn, true);
> 
> 
> I believe there's a small problem here. We jump directly to 
> out_remove_win if allocating the property failed. Yet, the first
> thing 
> remove_ddw() does is look for the property. So it will never find it
> and 
> the window is never removed by the hypervisor.
> 
>    Fred

That makes sense, thanks for catching this one!

What I intended here was just removing the DDW, so I think it should be
ok replacing remove_ddw() by a new helper that only does the rtas-call.

I will send a v6 with this change soon.

> 
> 
> > +
> >   out_failed:
> >         if (default_win_removed)
> >                 reset_dma_window(dev, pdn);
> > 


