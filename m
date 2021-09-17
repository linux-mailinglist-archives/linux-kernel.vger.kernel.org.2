Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2231040F1B0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 07:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244897AbhIQFlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 01:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbhIQFlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 01:41:21 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E62C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 22:39:59 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p12-20020a17090adf8c00b0019c959bc795so933102pjv.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 22:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDmd8ycUb5A33cqxczJ56wHGFGeWT2rzATobJNiElZc=;
        b=mjKLzQ4indMMpCe2+SSAdTsz4b8weE1gFwDDjCVqrp9B3pKj/bdL1dSfl3/8kMyDCa
         OwNV8mBPxU0bohv0fNfCJuap5gQU8HNWcHGvgWIX9Lhe7vGcS0pmJGS5ohNAPqSW6y2b
         HqPHz2ZXAbYY+37RrveljTcqnLFKRWJM074UPOg0nvYDWFIceiA6ATCiTK4fbdFOd+Vo
         dqzJiLqCMHcx+FD5eJ2pRWB6exkXZDw4haYWbQNDsI6lawjDscBFXvjHFo6B0WPx7Aoy
         3w8qeKXz5bhoAg7yncGtqLrlHT7BrfpztPQ9n7irXnqvU4hMwQ7+uzq+gLEMQP63o4JJ
         +kHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDmd8ycUb5A33cqxczJ56wHGFGeWT2rzATobJNiElZc=;
        b=VDBRT3C7QDSaYdPcs96kFaOzX1ZkoqSa44AVoodG3/8W7hT91TGqKJr0INKNsKlP5x
         R81GJ6xcdeOTWLpPxwMn7lVnty3ybalo0FsTuUhyPqtkw4DIZmN1epRjfdoabAEfAjdD
         c3OJwKzLJkPme7XkuC0NbiQRTDvDO6iPJ/ubk4m05x1wcASraTE0daWe1kZiBCQz31X7
         b8Br7u5KJq7dVcGjSqu5HNTWOBZLOWmpIvCdAODmYpA6q/cBgYYp4tbNsOtWhuoLvbKz
         ObodKMRpZNoH7DEI2DwfuRCzXCV9XpAKLSrQkofr9jKTfbrHnaHBISAD3fKYS5SSEXVQ
         9eIw==
X-Gm-Message-State: AOAM532W0XYIrGTFQD/uvSyCS0svk8ajsGoPCP3O1nYV/0na5UwMNVyB
        B3TSx0kPBkS39O+QwW8rmfn7u9S8f5pn6+wbhy0Dvw==
X-Google-Smtp-Source: ABdhPJzZMkaEHIdpYul5buHW1Dv1P4OGtrg3QMqu5AMf+ifi+Fe4a5b98Wn+iDry0ryDPZOE6JwsAGuPU3s4o9OB4gc=
X-Received: by 2002:a17:902:6f17:b0:139:eec4:867e with SMTP id
 w23-20020a1709026f1700b00139eec4867emr8140416plk.77.1631857198933; Thu, 16
 Sep 2021 22:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtFvJdtBknaDKR54HHMf4XsXKD4UD3qXkQ1KhgY19n3tw@mail.gmail.com>
 <CAHk-=wisUqoX5Njrnnpp0pDx+bxSAJdPxfgEUv82tZkvUqoN1w@mail.gmail.com>
 <CAHk-=whF9F89vsfH8E9TGc0tZA-yhzi2Di8wOtquNB5vRkFX5w@mail.gmail.com>
 <36aa5cb7-e3d6-33cb-9ac6-c9ff1169d711@linuxfoundation.org>
 <CAK8P3a1vNx1s-tcjtu6VDxak4NHyztF0XZGe3wOrNbigx1f4tw@mail.gmail.com>
 <120389b9-f90b-0fa3-21d5-1f789b4c984d@linuxfoundation.org>
 <CAFd5g47MgGCoenw08hehegstQSujT7AwksQkxA7mQgKhChimNw@mail.gmail.com>
 <3bad5d2f-8ce7-d0b9-19ad-def68d4193dd@linuxfoundation.org>
 <CAFd5g47bZbqGgMn8PVa=DaSFfjnJsLGVsLTYzmmCOpdv-TfUSQ@mail.gmail.com> <CAK8P3a0wQC+9_3wJEACgOLa9C5_zLSmDfU=_79h_KMSE_9JxRw@mail.gmail.com>
