Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AFB415588
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 04:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbhIWCtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 22:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238899AbhIWCtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 22:49:17 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551D2C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 19:47:46 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q68so4826713pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 19:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/VKaH5LYPKrDQyH84TANzL55TxA7XWLk0nnnZWpUxxY=;
        b=gWHI3fbRffkXeOZe7VBtHpM0rsjd95uMaPBQTsRiJPv5Fn/2faFRuKbgkQ9OrV2sNh
         KTY7zucxT3Fb6f/ZL+8zs9FoQbcrkMEghy7cqtIYNRMMzPVzUuErMoH++tRCysj2DG/7
         5kumQgjzIt4iEugzLGlKNOLYI/5At9xZMuS7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/VKaH5LYPKrDQyH84TANzL55TxA7XWLk0nnnZWpUxxY=;
        b=AdWA+rnZNniu3fMgQDIMaIHXbIOof4kCCH7xhdA/t29pC/E3QvyDRkT+oBqfmC6wgK
         1XKNvVrV1WF4BI1jOMEiuU01Rt4pladEz8vQws9b/Q4xbGpd5faFhxqzoy+xhxg/nDx2
         AKvAAnnBnP9k7xNzmyZvBrLVNivwILmFGpvXk9PsjF5EFbGz+aisFaqtm+tTPFB190az
         iCHTsyx7H/tSukhGqHbT7AE0TchRrz27RNfAsDzz7MZM++hUW7q1OGGobpWUyqVtQBig
         mcXcepfv8gueEFuG7f5wqsQIpRGeFPbCUDUS9JDQDOiwuHbRRCldZgcjrz/QtiFUiHJc
         7Z5A==
X-Gm-Message-State: AOAM532ldfvkPZW2tR1A8Ork6geTH+ritrK3O8ARoDo5YCeTq/kXZLq8
        diH1XLVNQYS1iC8JTRGVxeWgOQClCzLElA==
X-Google-Smtp-Source: ABdhPJznzKeB7V0t1SdgMK6bXz7z1bR0XFdE8eCy29ACVDf8DjyDo+lXIF/Z8xDnS5NfYPqzSxrv4Q==
X-Received: by 2002:a63:8c42:: with SMTP id q2mr2022859pgn.325.1632365265849;
        Wed, 22 Sep 2021 19:47:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o2sm7229487pja.7.2021.09.22.19.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 19:47:45 -0700 (PDT)
Date:   Wed, 22 Sep 2021 19:47:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] ksmbd server security fixes
Message-ID: <202109221850.003A16EC1@keescook>
References: <CAH2r5mvu5wTcgoR-EeXLcoZOvhEiMR0Lfmwt6gd1J1wvtTLDHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mvu5wTcgoR-EeXLcoZOvhEiMR0Lfmwt6gd1J1wvtTLDHA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2021 at 09:22:31AM -0500, Steve French wrote:
> 3 ksmbd fixes: including an important security fix for path
> processing, and a missing buffer overflow check, and a trivial fix for
> incorrect header inclusion
> 
> There are three additional patches (and also a patch to improve
> symlink checks) for other buffer overflow cases that are being
> reviewed and tested.

Hi Steve,

I was looking through the history[1] of the ksmbd work, and I'm kind
of surprised at some of the flaws being found here. This looks like new
code being written, too, I think (I found[0])? Some of these flaws are
pretty foundational filesystem security properties[2] that weren't being
tested for, besides the upsetting case of having buffer overflows[3]
in an in-kernel filesystem server.

I'm concerned about code quality here, and I think something needs to
change about the review and testing processes.

> Regression test results:
> http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/8/builds/67
> and
> https://app.travis-ci.com/github/namjaejeon/ksmbd/builds/237919800

Can you tell me more about these tests? I'm not immediately filled with
confidence, when I see on the second line of the test harness:

- wget --no-check-certificate https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/linux-5.4.109.tar.gz
       ^^^^^^^^^^^^^^^^^^^^^^

(and why isn't this a sparse clone?)

I see xfstests and smbtorture getting run. Were these not catching
things like "../../../../../" and the buffer overflows? And if not,
where are the new tests that make sure these bugs can never recur?

(Also, I see they're being run individually -- why not run the totality?)

And looking at the Coverity report[4] under fs/ksmbd/* for linux-next, I
see 12 issues dating back to Mar 17, and 1 from 2 days ago: 5 concurrency,
4 memory corruptions, 1 hang, and 2 resource leaks. Coverity is hardly
free from false positives, but those seems worth addressing. (Both you and
Namjae have accounts already; thank you for doing that a few months back!)

Anyway, I think my point is: this doesn't look ready for production use.
I understand having bugs, growing new features, etc, but I think more
work is needed here to really prove this code is ready to expose the
kernel to SMB protocol based attacks. Any binary parsing code needs to be
extremely paranoid, and a network file server gets it coming and going:
filesystem metadata and protocol handling (and crypto)! :P

Anyway, I hope something can change here; if we're going to have an
in-kernel SMB server, it should have a distinct advantage over userspace
options.

-Kees

[0] https://lore.kernel.org/lkml/20210322051344.1706-1-namjae.jeon@samsung.com/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/fs/ksmbd
[2] https://git.kernel.org/linus/f58eae6c5fa882d6d0a6b7587a099602a59d57b5
[3] https://git.kernel.org/linus/6d56262c3d224699b29b9bb6b4ace8bab7d692c2
[4] https://scan.coverity.com/projects/linux-next-weekly-scan
    View Defects, Settings cog, Filters, File: *ksmbd*, OK

-- 
Kees Cook
