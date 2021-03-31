Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377ED350A5A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 00:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhCaWnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 18:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhCaWnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 18:43:10 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7CDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:43:10 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s11so74127pfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ro3je/BBvWF7sM47Lmq+Xq0Jon+ne6ToNQmIFqDmWiY=;
        b=hEK+hFySXLu8+oYIA1hqyF75ZfrVVL6t7J7ceUsg9icsOb09sA2C+DFnpw/xi/0/Pa
         DaVrYEDOjkin5pJJV06x8hslITIFIiLhQMMO2gqHzpXFTCp+heLL0CDGOie63tJEhb5i
         CYc7JNAbLqDUzEfoK+HcClNkufN/eVENTHF21VSJHqj1ZvAGUpGQgzX3Um/JVefiDxHB
         cHN2FRBZRBLCF61HBaQY1uhs7EEHQbZ+LxrdvZBMbXu+lmOLfoiseUd8SXTCr7//mwr+
         MDGH6m+jt8ilsNXHboGO9e3apgifCrNljhMe/Pwq5vvM5IkKPSYGtsPqsBbZIRGLdAh9
         AgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ro3je/BBvWF7sM47Lmq+Xq0Jon+ne6ToNQmIFqDmWiY=;
        b=JBchXRSW2CUIo+/xpFrmvFhnsXXHSsgU4vDMyLBKOR3b9UmXQohg7vTx+1rTR061Mb
         e1cw66gS9wiQIypbua1j8K2SrBTbzrdJNu/keESB20k2zcV72OwdeGzoGo36OzXnTlBN
         bCwnYOrgpnlmN1zJcH6Nvwy9E5FjbCd5SmwrARgNeNC7SmkV23tmSB1FXOapUU5Ggnsq
         3CInNPQRTs0b+Ve7QMWEQW6amTq+janUj/Qe/lfjv7XgB3+JPYGs7aP3KmMN3rImOri5
         DSGpr7rPLNAsUjgZej2lYXTAHseqkQWuVnvmCxvEJ3cSFHWO80HL/3AoVGbt//rYV+Yr
         xPbA==
X-Gm-Message-State: AOAM530GrsUiSpOoviwphVvpEWzbKXPHIsQBPGoePP0pl6WeQwFzN9NE
        Yk4b2kIzNgJJCpVoqBIi8XI=
X-Google-Smtp-Source: ABdhPJxBJwcYeyB8UmTusLHKSMUBjiy3odcEztG2xRWtgIa5tsz4HAx2dfm3Pn35tQgOFS12HQPQ3w==
X-Received: by 2002:aa7:94ad:0:b029:1ef:2392:4ee8 with SMTP id a13-20020aa794ad0000b02901ef23924ee8mr4985616pfl.75.1617230590087;
        Wed, 31 Mar 2021 15:43:10 -0700 (PDT)
Received: from djbComp.hitronhub.home (S0106ac202ecb0523.gv.shawcable.net. [70.67.120.89])
        by smtp.gmail.com with ESMTPSA id h19sm3338830pfc.172.2021.03.31.15.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 15:43:09 -0700 (PDT)
From:   Deborah Brouwer <deborahbrouwer3563@gmail.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, fabioaiuto83@gmail.com,
        dan.carpenter@oracle.com, phil@philpotter.co.uk,
        amarjargal16@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>
Subject: [PATCH v2 0/3] block comment style changes
Date:   Wed, 31 Mar 2021 15:42:28 -0700
Message-Id: <cover.1617229359.git.deborahbrouwer3563@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Style changes to block comments.

Changes since v1:
	- all commit messages have changed to be more accurate

Deborah Brouwer (3):
  staging: rtl8723bs: core: add comma within a comment
  staging: rtl8723bs: core: add * to block comments
  staging: rtl8723bs: core: remove empty comment

 drivers/staging/rtl8723bs/core/rtw_xmit.c | 60 ++++++++++-------------
 1 file changed, 27 insertions(+), 33 deletions(-)

--
2.17.1

