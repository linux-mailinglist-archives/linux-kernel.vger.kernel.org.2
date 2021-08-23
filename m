Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2A33F5071
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhHWShN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhHWShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:37:12 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1EBC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 11:36:29 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id a185so1211684vke.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 11:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oD+FfNvttTlhjkxgv46BkQdP0Q+7tbVwZBHtdENnPDs=;
        b=pgZbSzzqkGGiIpo4Gf6Xk8xnzSqmebfIAehocG0R9hnETl094QpzNQljT3BxuZjRTo
         u4oC3AZSt3Ps679D3bD4AQBNVwNPLV1ZtB3J988aFWWam6k4aAae4xk63JzNrMViBLVr
         9PFReSdv9CPouKzddX4B14cHs6mA4gEMzW5bIFGwFAiIbw2PKHJSTezVmNVkWb0gHwGt
         fbr4n+I9nFuwB2DB8dSRt2PPTAAAJXF6bG+Viam15tiofrL9NOUp/9sTo2h4GU791KVN
         MqNfxnMXap6nOtZxJ6k18nY5EViEOIriZ292kXpnxLj2b8Ub4HlFebW9sRvpYvB4oP/0
         q//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oD+FfNvttTlhjkxgv46BkQdP0Q+7tbVwZBHtdENnPDs=;
        b=S6IRrZAFo1qPGA40vssk+f8N8Sz4Jbu5nZMddmlN4RyiJ00zpNOQWASGeYFxn6UOh8
         w8GXShNZEzcap1KwRoAaqIuTdJ0mIvE2VWRu6cjE2+SATtdc9IEvPkRAS9rj61dNs76a
         x3AOonuoemSgsiEujY5n+t3BZWK5uoFcJGkei7c6ra++6SigejSDJGB6CheRipWYCGdz
         1awpzdDrVdQmyfXrZ0ZfmRFJpzbXM0hdDDbIJDtRMFvqnkbOMshUA58HIP65N/PJ6TcS
         zdampmp22cJjbybxychLebaJ6/WwqPeWKG+Ateke1FZazmDbN3KdMsuDFa8VCZpC+AH5
         pLeQ==
X-Gm-Message-State: AOAM533OIFYf8mOH3fiIdMAwj3wVYGAuImyxRhZtbzRXyCCnXABpPfJB
        hS4gr+Gwa7qlEfZX5FscmR5j2T8xYo3Ac5bLc9o=
X-Google-Smtp-Source: ABdhPJxkBUE5Mb3AVj1rY8pemuvJ22/gztSRZps/lKhX3Bb0VUAxGBfiMN04gCVGgcanD3Bvuyb8NXhzHOhc7M04BeM=
X-Received: by 2002:a05:6122:189f:: with SMTP id bi31mr14411337vkb.8.1629743788056;
 Mon, 23 Aug 2021 11:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210822222009.2035788-1-jim.cromie@gmail.com>
 <20210822222009.2035788-3-jim.cromie@gmail.com> <CAHp75VeGGRX-LWfDg_6+p2b27LMLSy+8gdH8ApqGchR=QDyEqA@mail.gmail.com>
In-Reply-To: <CAHp75VeGGRX-LWfDg_6+p2b27LMLSy+8gdH8ApqGchR=QDyEqA@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Mon, 23 Aug 2021 12:36:01 -0600
Message-ID: <CAJfuBxxqO=z0rVtj9_rKnxMWF5HyWzcBPJMu2oVd74opbiGdVA@mail.gmail.com>
Subject: Re: [PATCH v6 02/11] dyndbg: add DEFINE_DYNAMIC_DEBUG_CATEGORIES and callbacks
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Paul <seanpaul@chromium.org>,
        Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 12:41 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Aug 23, 2021 at 1:21 AM Jim Cromie <jim.cromie@gmail.com> wrote:
> >
> > DEFINE_DYNAMIC_DEBUG_CATEGORIES(name, var, bitmap_desc, @bit_descs)
> > allows users to define a drm.debug style (bitmap) sysfs interface, and
> > to specify the desired mapping from bits[0-N] to the format-prefix'd
> > pr_debug()s to be controlled.
> >

yes to everything, 1 question


> > +       if (!bitmap) {
> > +               pr_err("set_dyndbg: no bits=>queries map\n");
> > +               return -EINVAL;
> > +       }
> > +       rc = kstrtoul(instr, 0, &inbits);
> > +       if (rc) {
> > +               pr_err("set_dyndbg: failed\n");
> > +               return rc;
> > +       }
> > +       vpr_info("set_dyndbg: input 0x%lx\n", inbits);
> > +
> > +       for (i = 0; bitmap->prefix; i++, bitmap++) {
> > +               snprintf(query, FMT_QUERY_SIZE, "format '^%s' %cp", bitmap->prefix,
> > +                        test_bit(i, &inbits) ? '+' : '-');
> > +
> > +               matches = ddebug_exec_queries(query, KP_MOD_NAME);
> > +
> > +               v2pr_info("bit-%d: %d matches on '%s'\n", i, matches, query);
> > +               totct += matches;
> > +       }
>
> I'm wondering if there is a room to parse a bitmap as a bitmap.
>

I dont know what you mean here.
can you point to an example to crib from ?

thanks

> --
> With Best Regards,
> Andy Shevchenko
