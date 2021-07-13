Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D443C6ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 12:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbhGMKsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 06:48:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235390AbhGMKsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 06:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626173123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tm3BAPBxcujCn83ZLlZEVc0uhwhMyYxPuk4009NBqU0=;
        b=IVB4QhpAN4tOROFDQbEqSd1fIta+TXTX9BodhBkSC4nQMPB3yr6XrVf4KhNzibIVEdq8JU
        C0u6CglO190bh7ldpXeU716aO7QBxtBjLGEN6n1lasvwXRa1SBewRGoyA0OkRnYsh0smo+
        q3RNSTB/noaxUdqETMX9N10kY8xyloc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231--dRpA-WSNUC3TM9EpU45Pw-1; Tue, 13 Jul 2021 06:45:22 -0400
X-MC-Unique: -dRpA-WSNUC3TM9EpU45Pw-1
Received: by mail-ej1-f71.google.com with SMTP id 16-20020a1709063010b029037417ca2d43so6428320ejz.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 03:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=tm3BAPBxcujCn83ZLlZEVc0uhwhMyYxPuk4009NBqU0=;
        b=Xw6LOGuHfcOVwwWzhV/Gfr01zX47jHV95uLzgrmugTVekWZAAPYJmf6u5uJoi9vRuf
         OBnJkOEYTWEj1CVf5vh/eBXCyY64sjKN79I/jDdEFk8V1JMBB3Is8K6utdfbBNHyf4fJ
         P9+9OOs/jwvAgYenFfEAq5zJwEvj9hNE+WX1L8x4w9dv6EueLz5XZ4PrySqQ2MWzWdxL
         cNnsV4VDGmqZftkVo7gyXhjAeMrHFzH0KxA8rmtB98qas1ELwrCbDHUP4gQCksIcApg+
         2qvO5VVmTWD+ZNBBydGixE19iCjZ7qENMkSCehWaKp1k7OHBUpQU8cuwu6GPYr5OqVbt
         p1gw==
X-Gm-Message-State: AOAM531178wvyJnk9pSJRdeTWOeP04NOtiTVP1e57/0ogzGsHHfNDlpx
        dXn2TC1Xhr4JvUKsEXJWUhANTXCT0rbuNf81mvUXNPec8pEI8iEO19f8v+MlFnzzoPl0zl8f5OM
        LQWFdJysblyQ+KHAUmQ2etf9YdgrviPsJNShCoVNXqi3Zfn6xSNA10FcfoTLLAeawxg3pjUXtzC
        uJ
X-Received: by 2002:a17:906:6d8e:: with SMTP id h14mr4924107ejt.128.1626173121044;
        Tue, 13 Jul 2021 03:45:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMemoqHtCQm8MvCsHTFd/7QO+vl5+8z/ZgEsYC6HbfgHNENkjma/gD7gKut3z1BjHjunkssw==
X-Received: by 2002:a17:906:6d8e:: with SMTP id h14mr4924085ejt.128.1626173120840;
        Tue, 13 Jul 2021 03:45:20 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id dj16sm5006073edb.0.2021.07.13.03.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 03:45:20 -0700 (PDT)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] vboxsf fixes for 5.14-1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <30c7ec73-4ad5-3c4e-4745-061eb22f2c8a@redhat.com>
Date:   Tue, 13 Jul 2021 12:45:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is a pull-req with a set of patches fixing a vboxsf bug for 5.14
(I am the vboxsf maintainer).

Linus, sorry for sending this directly through you, instead of going
through some other tree, but trying to get this upstream through the
linux-fsdevel list / patch-review simply is not working.

This bugfix patch-set (3 preparation patches + 1 actual bugfix) fixes
a bug which is actually being hit by users in the wild, e.g. doing
a "git clone" on a vbox guest inside a shared-folder will fail
without his fix. Since you merge pull-req-s for a bunch of other
filesystems directly I'm hoping that you are willing to take this
one too.

This patch-set has been posted on the linux-fsdevel for the first
time on January 21th 2021, so almost 6 months ago and I've send
out several pings and a resend since then, but unfortunately
no-one on the linux-fsdevel list seems to have interest in /
time for reviewing vboxsf patches.

Regards,

Hans


The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git tags/vboxsf-v5.14-1

for you to fetch changes up to 52dfd86aa568e433b24357bb5fc725560f1e22d8:

  vboxsf: Add support for the atomic_open directory-inode op (2021-06-23 14:36:52 +0200)

----------------------------------------------------------------
Signed tag for a set of bugfixes for vboxsf for 5.14

This patch series adds support for the atomic_open
directory-inode op to vboxsf.

Note this is not just an enhancement this also fixes an actual issue
which users are hitting, see the commit message of the
"boxsf: Add support for the atomic_open directory-inode" patch.

----------------------------------------------------------------
Hans de Goede (4):
      vboxsf: Honor excl flag to the dir-inode create op
      vboxsf: Make vboxsf_dir_create() return the handle for the created file
      vboxsf: Add vboxsf_[create|release]_sf_handle() helpers
      vboxsf: Add support for the atomic_open directory-inode op

 fs/vboxsf/dir.c    | 76 ++++++++++++++++++++++++++++++++++++++++++++++--------
 fs/vboxsf/file.c   | 71 +++++++++++++++++++++++++++++++-------------------
 fs/vboxsf/vfsmod.h |  7 +++++
 3 files changed, 116 insertions(+), 38 deletions(-)

