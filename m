Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462C4343333
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 16:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhCUPjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 11:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhCUPi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 11:38:56 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FE5C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 08:38:56 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id x27so7508072qvd.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 08:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0pewC4NLVkrzHJtpkPlyz+hRs/mv7dEXjipPB7HV5Qw=;
        b=U8oQ/Xu+HrCJcE3AErjsrkX/1a7EZaDn8c/OzoFdXzUJcJIDw6VMt3qHLwYnp2MfE2
         i1b2oGARSq055n/rkEAgO81ub62ZdIE4FVbh0hTYdzifETv2u43AfuwyLk7ca0e3cOp0
         RXin7+YqHUhpI6K6c1FUbr5diue6acJJ9espBCFYpAvmE8z2U7hItrAG9HPxKGt95fx3
         YFPMysZkMyzP3MVzyHoVBqMSud6aTm6x0hXSrqPye/WAxsCzheqWxKpn0X12GLDl7EHk
         ZeUV0MvV0oOmtbHGZrecievcq/xis1VS98YUMxAiFnAms9f5aY+WoxHDH3sig5p8Xh4/
         9Fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0pewC4NLVkrzHJtpkPlyz+hRs/mv7dEXjipPB7HV5Qw=;
        b=U28+Nq617ME0aCAC23n1f77Q0sgYZ9cRtYFouyhVX4fF02zyG0vO8RsHebV7J66l3C
         0UrgEOHMCHyTwmlObPsSOCyzGV8GWhN7XsXCOH7wstziIIHA4A2j71TGijdehH6q//2U
         t9bxI4b+LXgOn7/FKcchW4tfbE2OtmvzbxYWHlQnSs46RKWQqtUciHq/qncK7laGC/9E
         kqon3eagZzEmHQMmc9gHuncb95aduhQuefRJyH1RQL70DCA3gMDlATayojhYbCh9/Krs
         i5aneQoUUpGV4JurAbeQn8f58PG5B7YlxKqSd4vH6Vny5Oj8Xg6iSxf1Gi/83J+YeVRp
         W72g==
X-Gm-Message-State: AOAM530y7OVBdM5pMdezpaw6bm8VdaoJnUmD4EdfgnAfylvEakUVD7Ce
        t1tJqGerO7rVDr6lwn48wYY=
X-Google-Smtp-Source: ABdhPJzk7eAyvxjVUaT9Olw5L1o7rrI8BwAGtajFX3oov2oK0Rtg/ME9/G4CJpBuViS3V2Ehhs6DyQ==
X-Received: by 2002:a05:6214:945:: with SMTP id dn5mr17509531qvb.3.1616341135432;
        Sun, 21 Mar 2021 08:38:55 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:f925:bb4b:54d2:533])
        by smtp.googlemail.com with ESMTPSA id y19sm8976317qky.111.2021.03.21.08.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 08:38:55 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Jasmin Fazlic <superfassl@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <allen.lkml@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Naoki Hayama <naoki.hayama@lineo.co.jp>,
        Tom Rix <trix@redhat.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: [PATCH v3 0/3] ALSA: rme9652 don't disable device if not enabled
Date:   Sun, 21 Mar 2021 11:38:37 -0400
Message-Id: <20210321153840.378226-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <s5htup4exbl.wl-tiwai@suse.de>
References: <s5htup4exbl.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes issues in hdsp and hdspm. The drivers in question want
to disable a device that is not enabled on error path.

v2: add fix to rme9652
v3: change checks to pci_is_enabled()

Tong Zhang (3):
  ALSA: hdsp: don't disable if not enabled
  ALSA: hdspm: don't disable if not enabled
  ALSA: rme9652: don't disable if not enabled

 sound/pci/rme9652/hdsp.c    | 3 ++-
 sound/pci/rme9652/hdspm.c   | 3 ++-
 sound/pci/rme9652/rme9652.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.25.1

