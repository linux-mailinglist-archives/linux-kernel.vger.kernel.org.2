Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134713709AB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 04:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhEBCSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 22:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhEBCSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 22:18:17 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56571C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 19:17:26 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id u200so542727vku.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 19:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dqaSxBqnpQQ5yJej8q3aImwEDK5i+RDSkktLqxVmfqQ=;
        b=vQK0rlGW8Dsa3qh1UIbGmJUu9RXzrm+isAmobNkeoTLYQI0QoPq2N8k7r9DyLI16TO
         BoRx9z6OpVHyirOZPr2aBrR0xB/L7+yTE0ZfMaLfjgqtSFoBe2ioMHLWpGH3fq9d503a
         OhYIoECfiHLIp6aK8TK9bFD6EWAxTncmA/ReZCz4JuBHipRwo9KMtUfc6+OG1hPiRHDD
         +Rvvkb7xZxVkc9QdbtazAuFTXbNvqBaZcX8lBecMbgNJOA9lCpN/7GdiUePgoJoPPo5F
         JwclkBpW78rlNgpSH+T59BmH1qaAmghr/EY+771j4uQw+80mhctanvGlJ0cZLCICXEMw
         WQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqaSxBqnpQQ5yJej8q3aImwEDK5i+RDSkktLqxVmfqQ=;
        b=fi23c/YELOp/LKx/r7r9WgzPfDZ6jnV0xqrthSBeTUQmd/Om21o8amCYUpIgwuz5jI
         jeNo0P8Tw/k8xjV7RfHiQQo2F98UCC7lNTidjzn9XOg8nzKRABa2leI0BKyA77G7VudD
         HmMEmq9pyo5WI7VRW6Xk+X4q5fcVddoIKKhfPsViamO3L3rewLgXq7T28uhi4+dheipX
         ZINHXJouIRXgDr4S2/8T8XbTziQR5soLJQU5OuQzvM6btAg5wgRoMLV2Je46bjQilb1+
         d4wsEF1yPE6ztIpIQHm+0Yti4zUvILXdokp1InN4nWQX9QLub5Pev/ow1LLZMT4pKGQ5
         5pIw==
X-Gm-Message-State: AOAM5305wm6O6QToQfCfjQan1jWmryHmjT/PospbQqrYAkN/xGENloXa
        V+BQzWkYsqRLct52PfcOitmQYjidH06LRX913NA=
X-Google-Smtp-Source: ABdhPJxSGePAnv2xy3eQ/CJbjnnH1c4ygiWRTdae2BV6Co60nQK9xvXsMHaeOjMPQfMKOfpLOhhLf+KYZMTrAY9m1uw=
X-Received: by 2002:a1f:3a56:: with SMTP id h83mr11579567vka.10.1619921845348;
 Sat, 01 May 2021 19:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210316050801.2446401-1-jim.cromie@gmail.com> <87ft0rvl1r.fsf@linux.intel.com>
In-Reply-To: <87ft0rvl1r.fsf@linux.intel.com>
From:   jim.cromie@gmail.com
Date:   Sat, 1 May 2021 20:16:59 -0600
Message-ID: <CAJfuBxyJHu3JdZ++0RU3DEDUS-i-4iT990P+zihFG_nKfyjVFA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/18] dynamic debug diet plan
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:12 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> Jim Cromie <jim.cromie@gmail.com> writes:
>
> > CONFIG_DYNAMIC_DEBUG creates a struct _ddebug (56 bytes) for each
> > callsite, which includes 3 pointers to: module, filename, function.
> > These are repetetive, and compressible, this patch series goes about
> > doing that, it:
>
> So how much memory does it actually save?
> -Andi

sorry for late reply, html mode got switched on and I didnt see kickback

on my laptop/build, master has 165kb, about 70k is the compressible data,
RLE column-wize could get close to 60% on my data. so ~40kb ?

3 things to do to get the savings:
figure the compression,
figure the hash holding enabled/used/expanded pr_debug decorations
(maybe optional, depending on indexed/seek decompress time)
drop the site pointer, with some anonymous union struct combo to blend
header with callsites cleanly
