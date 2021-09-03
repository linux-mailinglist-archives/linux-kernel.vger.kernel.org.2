Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9442A3FF9F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 07:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhICFVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 01:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhICFVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 01:21:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65454C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 22:20:34 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z4so6423748wrr.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 22:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UWnVoOsgJYFKBQC7gDrk27BiZv5PpKBBdz1rSf70+Fw=;
        b=uORisnFHF3C/KKmzeVjKSXmo3ZSCBYyfABaMZvlKoyRy1SeCmGWThm5hd9vRkMOFDJ
         lIJIif5+vtutn9spPr4yRXoj5CVsm4v1jWnzW4JpnhkWXTj6JA/FjFmLiKO3trMgTFRA
         om62RC2Krk7RKUBLKIIPCa5Ag2dkU2k5TxgCRLH4nnd/TdVZXVhnQQcMaYzwPfk38ki5
         wTN8uH/wpwQiU/hLlfoBjEEiHyefyLUnmrJItXAIleEMHf8sAWR5135mrMeiP3BCD6XH
         gyTvilDhCMAvNHH8tMYXwm3oeQylbZxckcfjuoov6Ays/S0hq8kn+51tCg4dcsr4mBjO
         cX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UWnVoOsgJYFKBQC7gDrk27BiZv5PpKBBdz1rSf70+Fw=;
        b=k7xo1Gywoj23H6PSUz+UOQzLnCzgkwMteQv8fbg6VAaT0pkrkWcw8iiRFrtuQgw+uB
         ZOrPe/p2VOt96jFwtNi1kSktFvZqm48UWb0Q2XCv9lOkEax9SZBbik7yhGt/BVRSs4b0
         4sFu0q6FKNvWbiJR6LhN8QA+s1akBWkXDWvpx40qWnNlALo3V2nQqQ9u8DJx+Ivt+t0u
         vsL8xIaSLp+rONpjYMCE6wDfJExsZH5//xMGfPxTF4nL7RiN2w2MGIBud3EHjRwU5kwW
         UkXeNuqd0VEHyJfEetMWYrCCvcuk5AHcB0ct1+95Z6Nf4h5t7MAsD4574RHgso1isJIS
         6/Lg==
X-Gm-Message-State: AOAM533lIJ4Vl+wfiCxHe+ii05TFWcDIS+honZ3gtDJT6sActQ6sdjYa
        6q6oHBYpZKnQWD6JcqWIz2xYu8zDjwIxyBTn
X-Google-Smtp-Source: ABdhPJyTvm0JdJ1KOq6IxDX3cjrZSt9VJLFbRx1E0604tu/YCSQU8gOtb50ESCvserT/MfzC5OuVfQ==
X-Received: by 2002:adf:c785:: with SMTP id l5mr1829346wrg.360.1630646432681;
        Thu, 02 Sep 2021 22:20:32 -0700 (PDT)
Received: from localhost.localdomain (p200300d997085c0087ad16bce8a07868.dip0.t-ipconnect.de. [2003:d9:9708:5c00:87ad:16bc:e8a0:7868])
        by smtp.googlemail.com with ESMTPSA id m4sm3313987wmc.3.2021.09.02.22.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 22:20:32 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Waiman Long <llong@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, 1vier1@web.de,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 0/2] ipc/util.c: Cleanup and improve sysvipc_find_ipc(), V2
Date:   Fri,  3 Sep 2021 07:20:18 +0200
Message-Id: <20210903052020.3265-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update of the sysvipc_find_ipc() changes:

patch 01: 
	Unmodified patch from Rafael Aquini, already in mmotm.
	https://www.ozlabs.org/~akpm/mmotm/broken-out/ipc-replace-costly-bailout-check-in-sysvipc_find_ipc.patch
	
	Acked-by: Manfred Spraul <manfred@colorfullife.com>
	https://lore.kernel.org/lkml/42b60dd8-8393-5e0f-e576-da5303f29fe7@colorfullife.com/T/#m230673c8ef7261745e80ba458b9712bf1fad2251

patch 02:
	Performance improvement and further cleanup.

Especially, patch 02 tries to make sysvipc_find_ipc() more readable.

E.g.: There was a "+1" at the end of the function.
My first idea: "+1", as in "move to next".
No, the "+1" was "convert from index to pos".

@Andrew: Patch 01 is already in mmotm. Could you add
patch 02 to your tree and forward it as needed?

Thanks,
	Manfred
