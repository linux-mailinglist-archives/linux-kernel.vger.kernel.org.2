Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7D33FADDC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 20:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbhH2Sho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 14:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbhH2Shj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 14:37:39 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709B9C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 11:36:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s10so1688025lfr.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 11:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m7TWMTgfTxT7/7EG4LyyaJdKNT+SzQbfeGl2On3Ben0=;
        b=JQ3HYwdgVvoPpGPUramb0TGGe61AeJS8g+Pqi8hjJhZnI8qBalEUMEajfzTkQs3PPJ
         aKKJ/wJvPdaN/+xrBveH0+/CgeSLuyUOmcfvSjmRbAiGn6ANrzQi+TwXoYfNql8oJwEi
         SVDpXyo2+jJ8LYlaIdi6VWydSd6gd4rW61D9uQ9BB2fCrY8/wTtEcN0esYiwlSrjpY5w
         8g2AroIOZpZPLQwpUiNPZIGgjHY181s1AEfzahC1A5ZZMK1inhsNnkyZZS1vg4fTdHzO
         J7hhOkEc1UxOBk4cv0vefIrnqxmaPJbnyFJU6sJYm4djP2f30bHsWtqPDjqcRnL1BB7j
         Yasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m7TWMTgfTxT7/7EG4LyyaJdKNT+SzQbfeGl2On3Ben0=;
        b=LynuDtRXaO+8bqlwocNsuaqqJsALeaoUtX8BWv7Rdw02tx5JtTeIP7e1/1cwacUtfv
         c15p84Hon7s2Et0C86WzUZIiJAiV0stcHz6Dt4tOo2hBguWlBYGp2yGUg/m68SKifHjk
         8WojiGnAlfB0rb80grqfgyHRTQyLzFkGuJR4gy/WU0vJGqPZOMoJfeu47bxjcdFjvUYx
         Zy+wrUTzHHdKgmWQTwBGnyLYPuZSNCJX9mzlgSGPKsO6+bh6tv9ILRzs9NmsL3G0YTJN
         Difq68TgtHb/iyZexo2pPYPF9374j2BF4HynWsWyKdrEwVcrW+wxWyWZgSEW9lhOtgd5
         Y7Gg==
X-Gm-Message-State: AOAM533Nyx3xEfHzViCHFVMIiEKa8CAjT1pKp1oplWElh7OyCdincVzb
        fu+GK/qy66yYWAicHRtDtL4=
X-Google-Smtp-Source: ABdhPJxYCUPgZSYc5epJ+WPhXSFNm/VKSXCbNN6B1UPueZ38rsAAozV16DJm6AehLCFFyy598d4g3Q==
X-Received: by 2002:a05:6512:3f1a:: with SMTP id y26mr14486247lfa.263.1630262204716;
        Sun, 29 Aug 2021 11:36:44 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id z5sm1533509ljc.123.2021.08.29.11.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 11:36:44 -0700 (PDT)
Date:   Sun, 29 Aug 2021 21:36:42 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Ntfs3 git repo in github should not back merge
Message-ID: <20210829183642.xatnwsqfmmq6vxx7@kari-VirtualBox>
References: <20210825192746.ryi2vzn5gz4myxri@kari-VirtualBox>
 <3e3b8facf46c4d68afeb0346dee66f5b@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e3b8facf46c4d68afeb0346dee66f5b@paragon-software.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 06:27:47PM +0000, Konstantin Komarov wrote:
