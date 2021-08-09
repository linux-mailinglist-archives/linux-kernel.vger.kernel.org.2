Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734EA3E3D68
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 03:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhHIBJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 21:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhHIBJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 21:09:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C6BC061757;
        Sun,  8 Aug 2021 18:09:24 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id bo18so3359379pjb.0;
        Sun, 08 Aug 2021 18:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=jLQyBU8VTizRie2ANBYDCTuzQESy6ouD7F0lRuwx+Gs=;
        b=OClwux1dZHviyRaacX3aDsWwre7i/BxBGrwjI65ZRcYFI1REsymgGuSwoVMq7Ko1Z5
         fumX3UhvaGB3rrIBuBU8Y7z/T4q4+JRhfyuxfOg1VNFvwhNRAP2It1BmKzMQ3cBeIyo+
         O0YS4yvAEQDunm9mJ7JtrkAT9WdMIQQsQoxVuWfwW2xw3hNOudCo18YQtlsEljhw08U1
         sLgFd2JPj2r7XSHaUZg5jIO1r4THimpK2wb+wsxS1YcI35Eh3WgyrQoXgEcaOngWtvUW
         pImJ4d0cfhFv5KA6QoI1ONx9/Us5aXAwcW0W7/UAd+tNs+XSlS9lYvewMVuzBfwxf0wf
         l4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=jLQyBU8VTizRie2ANBYDCTuzQESy6ouD7F0lRuwx+Gs=;
        b=EM5xL6MPc4sbG61ZAB3hZO8WJnNMlMEJqCB7QFcUOg6UAfcRKRz5bnUqJEsEp0mgVM
         q+3PtQ78n61OcVy4JInnw+U7t+oxhNtH27ISTb3JgmC4ofp9MFGIBcraNXpk9IEGQLXF
         fvIajGeEVu/aVpw/yxZNKllNM0vadnhE2UOKL/kUex/ifw5avKRKAST2gsMq0ISq0r3p
         d127Ni19CQ4fmfIGJ3Z0B5r5mh7jTK/dAqV2+LzA6ydyBq1hhrH6Labi4+xiR3TA4Kdp
         F9BM767+tgWSP0YdnEYrxnZHGAZmFEYKILrH/IfRuk2Bdie/QCVt6jZyOIgZGIcaUXYB
         0k1Q==
X-Gm-Message-State: AOAM530ScRNLA/ubRzfw8dzugwuTWIzMilnDJKac1/oVo+mmJ+m8kZGK
        JrI1h/lUtxR/mWI2IEjXall1pj5qw1M=
X-Google-Smtp-Source: ABdhPJwht86+28kUjUzEr4jaJOOM26JLyKv3pEaGnzZZJKSsJO5s/4UPMMEVdoibvkypdWo+3KC5zw==
X-Received: by 2002:a17:902:bd49:b029:12c:7775:cdea with SMTP id b9-20020a170902bd49b029012c7775cdeamr18267232plx.68.1628471364465;
        Sun, 08 Aug 2021 18:09:24 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id l14sm18536799pfd.58.2021.08.08.18.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 18:09:24 -0700 (PDT)
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v4 0/9] docs: pdfdocs: Improve font choice in CJK translations
Message-ID: <39d0fb0f-b248-bca4-2dac-df69e8d697b1@gmail.com>
Date:   Mon, 9 Aug 2021 10:09:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

6/9 in v3 was not compatible with Sphinx < 2.3.
It is now fixed in v4.

Change in v3 [1] -> v4:

    o Provide dummy commands for Sphinx < 2.3 to keep compatible
      with Sphinx < 2.3 (6/9).
    o Add Reviewed-by and Tested-by tags from Hu Haowen (9/9).

Changes in RFC v2 [2] -> v3:

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

[1] v3: https://lore.kernel.org/linux-doc/eb8184ab-cfab-680b-f180-1157a7f709b3@gmail.com/#t
[2] RFC v2: https://lore.kernel.org/linux-doc/20ff8a65-6a5c-c062-fe1a-0f5c5ddc813c@gmail.com/#t

For those wondering how the difference of SC and TC font variants would
look, here are links to screenshots from the traditional Chinese chapter.

    "Noto Serif CJK SC": https://fars.ee/oOAS.png
    "Noto Serif CJK TC": https://fars.ee/11Li.png

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

 Documentation/conf.py                      | 121 ++++++++++++++++++---
 Documentation/translations/conf.py         |  12 ++
 Documentation/translations/ja_JP/howto.rst |   8 ++
 Documentation/translations/ja_JP/index.rst |   5 +
 Documentation/translations/ko_KR/howto.rst |   8 ++
 Documentation/translations/ko_KR/index.rst |   2 +
 Documentation/translations/zh_CN/index.rst |   5 +
 Documentation/translations/zh_TW/index.rst |   4 +
 8 files changed, 149 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/translations/conf.py

-- 
2.17.1

