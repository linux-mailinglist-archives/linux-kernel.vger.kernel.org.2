Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5CB354ADE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 04:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbhDFCcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 22:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239101AbhDFCcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 22:32:42 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C538FC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 19:32:35 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t23so3854752pjy.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 19:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oEU1R+GF3fw05zjoYhUSVLkVYZLjVhoWO8rK7v+0G2o=;
        b=XiZ4k2eTKFHwCIJxrkbELoBfxWNyn5gvUHVBSM2CKl9/CYF7769JNBUmgHW8BboKha
         DczoKC/869C6ctOlkfsDWfIEBw95lv/xpii1Fi/yhTHSNQS0SWmlfxEhUrXeOd3oN2HY
         uFm6VRRWNfIifvsiGRaKud1d735nrcIJ5m9clUlZ0O30VZiMxE6mPe24h2nOlZUxoZBV
         EasL7jqpoOpoYcT+U+IH/HdPs2OA2VluupxcsLDToq4vCYYRcKC8ADQ/L36AOMPQpYtI
         FxKXO34NxqifCGZ+kuBYlxnzgCYonSPWvPphVRENnbMuKLaGtldDIlMgm+UV+2wmJXG5
         vYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oEU1R+GF3fw05zjoYhUSVLkVYZLjVhoWO8rK7v+0G2o=;
        b=Nb0jp/M1odhJ6eAQAipPjYWKg6dfiOOwU4qTlOscdgYJrtV7h3CJT+ZItBjBvZU6ev
         OBRjzelCS68xC4t6bpw7V+GTOqmwWMFCbJGqiMJggUkErFRgsYm4FU22REQSQSK3duRK
         6a3U8ql19HDlnYIaC9Ahum6tHjd7zKGUmd6ACiC+FTY1kQmv0PYOL/YazwMDo/Tg5JwM
         17hUSahFDk4H94hXTQJNGTCURa6xHJnoOYJ1tM278cnOtbgOSz2CKatcojESq6VuqE0i
         7/6G/3113nG8y/A1UmPjacGbPpkewghjKNzlFEeNK+JlJVGfQLgnzsM0Ce+RDpBmg6Pu
         3B1Q==
X-Gm-Message-State: AOAM5325zAb2Hm/7z1MrIN5PZo23V1XhN+elFCrwO42peS0DEMAhIl+s
        w5CyveEad3uuD551fzt0KLU=
X-Google-Smtp-Source: ABdhPJwAY4Om0AcFDGaDHZrp/MOxr3YYhRb6dhZcjcHzd9SfVCAGitQlJwOVYqq9kqXXLJqp+ecSNQ==
X-Received: by 2002:a17:90a:7bce:: with SMTP id d14mr2165977pjl.139.1617676355125;
        Mon, 05 Apr 2021 19:32:35 -0700 (PDT)
Received: from djbComp.hitronhub.home (S0106ac202ecb0523.gv.shawcable.net. [70.67.120.89])
        by smtp.gmail.com with ESMTPSA id e7sm281196pfv.107.2021.04.05.19.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 19:32:34 -0700 (PDT)
From:   Deborah Brouwer <deborahbrouwer3563@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>
Subject: [PATCH 0/4] staging: rtl8712: clean up style issues
Date:   Mon,  5 Apr 2021 19:32:16 -0700
Message-Id: <cover.1617674639.git.deborahbrouwer3563@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches make changes to clean up style issues identified
by checkpatch.

Deborah Brouwer (4):
  staging: rtl8712: add period within a comment
  staging: rtl8712: remove a blank line
  staging: rtl8712: remove space after cast
  staging: rtl8712: add space before binary operator

 drivers/staging/rtl8712/rtl8712_xmit.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--
2.17.1

