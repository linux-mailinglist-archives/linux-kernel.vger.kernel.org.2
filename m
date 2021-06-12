Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FC03A4F4B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 16:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhFLOkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 10:40:40 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:44790 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhFLOkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 10:40:39 -0400
Received: by mail-il1-f173.google.com with SMTP id i17so8119352ilj.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 07:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9SsP/FSVWhmEl55PCrccXfIl/vofkok6L9FcT1otW4U=;
        b=n7wU8Gchm9Dx7XukryMjjop4ulK5CHS/2q4iGvWWgmRQbuUcX+XWWRSSWeRMNLC+Kh
         tIiikvYaaXl9M+/nnoYvGA2IB7tIPu3YshLxDusN66mZSAxeqyJ7CEhyoy+lkztYjMYV
         L1X3oSCyaXlisR+cqCxCF9DXStF6MSJmGhIk80TUi+WnLK43FcN8sHmGxFXiQzYsk8Wv
         j1MsPxF0ml4fUvok/GXoGhqiFyQ5Sjradz4L85b/VFxvE1Rch/IKxhkZgQzF9vp3irXZ
         Db4GrPf28VZrNdOGbciuC28v+1e+zlDrenRkDCg6NZwHX5/n5M3TuhX7yJlhOU3+fl+v
         bQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9SsP/FSVWhmEl55PCrccXfIl/vofkok6L9FcT1otW4U=;
        b=JiEdkAbXcIrLjMy1bnZ8d1GvumWddB5LmDv/s6M8M5br3ZgFcb48v3EkeJ8yl49pfK
         x7hw8G+TMDcJLV+pB/6T5RZJ4waHazSDEGOmHFC9rl9lgXKqPfXzVSJFmGPIoihBJBGU
         RZT+nxByHN4Md3rmlpJYNjdsfhGS46uZABhn6yPgEz/KJvzEjHsmrD17X6TF5+KQtFJo
         NxZcRbC6NV5ceUZFtS6lO36iDMrHphJ/uvpaEQO9RYwBvh6h4Q2oOmynumuih7rlYAWe
         jId2sMsYV/2KgcrfVqupNbwNNFbSbbrx0suTOURfBbd7Yk1VuOLdvK/pumTKFGyHgYhY
         jYVg==
X-Gm-Message-State: AOAM530ngZp3QR/SPbs6XWYPV7GGZgtKGPYy06gBilj45+jqqv2qqi/7
        4AYqBogAH/UYVkTk9gE9DZB5zg==
X-Google-Smtp-Source: ABdhPJzk9G8fxiOvCLtfXbiRcvFVhcXS7dhcdkex60Ub9oAr0N8Q3lyamx05hAj8FdUyXnX7EjXw7Q==
X-Received: by 2002:a05:6e02:20c2:: with SMTP id 2mr5396998ilq.222.1623508659627;
        Sat, 12 Jun 2021 07:37:39 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id k4sm5126559ior.55.2021.06.12.07.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 07:37:39 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     subashab@codeaurora.org, stranche@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/8] net: qualcomm: rmnet: MAPv4 download checksum cleanup, part 2
Date:   Sat, 12 Jun 2021 09:37:28 -0500
Message-Id: <20210612143736.3498712-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 2 of a large series that reworks some code that handles
downloaded packets when MAPv4 checksum offload is enabled.  The
first part, which includes an overview, is here:
  https://lore.kernel.org/netdev/20210611190529.3085813-1-elder@linaro.org/

This second part of the series completes the simplification of this
handling code, removing unnecessary byte swaps and bitwise inversions
of checksum values, and along the way avoids the need for almost all
of the forced type casts.  The checksum field in an RMNet download
trailer is given __sum16_t type to accurately reflect the meaning of
that field.

					-Alex

Alex Elder (8):
  net: qualcomm: rmnet: remove some local variables
  net: qualcomm: rmnet: rearrange some NOTs
  net: qualcomm: rmnet: show that an intermediate sum is zero
  net: qualcomm: rmnet: return earlier for bad checksum
  net: qualcomm: rmnet: remove unneeded code
  net: qualcomm: rmnet: trailer value is a checksum
  net: qualcomm: rmnet: drop some unary NOTs
  net: qualcomm: rmnet: IPv6 payload length is simple

 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 115 ++++++------------
 include/linux/if_rmnet.h                      |   2 +-
 2 files changed, 41 insertions(+), 76 deletions(-)

-- 
2.27.0