> > From: Kari Argillander <kari.argillander@gmail.com>
> > Sent: Wednesday, August 25, 2021 10:28 PM
> > To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>; ntfs3@lists.linux.dev
> > Cc: linux-kernel@vger.kernel.org; Stephen Rothwell <sfr@canb.auug.org.au>
> > Subject: Ntfs3 git repo in github should not back merge
> > 
> > Hello Konstantin.
> > 
> > I notice that you have made back-merge in ntfs3 git repo in github.
> > This should not be done without good reason and there is none in this
> > case. If there is reason you should also write good merge commit for it.
> > As you are just coming to maintener I will write little info about how
> > this stuff works. I'm not maintainer, but I have study about how kernel
> > is maintained.
> > 
> > Here is link which you can read about back-merges. If you have any
> > questions you can always ask.
> > 
> > 01.org/linuxgraphics/gfx-docs/drm/maintainer/rebasing-and-merging.html#merging-from-sibling-or-upstream-trees
> > 
> 
> Hi Kari!
> Thanks a lot for this piece of information. It is really important to know.
> Apologies for messing the back-merge up, we'll study the provided documentation
> and will follow it in future (and won't be back merging again).
> There is really a LOT of information to handle there.

I think we should fix this before sending pr to Linus. I think he will
not be happy to see it. You are allowed to force push in situations like
this.

> > You could also go check some other trees how they do it. Usually there
> > is next/master/main/for-next which will be repo which will contain stuff
> > for next-merge window. This is usually based on rc1, rc2, rc3 depending
> > when you put first patches to next merge window. As you based your
> > branch top of the rc5.
> > 
> > https://git.kernel.org/?s=idle
> > 
> > Because your master branch is  for next you could have rebased your
> > branch top of the rc7 if you want to but that is kinda pointless. You
> > could always fix little mistakes in next branch with rebase, but you
> > should propably info this action to ntfs3 mailing list.
> > 
> > The idea is that this repo has very clean history always when it get
> > merged to Linus tree. Also developers who work with ntfs3 can see
> > everything in one eye.
> > 
> > Example take a look Ext4 dev (for-next) branch
> > https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/log/?h=dev
> > You see that this is based on rc2. Theodore will create pull-request
> > based on this when he creates pull-request. Very clean history and no
> > back-merges.
> > 
> > If you wonder how should you do development then if you can't back
> > merge. You should do develompent in linux-next branch. This way you
> > always know if others break something reletad to ntfs3. Then you check
> > who was it and send email about it and you solve it together. It can be
> > tricky some times who will take which patches but help is given if you
> > ask.
> > 
> This last paragraph actually is not very clear. Can you please refer couple of
> examples of such activity?

Good that you ask.

Example if you now we are trying to get ntfs3 in to 5.15. Linux-next is
kinda snapshot what 5.15 will look like. It is not absolute truth but
close. Our master branch will included linux-next every day and so are
everyone else trees. If you develop something new you should do this in
linux-next so you will notice right away if something breaks. It is good
happit to rebase current work top that if not everyday at least once a
week.

When something breaks you will know that something needs to be resolved
before you make pr. Or at least you need to info Linus that this kind of
situation will happend with tree X. If build breaks you will probably
get email from Stephen about it. But there is situations which can break
ntfs3 without breaking the build.

One another thing with linux-next is that if you use it you will help
others. If something breaks you can info other maintainer that something
is wrong. Same thing will happend other way around. 

Little off topic but, I will in near future make CI system which will
test ntfs3 in linux-next everytime new linux-next tag comes up. 

So using linux-next is not absolute necessary, but will benefit
everyone. There will also be times when someone send you patch and that
patch will only apply example to last stable Linux version. Then you ask
to rebase top of the linux-next or ntfs3/master. This is also reason why
development should be done in linux-next.

> 
> > There is lot of small info what I did not include here and hopefully
> > everything is correct. Hopefully you will also in near future respond
> > patches which are sent to you. There is already quite lot. If you need
> > any help how to maintainer should handle those I can assisntant you best
> > I can. There will be example little bit work howto make all fixes tags
> > right because you will have to rebase your current commits as they do
> > not have example reviewed-tags.
> > 
> We've just applied several patches proposed for past ~month. Please have a look
> on them - we tried to stick to the patch acception guidelines. Hopefully, they
> are good from this point of view.

They are ok :) Only wrong thing which I found was that with one patch
you first apply v1 and then v2. v1 was not needed. These where patches

v1:
 be87e821fdb5 ("fs/ntfs3: Fix one none utf8 char in source file")
v2:
 24516d481dfc ("fs/ntfs3: Restyle comment block in ni_parse_reparse()")

But this mistake where ok and did not do any harm.

I notice that you also made devel branch to github. I can help you with
these things that you first made changes to devel and then send email to
ntfs3 list or directly to me and I can check that it is ok and then you
push it to master. This way no messing up "public" branch. Just for
starter so that we get these things going.

I also advice you to not only applying patches, but also replying emails
to thouse which you did not apply. Usually people will resend in week or
two if nobody haven't respond.

> > I also CC linux-next maintainer as he knows this stuff and can say if I
> > say something wrong. And I feel like new maintainer can have little help
> > from gurus.
> > 
> > Kari Argillander
> 
> Thanks a lot once again, Kari! Really great help here.

Happy to help.

> Best regards,
> Konstantin
