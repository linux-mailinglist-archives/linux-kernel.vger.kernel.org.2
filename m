Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E79936A598
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 09:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhDYHxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 03:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhDYHxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 03:53:02 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC6BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 00:52:23 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 26-20020a05600c22dab029013efd7879b8so1551019wmg.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 00:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DxXfssDzZ5x1LEXGMfUGWMuElg3emrhM9KxgFO/3r7I=;
        b=RKcm0mnpPekdsyNlRFiGOmfjcV4J9ZbIVJOZTub5dFxfEJd5yICsFYE6bN9w4RHTCR
         SRJOwOHAxpr4PXdYUmUA0Qzop6GrJamo7viYc6iq+Yc1emXCZ6l5M4f5l7Z5c+AtCXHQ
         FVmBwzqeqsl9gOK1U5sUZo3jObNaJirmJG4SaGeBEmBURiqz+/p+CG6kBr1BQlVjvEhR
         CLqbrf2ACgmp+X7X4ZVWkos0EmAakOPBKHX3AyZ/YuIhTO6xRRxXGB+gceC6cNLsRy5H
         cbmfnuPrbbYvl7hVV5OvvH+wOJO7TwZlDcH8pEuEPPyvQWbWxBj7IEcla1t3eJMHVS0u
         zI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DxXfssDzZ5x1LEXGMfUGWMuElg3emrhM9KxgFO/3r7I=;
        b=QXwgj/jh1JFXkJYsObt0z+jD077OiNaJTBoqEGoc+PmKegQfBGO7lyixyn7MV/1GUT
         86VMO9T4qj08YKOiZyYA8W5WyNPgn+3qHBWsusBd2S2JT5hl2XDnoc40vay//5sgL4w/
         hzenHZcXcx904Mgtd74rMxGTls8lv5YZUI04BQTYDzP6g72+QrvH7Z+IRkMvuPjx2WZW
         YHQjas81twbVIx9xb04dgkdqcaivUmJM2rZtUf3JWpTQE1QX9qBRjgdFrHNN2279Ksnm
         uSTvI9IO4FU++ii8I1T61C40ANrk65hholc8oSOPX4okBEh1brZAhk/O+HsACZh6XIVm
         WD1w==
X-Gm-Message-State: AOAM530EYK8HXUCS18g8JVZWBO/32rSsA9livETesmiePteDYRocAgW7
        OoHXVcFJKnYUjq27SJW00S6rx2JT7D0h/g==
X-Google-Smtp-Source: ABdhPJyKkypBVt1Dv8z66wjR3Mpvmj65Wi/QN10SxhsN57XRFPh0o3KDnXSjRCLEnZaWrsnOHScSfQ==
X-Received: by 2002:a05:600c:2112:: with SMTP id u18mr12898543wml.33.1619337141689;
        Sun, 25 Apr 2021 00:52:21 -0700 (PDT)
Received: from localhost.localdomain (p200300d9971998009e1ae620ab52a3b7.dip0.t-ipconnect.de. [2003:d9:9719:9800:9e1a:e620:ab52:a3b7])
        by smtp.googlemail.com with ESMTPSA id n3sm12780169wmi.7.2021.04.25.00.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 00:52:21 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     1vier1@web.de, Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 0/1] ipc/util.{c,h}: Use binary search for max_idx
Date:   Sun, 25 Apr 2021 09:52:07 +0200
Message-Id: <20210425075208.11777-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2nd version of the patch:
@Andrew: Could you add the patch to your mm tree, as candidate for
linux-next?

Note:
I have tried to remove the ids->max_idx cache entirely. Unfortunately,
this causes a significant slow-down of semstat(,,IPC_STAT):
   * no object allocated, no ipcmni_extended: +50%
   * no object allocated, with ipcmni_extended: +80%
   * 30 objects allocated, with large gaps, no ipcmni_extended:
           +350%
Thus I haven't removed ids->max_id.


--
	Manfred

