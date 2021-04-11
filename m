Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3914735B38F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 13:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbhDKLfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 07:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbhDKLfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 07:35:14 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8680AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 04:34:58 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w8so2524579plg.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 04:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=eAzRDo314DwpqSCtRrPdwq25STQ7t6umx171HFgVOI0=;
        b=orIBLZrCQ1yR8fZVZ7PQqeOKJ0Eh3FJXa4s/ZtA6pN7GmzdapVBnOESR7Tf9piSq1L
         HX22/DvkFoWAFpKhQcw3Xh42PfGo9v9RqxvPlfg8AFb3O17WTpjL408y6ftl312Ln9Xx
         56F59aEg0XRs+Py05UVo+TZC9Rl7xBwHkRibynOi/gu0jxqbKt7MPMDgkCM3G9Rm2Unu
         AwwotyDjP2tHM004yf5T4dtCsDRikzntsl/iJx4Lki2q3aLFtKAvYbj/78TqqcGf+SKs
         qgguSvKpcdGWb0M4Rlljlrz38EJ1+txy/R4gSqOmWaKDYBkO+JxBhNHfxhwzDmTAl8lp
         ToeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=eAzRDo314DwpqSCtRrPdwq25STQ7t6umx171HFgVOI0=;
        b=scCNdMBBRtKXQsROsGsLq2UwvNLbN+zEVE6xkEyShBBLO+/o6uOcXSGblxMkzg/7/G
         f2qgK2NYfYghQJd6A27d0Shijmiv/WBCX/sSc8H0yT3BixrBeQicpTkl/MgQIkjybbMt
         FH7WTwqbsAQE1dd83jM+lS2MI90I7x5VxbteFr0jO7KnYZjufwhScmu0dIzpils92UYa
         Zw5bHny3WHvMaG0qU1ndLKC6n8yaxtihV9SuO5BAhn3s+rBIs5RMJgQzMx8PsiUFx3ta
         dojHOStkdQep9+HFPe8NeWLW7cacJJiWMwFWgNzEkihkX/BZzEA2gQZCVXlOHUzg+zsU
         vgmQ==
X-Gm-Message-State: AOAM530/jLI1Vh76244fJu5u88gJJKA1ZGxMmqLe4anZLmPPoy1SS5Ck
        Hz+hSnp+fNsTfJsPTmE0BJs=
X-Google-Smtp-Source: ABdhPJxtau/JY52m+cPCRn0600HaqksTK+/k8p78h+nWt/x9rZynxokupybw7lO9amhzYnZOax35Jw==
X-Received: by 2002:a17:90a:bb86:: with SMTP id v6mr23601738pjr.37.1618140897928;
        Sun, 11 Apr 2021 04:34:57 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id 129sm5120429pgi.76.2021.04.11.04.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 04:34:57 -0700 (PDT)
Date:   Sun, 11 Apr 2021 17:04:46 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v4 0/3] staging: rtl8192e: modified log message
Message-ID: <cover.1618139271.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes style issues
Changes from v3:-
[PATCH v3 1/3]:- Modified log message.
[PATCH V3 2/3]:- No changes.
[PATCH v3 3/3]:- No changes

Changes from v2:-
[PATCH v2 1/3]:- Modified subject description.
[PATCH V2 2/3]:- No changes.
[PATCH v2 3/3]:- Rectified spelling mistake in subject description.

Changes from v1:-
[PATCH 1/3]:- Removed unnecessary parentheses around boolean expression.
Changes has been made in v2.
[PATCH 2/3]:- No changes.
[PATCH 3/3]:- No changes.

Mitali Borkar (3):
staging: rtl8192e: remove parentheses around boolean expression
staging: rtl8192e: remove unnecessary ftrace-like logging
staging: rtl8192e: remove unnecessary parentheses

drivers/staging/rtl8192e/rtl819x_HTProc.c | 18 ++-
1 files changed, 7 insertions(+), 11 deletions(-)


-- 
2.30.2

