Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654FD392307
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 01:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbhEZXMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 19:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbhEZXL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 19:11:57 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADC1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:10:23 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id w15so3811162ljo.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R5KRURxHuIRN88Pq9m7M0QMDbYSaSSuxjl5MCR9Behs=;
        b=Ynrs5OeCYBdywINKAam25dmM5d9qI4+8NGAxeYx7bbhSmSgJuFGFHW+rWp3qju9chB
         8EFmBYuQotNniMoFuxnj71htVRrWPpuZ6hMOVCylUvb9QZPekJ5wztkAihGO+adT3ndS
         zG9Wgf//E/TNyjng2VKHD+sd7bLmUtnAsB+l0mHYFWlHGBlNBDgeJnOgQz5CGy8Xmomo
         xNG8mTqr3c/cJnrzka2IKRhG5lU4yLWnBzNMmlyp8R5OPFWGgnTGu1njDSoS+qE/6f70
         0FDLjiBlcL7aScPilhXPj/VJdX64s5O/y87dTP4M0494u2zfryyWUNSLUZTYPHRfM/Qh
         u9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R5KRURxHuIRN88Pq9m7M0QMDbYSaSSuxjl5MCR9Behs=;
        b=opXaOWIyKdjap1fuSpPUVr4dXfv8Jk1lnqhJ065kBCfTzJprTFAzpIrzHbd/Qln671
         7UnPo4IXw+QN7WVzbOXOh2OUWjJCA49nm9t3mD0J7W71uEj3XQ0HMkKkxQdQVQkGpaF4
         H97OrVV/5AyMiX1XcNOcbsnt50GKhjzPKKpur/1dRpW+uMMefI3DcC2BtK0Xtu7V9fnP
         frAzbinp3tB2EX0z0mpabW19keJIOP22FxKZ3kRPotO6bbwAO/lCeTyz+iRycNxVn+sH
         7GN/NS47PA0ERIghHjIAYrytpc9HYN5ezM6AVLVC9WdoZeZLPiCcngZcDGaQspUDAxh4
         vVBg==
X-Gm-Message-State: AOAM532yOw3254yMGVLXbK7O78P7Pke58UZdV5sEahhmTZ2++eK/ObsD
        GD+S/lVJAY3RWiEiGThoGeI6ZDxP66U=
X-Google-Smtp-Source: ABdhPJyLm/jqms3TflDkHNXOnrAgQmry/eccJ3qYNO1aroF0i6fo5eMr8i7kxP/p43Jj4WvcG9HzkA==
X-Received: by 2002:a05:651c:1258:: with SMTP id h24mr316230ljh.340.1622070622192;
        Wed, 26 May 2021 16:10:22 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id d5sm35802lfi.144.2021.05.26.16.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 16:10:21 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/5] ASoC: Constify snd_compress_ops
Date:   Thu, 27 May 2021 01:10:08 +0200
Message-Id: <20210526231013.46530-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only use of the static and global snd_compress_ops structs is to
assign their address to the compress_ops field in the
snd_soc_component_driver struct which is a pointer to const. Make them
const to allow the compiler to put them in read-only memory.

Rikard Falkeborn (5):
  ASoC: cs47125: Constify static struct snd_compress_ops
  ASoC: wm5102: Constify static struct snd_compress_ops
  ASoC: wm5110: Constify static struct snd_compress_ops
  ASoC: qcom: q6asm-dai: Constify static struct snd_compress_ops
  ASoC: SOF: Intel: Constify sof_probe_compressed_ops

 sound/soc/codecs/cs47l24.c       | 2 +-
 sound/soc/codecs/wm5102.c        | 2 +-
 sound/soc/codecs/wm5110.c        | 2 +-
 sound/soc/qcom/qdsp6/q6asm-dai.c | 2 +-
 sound/soc/sof/compress.c         | 2 +-
 sound/soc/sof/compress.h         | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.31.1

