Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690DF3CCF37
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 10:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbhGSILn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbhGSILm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:11:42 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736E4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 01:08:43 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id m83so15791130pfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 01:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=u1oZ21urlDEMYCTRvpJZCNd9Uc5ubV0Y0bczC4MZIq4=;
        b=v56AXMPZtmcyNYOHmuBwzQpI/BqqZMqp9P5Qi8MtbrEx+0hjnFxF23uBFUpQiSCpk8
         rPSSpgK4hhCYVzAbsB2GJjKLH0fvEr+M86LFL+brS+xyf/bxh3CbzhQittPmIeHUEqJF
         xV3Ydm3/OII8eLwtr4nqL/hifFQPp0ysCrrjdSP3Fl9vE3kJGNurTveQykFpbIjnKnie
         gA4T0Cnrh0H7AUTW5k6xWhVBgXOKH0ba6Cqo0pS0PZ6o3ycnCVeNAB0FNI+MxqrmrWj+
         FldzILkak2HuFOCkAktqZkBwlhfj62geUChA7znz3RzEQjAcqlZbCwtB2BHIG2k+STBs
         F/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=u1oZ21urlDEMYCTRvpJZCNd9Uc5ubV0Y0bczC4MZIq4=;
        b=D8hTesBC1nn0K3bLOp3PKnoTqEXHAevCtw+v3h8YlRDErIsdy8EPpixZ/2kjTNobmZ
         WMu0K7GU8xH6X0ZKKydUkiOqrI6edksxT70UO8xih2gIJhPf4neIU2kXLfUtOEiaVhgo
         kkbm+omcRQcITYttWW92nZW4+JCZ6whmCORgGdmluv/Mlck9woQ/FjpE/DRy+Bs2hy3K
         LWewJwK6gtLvu4oCBO/62taDpYJ9SJ5ysKZMDYRJExMQQYXxmtlbPtfSbT3GCx6hUqMh
         1xLxzLg9bv3QBjx5LiSDRrzt36fDhqZzheCNLnpIH1s92MIVHYkJpu86KASjfM6lhic3
         BCtg==
X-Gm-Message-State: AOAM531vU3Fm5uSmKsTdfjN4c6qZ8Yzi4u70Lu/ecwpS09/gLAz9pPfD
        kEJ/t7seoOfMsD6VE66vijWpug==
X-Google-Smtp-Source: ABdhPJxaeUPmcqGucl+mz8pPkv5TQr3ZoFupylauqIzN6XYFr1ZHzHE8ImdPcZ9RxMu5YBZrWW7kOQ==
X-Received: by 2002:a65:6555:: with SMTP id a21mr24282177pgw.53.1626682122967;
        Mon, 19 Jul 2021 01:08:42 -0700 (PDT)
Received: from anisinha-lenovo ([115.96.137.169])
        by smtp.googlemail.com with ESMTPSA id m6sm565017pfc.151.2021.07.19.01.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 01:08:42 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
X-Google-Original-From: Ani Sinha <anisinha@anisinha.ca>
Date:   Mon, 19 Jul 2021 13:38:26 +0530 (IST)
X-X-Sender: anisinha@anisinha-lenovo
To:     Joe Perches <joe@perches.com>
cc:     Ani Sinha <ani@anisinha.ca>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        anirban.sinha@nokia.com, mikelley@microsoft.com,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: Re: [PATCH v3] checkpatch: add a rule to check general block comment
 style
In-Reply-To: <4e42f2580d8b473ac7e25642b039adf73b5efe06.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2107191324330.14021@anisinha-lenovo>
References: <20210714063422.2164699-1-ani@anisinha.ca> <alpine.DEB.2.22.394.2107162145100.3277407@anisinha-lenovo> <CAKXUXMzxyQxYKdnuVbZnUFbYFuKMq+Vc5LxSR-_fKtH2dv-4wA@mail.gmail.com> <alpine.DEB.2.21.2107181853320.55905@ani-ubuntu>
 <c32293fc03a8673ade348ed4451c60dfdf9bb2c1.camel@perches.com> <alpine.DEB.2.22.394.2107191054260.9400@anisinha-lenovo> <CAKXUXMyJ9Ab_Fvpk8WAimEnDjcOhJRe2uODkC=RxCgsN8T0WyQ@mail.gmail.com> <alpine.DEB.2.22.394.2107191221570.12107@anisinha-lenovo>
 <4e42f2580d8b473ac7e25642b039adf73b5efe06.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Jul 2021, Joe Perches wrote:

> On Mon, 2021-07-19 at 12:25 +0530, Ani Sinha wrote:
>
> > I do not see why we cannot add this rule to checkpatch. If the
> > reviewer likes the other style of commenting they can always ask for a
> > correction. Having checkpatch agree with Linus' preferred style of
> > commenting and the preferred documeted style of commenting (which seems to
> > be the same) does make everything uniform and agreeable.
>
> Too many novice developers take checkpatch output as dicta.
>
> It's not.
>

Well those "novice" developers have perhaps worked in companies where
tooling like pre-commit sanity hooks have provided immense value in
ensuring certain basic rules and code quality is maintained across the
board, particulay when the company scales. Existing violations did not
deter them from adding stricter rules to make sure all future commits
follow certain patterns. Ofcourse at the end of the day, common sense
trumps any tooling, goes without saying.

> It's just produces suggestions that should _always_ be taken
> not very seriously.  Those suggestions should perhaps be
> considered, but good taste should always override a brainless
> script.

At the very very least, checkpatch should lay this out in clear terms
every time this is run. Different communities have different rules and for
me, I always run all my patches through checkpatch to make sure that the
patch I sent out of review at least is checkpatch clean. This makes sure
that I am not violating any obvious code submission rules laid out by that
community. This is particularly true for kernel community where flaming
people for even small issues seems to be the culture!

>
> _Very_ few senior developers really care that much about any
> particular comment style.

I disagree on this.

>
> These are the same senior developers that would be burdened
> with unnecessary patches to review from those novice developers
> that believe checkpatch should always be followed.
>

Well for those "novice" developers, the doc tells us to run checkpatch
and address the complaints :

 Are you sure your patch is free of silly mistakes?  You should always
   run patches through scripts/checkpatch.pl and address the complaints it
   comes up with.


Anyways it seems this conversation is self serving for the kernel's sr
developers so that they can take any stance convenient to them.
There is no value.
