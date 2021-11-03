Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AFB4443EA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 15:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhKCOz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 10:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhKCOz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 10:55:27 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFF8C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 07:52:50 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id v40-20020a056830092800b0055591caa9c6so3847818ott.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:subject
         :content-language:from:content-transfer-encoding;
        bh=RJ3J+BkpfwzB4YL1fBz0ShyhMMZwOzxgGUXKM0smB5o=;
        b=X8z+erZYK3mFqt+DWWidoNmsyh0tRc2jze0C+f/FpIIn93sac+FL6Vaf6mG9+/803X
         igljfQZ9ruAWYjq4jc8h30P5OEorwhYmlPD8ObxIrpuM5MDphud0KweQ6yZ0hO04UZaO
         HdyBxCxfewbMPwlWHGGf4Fl7Ddfj6L31mnlznmPikuS+fdPzlu7Ys+VQ4WqL7Z/zeBgQ
         jrkoHAw0JkCrLf+oxuw2jQ8zaT9RekDIbEh66bWXm/cIgtuv/DzeBIk3ZudsjTrjpmXS
         lw4GIKhna+Uz9udCrG8V5p1b92eWhC92xOQZPcI5JFr+TGtou9SkKk38nboyWqkFPUn2
         bILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :subject:content-language:from:content-transfer-encoding;
        bh=RJ3J+BkpfwzB4YL1fBz0ShyhMMZwOzxgGUXKM0smB5o=;
        b=QKwMbq9J1GYAoXFpJCdN319LM07cA+xR8yn6AzV9sv7zr+j5+XoC5In+AlTqDCgHwH
         pJ8EofwOAnlmVOmFssqcqaTc4lFXB7Wz/ckKAg5DqmrntrZBDqkmHBMKn4YRNK/JAMbo
         usWS3EujtuUdHxvC31FiPWx4fFI92rPG7Ea9j4JS7hB7RhMZ4xA26bU3uvLy6EFG5v4x
         Y/JHQRNHF9Ij3g/XdlGZ5UXgsfkHhOwNOtDmbk3MTeiHxjCI8DGmjKTE7S4BsR12r7br
         HyDS+qAO3fTgiBTXX+2eJHeaEGRDA7PhwDgxbg3UmR9Osnz+jqIMdE1heoFtbjOLSrT3
         8ZlQ==
X-Gm-Message-State: AOAM532dp6CQ+RpoLBSifHsM3gNagEWUyuqrNP7LHmwcMIIEemlw50ig
        TLp96RrhW7VCUvRvXRAZH9uGrOq3N+BRHg==
X-Google-Smtp-Source: ABdhPJx3zsxaVoHeEPmH5v4Wf1dVOMyCDB5gHCBssSb9k6ObSfVAm+c4FXoNzUDAIMKu2wjqlORWhg==
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr20816135otp.280.1635951169786;
        Wed, 03 Nov 2021 07:52:49 -0700 (PDT)
Received: from [192.168.0.162] (cpe-68-201-65-98.stx.res.rr.com. [68.201.65.98])
        by smtp.gmail.com with ESMTPSA id q1sm550610ooe.30.2021.11.03.07.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 07:52:49 -0700 (PDT)
Message-ID: <f11c6abc-4f95-6031-0b30-813357647929@gmail.com>
Date:   Wed, 3 Nov 2021 09:52:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] jfs updates for v5.16
Content-Language: en-US
From:   Dave Kleikamp <dkleikamp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 58e2cf5d794616b84f591d4d1276c8953278ce24:

   init: Revert accidental changes to print irqs_disabled() (2021-09-22 13:02:30 -0700)

are available in the Git repository at:

   git://github.com/kleikamp/linux-shaggy.git tags/jfs-5.16

for you to fetch changes up to c48a14dca2cb57527dde6b960adbe69953935f10:

   JFS: fix memleak in jfs_mount (2021-09-23 09:52:01 -0500)

----------------------------------------------------------------
Just one JFS patch

----------------------------------------------------------------
Dongliang Mu (1):
       JFS: fix memleak in jfs_mount

  fs/jfs/jfs_mount.c | 51 ++++++++++++++++++++++-----------------------------
  1 file changed, 22 insertions(+), 29 deletions(-)
