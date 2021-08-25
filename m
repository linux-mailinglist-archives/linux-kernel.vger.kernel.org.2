Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10EF3F7CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 21:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241451AbhHYT2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 15:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhHYT2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 15:28:36 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AFFC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 12:27:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g13so1128438lfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 12:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=6Iq8wyP9bfu0acszg2LRSmGYllk6hX7iU9bhGsJbEx8=;
        b=lJGomNfAfCRBeyML465YfwiYC9EIaA7nLfxj1leWBRVJ+b5wmbP3xc4r4e00iuwGZd
         fdwBKaB309OlJekyr58HUrq6d4X+9If53Inyu8eyF310/kbbykJtZXtfhRazq4JVO3sT
         47yUrCIEYtwB1slTOdiptUawftOCEToHjBDT3uoRa/EI/+HCnn4qalLRMeUNWG5qdICf
         Uwf6ZW/rSmW9TsKKCEki8KTSgrB4iEG051c/+HfMzVqG4LHHTaCwOsz12TdZtY1umO+V
         keGR+h0dzkODZ++sXPoHWtSwZlf5QhaFsM1WEuxEtziIcQILSdVk14pC3rLSie7fqa2S
         poeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6Iq8wyP9bfu0acszg2LRSmGYllk6hX7iU9bhGsJbEx8=;
        b=KP/MUlrC/l5mKDj0XmP5+0dNl80Rx7bbU87C7fHWyGk2SHTce+rDDygg7rzPeNqBWM
         07cUI94WYMSNS7tGnvKbBpNNVRyQOj9rAwEs3Nv6K3mcr/IiUCvo7LFfIqF96Xyj0xmC
         TJKwnXTyBR3uoaTrur66GeP7czUz4t2anAxEILY1ni9PD5jvYqZnMlYHNnXCZ3vppOiB
         XEr+zsZ+reO8oUMeaRMh4z7XfJjPUHSw6ccFQEV2CBSgR4fA/QMXcUqlJuJrDbQGIAuZ
         ThtvMihWMzVRXeLIFsDGBPpo2OLuIi6m1KYyYpMu6jPppyDW9ffoSCTcrL1dykIJYV77
         8dpw==
X-Gm-Message-State: AOAM532XlpthoLumoa7IUGCzr2Dt+sesrnByM01iwZj+PpG/3CrbclWr
        lTS6NZPAizbDWb7xpOUEC2U=
X-Google-Smtp-Source: ABdhPJwl3skOW4hGk8fQic1CH0gQjOep5JnW8oJnLkSZ3BEwwndG4g//jYO4Dbmrjn7DgqQ7kLaYJw==
X-Received: by 2002:a05:6512:21b1:: with SMTP id c17mr34623772lft.34.1629919668896;
        Wed, 25 Aug 2021 12:27:48 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id e8sm94154ljj.132.2021.08.25.12.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 12:27:48 -0700 (PDT)
Date:   Wed, 25 Aug 2021 22:27:46 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Ntfs3 git repo in github should not back merge
Message-ID: <20210825192746.ryi2vzn5gz4myxri@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Konstantin.

I notice that you have made back-merge in ntfs3 git repo in github.
This should not be done without good reason and there is none in this
case. If there is reason you should also write good merge commit for it.
As you are just coming to maintener I will write little info about how
this stuff works. I'm not maintainer, but I have study about how kernel
is maintained.

Here is link which you can read about back-merges. If you have any
questions you can always ask.

01.org/linuxgraphics/gfx-docs/drm/maintainer/rebasing-and-merging.html#merging-from-sibling-or-upstream-trees

You could also go check some other trees how they do it. Usually there
is next/master/main/for-next which will be repo which will contain stuff
for next-merge window. This is usually based on rc1, rc2, rc3 depending
when you put first patches to next merge window. As you based your
branch top of the rc5.

https://git.kernel.org/?s=idle

Because your master branch is  for next you could have rebased your
branch top of the rc7 if you want to but that is kinda pointless. You
could always fix little mistakes in next branch with rebase, but you
should propably info this action to ntfs3 mailing list.

The idea is that this repo has very clean history always when it get
merged to Linus tree. Also developers who work with ntfs3 can see
everything in one eye.

Example take a look Ext4 dev (for-next) branch
https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/log/?h=dev
You see that this is based on rc2. Theodore will create pull-request
based on this when he creates pull-request. Very clean history and no
back-merges.

If you wonder how should you do development then if you can't back
merge. You should do develompent in linux-next branch. This way you
always know if others break something reletad to ntfs3. Then you check
who was it and send email about it and you solve it together. It can be
tricky some times who will take which patches but help is given if you
ask.

There is lot of small info what I did not include here and hopefully
everything is correct. Hopefully you will also in near future respond
patches which are sent to you. There is already quite lot. If you need
any help how to maintainer should handle those I can assisntant you best
I can. There will be example little bit work howto make all fixes tags
right because you will have to rebase your current commits as they do
not have example reviewed-tags.

I also CC linux-next maintainer as he knows this stuff and can say if I
say something wrong. And I feel like new maintainer can have little help
from gurus.

Kari Argillander

