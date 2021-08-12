Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5843EA719
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbhHLPGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbhHLPGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:06:31 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5403C0613D9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:06:05 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x14so10135941edr.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QEmLCQfmQOuhAIlIo7tcPafee51VNGzdqFJimZNT+qM=;
        b=KaHfVQvX5t1Gl/ExbaOUje9GfbDNpJxy3O9DDDPK6lqgCRBEspMsuS319Rj3tvxXZu
         rgg5Dwt0FFu1SsPKItfNcLL+qMjYHNU5khYAm/MFKguqHz+kWovaAVVeZH/IEuy3yJv/
         Q1Mch9uD/zrMePWc9us4UQqGcpOGQAFClqnDQ3CMbUgm1a5zjyxy0py54n84rEF+yJo3
         EjLufgWVPmsd2j2vYCkJK9dfddOYC7nDEsFq7x2eU55SDH36kskyAmQgetwzsSDuyFfU
         A2XXlTBpe0eag3MJP1isBUN1KGxKf0OIoGaV82cBaTDStXNtcIeFdSjsONtF4KNj19ys
         7IbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QEmLCQfmQOuhAIlIo7tcPafee51VNGzdqFJimZNT+qM=;
        b=E8NcFppPd3KJZSYQGen/pIF1sLBwxMfrXqae1szOOfHIsXM/zEqECP0gqt5wRx+5G8
         iIwOYApcRNVtViJFj61D48DRFz0pptWGtqcbqbI/tlcUBjppYGtb9ENMiTrRDrWg0TwR
         IYjhd1LpHbbd0ICbRDgSVZhe21V76+6QTif52Y9HSZ0ftXSR7shVm1a4D9a+Z43pxXwp
         K2a3ipWjN4dBC6zzRMBNhCQ9PudrbeozgBOjnPlqTrqRj66gNx//MDMc1WYY0sEg5slT
         1DXBDhVbMwb+Gbkga1cgWbTla9MCrxqEa+S5om1Bl6SVHAhuxVRrjT2gb3UViHiTIa4q
         Y6tA==
X-Gm-Message-State: AOAM530AeUL04Znoi05d00ZLYYZlSUp8f9ZzK4XMgTmeZ5joS5Zqfksq
        O5u2rmMVpmJm+jiZSlhBw7m/KPnuCu1cTj1Zb+Y=
X-Google-Smtp-Source: ABdhPJxbJBh/xZnW8LR9jaTOd4+Z93lHVquS+4vlVqdDc1G8LajwvQL4lEQ/ckbptOQhaz+p/Zfs/YPOiX5fcx6umwY=
X-Received: by 2002:a05:6402:1299:: with SMTP id w25mr6232247edv.30.1628780764189;
 Thu, 12 Aug 2021 08:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628779805.git.andreyknvl@gmail.com>
In-Reply-To: <cover.1628779805.git.andreyknvl@gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 12 Aug 2021 17:05:53 +0200
Message-ID: <CA+fCnZfjsfiAsfnOxJhMaP0i7LaDgsVSkrw_Ut66_E_wQ3hE_g@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] kasan: test: avoid crashing the kernel with HW_TAGS
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, andrey.konovalov@linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 4:53 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@gmail.com>
>
> KASAN tests do out-of-bounds and use-after-free accesses. Running the
> tests works fine for the GENERIC mode, as it uses qurantine and redzones.
> But the HW_TAGS mode uses neither, and running the tests might crash
> the kernel.
>
> Rework the tests to avoid corrupting kernel memory.
>
> Changes v1->v2:
> - Touch both good and bad memory in memset tests as suggested by Marco.

Ah, I forgot to include your reviews/acks, Marco.

Perhaps you can give one for the whole series now.

Thanks!
