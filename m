Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0473F80EA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 05:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbhHZD1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 23:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhHZD1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 23:27:06 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67529C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 20:26:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so5602174pjw.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 20:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=gTlQCJHQbFHWNH1/OUl4/6XKO8pY5t2nEBNZMA5JnuM=;
        b=agl6gwgInLeQrzWMkp3jywI1vMjb4RiB+d/PJei+WDcwfCro/MnwPd4edz/dLv1ngH
         +qQ8u7Es8xXG2FmMqiNWQHLQprou/umjrMyvj8yYPnELjsnHOyLVBN2cIxWkGjV7Skdo
         SvQE6aCqYcKDlWVL4yNXhj/iw6eK/qFeS5eef/oTyEZoz5T/s2Dl/S832NFRhWzCMRce
         bRraNuTJKtckKPVBjRNQ3+LOjChwXN3dGhIYlIDqODqe35NzRg4Njd8vJPdqbfZNZu0o
         zyZRdHTSEP8q1TACyi4qu3pxdTyAMSxmQ8xDq8lHM+Tx1EaWgER4CtTUMmrR5TCycplJ
         C/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=gTlQCJHQbFHWNH1/OUl4/6XKO8pY5t2nEBNZMA5JnuM=;
        b=bybUsG+i1kAXaPGaBmaxo+xjstNKHrtamGAXcBkncNeojsNLSD+cI9mTEuWTTU3IkR
         sY0tDIThdpV87KtEbaSIwCwfqqQCijJkbhip/RCXCVBZ+wCylsJQL3tYa4HDLAPvnoxa
         LZMlBa90oo4GCYD2wWpGMVGYnPVZh1hoAg5uIa3yJ5RtCPRlsRv/0cyzMiFeHsTtukoz
         tENgcpsZi5uhlXSYvk0MdSTEPmKpGLw4Fcu5j0p8hzU/4U9Ijg19aO5ZRa+cfb9KVnVz
         bKL6C3+6QU5kDSBWnD4E1/KeudJJNRuqXIvHirGYZbBnpIfekFpSSHW7xlfgSwMgVY2r
         Ehnw==
X-Gm-Message-State: AOAM532ZftXdd5uXmCDkiUFpNcykmSdROT+KGC8OXw3qkx3D9chCXcyb
        Xvs+LWJNeqviRjYOLpYtx/ZLIBUt79A=
X-Google-Smtp-Source: ABdhPJxICERuP2fpSTN98/UbrL/fs2rew1tUinpjIxBVcK1KJ8ykJkAd3tE39jBvlFCgtTjJK6Z4aA==
X-Received: by 2002:a17:902:dcc9:b0:134:92c7:3cb6 with SMTP id t9-20020a170902dcc900b0013492c73cb6mr1697569pll.79.1629948379830;
        Wed, 25 Aug 2021 20:26:19 -0700 (PDT)
Received: from localhost (193-116-119-33.tpgi.com.au. [193.116.119.33])
        by smtp.gmail.com with ESMTPSA id l14sm6684825pjq.13.2021.08.25.20.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 20:26:19 -0700 (PDT)
Date:   Thu, 26 Aug 2021 13:26:14 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/2] powerpc/bug: Remove specific powerpc BUG_ON() and
 WARN_ON() on PPC32
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
References: <b286e07fb771a664b631cd07a40b09c06f26e64b.1618331881.git.christophe.leroy@csgroup.eu>
        <1628834356.pr4zgn1xf1.astroid@bobo.none>
        <20210818150653.GJ1583@gate.crashing.org>
In-Reply-To: <20210818150653.GJ1583@gate.crashing.org>
MIME-Version: 1.0
Message-Id: <1629946707.f6ptz0tgle.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Segher Boessenkool's message of August 19, 2021 1:06 am:
> On Fri, Aug 13, 2021 at 04:08:13PM +1000, Nicholas Piggin wrote:
>> This one possibly the branches end up in predictors, whereas conditional=
=20
>> trap is always just speculated not to hit. Branches may also have a
>> throughput limit on execution whereas trap could be more (1 per cycle
>> vs 4 per cycle on POWER9).
>=20
> I thought only *taken* branches are just one per cycle?

Taken branches are fetched by the front end at one per cycle (assuming=20
they hit the BTAC), but all branches have to be executed by BR at one=20
per cycle. On POWER9 BR even has to execute some other things like mflr
as well, but at least that's improved on POWER10.

Trap is executed at 4 per cycle and will never use branch table entries=20
or alias with a non-tagged predictor and mispredict.

> And those
> branches are only taken for the exceptional condition (or the case where
> we do not care about performance, anyway, if we do have an error most of
> the time ;-) )

It's not that big a deal, but trap is really the best instruction for=20
this.

>=20
>> On typical ppc32 CPUs, maybe it's a more obvious win. As you say there
>> is the CFAR issue as well which makes it a problem for 64s. It would
>> have been nice if it could use the same code though.
>=20
> On 64-bit the code looks better for the no-error path as well.
>=20
>> Maybe one day gcc's __builtin_trap() will become smart enough around
>> conditional statements that it it generates better code and tries to
>> avoid branches.
>=20
> Internally *all* traps are conditional, in GCC.  It also can optimise
> them quite well.  There must be something in the kernel macros that
> prevents good optimisation.

I did take a look at it at one point.

One problem is that the kernel needs the address of the trap instruction=20
to create the entry for it. The other problem is that __builtin_trap=20
does not return so it can't be used for WARN. LLVM at least seems to=20
have a __builtin_debugtrap which does return.

The first problem seems like the show stopper though. AFAIKS it would=20
need a special builtin support that does something to create the table
entry, or a guarantee that we could put an inline asm right after the
builtin as a recognized pattern and that would give us the instruction
following the trap.

Thanks,
Nick
