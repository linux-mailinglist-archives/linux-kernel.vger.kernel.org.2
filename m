Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8D2432836
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 22:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhJRUQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 16:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhJRUQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 16:16:30 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AACC061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 13:14:18 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j21so2436257lfe.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 13:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tt24hSGflNdpheMRwlJmY7tz8SqrWMFdjzVrWWc99WA=;
        b=ThzaXo9WMP/Hx60CctXyI47vb2LH1UDfrYY8Ar9oaSYyIGAmOezaOvDQ/jGlcx8JQ4
         0brV7of05Lpixk+xH/TLFCWzQwK7jriqQMDLPnN5ss46nsAcOoEsTOur5rdnomWefoPe
         az7yIStcQN012YMWrb/4FUJ49saLFmUDhyvpWcWH6Rx/LzGqfPuBlth8b7OvQYhS+Ysm
         Bz9I+BJUt6goyo6D8gV6hg0vC06pn2nCP16akhI5YQ8Sa9RbvGYGi3pKJdr025cIHpbc
         pNxNRW+eTROo3kwt8ERY1h33eLQTL70ZZI+mcC4i+IT3rm63x9tVUisYuK7cgoANHt6k
         CvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tt24hSGflNdpheMRwlJmY7tz8SqrWMFdjzVrWWc99WA=;
        b=BSbDKBSIKGHF90P77gDhCJScmeSIOMEwH7OvZH0VrDe3rgZazI5Q5ljTAfcczoTrNe
         qjALR99Q1wriDCposjlaN4nFfVS5HD8rYpeM249CqAnEot/mO+vjbTQS9b1r9dnLzWc+
         GtWHRTjWuKEzbFxpkiwTfT+yO/m/3+oBrnHZiWY+p4NT60tfj6TI5ouvUakyWcOKwqJk
         DQfmOmTZIaZtriTbZQ4WwobaGhm9j9rgOBtVOR3y3CqEgFaGlcwjI2dVUuMMjxNzt4OB
         170YKQzzW4sr0VW0QowyOeM/qqIrMbYSgA0Tmc59tym/sp0juz0+t3mI5AYiSW/guKu/
         nUuw==
X-Gm-Message-State: AOAM530pM76z/V8NAmYjBXc00ILQX4ah1YaIRS7OBV7nnNJahWnxkKQb
        BjVN8VnyxMZESQbv7UYac8IBFTqbkPHY7qmEcAtZ1w==
X-Google-Smtp-Source: ABdhPJzslvUpnH9sQ/IhkDtp4mGVU7/17DQKkqHCoDvDX9vcL6++QrFeuzEfX+XJ9kFW9AXMdoVU1XuaqjmEeVcZDrk=
X-Received: by 2002:a05:6512:3ba3:: with SMTP id g35mr1762408lfv.651.1634588056448;
 Mon, 18 Oct 2021 13:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211018182537.2316800-1-nathan@kernel.org> <CAKwvOdn4_DrgaZoAo-v7CbYurNUpfAK5tnzT023=WCDzkmYQVg@mail.gmail.com>
 <CAHk-=wi7hUsTTcmPfZCkUEw51Y3ayq3JJxzFsNgodsxxDyk9Ww@mail.gmail.com>
In-Reply-To: <CAHk-=wi7hUsTTcmPfZCkUEw51Y3ayq3JJxzFsNgodsxxDyk9Ww@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 Oct 2021 13:14:05 -0700
Message-ID: <CAKwvOd=wGjd_L1703Y9Kngcr9-_wTvcRLToiydXYkR=S_9xWDw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Fix bitwise vs. logical warning
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Tor Vic <torvic9@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 12:41 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Oct 18, 2021 at 8:34 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > LGTM, thanks for the patch! I guess this would be the first
> > "interesting" case this warning has found in kernel sources?
>
> The patch looks obviously correct (tm), but I'm not convinced that the
> warning is actually all that interesting.
>
> The thing is, using bitwise operators for booleans is _exactly_ the
> same as using logical ones as long as there are no side effects.

Right, the patch that added the warning explicitly checks for side effects.
https://reviews.llvm.org/D108003
https://lore.kernel.org/lkml/20211018193101.2340261-1-nathan@kernel.org/
is another example that I would point to in favor of the error.
-- 
Thanks,
~Nick Desaulniers
