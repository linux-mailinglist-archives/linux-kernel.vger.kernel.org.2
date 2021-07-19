Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BA93CCD6A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 07:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhGSFbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 01:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhGSFbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 01:31:50 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56FBC061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 22:28:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n11so8997853plc.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 22:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=wRPbS6zpQ9FVE+NUj4IhGamo+w19qmgSr64zdmso1eM=;
        b=OAsf0Svf6FbEYmR4WgRIbSshYTr67hh80/dyack0GosHONUAM4KG3wxqffwR3ytrh8
         qiC7x40PResPZLAniD0jtGtMslGWOg/9bwEfe7oR55nSsSl3r0kLb/XfBqMGtahONQu1
         LCPbOmf7GodRre5OBGXM81Y9jX/oi+nUJPd+HHCFb9XJAq1RZrPoLPQ9sptI1ZACwodE
         nBmfcO3wL6+n724rPHtE+VAp6E26seScIYXWyCaq1otxi9wZjY/QRt8jt281dwQSwSBu
         476RiqkiWBfA0U5777pjYCsHeZreZCJRZH7yQTZMWd4jU/wUPuxmTfVwEoSWRtFhAiSr
         fJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=wRPbS6zpQ9FVE+NUj4IhGamo+w19qmgSr64zdmso1eM=;
        b=hMeEIbQlIx+v9wad/ekG02AdPzHRHh6Mf4etz2AA7h0qhtaqrN35La+noxbvl9SFea
         G+nWUVXvsH/RKXrZKYDWq+KW3nSIfUmZMYSYwXIHtCSbieQ7ptBH+8LipyggtTL++0nH
         valx5hnO1XXw6WI2prWyoCJJ4XnilBZOIep2Li7feqB1Al5y6ZK/TcFIXpTxXA44MYsT
         MP3atpJ22dA2T1ZwPzAq61FOQv5L+n+1RvgSqW/0HMbehPumBpo9D9kfhg6YyqLDyl1W
         hQ7pUTL9NvloLv90xpPCfW1jG9GlVD1c/4aTdy7VAgZr1rqiUOUlmknstdvSYjdeQmh1
         zi6g==
X-Gm-Message-State: AOAM532YELZwTNNpqAbfhMqAEuFCqzl7PRtjcgxsraOwc4ZFNcjnyobw
        E1Up4yDk6PxV5q1IRSnh+W/icQ==
X-Google-Smtp-Source: ABdhPJwUdgiyNa2IXaXk1+7GH7nxPyCjG76eHgetuovGboP7MO0nQ6RPGZrcC9c2zEdRqpbVjsuXrQ==
X-Received: by 2002:a17:902:e202:b029:129:73d9:b846 with SMTP id u2-20020a170902e202b029012973d9b846mr17709091plb.26.1626672526613;
        Sun, 18 Jul 2021 22:28:46 -0700 (PDT)
Received: from anisinha-lenovo ([115.96.137.169])
        by smtp.googlemail.com with ESMTPSA id ca16sm14762701pjb.44.2021.07.18.22.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 22:28:46 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
X-Google-Original-From: Ani Sinha <anisinha@anisinha.ca>
Date:   Mon, 19 Jul 2021 10:58:30 +0530 (IST)
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
In-Reply-To: <c32293fc03a8673ade348ed4451c60dfdf9bb2c1.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2107191054260.9400@anisinha-lenovo>
References: <20210714063422.2164699-1-ani@anisinha.ca> <alpine.DEB.2.22.394.2107162145100.3277407@anisinha-lenovo> <CAKXUXMzxyQxYKdnuVbZnUFbYFuKMq+Vc5LxSR-_fKtH2dv-4wA@mail.gmail.com> <alpine.DEB.2.21.2107181853320.55905@ani-ubuntu>
 <c32293fc03a8673ade348ed4451c60dfdf9bb2c1.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2088271309-64158316-1626672525=:9400"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--2088271309-64158316-1626672525=:9400
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Sun, 18 Jul 2021, Joe Perches wrote:

> On Sun, 2021-07-18 at 19:08 +0530, Ani Sinha wrote:
> > On Sun, 18 Jul 2021, Lukas Bulwahn wrote:
> > > On Fri, Jul 16, 2021 at 6:15 PM Ani Sinha <ani@anisinha.ca> wrote:
> > > > checkpatch maintainers, any comments?
> > > > On Wed, 14 Jul 2021, Ani Sinha wrote:
> > > > > The preferred style for long (multi-line) comments is:
> > > > >
> > > > > .. code-block:: c
> > > > >
> > > > >       /*
> > > > >        * This is the preferred style for multi-line
> > > > >        * comments in the Linux kernel source code.
> > > > >        * Please use it consistently.
> > > > >        *
> > > > >        * Description:  A column of asterisks on the left side,
> > > > >        * with beginning and ending almost-blank lines.
> > > > >        */
> > > > >
> > > > > It seems rule in checkpatch.pl is missing to ensure this for
> > > > > non-networking related changes. This patch adds this rule.
> []
> > > Honest feedback: IMHO, your commit message is unreadable and incomprehensible.
> >
> > OK. However, I fail to see how your above comment is useful without any
> > suggestion as to how to improve the commit log. I find having some test
> > data with the commit message valuable so that there is some sort of record
> > as to how the change was tested and with what arguments. Beyond that this
> > is not something I am really worried about. The commit message can be
> > modified and improved in any way reviewers like.
> >
> > >
> > > Now to the feature you are proposing:
> > >
> > > I do not think that it is good if checkpatch would point out a quite
> > > trivial syntactic issue that probably is currently violated many times
> > > (>10,000 or even >100,000 times?) in the overall repository. That will
> > > make checkpatch warn on many commits with this check and divert the
> > > attention from other checks that are more important than the style of
> > > starting comments.
> >
> > I have some strong opinions on this. Just because a rule has been violated
> > in the past does not mean it can continue to be violated in the future.
>
> Intensity of opinion varies considerably here.
>
> > > Further, some evaluation by Aditya shows that the distinction between
> > > NETWORKING COMMENT STYLE and GENERAL KERNEL COMMENT STYLE is not as
> > > easily split as currently encoded in the checkpatch script,
> > > https://lore.kernel.org/linux-kernel-mentees/cfff5784-9ca3-07f8-c51c-f1c82b2871e3@gmail.com/.
> > > So, this checkpatch check is largely wrong already as of now and most
> > > probably ignored by many contributors.
>
> The only reason the rule exists at all is because the networking maintainer
> was constantly telling people to change the comment style in patches.
>
> I don't care one way or another.
>
> // comments are fine
> /* comments are fine */
>
> In networking, multiline comments are almost exclusively like
> what Linus himself does not like:
>
> 	/* comment
> 	 * ...
> 	 */
>
> but in other subsystems, the styles of multiline comments varies.
>
> Either works, there is no single standard.
>

OK then in that case, maybe update
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v5.14-rc2#n584

It is confusing to patch submitters (and it happened to me with a recent
patch) that the reviewer insists on a particular commenting style when
checkpatch does not enforce it. Its confusing for reviewers too.


> And as the referenced link by Aditya somewhat shows, the nominal
> rule compliance varies by the age of the code.  No one care much
> about code submitted a couple decades ago for subsystems and drivers
> that are effectively obsolete...
>
>
>
--2088271309-64158316-1626672525=:9400--
