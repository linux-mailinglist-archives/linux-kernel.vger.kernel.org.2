Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58573325B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhCIMs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhCIMsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:48:53 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CD5C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 04:48:52 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id d5so12057101iln.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 04:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EdqSV9iHXI9edaVKvYFhOZKxNewnVH7t0NjYc9U5DGQ=;
        b=iQ9W693U/lDKf6xvxhitW2eA6CCVCbnJlzcbXtzJa+f/r1ONSm+difFu+xKJaHpLcX
         6Eppb4vAdVFkBu7ge1ML5zkYq9/upaGROdgaGIBCGwRgKahkI1PoFMuLQU7bdSaRoK+E
         Qajlj5YSwzOHZhAkeNyR2R3j0LZ2TL3NZ2/NCeClSh20sG488Ck8smoHF92J3tQQiWmJ
         TESDoWmL5gcJVaral6oIx34tkwRQNauL3YoRrhumqtwoTp6d61Ap8kJiafHLeGuOtezV
         SDCmJ6h7Ml838Cwm+Xq3myHVqXUQl7YKUi+ax9Nf9nG91lQ031E3zPgLZy/pOUC53dsI
         khEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EdqSV9iHXI9edaVKvYFhOZKxNewnVH7t0NjYc9U5DGQ=;
        b=PHmk5PgJDq6k4Vb8hK00IKDcohLrTVhpphKTI/wzhS7eeBp4lhxXHMJBGvoLy60Ey1
         e+yEk1WQns1wbva+N7iE3DxeeOEfiKSXJU406naNB6NYsBDaB9OIU3SjRvpNgWfvgIQC
         ZSuAAE/2mXU6humwQyMXFS/FwskUoXriT8vRv4MXnQPSuglxEoonbRmtRmh0uOydAjP3
         BqesAmhUzfxBZ73gNpTan55NOIpslpGeRhlIi8jX4dnY7EOgk5zPcjn3U65MpZZ9cywd
         bC6E6k0gmQM6qWslLBFFMhUYhH9T+LYYdW2SkAhVw30l6fA7FrVYa9FuWHwOdnIWAvWK
         rHdg==
X-Gm-Message-State: AOAM533i44wW21IBbCkhYbTKNgOv/DRhdVQASD0UdhBB6mFJ7lea5NzB
        hXvLy6CcDnUiJWPdtOAOQ3pSZCiH/g2Y5A==
X-Google-Smtp-Source: ABdhPJwoc0RMxKEKIwPTfQQi+XWpl1qVHDKks4afsLDx4m8/HcX4mmKIM4wjJFmcoEWZpSXU1h/DkQ==
X-Received: by 2002:a05:6e02:1069:: with SMTP id q9mr24361776ilj.97.1615294131754;
        Tue, 09 Mar 2021 04:48:51 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id o23sm7810009ioo.24.2021.03.09.04.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 04:48:51 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     subashab@codeaurora.org, stranche@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     sharathv@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        David.Laight@ACULAB.COM, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/6] net: qualcomm: rmnet: stop using C bit-fields
Date:   Tue,  9 Mar 2021 06:48:42 -0600
Message-Id: <20210309124848.238327-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 3 of this series uses BIT() rather than GENMASK() to define
single-bit masks.  It then uses a simple AND (&) operation rather
than (e.g.) u8_get_bits() to access such flags.  This was suggested
by David Laight and really prefer the result.  With Bjorn's
permission I have preserved his Reviewed-by tags on the first five
patches.

Version 2 fixed bugs in the way the value written into the header
was computed.

The series was first posted here:
  https://lore.kernel.org/netdev/20210304223431.15045-1-elder@linaro.org/
Below is a summary of the original description.

This series converts data structures defined in <linux/if_rmnet.h>
so they use integral field values with bitfield masks rather than
relying on C bit-fields.
  - The first three patches lay the ground work for the others.
      - The first adds endianness notation to a structure.
      - The second simplifies a bit of complicated code.
      - The third open-codes some macros that needlessly
        obscured some simple code.
  - Each of the last three patches converts one of the structures
    defined in <linux/if_rmnet.h> so it no longer uses C bit-fields.

    					-Alex

Alex Elder (6):
  net: qualcomm: rmnet: mark trailer field endianness
  net: qualcomm: rmnet: simplify some byte order logic
  net: qualcomm: rmnet: kill RMNET_MAP_GET_*() accessor macros
  net: qualcomm: rmnet: use field masks instead of C bit-fields
  net: qualcomm: rmnet: don't use C bit-fields in rmnet checksum trailer
  net: qualcomm: rmnet: don't use C bit-fields in rmnet checksum header

 .../ethernet/qualcomm/rmnet/rmnet_handlers.c  | 11 ++--
 .../net/ethernet/qualcomm/rmnet/rmnet_map.h   | 12 ----
 .../qualcomm/rmnet/rmnet_map_command.c        | 11 +++-
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 60 ++++++++---------
 include/linux/if_rmnet.h                      | 65 +++++++++----------
 5 files changed, 70 insertions(+), 89 deletions(-)

-- 
2.27.0

