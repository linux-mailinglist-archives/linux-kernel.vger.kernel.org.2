Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CF53D09CC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 09:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbhGUGzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 02:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbhGUGy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 02:54:27 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BF1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 00:35:03 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id t4-20020a05683014c4b02904cd671b911bso1285758otq.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 00:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+C3yWM1Aq25AnToXYe0OxrL1vCuAWOUW+a14IQfShM=;
        b=vtaMs7dhTXsjys2mWi5QB8shnliH3LrkB6s1LGUXdyJanimPJRQ7SUjC2I/vqoWGxY
         k3hviiV60qay40DJOSTvONJWAx1+PKwC0nu+4ZtW6HdXRuNwvO9S+1I39Qj8gQzE6zuV
         gLJk5Tic/HuzwEa1ubkMIUQbEjzfZ7tmpxdwFF4d8tzcMd1JVE7BQGvIdIeDsU37/ami
         IVklHeTuWAMtlrhMuic3GFQOWBFipA+CJt38rkdbMAR/Ls955ATKzwoU+dpMyed22fA1
         y9ltCCmdh96NJRIpZlLXDrqVg0gP5ycxewWFVVblNPyYrPYJZ4F/rqky9ww5tsY3Agti
         YaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+C3yWM1Aq25AnToXYe0OxrL1vCuAWOUW+a14IQfShM=;
        b=O5WsAMMxli73H+udH6SVBo37hK0UgEQDENiieGbt8two7D/dZdq1jvu63VkKNWg7ho
         vRobv7P5mlthyMw9XM91YR/uFT6xxvFIHQ8oJAxHT1GefqeAvvNy40u7dUX8DPouUeZM
         J/kYcebcAQm5UuFGZhzh/47+haFctXMNvsXcGI1QhMW/h8aK3PyhsPDC1h90Ga74TMRU
         I9F0zfd0BMbbySkDQ9ggtXQmS3cjqtIs91HHyLSDH5ACT+/YxKvSJelee2pRJx8BEyYp
         TTtfN2lt3HbVlBnl5dZNbcrA1phJGHptUf87uQD/h1v0xmazqycWXWvHaUuFQVxBFS5G
         sN0Q==
X-Gm-Message-State: AOAM530qGxEl2Bf8+aXzZo2Do4zLCz3paI2FcZpdi0+HrnyKa1T5M2b/
        KpKgk7fOQyBxn+8Cp9D4NlcjiXCGDO7be9mP73tk2g==
X-Google-Smtp-Source: ABdhPJxWS4P3/legZ/TlwXxppTSSemQXnWnvlkkGMpTD3obhtSOJNiFjn6I7+UP0SEsIAcukDCsLe6vdUfva3QrxYkQ=
X-Received: by 2002:a05:6830:1455:: with SMTP id w21mr25226545otp.365.1626852902894;
 Wed, 21 Jul 2021 00:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210719104735.3681732-1-qperret@google.com> <20210719104735.3681732-9-qperret@google.com>
 <CA+EHjTwmmV6EooG+Ykbso3G6nkjq=sbRzXH3vetazzPF5mO02g@mail.gmail.com> <YPbYdtRx6dMH52oO@google.com>
In-Reply-To: <YPbYdtRx6dMH52oO@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Wed, 21 Jul 2021 08:34:26 +0100
Message-ID: <CA+EHjTw4ZKCGUWz99c-Ui_e5yGWS2eh_f-85RaZpFeZKgy8D9Q@mail.gmail.com>
Subject: Re: [PATCH 08/14] KVM: arm64: Add support for tagging shared pages in page-table
To:     Quentin Perret <qperret@google.com>
Cc:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        dbrazdil@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,


On Tue, Jul 20, 2021 at 3:06 PM Quentin Perret <qperret@google.com> wrote:
>
> On Tuesday 20 Jul 2021 at 14:48:09 (+0100), Fuad Tabba wrote:
> > This might tie in to Marc's comments for using enums, but
> > consolidating the translation between prot and ignored/software bits
> > in one place would be good: thinking about patch 10 as well, where you
> > get the prot from the ignored bits. Even though you have documented
> > it, I'm finding the part where a field can be borrowed and shared as
> > opposed to being only shared not very intuitive, and I need to reread
> > the comment here to remember the difference while going through the
> > code.
> >
> > You also mention lending as potentially reserved for the future, but I
> > think that lending is the other side of borrowing (depends on who's
> > doing the giving/taking). I wonder if in this case it would be clearer
> > to describe it in terms of whether it's exclusively owned vs owned but
> > shared (for the owner), and just shared for the sharer...
>
> Argh so I actually found the encoding pretty neat :/
> The idea is the following:
>
>   - an entity that has a page mapped as SHARED in its PT means it
>     doesn't have exclusive access to the page;
>
>   - an entity that has a page mapped as BORROWED in its PT means it has
>     access to a page it doesn't own;
>
> From that we can build the states we need:
>
>   - when an entity shares a page with another, the original owner gets a
>     SHARED mapping, and the recipient a SHARED+BORROWED mapping.
>
>   - and in the future when/if we implement lending (which means an
>     entity gives exclusive access to a page to another entity, but
>     retains ownership) we can map the page in the recipient as
>     'BORROWED' only, but not 'SHARED'. And the original owner will have
>     an invalid mapping with a new state 'LENT', which is encoded with
>     both SW bits set.
>
> How does that sound? Did you have something else in mind?

The encoding is very neat by the way :D

I see where you're going with the lent state now, and I understand the
states as well as the possible transitions now that you've explained
it.

It's the terminology that confused me a bit (especially when you
mention lending, which seemed to imply is something distinct from
borrowing as opposed to just the other side of it). What for me would
help is to document this, and the possible combinations/legal states.
kvm_pgtable.h describes the prots a bit, but maybe you could expand
that similar to what you've done in this email:

@KVM_PGTABLE_STATE_BORROWED: Page borrowed from another entity: has
access to the page but no ownership

Not sure if defining aliases for all legal combinations would also
help or add to the confusion, thinking out loud, something along the
lines of cache state taxonomy (e.g., Sweazy and Smith fig 3 [1]). You
have that in the borrowed (as opposed to owned), and shared (as
opposed to exclusive). So aliases to build on these:

#define KVM_PGTABLE_STATE_BORROWED_SHARED (KVM_PGTABLE_STATE_SHARED |
KVM_PGTABLE_STATE_BORROWED)
#define KVM_PGTABLE_STATE_BORROWED_EXCLUSIVE (KVM_PGTABLE_STATE_BORROWED)
#define KVM_PGTABLE_STATE_OWNED_SHARED (KVM_PGTABLE_STATE_SHARED)
#define KVM_PGTABLE_STATE_OWNED_EXCLUSIVE (0ULL)

You have thought about this way more than I have. But I think that
having clear documentation, ideally in the code itself via
helpers/enums/aliases could help people like me who come to the code
later not shoot themselves in the foot.

Thanks!
/fuad

[1] https://www.cs.auckland.ac.nz/compsci703s1c/archive/2008/resources/Sweazey.pdf

> Thanks,
> Quentin
