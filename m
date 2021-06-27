Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111603B542E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 18:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhF0QWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 12:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhF0QWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 12:22:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C47BC061766
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 09:19:37 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o35-20020a05600c5123b02901e6a7a3266cso6911946wms.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 09:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kU2Mk8uSDc2zxU3chWaXpx2d5lLNYMiHXfviaQ8+BzA=;
        b=k2YI6Osm7GH9FKEK2zhDXC/pW+DEixAaH7KPObh56kUOkZFA+OapovPGE9q9yDi9q1
         OKUtViNJJHPzgQC6bsa5gO9XyjAQbmjGlJMTvEM33foOlQCi9lt2uXuuMwXJJfDv3rcz
         WXb9Mlg4zYNUeChk41a36yj5PB6rwiGVwCzry+XhcYrmSkwz+ohldC4Pdd/vCJ9SKjKP
         C10gXUPU1ZrOIl6evr6O7kVY635ydRpL4FRtb/0Mylo33RfV02StwfpfStgJRdIiAEi+
         HfRtNGpW6fA5MAFI6G8SJ8l8nRc/DFEl44kZ285wnORz+g991j1nghM2Wk42DS+aoNO0
         zMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kU2Mk8uSDc2zxU3chWaXpx2d5lLNYMiHXfviaQ8+BzA=;
        b=BCaN7z6fW9g4Sl2ViOBQuFqHGF/es6yJiosdvaTXpnNTdqmreE4CiS/Dij9A9Vd3GB
         C0f40ydoKZ24IU/XTXM3Te1KdU3UKHwZJL8/uaNG2p1CqBkb1vPMXsAR8Tl6fbkoDDxW
         nF8eH0tmdN8Lf2bqNSdcx9Wg9C1GnuUP9moNwLzenMjP7mh9CExgmSSoFLeprcjGOxLP
         9DMhOso9CZxNJ3tXOMDAsiE5mbY5QErTP0ldCvqSgpqoQnsWyHkjCwbIOx1s+BpsYNkr
         5t2SaL6xeeVHcA3nPHXc5CI76MxMXVRiUxAl+nl/nTrMLj9UJqIVn/TjHdvzi/kBeydZ
         YreA==
X-Gm-Message-State: AOAM532hBSvcKkl+9oW86bMUa4aVZnzzD1BTQhdASfHT06PhHxmDiH86
        tv2I9/kJjM91LQY5msA0vYkqFrcg5wSt6g==
X-Google-Smtp-Source: ABdhPJxcIct+WOtglb3B3eV4J/ZzGCw8s9V53PABXvOiW4D26zE3RmryQXXnwL8FMvbaUh4YRZz0rQ==
X-Received: by 2002:a05:600c:354d:: with SMTP id i13mr21983769wmq.143.1624810775864;
        Sun, 27 Jun 2021 09:19:35 -0700 (PDT)
Received: from localhost.localdomain (p200300d9974f98002cd84be72c5877b5.dip0.t-ipconnect.de. [2003:d9:974f:9800:2cd8:4be7:2c58:77b5])
        by smtp.googlemail.com with ESMTPSA id f22sm10820384wmb.46.2021.06.27.09.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 09:19:35 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        netfilter-devel@vger.kernel.org
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>, 1vier1@web.de,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 0/2] Fixes for KCSAN findings
Date:   Sun, 27 Jun 2021 18:19:17 +0200
Message-Id: <20210627161919.3196-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extended patch, derived from a KCSAN finding:

- Fix for nf_conntrack_core.
  Unfortunately not tested, I don't have a conntrack setup.
- Fix for ipc/semc.c

@Netfilter-team: Could you integrate patch #1?

@Andrew: Could you add the ipc patch to your mm tree, as candidate for
linux-next?

--
	Manfred

