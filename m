Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBD03BA73B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 06:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhGCEkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 00:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhGCEkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 00:40:40 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A45AC061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 21:38:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u25so16256517ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 21:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnDblw8gy5vdy8On4S0MIAZXoj2sjHN4YmX0FYmA5NY=;
        b=CkQzbEHD9lnQMmpXs8BNA7ljTkW5GAfDQqdzolj+bZOkXfkD4GubRi+GM5S3tTqFea
         Z/+wsJb/jVNBDdTsLfJ5sLaHvshRRCjSCJLHOwr5Bg30pb3NCloTfQegJ4dB+cqiR1S+
         +tleb1gnx7RxqTMPseSHRjTskaIbcxIG+vOJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnDblw8gy5vdy8On4S0MIAZXoj2sjHN4YmX0FYmA5NY=;
        b=YlMfm9AKwrID9RyTml/8tz2u2+34LqKCJQQSYXYBUdDQZxYHTOHU98HRaVxKKdcq9E
         AwKFVHxWXZaOY1+3GSCTeDu4RgWvxa4mWUiISRnwf8eeVAa6IazcGZ0LGMO67lXkBOhs
         PO2v1lW50RqY1ebw0FBPxlKmraHxGfVlcrskuzpBbVCCKk73dosD6PBSnPZ+hzk6McnG
         G9Prt3DEhxOFwMieCsCYRbAxdHNE3CpBKpjTreUOQePwMErcApM1vTwpIpSoKkDU3cz6
         KQMlPvYONod6qb01dEqzAZOl3JbSc+q5sYSTt0ZQ22FXT/EvH8wk3FFG7m1XcLwC2kwa
         6yBA==
X-Gm-Message-State: AOAM530nVReulSOe736WSQTy3a1ZGGOQr7E2PKiHQgYDcAGnh1J5A1I/
        X1Y3Gp7nHphXd3eZkOTQHvWmsqNAFjSne96PMto=
X-Google-Smtp-Source: ABdhPJxPgiUco8LXu77F4S2sYaUkhnsU1fVZFqYZMiVDkBwztUMbqN1LvxEIp5ZSAbtqKZIYUtpnHw==
X-Received: by 2002:a2e:8750:: with SMTP id q16mr2137360ljj.92.1625287083671;
        Fri, 02 Jul 2021 21:38:03 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id m6sm444492lfu.238.2021.07.02.21.38.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 21:38:03 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id d16so21955327lfn.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 21:38:02 -0700 (PDT)
X-Received: by 2002:ac2:42d6:: with SMTP id n22mr2212174lfl.41.1625287082652;
 Fri, 02 Jul 2021 21:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <s5hbl7li0fe.wl-tiwai@suse.de> <CAHk-=wiTwX5mzzEcw3jk3QdW600Hntt=Ehgoyz8K-VU8zbEmBg@mail.gmail.com>
In-Reply-To: <CAHk-=wiTwX5mzzEcw3jk3QdW600Hntt=Ehgoyz8K-VU8zbEmBg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jul 2021 21:37:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhDWDsVz12mhKtnS6DG-GzVWxBk2XjoOp=gwNJ7T0bTw@mail.gmail.com>
Message-ID: <CAHk-=whhDWDsVz12mhKtnS6DG-GzVWxBk2XjoOp=gwNJ7T0bTw@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 5.14-rc1
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 6:36 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> After incorrectly suspecting Andrew's -mm tree (because the kernel
> hung with a watchdog on TLB flushing, and so I suspected mm problems),
> I've now bisected my hung machine into the sound tree.

Hmm. One more step to go, but I think the culprit is comit
9ce650a75a3b ("ALSA: usb-audio: Reduce latency at playback start").
Because I don't think it can be the other choice.

Will finish the bisect (this took much too long, partly due to an
annoying F34 bug that makes all the boots take forever). And then go
back and verify that a revert fixes it on the current tip too.

But I thought I'd report this as a likely candidate.

          Linus
