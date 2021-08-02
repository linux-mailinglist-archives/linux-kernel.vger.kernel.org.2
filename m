Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D38D3DD328
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhHBJnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhHBJnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:43:15 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A8CC06175F;
        Mon,  2 Aug 2021 02:43:05 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a8so1399866pjk.4;
        Mon, 02 Aug 2021 02:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=YbdIMARtJxRkTOslQQ5ri4FD8C2FyQyUZnDqe4IDOx4=;
        b=XSJW2hSgRRVRJthHCXUup5AIdm/UiOPnTJvDUQi4BR1RpbVp+UkO8NOHtlmCqQNu9k
         kk11Tf6DlhBo4O01V8FagyynCoicghyzFqPEeGs4LOg6zrdt82WUvWXcUVRN0IXtin4Q
         x4JzFPEZnobK+3Cxz1SxqrzUypNtYLCuSUaaaiUQq3G4F0zHGGqnTporMGhzMyFHJ/ZP
         VhEKN5cvLjUMEog8hJA546+E0z1VINyL6m8j2LSy5YUJluNAm/0pRH0ohaSjm7toXJPa
         RLBqw556qW7ONq1c2EUQr+QP1R1yOmMFvZUdzvQQRaIUaYTHCqfH9Z/18kAjf+SJoSg7
         yrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=YbdIMARtJxRkTOslQQ5ri4FD8C2FyQyUZnDqe4IDOx4=;
        b=Sj6oujwde/q8Rk10CXNwnRWbubouJEI6uJzlvUmGp/CAp+qg+1vqaKtEGE0EIPEIRZ
         N0BNpqCY1wgb5zkxVd8BWnAncv+wVTd1oP9ZGwyJny57ijVbs1z14Ux2nVW1dNMQuklX
         bVZIL7V2n9r4LypaxE1o6KV/tCYgPvES5p4mDvbjolojb3aJoYDbquzCoVi6UKQ1dfcW
         Op092z2zbAcjIcUzFNrtfabaTH2+h+kVweut4vfBykA7W8BaxzZSzLXYEfyB4aSG0jTM
         zD9EpYdPxIUTydV60gpmsMmqZ/rFYW4fua3OxUibeeaqDzfIOD2+gch8C1czB3Qzhht7
         z5lg==
X-Gm-Message-State: AOAM532G3ZJPwY/mnQthpVgFXPRYPh8Ija5f+NIACihdmtZpehBgKPbh
        C29B6CcesGIo5BcvvC5DgCNYlUMOl6c=
X-Google-Smtp-Source: ABdhPJzGghxvBvbMNagZAXUxQ21GnkNv/Oz2UvCPbKSuClFMrlRX+7QTNAsFjCmHWpFy41Bl5R6OhA==
X-Received: by 2002:a17:902:7c01:b029:12c:25f:be9e with SMTP id x1-20020a1709027c01b029012c025fbe9emr13723450pll.75.1627897385406;
        Mon, 02 Aug 2021 02:43:05 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id nm19sm10137954pjb.27.2021.08.02.02.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 02:43:04 -0700 (PDT)
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v3 0/9] docs: pdfdocs: Improve font choice in CJK translations
Message-ID: <eb8184ab-cfab-680b-f180-1157a7f709b3@gmail.com>
Date:   Mon, 2 Aug 2021 18:43:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Now that the traditional Chinese translations by Hu Haowen has been
merged into docs-next, this v3 patch set covers them.

Changes since RFC v2 [1]:

    o Regression fixes:
      - CJK Serif font is chosen only when it is available (3/9).
        Now systems with only "Noto Sans CJK" fonts are good enough
        for building pdfdocs.
      - \usepackage{setspace} is moved before that of hyperref for
        compatibility (6/9).
    o Split RFC v2's 2/7 into 4 smaller chunks (2/9 -- 5/9).
    o Cover zh_TW translations (2/9, 9/9).
    o Use \scmain, \tcmain, \krmain, and \jpmain instead of
      \scserif, \tcserif, \krserif, and \jpserif in the definition
      of \kerneldocBegin(SC|TC|KR|JP) (2/9).
    o Having heard nothing from Mauro and SeongJae, dropped RFC v2's
      6/7 and 7/7.
      (I'll post them later as a separate RFC patch set.)
    o Wordsmith change logs.

[1]: https://lore.kernel.org/linux-doc/20ff8a65-6a5c-c062-fe1a-0f5c5ddc813c@gmail.com/#t

For those wondering how the difference of SC and TC font variants would
look, here are links to screenshots from the traditional Chinese chapter.

    "Noto Serif CJK SC": https://fars.ee/oOAS.png
    "Noto Serif CJK TC": https://fars.ee/11Li.png

The difference might be hard to spot for non-CJK readers. ;-)

        Thanks, Akira

--
Akira Yokosawa (9):
  docs: pdfdocs: Refactor config for CJK document
  docs: pdfdocs: Add CJK-language-specific font settings
  docs: pdfdocs: Choose Serif font as CJK mainfont if possible
  docs: pdfdocs: Preserve inter-phrase space in Korean translations
  docs: pdfdocs: Add conf.py local to translations for ascii-art
    alignment
  docs: pdfdocs: One-half spacing for CJK translations
  docs: pdfdocs: Permit AutoFakeSlant for CJK fonts
  docs: pdfdocs: Teach xeCJK about character classes of quotation marks
  docs: pdfdocs: Enable language-specific font choice of zh_TW
    translations

 Documentation/conf.py                      | 118 ++++++++++++++++++---
 Documentation/translations/conf.py         |  12 +++
 Documentation/translations/ja_JP/howto.rst |   8 ++
 Documentation/translations/ja_JP/index.rst |   5 +
 Documentation/translations/ko_KR/howto.rst |   8 ++
 Documentation/translations/ko_KR/index.rst |   2 +
 Documentation/translations/zh_CN/index.rst |   5 +
 Documentation/translations/zh_TW/index.rst |   4 +
 8 files changed, 146 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/translations/conf.py

-- 
2.17.1

