Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5033FDE6A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbhIAPSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbhIAPSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:18:32 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D629C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 08:17:35 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id s12so5679611ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 08:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/GGmOUmP/HWfyFYlF4fSiVjkuTnkEVuMct1cxrvUQZ4=;
        b=NmEmdHPJEhOBweZo8F+2InfFyID4brlXdOBGB3F9Wn66QGiotlqQzBoHBUKcN9nDjm
         2hWvPwkxOX6dU3PFew4NiENqTCTuHwkE4DzRlNjuidyLBg7iepn6TGXAMlOv9FfcLAdA
         XRKAnrDf3ChNzZSUNf+uhaY7tmRlLTOYa7KhpAaESisk/daem0ShsCimR1i+yJT8m3H/
         s2h3JvJH2wL94PIZ+NMDmB/G1xsym0azMewbFd/wUac7nLlkJftlS4G6q4WbfT10JOpX
         WutEwH912hhtBRuWN7Bt78ZsZwmH5MjKL6iD3oGkz46yq9EqcAgbrKRQmNrtlmfr6VRW
         fF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/GGmOUmP/HWfyFYlF4fSiVjkuTnkEVuMct1cxrvUQZ4=;
        b=dcKJnZRQX+qcaZ3DQitb9B4Su5O1D5/8kgXd4V73K3G/Tsr1KapBUT0xdgiHFnjNBl
         /HmU6GbIdSoP81zuK/XYR31nwxvFTw0P3qVoaqujV4YQ7rhR3tKRnWEHoBXq7HWWnVmt
         7C/3krl///mKHKqMnuGIQu0UswivZF4ZCJjhBI1MzizG6lb6Sydbfbl4aRVe5asodT+y
         3v4TrDMbh7O9B8u+Wu642bVvw++5JUfcfEML8HZMDN0Lkjz/aW4WR4JNhCV56EngaKEt
         AFtCBj+fza6TR5L6nryHC2h4pBiG8NTFRW0XKAvUazvDaVnqADDO1skB04Z1mKE63JEi
         dLGA==
X-Gm-Message-State: AOAM531KNCkqTycQPYcmlgxXC2rjBWO1kgm4tYlXXKPcRVQ6LQzKxOvP
        X16fXLPb2ILEifmRcMGvqarENDhr8X+n9ZEByMM=
X-Google-Smtp-Source: ABdhPJzGhbYmqggX6Td/rXLB0q2ecWWWJ4iiAUmGvOSrF2WPKOc+BlXbemEYM8qOQ2zYaC4yHgAKLxXQHtw+3qVGcBk=
X-Received: by 2002:a2e:9296:: with SMTP id d22mr110958ljh.413.1630509453492;
 Wed, 01 Sep 2021 08:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210831051037.3108944-1-daeho43@gmail.com> <33e7e327-5318-e30f-4419-42497fe90b31@kernel.org>
In-Reply-To: <33e7e327-5318-e30f-4419-42497fe90b31@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 1 Sep 2021 08:17:21 -0700
Message-ID: <CACOAw_wyLX_mnnPV0vWeAqTtEDx_bhG2c72jq6YmjQGOgtVLeg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: introduce fragment allocation mode
 mount option
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_SEG)?
>
> It needs to randomize position of next segment only in fragment_seg mode? IIRC.
>

I want the randomness of segment allocation in fragment:*_block mode
to simulate real filesystem fragmentation.
How about just using fragment:rand_block for the simulation. I mean we
can use segment randomness for fragment:segment and
fragment:rand_block.
