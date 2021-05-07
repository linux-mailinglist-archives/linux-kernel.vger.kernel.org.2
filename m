Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1499337613A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbhEGHhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbhEGHhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:37:02 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4DBC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 00:36:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so4294590wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 00:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UpLXPBEca00X1jt2BN5Po39enJc5MfLPxoMSCRbIJjs=;
        b=lkCNWke4nt4qvL/3A89p2+OV9OrOjUnPpf2JQBWj6b5CaqFLacdUCysNuSmH860Hsi
         eie4XrwdgPinHZmI8RtAU/y11UJW6fnkB/0nwz02q1VW1AdBbsjECL9YYpMIZ2sGuiLI
         se3HcC5hyu2q7/32q+lFAei+IETcbhmp7XiJVRP1Pb26iY6mGJVjLA0BdoZk36UmlUtA
         DpO34NbNBAlEl5+9wsAQo+aqkeaSm51vTAB84eeeRGb5K20U+87Y3lsZvZd0BQvFbKJB
         cvvD6a92uJgsYb9rmQL2NpG56YaNST4HCBvg/nSuSc9tKArdP9KyovYnkdombgMeTgOe
         53JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UpLXPBEca00X1jt2BN5Po39enJc5MfLPxoMSCRbIJjs=;
        b=s7FFxac2nH4tswbJSmdsu49QYBwDa4q5vt56rc7fKjrrtHwwSfNWEzIaAfvvH3ddp4
         CFEky1xim3HHwZk4/g0M24Ji9NypmVimb14zT6T0IL5KeQ5g+fWs6ewMsmQf3VEAT6F2
         nou/xvRYNPcHi6jSbYwlfq0wd45Eb7InhefgJBvzoi6NhU+C+q9O2ylAsJ0A6KaYckLo
         4ket5DKGKQ+EHs5o4HbKYhkScb1jJII0qXfoenHaTFmsELng/5ZHdYQ40Lb+1gj9z6Cd
         NjHNZdzZ9KYGcbl3WWfte1G2+zyfklnllAbjAY/5JxN0vatAEzpi1PitcqwRFCDhNNsP
         ZDZg==
X-Gm-Message-State: AOAM530JptMj1OOZMrBc+blTAJqfuzuQpzfJIFr26PqbYQRbuwMtwSgi
        kAa8SIT7bNYRjsR4ZIMVX02QYo4BFGaXdg==
X-Google-Smtp-Source: ABdhPJz8hfgogAayHw7HZWMvEcBVvaI+9+Lyyn81eann3OdlIChYSmWCJv+OrbtB4J4bpIJdKs3Qjg==
X-Received: by 2002:a05:600c:9:: with SMTP id g9mr8564603wmc.134.1620372961805;
        Fri, 07 May 2021 00:36:01 -0700 (PDT)
Received: from agape ([5.171.80.53])
        by smtp.gmail.com with ESMTPSA id c5sm7561883wrs.73.2021.05.07.00.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 00:36:01 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] staging: rtl8723bs: rtw_security.* clean up
Date:   Fri,  7 May 2021 09:35:56 +0200
Message-Id: <cover.1620372584.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset remove some unused macros in include/rtw_security.h,
most of them tyed to old private AES encryption.

It also replaces private arc4 encryption implementation with
the in-kernel one.

NOT tested.

Fabio Aiuto (4):
  staging: rtl8723bs: remove unused macros, arrays and an inline
    function def
  staging: rtl8723bs: remove more unused encryption macros
  staging: rtl8723bs: remove unused symbolic constant _AES_IV_LEN_
  staging: rtl8723bs: replace private arc4 encryption with in-kernel one

 drivers/staging/rtl8723bs/core/rtw_security.c | 276 ++----------------
 .../staging/rtl8723bs/include/rtw_security.h  | 101 -------
 2 files changed, 21 insertions(+), 356 deletions(-)

-- 
2.20.1

