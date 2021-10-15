Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC96442E533
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 02:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhJOAXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 20:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhJOAXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 20:23:15 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78181C061753
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 17:21:09 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p16so34398975lfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 17:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=axcc21xdI/dvORlK9JnY4plyzJWNbNS1Oplgc4UgVPQ=;
        b=Vkna6zOYpmrV6tfJTpvlreMclp67ltxLbYGSiwE+44ex2NwtqiQS8YhV7jr/PeCtNF
         bIecXGY3fpYF7Q9pPdaUWzd3fjd9PCTU+RsVkROOQnikztXmitWv039xuwlFszGxg5Lw
         /LRZcYlWN5eQjrYAKVXF1WfuxnIhmYtQj30kaSIgQH6kO31YIjcV5MbB5MX5HjULHXvg
         BdPn4vtiV+29Y1ce90UjbWU8qEG0Q3/8X+lSWSRzx4IwU2/YjkGP5mXV80vW0T6o/dkg
         JLtY6iJrK5NmqDpBNibkvByacmoSSoQrvsqE42gOoz/jX8RV7hTDl7Z2u5Kpkqw2Qs1m
         i0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=axcc21xdI/dvORlK9JnY4plyzJWNbNS1Oplgc4UgVPQ=;
        b=6mFNff4yXl4i3KhwLXT7qXSOgn9iT0cnwYe7Y/pTnB1zWcITI/FpffmMTOO++pbcIh
         g85/8q120cb++tiszPEQU1hkTG5G2tyFABCclSf2R+PszD5K7/jwiR2RaJd2kdt7/Ax9
         gjO6b1o1TkGudnAhZU/lHF7lUEypIbUy7V23R2KU//D46O2ylUuejpMUj8zSmPJ1MsPt
         DZrh3xk54SWWOWDCRPiqlJb6S989RlSeLyb7nFscvemnyCanO/8qqg/ICd5hU1kEOPBG
         B9E360qpqpciTcM0vlcDtls6fzudW4DaAeYwvYecjb5dUITwuQkvYYUzjxTMZ1KIj0HW
         FFEA==
X-Gm-Message-State: AOAM531hQ9peLK5M5s9qTJTLMi8qX6sAeUnCX1sloon6ezr0fhw+pC+6
        IyvGJ/3kCPi4PVpIZ7tYlPek95AiFt3tBzI/LEarvKFdrkQ=
X-Google-Smtp-Source: ABdhPJwNeN0mOd7mY/vsrY80L4MJjAYh7Wko7XKqQaD5V0rIKucUbvX8H4lpmKqsHw9HeLJ5Mhu/GMSZZ3EU7mlTU9M=
X-Received: by 2002:a2e:b690:: with SMTP id l16mr2155205ljo.112.1634257267086;
 Thu, 14 Oct 2021 17:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211015095327.42344a21@canb.auug.org.au>
In-Reply-To: <20211015095327.42344a21@canb.auug.org.au>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 14 Oct 2021 17:20:54 -0700
Message-ID: <CAHRSSEwR9c1jV_Hy6DbH9aZ5Q02AeR_dkay9W9od0RpiYKdgLg@mail.gmail.com>
Subject: Re: linux-next: Fixes tags needs some work in the selinux tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Paul Moore <paul@paul-moore.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 3:53 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   fef994d85ac9 ("binder: use cred instead of task for getsecid")
>
> Fixes tag
>
>   Fixes: ec74136ded79 ("binder: create node flag to request sender's
>
> has these problem(s):
>
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>
> In commit
>
>   d1c927fb8b52 ("binder: use cred instead of task for selinux checks")
>
> Fixes tag
>
>   Fixes: 79af73079d75 ("Add security hooks to binder and implement the
>
> has these problem(s):
>
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>
> Please do not split Fixes tags over more than one line.

Stephen / Paul - do you want me to upload a new series for this or is
this something you would normally do since it is a simple change?

>
>
> --
> Cheers,
> Stephen Rothwell
