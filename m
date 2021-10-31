Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C15144108B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 20:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhJaToh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 15:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhJaTog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 15:44:36 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C30C061714
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 12:42:04 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id f9so19046128ioo.11
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 12:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=UJAmDNZ/jLwCgDF6rb5hn4XMoc5AuRYESmnLTqSBO4c=;
        b=dz/frPgGDmB/3DWfGPM4LKFtz3N/tM6zkABNYq4rCSaGaQTi9RWXTvFFfDzAdQhtf1
         NcHdssiLxh3W/Af5SYJ0yLLKf/5ImNDtu8RLh5GAv/n0S+gJ+gIMjzJLg2r8o38Qwtpa
         fMFtD30o6WC+dr/Z8Tr61CZYrDm+HrYh66GI9WA9r62jmVT4WhAeYdbXSSdeuUeozttl
         R5xu+kq1t41pNKK2l4qNVuej0OP1BE1USwqH/XkPDLWBSaSwyV95AZ5vt+jB1dox+dZh
         YHE1zj1zOyj0J8rQGm6LKrOm/1EDlG/qlue0tWxB3KtM/+3vQ9nWpUAEGFnqCJzxhRhf
         0CpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=UJAmDNZ/jLwCgDF6rb5hn4XMoc5AuRYESmnLTqSBO4c=;
        b=8OJw0CZV6LzalAHJobX01qGBQTX7e3CFTTvYUnLJPXLLn7e74q0j7YOtEkBVQmVUiR
         vIl1Fb+GeCrvx2C03TtlfzQWmpY5LL5d/OgaGowAh4iGcs7j21C9JBKuJD01yK1uyGID
         rWz2iy9+mCUCLWBiLXqvkGNjZFlxBlDycY513d3Qz5/9AMrTFcbxyOEj0LOTKKAfnX/y
         eEHZskwoTsyjHBMXgwC8kj3wxrljHn5vEkESgRd4ogk7sPUGykRy0wrCSaA7DchvhjWF
         XPVty2yXOdpIrOd73o9iAl6Q7zBcuQib7z2RUllNGrTamavcaYaf67FJMSPrXNuIFuDj
         uFgg==
X-Gm-Message-State: AOAM532rYOu3fBr9vufeRAuRmUvB66zIgwqIsRdlIBj8pgQyHcik+mkh
        4u9A/YWMH4c6Sac6chA8UYpsh+fuGKNHiA==
X-Google-Smtp-Source: ABdhPJxQh+wSlhg4vMDFQEYKrPyz6bD2Zi9o2tkvOq21dtiCnTn8vZNuYMmfcLDuEq1gnefnZ5P2Tg==
X-Received: by 2002:a05:6638:2b5:: with SMTP id d21mr18606439jaq.133.1635709323576;
        Sun, 31 Oct 2021 12:42:03 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id i16sm6792077ioh.54.2021.10.31.12.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 12:42:03 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] CDROM updates for 5.16-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <9170ad88-1150-1a34-9979-669054d6d2f9@kernel.dk>
Date:   Sun, 31 Oct 2021 13:42:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On behalf of Phillip, here are the CDROM updates for the 5.16-rc1 merge
window:

- Add ioctl for improved media change detection (Lukas)

- Reformat some documentation (Phillip)

- Redundant variable removal (luo)

Please pull!


The following changes since commit 316346243be6df12799c0b64b788e06bad97c30b:

  Merge branch 'gcc-min-version-5.1' (make gcc-5.1 the minimum version) (2021-09-13 10:43:04 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.16/cdrom-2021-10-29

for you to fetch changes up to bbc3925cf696422492ebdaba386e61450fa2294c:

  cdrom: Remove redundant variable and its assignment (2021-10-21 08:23:09 -0600)

----------------------------------------------------------------
for-5.16/cdrom-2021-10-29

----------------------------------------------------------------
Lukas Prediger (1):
      drivers/cdrom: improved ioctl for media change detection

Phillip Potter (1):
      cdrom: docs: reformat table in Documentation/userspace-api/ioctl/cdrom.rst

luo penghao (1):
      cdrom: Remove redundant variable and its assignment

 Documentation/cdrom/cdrom-standard.rst      |  11 +++
 Documentation/userspace-api/ioctl/cdrom.rst | 113 ++++++++++++++--------------
 drivers/cdrom/cdrom.c                       |  63 ++++++++++++++--
 include/linux/cdrom.h                       |   1 +
 include/uapi/linux/cdrom.h                  |  19 +++++
 5 files changed, 146 insertions(+), 61 deletions(-)

-- 
Jens Axboe

