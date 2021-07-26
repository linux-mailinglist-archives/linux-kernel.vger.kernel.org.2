Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2904A3D680A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 22:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhGZTjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 15:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbhGZTjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 15:39:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3954C061764
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 13:19:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n192-20020a25dac90000b029054c59edf217so15511321ybf.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 13:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GsN8HCqVh5N8aSJwsQzyNpefHB2pESiItXifSlAmSSM=;
        b=gJdCKTbk2C37vKwDcBCzX6vy3NgrJaCdDO8ylX4jL5Efkl2THEgpciZ+Gfqpi1pNu+
         uz26sJGw6z1vPs7dtWhk3sYsIs7+y9MTiHK5v5yI865S++oSd16Nctp8n7nUT3Zj8zzi
         6QLaLHEEcBGQrCRMx7m+rBZ3I//g9e+H6PPfSwhHOcYcQS9yh5jeI/vbv5ydjBavNrJj
         YRem8g5HR3BObvLbZY4p2i6KNKemqng7M1oG5CxGQFLuez26dnrjalCM9GaZH58s/TzH
         7JwmhrgZ00ztjpGMEkzhVpegunGGT7RAb+M41Lv048GixgOjdctrvQDap6++zAdAeABt
         zxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GsN8HCqVh5N8aSJwsQzyNpefHB2pESiItXifSlAmSSM=;
        b=CtI9I+oWggvHexCMOqUEdZ9Wq5RlMneBO3Qf3Bxs+NwF2Xj8bxQx4/gLkfcBzpQrnK
         990AkQPBA7EkliPjavAtaqUVeoUwM3i2xJ3fic5T/VvQbcRb8vjllB2GBripLxMniYun
         UBnny3f2EB7Um7fTxTAbN3Owua4YTFwRy4nNWI1WS6RqScmON2yNZL9LmAIkA+ktOQgh
         Algy2Z/n4tDlINkPQoz9k+DmbhXQxsAx0Ffrv6LzrvGb/zjn1l99H3WxhYkvA3S4x+iC
         DdR1vdSUqMSTjauwNhY+FvQ4HFytdbXzqKT8EGZ7/Gb83niEHwtU2czhVlifJ58dy/nz
         BcRQ==
X-Gm-Message-State: AOAM5323GK1tzrfDELZhLmmWDbvw42VW+l6QC8U++/13kHWSj++Z1iyR
        v/1rK4E8q5K8sCP0iHtsiqwiRhjKLg6CAkbMkgvq4ot0q/nl92uTTzrA2ngjqaMGMzMWU4NFk4k
        BAq3dRQ25m/f4ILAr5yXiCfgG13RWnC8Bn4PYI/RVz9L4pmDCfIe/rEK9un5AeJGVWw==
X-Google-Smtp-Source: ABdhPJyOQYwh3EiuCdUYc7I7SF9y2w6LHgoEfYxWl8nVzf1ebeI5lLJPSEbw4ycEaE0y5KP0ZO54TwepYg==
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:ccf7:db54:b9d7:814f])
 (user=morbo job=sendgmr) by 2002:a25:ba10:: with SMTP id t16mr26601022ybg.87.1627330767966;
 Mon, 26 Jul 2021 13:19:27 -0700 (PDT)
Date:   Mon, 26 Jul 2021 13:19:21 -0700
In-Reply-To: <20210714091747.2814370-1-morbo@google.com>
Message-Id: <20210726201924.3202278-1-morbo@google.com>
Mime-Version: 1.0
References: <20210714091747.2814370-1-morbo@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 0/3] Fix clang -Wunused-but-set-variable warnings
From:   Bill Wendling <morbo@google.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-scsi@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-everest-linux-l2@marvell.com,
        "David S . Miller" <davem@davemloft.net>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches clean up warnings from clang's '-Wunused-but-set-variable' flag.

Changes for v2:
- Mark "no_warn" as "__maybe_unused" to avoid separate warning.

Bill Wendling (3):
  base: mark 'no_warn' as unused
  bnx2x: remove unused variable 'cur_data_offset'
  scsi: qla2xxx: remove unused variable 'status'

 drivers/base/module.c                             | 2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c | 6 ------
 drivers/scsi/qla2xxx/qla_nx.c                     | 2 --
 3 files changed, 1 insertion(+), 9 deletions(-)

-- 
2.32.0.432.gabb21c7263-goog

