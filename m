Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918AF440421
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 22:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhJ2Uei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 16:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhJ2Ueh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 16:34:37 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8480BC061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 13:32:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 5so41503698edw.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 13:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ozNhOMYHhRS66Zjk0oh8InVNhdkPNj4ByxHFQ8rkaUk=;
        b=RCw3Iivy1snzcZ919MyW/R1XUhrFMj1e/VuOf6L3q0VvuplLCn6XUmySNM+UDUxoJ5
         LZl0p4GKBFe0B9/BsG5ZE+EidRP0fxRxvZSZjyQP/062kOz6n+qZgdrvSvYvb24AyNPv
         TKtuUYCXBSeCRMRiW7404PnxmIuqWIEoME3cJfWsqza0wFDfF3/lM959E8ogIhnkWQ58
         FfFtnST+shH/+pOJWCUlXWELAyhswIJTWg4Er40sCS4I6bmhilkc4bkn7YGyl2iBc5oU
         kr84n03lUtZ3AHvJI3AUQYGh4L6FoIPRVQPLiSX8FdrGjrxFbBdQL9kh0mEbLP/Ov8el
         jgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ozNhOMYHhRS66Zjk0oh8InVNhdkPNj4ByxHFQ8rkaUk=;
        b=NEUGVsNkg2+LFbLOrUTJe2vpmESVq6fYNZPTSw7GKwtEdYCjJFI/DbDjHK/j8EpCh5
         jPJs+1OVqrwzp5yWgDBe+ObAS4g5UeHN/TUaPc9yvrS24xfaO8QlYv8BYq8lNS0CxNpx
         9oK/ueyTwp+8saiNucWDxJqSA7/2Cdn/fj0BJyEhk3fN2wU/3skoKbxWJOYO8+5RxUYu
         zevQDWU6UncbN9ShPt9PnNEYIXhUZvM8lRRyyv9yNKGYFtHePsd+6nOcxt2jGbtRGYJ9
         nBbzXLBxmma/81l0fmOWvfXPMzCe87wHzXX2M9h1badFmANa1YuzO/03nYxRaQo0qxFU
         964A==
X-Gm-Message-State: AOAM531F8Iy5x1+C9TgRlrQmjOzqjxprAXYlAEg1P68TIamfu6dDPV78
        PZnoVl9XFQevFKZg9KYiT4WX3hK5zDE1Tj/jQ2rOP3v9xwDntA==
X-Google-Smtp-Source: ABdhPJztI2Nd1ffMSi/k8qSjj7eVlfXQjs6tyYTMz/oVQicYetCA3AeEFeXv38o7aYUiOvlGfDuxFe3ZaQ5X3kpoDdo=
X-Received: by 2002:aa7:ca07:: with SMTP id y7mr17607050eds.107.1635539527085;
 Fri, 29 Oct 2021 13:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211027153354.81129-1-andriy.shevchenko@linux.intel.com>
 <YXwZihLk1njsBNT4@smile.fi.intel.com> <c0524c86-fc7e-632a-8b2a-862695529115@csgroup.eu>
In-Reply-To: <c0524c86-fc7e-632a-8b2a-862695529115@csgroup.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Oct 2021 23:31:30 +0300
Message-ID: <CAHp75VeB8Dmr6Hrupb1Hj=D=oG1zPyJrhCXu37QtXHNNKdNvZg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] soc: fsl: Replace kernel.h with the necessary inclusions
To:     LEROY Christophe <christophe.leroy@csgroup.eu>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 10:04 PM LEROY Christophe
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 29/10/2021 =C3=A0 17:55, Andy Shevchenko a =C3=A9crit :
> > On Wed, Oct 27, 2021 at 06:33:54PM +0300, Andy Shevchenko wrote:
> >> When kernel.h is used in the headers it adds a lot into dependency hel=
l,
> >> especially when there are circular dependencies are involved.
> >>
> >> Replace kernel.h inclusion with the list of what is really being used.
> >
> > Seems nobody from PPC took this patch.
> > Any idea who can take it?
> >
>
> You have to check in MAINTAINERS file in the root directory of kernel
> sources: https://github.com/linuxppc/linux/blob/master/MAINTAINERS

Actually for these files get_maintainer.pl showed nothing.
I have chosen PPC maintainers manually.

> That's Michael who takes them. But you have to allow him enough time for =
it.

Thanks!

I wrote that message because I have got a notification from checkpatch
that it should go somewhere else.

--=20
With Best Regards,
Andy Shevchenko
