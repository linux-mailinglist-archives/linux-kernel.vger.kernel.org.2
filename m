Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE6C38D4B6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 11:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhEVJV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 05:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhEVJV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 05:21:57 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344E5C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 02:20:32 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 27so14863055pgy.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 02:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nOv2WZcEnasfeaDEDQfGE1rOBmGTIP4Ftbjn/A5YKXY=;
        b=iBJp6TOm7ej0YRmC6vvdzugacEBVtU2vNnD+JIVZBmrlPtAuVZ3RQX2w2otf+mWDA1
         BGXuYFw0Tz4L8FCsxc+kxDr1nRJffzP+gvU6SVPgQep902HEAA0AIV3fwMwimKwE42e6
         q73e+IqsJX9uIkhnw7kJqjG391RZ6m0HoqS6sorlNRVRxs0ZI8fvNpSLkSZzl1h/JYhW
         I3s+P7w+z0tAe0MJEymj6a/iBMxq3eVg3GAkTXcbgbeWHeVhE+8ucETWeGubLC8LAHiB
         oOIfdb3+Nd+MZdKjHnrkEYKDc87R1AYeTLSbxs5RJfkrsPegck+2/VlaYkbp2vIe1F/V
         mRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nOv2WZcEnasfeaDEDQfGE1rOBmGTIP4Ftbjn/A5YKXY=;
        b=VpYm2K4Vsopc2FEftTRBgFqbCsRH18ZL8vShUMQOkgEwHbFkGZt3CZZPhYXImRPytR
         hRpzwQyZHta16rDX9qtRu1W2Q6icnr9VoZAcMJvV22LLzeVQ/HAw5IwP3WXrZ2qZ1+KT
         ArabiFHuw5ZkkNI3SAiCTCtvAnVWrXqRSJN8Lo/vPyryxBSTtaZ9qSHVEVodf93hDorZ
         ePjbAKHrnDPHe3nGFHlgcRZENW1DCr5pT1zx/XTC0bPRpIt7tnfaVjzhVfIXfR6Zl5qb
         0H+XOfjkbWKiFIZAuFSr10SE/uf2/NOjlt0VxST4AxzuhARxJq8ThMKVf96xLK56G0k5
         CnuA==
X-Gm-Message-State: AOAM530ByzCPUyrvwBcBdqAwvS7SHhPavyAPYY4i9awidPYM5e0VSqrx
        hbpcz1KPbixPHWUFqXh0O0Y=
X-Google-Smtp-Source: ABdhPJyaSGFX1We6YOP3L0kI9ML/rZmT+WvYiXHoYuIILi9hnDMa5hSLG7hAmqDQ1KggtN5I1RtX3A==
X-Received: by 2002:a63:af57:: with SMTP id s23mr3238856pgo.393.1621675231716;
        Sat, 22 May 2021 02:20:31 -0700 (PDT)
Received: from fedora.. ([2405:201:6000:a04d:2131:362f:d566:c9d5])
        by smtp.googlemail.com with ESMTPSA id gt23sm5925752pjb.13.2021.05.22.02.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 02:20:31 -0700 (PDT)
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, straube.linux@gmail.com
Cc:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [Resend] [PATCH 0/2] [RFC] staging: rtl8723bs: refactor to reduce indents
Date:   Sat, 22 May 2021 14:50:22 +0530
Message-Id: <20210522092024.65018-1-chouhan.shreyansh630@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

**RESENT THE PATCH BECAUSE I MESSED UP THE EMAIL ADDRESS FOR LKML IN THE
PREVIOUS MAIL. SORRY.**

This patch series tries to fix the following warnings by checkpatch.pl
in core/rtw_wlan_util.c:

WARNING: Too many leading tabs - consider code refactoring
#887: FILE: rtw_wlan_util.c:887:
+                                               if ((edca[j] >> 16) > (edca[i] >> 16))

WARNING: Too many leading tabs - consider code refactoring
#1529: FILE: rtw_wlan_util.c:1529:
+                                               if (pIE->data[5] & RT_HT_CAP_USE_92SE)

WARNING: Too many leading tabs - consider code refactoring
#1537: FILE: rtw_wlan_util.c:1537:
+                                               if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_BCUT)

WARNING: Too many leading tabs - consider code refactoring
#1540: FILE: rtw_wlan_util.c:1540:
+                                               if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_CCUT)

I wanted to ask for comments on the names of these functions and if such
a patch series would be acceptable.

The first patch refactors the code by introducing two new functions
sort_wmm_ac_params and get_realtek_assoc_AP_vender.

The second patch removes unnecessary braces from the conditional
statements in check_assoc_AP function.

Shreyansh Chouhan (2):
  staging: rtl8723bs: refactor to reduce indents
  staging: rtl8723bs: remove unnecessary braces from conditionals

 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 141 +++++++++---------
 1 file changed, 72 insertions(+), 69 deletions(-)

-- 
2.31.1

