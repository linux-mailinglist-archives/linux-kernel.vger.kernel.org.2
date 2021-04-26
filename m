Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5B236BB90
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 00:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbhDZWSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 18:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhDZWSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:18:40 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3A9C061574;
        Mon, 26 Apr 2021 15:17:58 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 190so1508443qkl.11;
        Mon, 26 Apr 2021 15:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pT8Z+BT2Uzmb9KP8iLMvUauv3UtnTngOEKOh9DM9qy4=;
        b=ls88h6qyJchcgT2gheBMtudKdMq1gyb07dTcQOV8pEX9uxpTys/RsUPQg8mKcSczat
         N3AQwYv1yH2AVQF6kTC7//Y6JGWsod8vPKVCN/NHqF88ETT4zerdjRIuSMjqXQxsvz2n
         2PUrkKm00H5yDGX7LdUNkU9VMzb7z1KmIug7hMxRE+3M/SqERb0K+XdQ0LDjHc1Mwmr9
         Q/MgfjEIR3UhkTeObEGz0vTnkDJWgVm4/s0kb3FvY0DHNeVRIpmE0STPoMDver35CK8d
         C0CFtEXktUU4xM0z73+1cCpVKXsME2/Z//BAbumV00rpa/r3iz8MGU4glUaHGLXTEJyi
         Xupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pT8Z+BT2Uzmb9KP8iLMvUauv3UtnTngOEKOh9DM9qy4=;
        b=Tm7TaMW8qv0wG6hL0DPoTcFU407yeRfomQ8HEBT+kd+Olo/73/xXnfBmwd8VcNp1zr
         CW86s3uPAUJCV/J7nS+zyw/yqJlfudiyUuQJBEJJl3JFeO+3sJZNv/sSrDu9faxIsg4M
         XiXCeYvVTxn9N9CCdQQ5adJrv7UuCrdj1LHtS5Mv2s8Zb4d1Zn7MfHzCeYWpuM4Xeqpt
         5TYs1aqEVsNYmvw/Sf1t5W+9O6WI8o4JXjhmtemNjHiN41g86tkobF4KVPgbfwdp0JwP
         o/uMUgYRrWtVtk80oLENYAAYdSZdX8YVYGJk1JLTZ2VbCgjcNr5zwqNivGykYQ7ZX/dD
         1Ltg==
X-Gm-Message-State: AOAM530PBPFm8s8pCPyDctFchwej+q2GEAbGE/meN00GoaKx2tf4r6g+
        DOKYT2NV6r1vZHnKRy9/xc4=
X-Google-Smtp-Source: ABdhPJwHRhWj15+STILXHLcbrerqEPaFw9TR6Lud8ogKrGI6XqXY451mMzvcEH4xijSbRTNDATMIFg==
X-Received: by 2002:a05:620a:670:: with SMTP id a16mr20732183qkh.428.1619475477527;
        Mon, 26 Apr 2021 15:17:57 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.247])
        by smtp.gmail.com with ESMTPSA id x20sm1374111qkf.42.2021.04.26.15.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 15:17:56 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, nathan@kernel.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org, linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, viro@zeniv.linux.org.uk,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Subject: [PATCH  RESENDING 0/3] Removed oprofile stale entries
Date:   Tue, 27 Apr 2021 03:38:44 +0530
Message-Id: <cover.1619181632.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series trying to clean up the remaining debris of removed
functionality.Kindly see the commit : 24880bef417f(oprofile-removal)

In truest sense, it is all trivial in nature, so cc'ing that mail id too..

trivial@vger.kernel.org

Bhaskar Chowdhury (3):
  Removed the oprofiled version option
  oprofiled version output line removed from the list
  Enlisted oprofile version line removed

 Documentation/process/changes.rst                    | 1 -
 Documentation/translations/it_IT/process/changes.rst | 1 -
 scripts/ver_linux                                    | 1 -
 3 files changed, 3 deletions(-)

--
2.26.3

