Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559E334A4E0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhCZJuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhCZJtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:49:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C9FC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:49:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o16so5054516wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=elCWYfz7VHa4szRLmbcmnwRFKSwIKNOzpwn47h2LXJM=;
        b=T/oBWEa24zAqHxWOngHIS0uy21UYpOdPRjJP/msfpLHJqR4Y3lyVDwXoKkLLcgshMj
         rr+SsLD90/uv3zVCt53I6O8USKWLZPq0MAELtUHmJtNzXfbIP9gawUH4fvM8YBfBVTFh
         1YbwPKjrVJ31CWdurgl3bqMby/dOL5p7O0OAGKPubAvr0HZVQujFRsBDdFJgL8g3K2br
         nfRllSBnhpKlSjv6B653HdxcnCT30pYC8v0vPkd3wS2uuVfq2W8pP2iFIK3nzdZ+mY/u
         P+LKZZoEM/I1bthyOsXJy1rXOG+h9f0jQCUasIOa8RCSp3cTeBzuIvSFoxVY1RhNg0Yg
         pMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=elCWYfz7VHa4szRLmbcmnwRFKSwIKNOzpwn47h2LXJM=;
        b=Cx0S89A5tfE9E1asnFfapvrYBMaaIC8gUQPdor8npj3/huMv2bXPp0GYO5bPTLu4ve
         0cPQ6qqTvrAxGHHQiI3IsvUcypIgii5SeUlh3YK8eWH86/2xSZmxcF0p3boKIfB0Gmod
         iRMBSmBzsmGjFFGaLxA2aW2AU5OOJl//4bc2jutUN26I4m7fPlfl0d1taH+a2tsVkTd5
         sLBgwbWfpT6Rp5hAB9zvDgVwYQrd6wA1lXPd0aCQsskRbwbJxb10g6hPLBywNa/yLgWV
         DXXWR1KmFrXzhaXBfUdO1p4+YPu4Xfh5WOHoRheXMyni/gjLPgSM+vr0tZ39j5ud6JWk
         M8IA==
X-Gm-Message-State: AOAM532Lf4+zBZf8BupS9t5Xwfo8eW6xcFG0WSoXvQcRVs5Rsp/6i7SR
        dZ51uU9ozXIMWuWjFn+NFWA=
X-Google-Smtp-Source: ABdhPJxONXoJi6pBhZ5DofYJSSUcXRLK7XgqLFIFqAOEhbdNasVBLoUAyvfuO3IWOyAk243WmhgOYw==
X-Received: by 2002:a5d:68cd:: with SMTP id p13mr14125444wrw.247.1616752161895;
        Fri, 26 Mar 2021 02:49:21 -0700 (PDT)
Received: from lorien (home.raoult.com. [78.214.78.108])
        by smtp.gmail.com with ESMTPSA id o2sm10237253wmc.23.2021.03.26.02.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:49:21 -0700 (PDT)
Received: by lorien (Postfix, from userid 1000)
        id C68321402FD; Fri, 26 Mar 2021 10:49:19 +0100 (CET)
From:   Bruno Raoult <braoult@gmail.com>
To:     gregkh@linuxfoundation.org, straube.linux@gmail.com,
        zhaoxiao@uniontech.com, dan.carpenter@oracle.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bruno Raoult <braoult@gmail.com>
Subject: [PATCH 0/5] staging: r8192U_wx.c: multiple style fixes
Date:   Fri, 26 Mar 2021 10:48:30 +0100
Message-Id: <cover.1616748922.git.braoult@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These 5 patches fix different issues reported by checkpatch.pl on
drivers/staging/r8192U/r8192U_wx.c :

Bruno Raoult (5):
  r8192U_wx.c: style: alignment with open parenthesis
  r8192U_wx.c: style: spaces preferred around operators
  r8192U_wx.c: style: braces all arms of statement
  r8192U_wx.c: style: Unnecessary parentheses around expr
  r8192U_wx.c: style: avoid multiple blank lines

 drivers/staging/rtl8192u/r8192U_wx.c | 139 +++++++++++++--------------
 1 file changed, 69 insertions(+), 70 deletions(-)

Note: One checkpatch report about style remains in r8192U_wx.c after
applying these patches, to be fixed (?) in another patch.

--
2.27.0
