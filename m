Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6463330E731
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 00:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhBCXW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 18:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbhBCXWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 18:22:25 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94182C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 15:21:44 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s3so1764754edi.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 15:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xSDYIhEylmTeuw2DTZnxcQ8Wrmv9RL9dV2+z2ww2C58=;
        b=Zd1fDhAzbh5JvfCU6vB0KH+C1t8PwCmbtck9DtxbZC6JIxzuc2W8BnxxTOHeQVA8g+
         PNKk39/2C7orZiikLVhOU0aUFcYzFZPCAiUz906HqyT+f5EQB0aeDJiKmeABcIcMY2ES
         SEBKYKFXhIhRk3d47BgYfI/U05TZViJQOBwb8qstXCRxDlO/yVAW7DDLXq6xmdNJWKR4
         dIl0Z9Mutk0qUc3a866bIZHo25TCKiav9VYs0cwhi14p+8hJi7+fZaYWPBE06hMEu6oH
         Y+nGgw1MsSpa1TAUq3/+Dg8Cq3YL17F5aIHRRZeeE1sL6Dy3Bb1P3S1oUT3DhpOFRUal
         AXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xSDYIhEylmTeuw2DTZnxcQ8Wrmv9RL9dV2+z2ww2C58=;
        b=szDFC5O8n2KV7xODqQqvpFT0y0vqzZqFGZTjH9EUzv9cAF/C0jmT+4qJjoq62qXT3c
         Ll4T+qarpUuSYwHcw2L/SlyoQEhrU7YmzsDL0Y69F1ppFrb8XmDaK07zpHXpHPTk6yVR
         3I4/fsuROEsQSUaWMCUF/UYXIpJt9X/I/1BMMrC6CZSx6LFiqUTrwiZGGgSvrCQesCym
         W0ByumoLiVPu4EFTHkbpSse9HBmcROP88Ah21zP5eLsxAhZGpNqywPs2rC/LpF2XXKIB
         Awkdqpyljj5qK85Zk7xf0QcbP8+HTHjFPd1nz+VnucIx6cB6MUu0wNB9rC/3uBa0CSu9
         +9Ag==
X-Gm-Message-State: AOAM533LCXpbyAEIIa8g7+b+peR5BaIQjo8KWq00ZVgjwagK7NGurISa
        u0aOSqYIsLX30rFfTSyDV8N4y1akhXx6ux6w876yiD+xmeBtuA==
X-Google-Smtp-Source: ABdhPJyteeQ58iqBp708IkG20W61ytTXE2+o+FVaBb6qxe1eJ+Vel1tEfe88TMdmh5m2BlxU+Os2ZdYF0XcUo2JYQzo=
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr5570748edv.116.1612394503379;
 Wed, 03 Feb 2021 15:21:43 -0800 (PST)
MIME-Version: 1.0
References: <20210202200324.5179db33@canb.auug.org.au> <CAK8P3a3uJfyt6vsgTdSjnE23V4E_Mw=N89nrMPLJ6bhA363nqw@mail.gmail.com>
 <5504da4f-7eec-ecb0-c47d-7821d06dc880@infradead.org> <CAK8P3a2Y9-5dhk1MaZhhnKQkbOtqOSqfqZA0c4ncBXgD8tJTZg@mail.gmail.com>
 <CA+CK2bC9oMvtkT3MZzxNMtCn1b0hafYPbLH3GM_Z_66j_NQeJA@mail.gmail.com>
In-Reply-To: <CA+CK2bC9oMvtkT3MZzxNMtCn1b0hafYPbLH3GM_Z_66j_NQeJA@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 3 Feb 2021 18:21:07 -0500
Message-ID: <CA+CK2bBpuiLf7y7qVDoo3k6vajoaTkrDNx+pnNBTMYY616iDwA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen, do you want to send a new patch based on the current
linux-next, or do you want me to send an updated version?

Thank you,
Pasha

On Wed, Feb 3, 2021 at 5:36 PM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
>
> > > After the most recent build errors, I tried to apply Pavel's patch
> > >   https://lore.kernel.org/linux-mm/CA+CK2bBjC8=cRsL5VhWkcevPsqSXWhsANVjsFNMERLT8vWtiQw@mail.gmail.com/
> > > but patch said that it was already applied (by Andrew I think),
> > > so I bailed out (gave up).
> >
> > As far as I can tell, there are two different bugs that got mixed up, and
> > we need both Pavel's patch (which is now in -next) and Stephen's
> > (which got dropped again).
>
> Stephen's patch looks OK to me. I should have used define instead of
> inline to begin with.
>
> Thank you,
> Pasha
>
> >
> >         Arnd