In-Reply-To: <CAK8P3a0wQC+9_3wJEACgOLa9C5_zLSmDfU=_79h_KMSE_9JxRw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 16 Sep 2021 22:39:47 -0700
Message-ID: <CAFd5g44udqkDiYBWh+VeDVJ=ELXeoXwunjv0f9frEN6HJODZng@mail.gmail.com>
Subject: Re: ipv4/tcp.c:4234:1: error: the frame size of 1152 bytes is larger
 than 1024 bytes [-Werror=frame-larger-than=]
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Ariel Elior <aelior@marvell.com>,
        GR-everest-linux-l2@marvell.com, Wei Liu <wei.liu@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 3:04 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Sep 14, 2021 at 10:48 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Mon, Sep 13, 2021 at 1:55 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
> > >
> > > On 9/8/21 3:24 PM, Brendan Higgins wrote:
> > > Brendan,
> > >
> > > Would you like to send me the fix with Suggested-by for Arnd or Kees?
> >
> > So it looks like Arnd's fix was accepted (whether by him or someone
> > else) for property-entry-test and Linus already fixed thunderbolt, so
> > the only remaining of Arnd's patches is for the bitfield test, so I'll
> > resend that one in a bit.
> >
> > Also, I haven't actually tried Linus' suggestion yet, but the logic is
> > sound and the change *should* be fairly unintrusive - I am going to
> > give that a try and report back (but I will get the bitfield
> > structleak disable patch out first since I already got that applying).
>
> Looking at my randconfig tree, I find these six instances:
>
> $ git grep -w DISABLE_STRUCTLEAK_PLUGIN
> drivers/base/test/Makefile:CFLAGS_property-entry-test.o +=
> $(DISABLE_STRUCTLEAK_PLUGIN)
> drivers/iio/test/Makefile:CFLAGS_iio-test-format.o +=
> $(DISABLE_STRUCTLEAK_PLUGIN)
> drivers/mmc/host/Makefile:CFLAGS_sdhci-of-aspeed.o              +=
> $(DISABLE_STRUCTLEAK_PLUGIN)
> drivers/thunderbolt/Makefile:CFLAGS_test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
> lib/Makefile:CFLAGS_test_scanf.o += $(DISABLE_STRUCTLEAK_PLUGIN)
> lib/Makefile:CFLAGS_bitfield_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
> scripts/Makefile.gcc-plugins:    DISABLE_STRUCTLEAK_PLUGIN +=
> -fplugin-arg-structleak_plugin-disable
> scripts/Makefile.gcc-plugins:export DISABLE_STRUCTLEAK_PLUGIN

Alright, I incorporated all the above into a patchset that I think is
ready to send out, but I had a couple of issues with the above
suggestions:

- I could not find a config which causes a stacksize warning for
sdhci-of-aspeed.
- test_scanf is not a KUnit test.
- Linus already fixed the thunderbolt test by breaking up the test cases.

I am going to send out patches for the thunderbolt test and for the
sdhci-of-aspeed test for the sake of completeness, but I am not sure
if we should merge those two. I'll let y'all decide on the patch
review.

I only based the thunderbolt and bitfield test fixes on actual patches
from Arnd, but I think Arnd pretty much did all the work here so I am
crediting him with a Co-developed-by on all the other patches, so
Arnd: please follow up on the other patches with a signed-off-by,
unless you would rather me credit you in some other way.

> Sorry for failing to submit these as a proper patch. If you send a new version,
> I think you need to make sure you cover all of the above, using whichever
> change you like best.

I am still going to try to get Linus' suggestion working since it
actually solves the problem, but I would rather get the above
suggested fix out there since it is quick and I know it works.

Cheers
