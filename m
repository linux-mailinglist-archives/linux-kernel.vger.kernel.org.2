Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF80F34C189
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 03:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhC2B7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 21:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhC2B7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 21:59:05 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175B3C061574
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 18:59:05 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id a23so5636437vsd.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 18:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ow1zs3cItHl7OQhkXPkPKnmVcsXMnGDINjd+t2rZz+4=;
        b=HL7jEOHhxCjXtEUyrATnLBUUV818++rOTkwH9FSMmlW4hKwDk7tg3lnoQyahnT5yrM
         NByS65qREQytoF26NUwxtzn2ZnuyYr6LUEn6LLrwKnUBIzAESbCcCPKkEdOJLAuwUSNO
         Mc1GzvOxfALhrseTffBsnjUqzYdWwDaWFD3TwpGzdJU64+xBi2yUeAzofFVt9vOimO9z
         n0C8fOsibYzDCJboPy93GlMjA+uJSTwZ+RHUhjt2EHgHTy3ue87TtVZTWb+YXUwdZLiG
         khbvSWc/0HJxt6hU+KzKcTpzKjEvxnrG/L1YPgi+LCsRXu3BGFQHLDDl3tEntdcOYWD7
         yrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ow1zs3cItHl7OQhkXPkPKnmVcsXMnGDINjd+t2rZz+4=;
        b=Vwaw6i4kyqY39FPJTOo8q3IEDzFELlq7TXyK9qEE8VBEa5kjY/YtPk2KNeQVHi37bJ
         zjIu5fwoQgIJ2+VAjrLyNZaWPII03wKyneWU/zF/v1SNPftTI73dW5r8J5Gqbsp7Em2W
         tXd/UEeYOSoXOCvd31RGAt0zwppfQx1xTrzTH5eqas0NTgvxambYZaFhomG9PCS8AhVS
         dlCy9AnJL0JbXWWwdHu1eLh7968Doz0LG9XF+3QyAv227d684H7sOZjqBU9p4ET9cHZt
         xg2FP5d1fjr4ptgGh9qINGgb61urstlNOfw+UsYZolQLMYLIqzQyxWRJNh0OyCrwBHyR
         Nw5Q==
X-Gm-Message-State: AOAM533+6RuWdMEwwd4zPZ+9Ttmcgf+XG0MPWTpMTKDKaREyi2wcDVHk
        kjgxNGEnBwTow8FOYSOrXgUfOcNVuE1JrxmNcPhdvBe56FM=
X-Google-Smtp-Source: ABdhPJwDm1MJIjc3Tvq0XbBfiBsjbrkbM5KG38v/weJPX+6L/VEVRz9N1G94hyEgfLPte3zpGmG8FyMmZKJ8BBzOPds=
X-Received: by 2002:a05:6102:3131:: with SMTP id f17mr13277929vsh.30.1616983143979;
 Sun, 28 Mar 2021 18:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <1615967692-80524-1-git-send-email-xlpang@linux.alibaba.com>
 <1615967692-80524-2-git-send-email-xlpang@linux.alibaba.com>
 <42b5dba7-f89f-ae43-3b93-f6e4868e1573@suse.cz> <34a07677-3afe-465c-933e-dc9503e9634d@linux.alibaba.com>
 <CANt8P=vwbshvNntPLAkEQFrRfeSHfd1bkxLUhmRXNS2CD_mO_w@mail.gmail.com> <2ad0539f-2c38-714e-330e-7709bb07ebac@suse.cz>
In-Reply-To: <2ad0539f-2c38-714e-330e-7709bb07ebac@suse.cz>
From:   Shu Ming <sming56@gmail.com>
Date:   Mon, 29 Mar 2021 09:58:52 +0800
Message-ID: <CANt8P=uD1X4wMHeomCVmE2ggvTSn6h3H7Fcwmu-FrEqzgrtRiQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mm/slub: Introduce two counters for partial objects
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Xunlei Pang <xlpang@linux.alibaba.com>,
        Christoph Lameter <cl@linux.com>,
        Christoph Lameter <cl@gentwo.de>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Wen Yang <wenyang@linux.alibaba.com>,
        James Wang <jnwang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am not sure how people are using partial object accounting.  I
believe it is used as a memory usage hint of slabs.

On Mon, Mar 22, 2021 at 6:22 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 3/22/21 2:46 AM, Shu Ming wrote:
> > More precisely, ss will count partial objects like denty objects with
> > "/sys/kernel/slab/dentry/partial"   whose number can become huge.
>
> Uh, that's interesting. Would you know what exactly it uses the value for? I can
> think of several reasons why it might be misleading.
>
> > On Thu, Mar 18, 2021 at 8:56 PM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
> >>
> >>
> >>
> >> On 3/18/21 8:18 PM, Vlastimil Babka wrote:
> >> > On 3/17/21 8:54 AM, Xunlei Pang wrote:
> >> >> The node list_lock in count_partial() spends long time iterating
> >> >> in case of large amount of partial page lists, which can cause
> >> >> thunder herd effect to the list_lock contention.
> >> >>
> >> >> We have HSF RT(High-speed Service Framework Response-Time) monitors,
> >> >> the RT figures fluctuated randomly, then we deployed a tool detecting
> >> >> "irq off" and "preempt off" to dump the culprit's calltrace, capturing
> >> >> the list_lock cost nearly 100ms with irq off issued by "ss", this also
> >> >> caused network timeouts.
> >> >
> >> > I forgot to ask, how does "ss" come into this? It displays network connections
> >> > AFAIK. Does it read any SLUB counters or slabinfo?
> >> >
> >>
> >> ss may access /proc/slabinfo to acquire network related slab statistics.
> >
>
