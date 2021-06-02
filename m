Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F36F398F21
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhFBPqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbhFBPpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:45:12 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5719FC061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 08:43:15 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso2789177otu.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 08:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8tyanviLNguYjdHyB5/9BULlk+3d/ekam7+w/MuyW2s=;
        b=boMPMQNRdiXV8/6uOQG1j4VkxRBI7KhVmUPkz2+HcRYJaeAcNBfUcoUyaDFyd7WyjO
         ovgu88CcW1BQJU8Nqf0HeAjncX7tvYNH3nKS/y8SAJOmvTzsoAPge/dXofF2L2451Orb
         h5R5Vfi8MEU8bgtXfjCgp4MaQ7S3ksOzYzSgLQe1jhAJVfbzjttO9pfVht5P7XR7Q4B5
         4+hb/kzqTEZpSJVtClrz6UhutTj14bW0FakHjlb5IAHdXrFZyqvOTnquVuJ0P5++JCB7
         aOx3WOxrRCHHcoCFUFv4kgZwd8tSZ0Zrioi7T3fKHvqTJyAI2QhfAZI2fhsAi5xP+xsZ
         kS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8tyanviLNguYjdHyB5/9BULlk+3d/ekam7+w/MuyW2s=;
        b=rPOHHjQ1MXQSkky7H1VlzVCBmYEdBQzf3QryN9BmwFutOOFbJN5/Z49tva4+AQImZv
         l0mfH3Lq7lOFkVT6rEaYbUxAiMdoxZdHnoaDGafYKbYKRe/ft1pWuZP7/9hropHgthNj
         9FtnOZGjhA5GoQsM/P/vjB+4E/55oDNLYOgdexwUnWtvQEODE6jjSv1vJBVgvrh8sjeU
         sxPaRWyUF9zIeYPusvKMGgXQFHfBwdrIgbqEpriekw99MOEU/8xwwMAFEVSwJ0D6eQu/
         z78/ZVyeOKwa5+wwFe56ihN8c473BW2kUsPOySG/RXf94izCygI3so6JkXuGIXqlStou
         TcAQ==
X-Gm-Message-State: AOAM532CTcQoLwhnP9V8ZuB0RTWzIhziVusbH0/+zmR3LzPis+Bs9z2b
        l5bnzs4ykENvgIZimPbXObOBijNJDEHQwRHolmjXRBoTDUmNEA==
X-Google-Smtp-Source: ABdhPJwLT90PmyY3UsGqkDcyX6yRtn7S6AN7eBVtcxIp2kxJV+dHTXil3pmYptM+vM2pFhtWWr8iGQJmjDiRFu1ytiE=
X-Received: by 2002:a9d:729d:: with SMTP id t29mr5454098otj.256.1622648594616;
 Wed, 02 Jun 2021 08:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210602151038.53794-1-manikishanghantasala@gmail.com>
 <YLehYmLYBMmI8MOk@kroah.com> <a5b5c871537bcc6931894e8f61ca7b28950c114a.camel@perches.com>
In-Reply-To: <a5b5c871537bcc6931894e8f61ca7b28950c114a.camel@perches.com>
From:   Manikishan Ghantasala <manikishanghantasala@gmail.com>
Date:   Wed, 2 Jun 2021 21:12:38 +0530
Message-ID: <CAKzJ-FOT8hnHqpYB8WiMOd5FgK9_BPgrv8FmvxXnSFA_9mhsOA@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8192u: fix coding-style issues in r8192U_hw.h
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,
Thank you for the response, I am changing the mismatch with the real name.
Should I also prepare a new set of three patches separately as bot suggested?

Regards,
Manikishan Ghantasala
B.tech CSE
twitter | GitHub | amFOSS

On Wed, 2 Jun 2021 at 21:06, Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2021-06-02 at 17:18 +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jun 02, 2021 at 08:40:33PM +0530, sh4nnu wrote:
> > > staging: rtl8192u: r8192U_hw.h: Clear the coding-style issue
> > >
> > > "Macros with complex values should be enclosed in parantheses"
> > > by enclosing values in parantheses.
>
> parentheses
>
> > > Signed-off-by: sh4nnu <manikishanghantasala@gmail.com>
> []
> > - It looks like you did not use your "real" name for the patch on either
> >   the Signed-off-by: line, or the From: line (both of which have to
> >   match).  Please read the kernel file, Documentation/SubmittingPatches
> >   for how to do this correctly.
>
> Might be useful to have the patchbot script reduce the content of the
> message when it's identifiable.
>
> The patch itself looks OK.
>
>
