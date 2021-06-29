Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84F43B7417
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbhF2OTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbhF2OTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:19:16 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CAEC061787
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 07:16:48 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id d21-20020a9d72d50000b02904604cda7e66so21030504otk.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 07:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fLvw6r9+pMXu01qZnvolo+M/6gBx74Mw6gbbfYI0vNE=;
        b=sZH9XyEzV+qpkKYW0Hf3jHU2x9M8wd/Gd0BuiQ920KEe4FXSMxyzWiPkQtoshBzb31
         MUM46b3n13Nr1ZkcS5CDtBoLRhoB6NlvR6djKMlKmnvk/DCsS4fKpKnbRzuijUl6xZZx
         BaRnxq33Y+Lu2QLQtkm0fGXdUbjBD+NERyQAeJ5C1XpOF4ozXgw5jiyCstNDlbRGMZ8+
         xAJJROx7gU52r4833nxQ6mEMmmwsY1R4kbrjK8+ORCGl3AOxaIMW2obQQRH6OaREm/Zk
         DgVw0Q7MEXHnVUNXtoaLvY0rirD6Ad2fRkWHgodW25tigyUvf5Oo7SqJ37HAPUHo/Sci
         NyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fLvw6r9+pMXu01qZnvolo+M/6gBx74Mw6gbbfYI0vNE=;
        b=WUwQSUMQf26/IzjFf0up0HExf/sSWQpjbfoPwY0FUTsxfNLbrmJlLIaAC+EMGcHLEM
         /AhayyXz/f8yutjyfOKnC0h0W/DdxgcQJ5uIrcSklP1CfuI2DHwrAJl+q2NVuri15ywe
         wI6DTYZZqTUnaKUz5r8N5L5jKg2T1umHWHuLeeTs2D9t7zVnoo4iKBXrQhWCf7vxdekd
         LxQRYi6pLUdvndUbheU1qUpxfbCPd9C0cCM2x16CXEmsqiCHpFXw6BA5is9U2uw9b5ze
         blpP6RUer8qoGi5S7s1GdZlMLv8r6XpWoRhZif3BwBcglaUbk55xwBlKRrrB1F+fh9ed
         lUUA==
X-Gm-Message-State: AOAM530TWW09j0ZjrmAUyKYRbrR1dnvrQh043meHfXfF3TRCpEICTeYn
        DrJtbkzuyWzMasd4GE+Hytk=
X-Google-Smtp-Source: ABdhPJyvmtXayFLuHFLtufN3ob5ZSIGXpyeP9HPXwuL28oyTFMMLuPbqbuvqigsd9L23KG2EulSYEA==
X-Received: by 2002:a05:6830:14c5:: with SMTP id t5mr4752259otq.272.1624976207584;
        Tue, 29 Jun 2021 07:16:47 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-aaa9-75eb-6e0f-9f85.res6.spectrum.com. [2603:8081:140c:1a00:aaa9:75eb:6e0f:9f85])
        by smtp.gmail.com with ESMTPSA id v42sm4093149ott.70.2021.06.29.07.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 07:16:47 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-kernel@vger.kernel.org,
        leon@kernel.org, galpress@amazon.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH resending 0/2] Providers/rxe: Replace AV by AH for UD sends
Date:   Tue, 29 Jun 2021 09:16:41 -0500
Message-Id: <20210629141643.14763-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches contains the changes to the rxe provider to match the
kernel patch series with a similar name.

Bob Pearson (2):
  Update kernel headers
  Providers/rxe: Replace AV by AH for UD sends

 kernel-headers/rdma/rdma_user_rxe.h |  16 +++-
 providers/rxe/rxe-abi.h             |   2 +
 providers/rxe/rxe.c                 | 117 ++++++++++++++++++----------
 providers/rxe/rxe.h                 |   8 +-
 4 files changed, 100 insertions(+), 43 deletions(-)

-- 
2.30.2

