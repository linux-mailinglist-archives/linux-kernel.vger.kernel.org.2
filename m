Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6903C3870DB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 07:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346299AbhEREoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 00:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbhEREoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 00:44:17 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5AEC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:42:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gb21-20020a17090b0615b029015d1a863a91so837398pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6/E0260RKAaTuA5t/VJ380T71hV58i1T3oQ6tmg0Xxg=;
        b=ktivBHXXlh0cPeILEDATbuupODCuGEWvSCydB3kAIJyY9rFtwRqyF0c4p5JRRF4vr8
         rr4tast23bJ0v7lZ0I9IuqeBLvmdi6Xw4yxk5lMQq/cfLxZr4P9ixOac96saL+Xr/bzD
         TWKH19Nd/xFjvBo0PbNf1AJCRyf8DSlumkLlWQ9gSY2HDEi31Ec8yNF1P1raIdgO8VXA
         UJZ//D08SuF3VVX8jOAyMflfSL8C+LW3DeqK0fVdGsI8wvlF3lKX+VUuMsJigDXwtFwo
         MxTVLiLmmsxj4TyVDUjAr6OR/jj8NtuNEwgHiLzEpeL8kpISNy7+Qt5UaV5sbjsRf72o
         63sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6/E0260RKAaTuA5t/VJ380T71hV58i1T3oQ6tmg0Xxg=;
        b=PWkKYZQ8OlR3UVq7vcnKjU/4/fiLKRobrSUAd+v6+Qn7souLkzSFOEGHY0OeIWrsqH
         kKLasr6qBc0yoVPU7O59WJuacIJREe9es/gY9raiJtR6IUgTiLuY+YpAxNa6GO0T9+7d
         o5OpaWKh3A0x9aC9bPJpE8N0maXcwfm/RD0LQiIZjSdRNSl2JbYQI4OltFEIXHo3lLu6
         QIALyyywFb4LqmvW4SjuH6zjZUEfh9XRNcs9ewgnC1TrghhsprAcA9cwNFN0eqrkj1Ey
         Fx3Ayumw9lekBoqy5aZ7Ym3Jb6VITAdP9IYy9Bg+z4lB+wqeD4febTNolCaNbG/qMCYu
         Wasw==
X-Gm-Message-State: AOAM530BMk2HSLp2GHLUGeXiHku2w1VGmWKrbS0RzX73LIKryEAxRk09
        C1aJebokVxTh8YYiVp2i9ws=
X-Google-Smtp-Source: ABdhPJzeQmjKwbJOIh35vt/GlskZevTMXjOPZ7992olPxBR9T3iaGQHZyZ4BKIpzU8Nu/iE9IlED2A==
X-Received: by 2002:a17:902:bc48:b029:f2:7db5:4d78 with SMTP id t8-20020a170902bc48b02900f27db54d78mr2379827plz.55.1621312978940;
        Mon, 17 May 2021 21:42:58 -0700 (PDT)
Received: from localhost.localdomain ([203.126.139.7])
        by smtp.gmail.com with ESMTPSA id t15sm357538pjh.0.2021.05.17.21.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 21:42:58 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     gregkh@linuxfoundation.org, marcocesati@gmail.com,
        dan.carpenter@oracle.com, fabioaiuto83@gmail.com,
        fmdefrancesco@gmail.com, eantoranz@gmail.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        skhan@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 0/7] Staging: rtl8723bs: fix warnings in HalBtc8723b1Ant.c
Date:   Tue, 18 May 2021 00:41:12 -0400
Message-Id: <20210518044119.2960494-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes 134 checkpatch.pl warnings in the file drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c

Although checkpatch.pl reports a large number of checks, these are for issues that were present in the original code. In fact, in the process of fixing warnings, the total number of checks decreased from 548 to 545.

All patches are syntax fixes and no logic is changed. As there are a lot of different warnings, to make things easier to review, each patch addresses a different set of warnings in the following order:

- braces {} are not necessary for any arm of this statement
- please, no space before tabs
- suspect code indent for conditional statements
- Statements should start on a tabstop (this type of warning is solved alongside the previous warning type in the same patch because the fix for one warning addresses the other)
- Comparisons should place the constant on the right side of the test
- Missing a blank line after declarations
- Avoid unnecessary line continuations
- Block comments use * on subsequent lines

Change in v2:
- Patch 7: Remove dead code inside block comment instead of changing the comment formatting, as suggested by Dan Carpenter

Desmond Cheong Zhi Xi (7):
  Staging: rtl8723bs: remove unnecessary braces in HalBtc8723b1Ant.c
  Staging: rtl8723bs: fix spaces in HalBtc8723b1Ant.c
  Staging: rtl8723bs: fix indentation in HalBtc8723b1Ant.c
  Staging: rtl8723bs: fix comparison formatting in HalBtc8723b1Ant.c
  Staging: rtl8723bs: add missing blank line in HalBtc8723b1Ant.c
  Staging: rtl8723bs: fix line continuations in HalBtc8723b1Ant.c
  Staging: rtl8723bs: remove dead code in HalBtc8723b1Ant.c

 .../staging/rtl8723bs/hal/HalBtc8723b1Ant.c   | 333 ++++++++----------
 1 file changed, 154 insertions(+), 179 deletions(-)

-- 
2.25.1

