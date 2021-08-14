Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDBD3EC173
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 10:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbhHNInx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 04:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbhHNInk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 04:43:40 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4E9C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 01:43:11 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 202so2070429ybc.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 01:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4uQaa0C4LRAVBFfYsZnRfLqcfZ45qVVswcaexgzhtgM=;
        b=QbbmvcXgy0HXw0H1ngbaSKrhn7QdbRS9+huMKbGDKwT3pulUw9tBepSms4/5gAdWXZ
         vjCpU7X0yD0eRaQFX8wLcFrCIruL8Zcn98SMYf3QVK/M4x6csdn7YZ5g4SF83QVTPFjV
         xujZtxPZRP9oivORBJea5i4mOkbpEYZMikto4OZzWKdxCD2WkhwDFp2C9kg4ZvceGRGL
         cn8I1b6lebJjTf++x4fsX3Xyo7XBRuNIDuMf6VMMkPLf8h8P0+mxQ6Mo60SGa/iHN+qd
         QquiblL/NSUK+8B2zW8/bBlNR4YhswEYVA4nVtaUfwezDp7TaFtKgbnC3IwIRpgRaUSk
         UfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4uQaa0C4LRAVBFfYsZnRfLqcfZ45qVVswcaexgzhtgM=;
        b=FVoOhMFUAeDiGKQJx0uxN+hX5BYgxCdRfqOkWegdyzM/nb5JkUzm5SXFVaTEzb4rTB
         5gj+Nu3PI4dZNw8pw5RuHcbtLbgLipY66otm3AhyZ1HcWiRegpHkI9WgB+Lq3xCsJgLg
         CnwBLcF58OgkNgYjU7InwMvigenChy3Lx1VNRgcO3ASyKwJk/R1REDdbCYKz+j3yRlct
         KKF4wCqx4SD8MOunTO8alySv7JO918I9+lEwmTWtlsZDcT2xHdect/1dkUkKxarC6/ct
         QXKVE7xArPT7oEeLM0wxjYYrVTWnv/d41EMZ/q16asuEjUlP7SdSaDHwHDEmnT602HIS
         TSgw==
X-Gm-Message-State: AOAM5316tZfpMBV22d0tTldP9YRJFhniXDWBcvoUqY/pJb1NEBqXEilb
        3EerK2SPxqZOWinx4lQcdu4n8oLjCz4BAgCbIUU=
X-Google-Smtp-Source: ABdhPJyQCv0atNWUg+WwAd3H+1JcGL8bOL3T+xMH+fFBLcHWIjjlMlOQx4jklaSBO1zqfRa7dO6efiSGcV9+5GYY+hU=
X-Received: by 2002:a25:3046:: with SMTP id w67mr8327328ybw.134.1628930590367;
 Sat, 14 Aug 2021 01:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210714082608.28918-1-someguy@effective-light.com>
In-Reply-To: <20210714082608.28918-1-someguy@effective-light.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sat, 14 Aug 2021 10:43:00 +0200
Message-ID: <CAKXUXMy2hutuTP1Z3+wt3AxKuSx1G=vEQb8V4cPeaaba+jBPfA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: fix an issue regarding the git commit
 description style test
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 10:26 AM Hamza Mahfooz
<someguy@effective-light.com> wrote:
>
> If we consider the output of the following command:
>
> $ git shortlog | grep '"' | wc -l
> 14185
>
> It becomes apparent that quite a number of commits have titles that,
> contain at least one quotation mark and if you attempt to refer to those
> commits in a new patch, checkpatch throws a false positive. This is
> because, checkpatch disallows the use of quotation marks in commit titles,
> only when referring to those commits in commit descriptions.
>

Joe will certainly have the final say on this.

But just some remarks and hints from my side that might help all of us
judge this change:

14185 commits with at least one quotation mark might sound a lot, but
given that we have surpassed the one million commits, 14 thousand
commits is basically 1,4% so really a small fraction. Checkpatch is a
really large set of heuristics, many rules are much more fuzzy and
'wrong' for much larger classes than 1,4% of potential cases. So, we
are improving the heuristics here of a rule that is already very good,
compared to other checkpatch rules.

For all changes to checkpatch, that Dwaipayan (see CC), my former
mentee, contributed, we always ran a checkpatch evaluation on the
latest ~100,000 commits and checked the difference of before and after
the change to check if the change had some unexpected negative effect
besides its intended positive effect.

I would suggest that you do that too and share the results of that
evaluation with us. If you need some assistance or guidance on how to
create such a quick checkpatch evaluation, please just let Dwaipayan
and me know and we might give some further hints.

I hope this helps.

Lukas
