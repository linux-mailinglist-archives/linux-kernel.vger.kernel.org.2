Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07BA44555F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhKDOfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhKDOft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:35:49 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DC7C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 07:33:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b15so2851960edd.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxqQEO/rT8vCYvc8shTb7+5KlfliNzIt+0I9iwl8MAo=;
        b=aNkhGBzuHtE+aKaw13HGw6I6vPq73j+InPfB4QqRZKmnPZtFCRKSA+jaNq1ULgn3py
         ajyp/iY34nquejwde3BsdN+r2yLScSMwq+wWHVYh5M/bCTnOUA9qYkh5Wy2ZSYf97S7I
         UtbM9/9nqGBNqbGcaClLG3ICUvAcakurSnUAawq0yArgjcs8gyx6gDAQ8hgEiSEMDPYy
         s0+RwrrgH1e1PYxZGi0Taqld5gI6htVwEPSq8DqYi/pWW2pbkANtuuoUDWuz63nCdDGQ
         HdFXgrPD92t0zW2rsyezLbggeVi7CAwE08+ZB7CCWizu5/KmyBQYDyjKYT2v4lD7VYf/
         lTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxqQEO/rT8vCYvc8shTb7+5KlfliNzIt+0I9iwl8MAo=;
        b=4d3AMYw+v1e45INDSACiP91tnggtMyq4GaKBSIGZs0I/d95/hFPqzm4bqkgpLV7TgI
         0eEqUP8b1qxYuoTJEORP4cUDxucZpU7Dms7Y2W5b2H+VJyVD6Y+wVltMK7qYfeuzN1ec
         0C+vUNZ5w98PJAorjA2UR1TOaP3InpdqarwaMEpPwFC2e5QoUWK0Qhq6TlU3wuCmnEsQ
         GKJ5ArtwRnTWR1lXIfgQ/caqKFgbaKrOx682AjK6D10D+5yCcOIKRSG/uheFMeD9lJRI
         a/mALJmvG3vVhes2avabKQhDeWohVdkvpva3zbcO0N55IywYQKJeZFau86PQvlylHlR2
         cvvA==
X-Gm-Message-State: AOAM532nttttEV00HNH2ZSTDlGGYZ6fGic4Iz2JcdM2B03xRZOFQDbCk
        pI8p1YpHSLdRkTr0LTsbgfOVL6xxPEDSiosjG/sz
X-Google-Smtp-Source: ABdhPJwE13mGNmySljOzUaHZss3NKTk1pkR2BMQqKnkop5Bli+fJLDi2R01BTeWo+lIIwuW3sMwj52Z3kphzbdOTwmc=
X-Received: by 2002:a17:907:868f:: with SMTP id qa15mr37133631ejc.187.1636036386968;
 Thu, 04 Nov 2021 07:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <a4b3951d1191d4183d92a07a6097566bde60d00a.1629812058.git.christophe.leroy@csgroup.eu>
 <163584790624.1845480.1785827913484538939.b4-ty@ellerman.id.au>
 <CAHC9VhROvSQHVQ6Wo8zHND1rGm+r6dGJur69B65sJ9JwNvMDpQ@mail.gmail.com>
 <87a6im87tq.fsf@mpe.ellerman.id.au> <20211102235449.rwtbgmddkzdaodhv@meerkat.local>
 <871r3w8msd.fsf@mpe.ellerman.id.au>
In-Reply-To: <871r3w8msd.fsf@mpe.ellerman.id.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 Nov 2021 10:32:55 -0400
Message-ID: <CAHC9VhSypCHxrAZA6dix1iHj12PPDQHhigPDmPdW59rPekRN-Q@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        patch-notifications@ellerman.id.au,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        linuxppc-dev@lists.ozlabs.org, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 2:20 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:
> > On Wed, Nov 03, 2021 at 10:18:57AM +1100, Michael Ellerman wrote:
> >> It's not in next, that notification is from the b4 thanks script, which
> >> didn't notice that the commit has since been reverted.
> >
> > Yeah... I'm not sure how to catch that, but I'm open to suggestions.
>
> I think that's probably the first time I've had a commit and a revert of
> the commit in the same batch of thanks mails.
>
> And the notification is not wrong, the commit was applied with that SHA,
> it is in the tree.
>
> So I'm not sure it's very common to have a commit & a revert in the tree
> at the same time.

I know it is not common for the SELinux and audit trees.  I guess
every tree/maintainer is different, but I'm probably more conservative
than most when it comes to merging patches so it's pretty rare that we
need to revert things in those trees.

> On the other hand being able to generate a mail for an arbitrary revert
> would be helpful, ie. independent of any thanks state.
>
> eg, picking a random commit from the past:
>
>   e95ad5f21693 ("powerpc/head_check: Fix shellcheck errors")
>
> If I revert that in my tree today, it'd be cool if I could run something
> that would detect the revert, backtrack to the reverted commit, extract
> the message-id from the Link: tag, and generate a reply to the original
> submission noting that it's now been reverted.

Even if it isn't practical to do the find-the-original-commit logic,
simply getting an email that says "FYI, this revert has been merged
into this tree/branch" would be helpful.  Although I guess that would
require either the revert having the right metadata, e.g. "Cc:", or
that prior mentioned logic to find the original commit so the proper
To/CC lines could be generated.

-- 
paul moore
www.paul-moore.com
