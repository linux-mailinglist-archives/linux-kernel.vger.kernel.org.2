Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D326368B51
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 04:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbhDWC45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 22:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhDWC45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 22:56:57 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2DDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 19:56:20 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u14-20020a17090a1f0eb029014e38011b09so469199pja.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 19:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=UtQhf0AMGUbWT9+v2yf9kUp3nmfSVtohRhb6bLrpe3w=;
        b=g//+B6F+TXQhW76hcLtZtiPnhUoG4OKOoeXsITq/NnITlSIoZ/PSEkyiJBwjx1pzOJ
         b/bru8FIC5SXz4K1SStTS1wrvbNgZ9GOW48lVyUxKaO+1SVehz0ICVVFzTklw331xhjG
         SYZVHe9vBOMA2SzGyusWqV5V0DOepdOP26d3+HgKF1B371z9qMc5+XH2CI/ISZW9rJhO
         LcUJnRg5wcq4VBdUDV/WkD8UDrOWLLvUBHOVOmY55jzheZBUoqDnqhxj87IJ3d3H14QU
         oD8WIYr7Ch8+u757kgjJ9rVTih+G9Y98n+xTjNje/DpNFrFV1FvtKilSaqX+Nf1sBZG+
         os/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=UtQhf0AMGUbWT9+v2yf9kUp3nmfSVtohRhb6bLrpe3w=;
        b=Q17MamDEB7NpnYTYRQSJiFMPVhyWyKNGPVPUYI4FYQCDOyfLGcJuJmAyAlTNWEn3ft
         MIG90F1N0R6+xcPlPPhdaiiVShxrKVcx3h2ClgKNSGHE12c4YjrhgOL9E/iIhZNYySHl
         iGNIKI6a6xBoZi8+TE7+JjzNR5FEgksweqtgE7nO3c4hv9hS9nxlgQEUbqfhdk3d0Ian
         ppBpKciOUoW0DcYHCdpARLENqmg5YHtM4Qfs49unqkPNNHt/oMb+7saGoiN+3wjpuvW+
         Rv1uYwy0VTKblEOsVt3kes4qdQRtZKqnaTk9UE5kFxuUXZh+Vxtgjow719ZPIajw3w6K
         VMuQ==
X-Gm-Message-State: AOAM531pa5Jeq3xVLL3onuAkxl6BS593ZaSGf4MkuqIUYrtPN5msBW8l
        wYy+jsgvkYsdrZ1EB3Y1n0fnLw==
X-Google-Smtp-Source: ABdhPJwUbOVgaL9jeXHuyFS1nq5rKBtjrsM1C9sCYcWtBQPflZeSEQ9adYi/u2sQZXINu1KuHSZoBA==
X-Received: by 2002:a17:90a:9a85:: with SMTP id e5mr3107773pjp.201.1619146579609;
        Thu, 22 Apr 2021 19:56:19 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a4sm3217271pff.140.2021.04.22.19.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 19:56:19 -0700 (PDT)
Subject: [PATCH] asm-generic: Remove asm/setup.h from the UABI.
Date:   Thu, 22 Apr 2021 19:55:45 -0700
Message-Id: <20210423025545.313965-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Arnd Bergmann <arnd@arndb.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

I honestly have no idea if this is sane.

This all came up in the context of increasing COMMAND_LINE_SIZE in the
RISC-V port.  In theory that's a UABI break, as COMMAND_LINE_SIZE is the
maximum length of /proc/cmdline and userspace could staticly rely on
that to be correct.

Usually I wouldn't mess around with changing this sort of thing, but
PowerPC increased it with a5980d064fe2 ("powerpc: Bump COMMAND_LINE_SIZE
to 2048").  There are also a handful of examples of COMMAND_LINE_SIZE
increasing, but they're from before the UAPI split so I'm not quite sure
what that means: e5a6a1c90948 ("powerpc: derive COMMAND_LINE_SIZE from
asm-generic"), 684d2fd48e71 ("[S390] kernel: Append scpdata to kernel
boot command line"), 22242681cff5 ("MIPS: Extend COMMAND_LINE_SIZE"),
and 2b74b85693c7 ("sh: Derive COMMAND_LINE_SIZE from
asm-generic/setup.h.").

It seems to me like COMMAND_LINE_SIZE really just shouldn't have been
part of the UABI to begin with, and userspace should be able to handle
/proc/cmdline of whatever length it turns out to be.  I don't see any
references to COMMAND_LINE_SIZE anywhere but Linux via a quick Google
search, but that's not really enough to consider it unused on my end.

I couldn't think of a better way to ask about this then just sending the
patch.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 include/{uapi => }/asm-generic/setup.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename include/{uapi => }/asm-generic/setup.h (100%)

diff --git a/include/uapi/asm-generic/setup.h b/include/asm-generic/setup.h
similarity index 100%
rename from include/uapi/asm-generic/setup.h
rename to include/asm-generic/setup.h
-- 
2.31.1.498.g6c1eba8ee3d-goog

