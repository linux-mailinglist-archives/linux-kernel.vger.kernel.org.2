Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB85A33090D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 08:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhCHH5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 02:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhCHH5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 02:57:09 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA010C06174A;
        Sun,  7 Mar 2021 23:57:08 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id y124-20020a1c32820000b029010c93864955so3198367wmy.5;
        Sun, 07 Mar 2021 23:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g5ETrTGY8J3iiON3uMWXoMBxr2195V4P3qKI5nvzbnM=;
        b=DcAtf5dG4fWhvT7BMJW/E+hoDbaDtw3vTflOFpB+kyGKDIat/VbU7gNtJTEQnlCv2Z
         zA6JOI/ERnhk4w7OlAYF/WoE2tUXXT55Qu3E/N5GNCDMXWXqDtq2xNYkBGou9NWGeITM
         zGiySjts0lW2UiXFdPkMBy/StPuklSWxPPnlPVJZUmwiK+GiaK+NXt1i7ZCwGcFBb4RQ
         DQOLOHjP+7JQxVX4Ckxr/y6I5FijTSwOea00JmOgDbotp3KI5bxcvgbmxSo1jr1Esrug
         q0CiVQAxnnIn6YspzZbuuDQuLF+PQXW7iP5rCKjk/JKlXkB/U+kqxlmonyeRdy18xyLj
         FaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g5ETrTGY8J3iiON3uMWXoMBxr2195V4P3qKI5nvzbnM=;
        b=lGoyY9X8Hwk5FhT8wMMF+K0NBsy7/H7Gip8rT7TrCrZjIdDH2ZrHoXIOaE4XJ7HWk4
         Rb8cAamBj3fsqFqplcgDAv2wqoceUL4r2kEagM2An99Fsrp+aFtWpkwKbRNcjqSAMhrF
         izRV1uckuVR4NGhX4l3cGW4N6ImPuKKlcjmn2lcL6c+LBL5/zRiyVyesiWZgTl20OPTo
         m+DXJpK+zdvAXzGqyujRL8CLP97JtMoPIE6CYiWHcF2eCRNGTwv1rdXSrqiojAmzmKLl
         EYfVT2Bx4PKgopZkhipOqGbCjj87X4XULQ62bq7TIuzpuZp4Jf9Yh4P41ss9IJ4bkK0e
         CW+A==
X-Gm-Message-State: AOAM532VDfBDBZN+DIoBupMGVq3Z2lL9dVkj7poJAyG/DpXWYertml5Z
        1rh1mTLvTrYUs8TvzG5NDrq9LsVxYPc5Ow==
X-Google-Smtp-Source: ABdhPJw+SswPGvP6+9FYQSnybE7a4V3sjiwhRlyLNaUyGLFMj3Nuw4J4XLjBr+bidsxwCchuTt5N6w==
X-Received: by 2002:a7b:c4d1:: with SMTP id g17mr20843543wmk.101.1615190227490;
        Sun, 07 Mar 2021 23:57:07 -0800 (PST)
Received: from localhost.localdomain ([89.16.147.135])
        by smtp.gmail.com with ESMTPSA id a131sm17391033wmc.48.2021.03.07.23.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 23:57:07 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH] docs/kokr: make sections on bug reporting match practice
Date:   Mon,  8 Mar 2021 08:57:01 +0100
Message-Id: <20210308075701.23411-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Translate this commit to Korean:

    cf6d6fc27936 ("docs: process/howto.rst: make sections on bug reporting match practice")

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/translations/ko_KR/howto.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index 787f1e85f8a0..a2bdd564c907 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -339,14 +339,8 @@ Andrew Morton의 글이 있다.
 버그 보고
 ---------
 
-https://bugzilla.kernel.org 는 리눅스 커널 개발자들이 커널의 버그를 추적하는
-곳이다. 사용자들은 발견한 모든 버그들을 보고하기 위하여 이 툴을 사용할 것을
-권장한다.  kernel bugzilla를 사용하는 자세한 방법은 다음을 참조하라.
-
-    https://bugzilla.kernel.org/page.cgi?id=faq.html
-
 메인 커널 소스 디렉토리에 있는 'Documentation/admin-guide/reporting-issues.rst'
-파일은 커널 버그라고 생각되는 것을 보고하는 방법에 관한 좋은 템플릿이며 문제를
+파일은 커널 버그라고 생각되는 것을 어떻게 보고하면 되는지, 그리고 문제를
 추적하기 위해서 커널 개발자들이 필요로 하는 정보가 무엇들인지를 상세히 설명하고
 있다.
 
@@ -362,8 +356,14 @@ https://bugzilla.kernel.org 는 리눅스 커널 개발자들이 커널의 버
 점수를 얻을 수 있는 가장 좋은 방법중의 하나이다. 왜냐하면 많은 사람들은
 다른 사람들의 버그들을 수정하기 위하여 시간을 낭비하지 않기 때문이다.
 
-이미 보고된 버그 리포트들을 가지고 작업하기 위해서 https://bugzilla.kernel.org
-를 참조하라.
+이미 보고된 버그 리포트들을 가지고 작업하기 위해서는 여러분이 관심있는
+서브시스템을 찾아라. 해당 서브시스템의 버그들이 어디로 리포트 되는지
+MAINTAINERS 파일을 체크하라; 그건 대부분 메일링 리스트이고, 가끔은 버그 추적
+시스템이다. 그 장소에 있는 최근 버그 리포트 기록들을 검색하고 여러분이 보기에
+적합하다 싶은 것을 도와라. 여러분은 버그 리포트를 위해
+https://bugzilla.kernel.org 를 체크하고자 할 수도 있다; 소수의 커널
+서브시스템들만이 버그 신고와 추적을 위해 해당 시스템을 실제로 사용하고 있지만,
+전체 커널의 버그들이 그곳에 정리된다.
 
 
 메일링 리스트들
-- 
2.17.1

