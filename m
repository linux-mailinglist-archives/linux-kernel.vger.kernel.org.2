Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B0D41D335
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 08:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348282AbhI3GWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 02:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348267AbhI3GWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 02:22:12 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D60AC06176A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 23:20:30 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id d12-20020a05683025cc00b0054d8486c6b8so6036400otu.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 23:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=HiybMtL3oTOqhfbzpPHAJ82Ac6PGi35Tix6YKtj/MUY=;
        b=WnAs56WTHuame0wISzaU1D/eX+SGWlP7Wu3CcXRT8U/GA+4+dJsAhPvIUpWlUbmiaa
         Ka2IEb9O73r4piCt3uIbjVrzgZ3ZqBUFwTME0twyG3c/DAXz8SMaFRIBFNeMbyhHYACd
         JgwFyW8o4Lz3jabhEMLRfcYvkJa/ZsEotAS/f/VS41cm3So6figvx1bZdZHhRbw1g3el
         7Xcce7AmZlP8QEeOTg+QFHr4dekxE/H5fzFiXUsmBtS6YFs6HVJL0Q9FbVpkNXz0qNLu
         ZuDK57bK2dXOtyEZyiheD+y+PlkB2BsGjuh/nJtgnuKuerKK38ZBod/Rvur1I8wc99wW
         EAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HiybMtL3oTOqhfbzpPHAJ82Ac6PGi35Tix6YKtj/MUY=;
        b=wqcJED/ok8yyeRhBGlQJL63SbaOLDOnKrxJ8aAa9XTG1nqaWB0B+rwlMoi8TcXyqKM
         nfvp5jYClH58R2W4lD+I/wU/CkG3zSxz7ZzVvsy4j+D4cU8HqTXGHBgrjrGDvxIMD44p
         wR/bqvkJzCfy2/VpilG/CLG1bA3fB6CaOpUJsp5nNCg7YkpCohGnd4hAdi7IDdMhC4/n
         K7ztytM0g/gD5wM1AkKfC8SH91UcZ6NsEbNunKnBOKM/Cjx58QefjyM/5xRSW13ku90i
         qc8Lxfj7NaTMP8bfRXv4hXmZB0b0oD7c6nFBmFJIPKAk5Y4jxSm8asZXdi3t3r89V9SG
         UJyA==
X-Gm-Message-State: AOAM533AJwZ5TKWZAu3BUgCoJpy/OWRipM1F4kIe3hDF/Il2mcPKhR9A
        M5Yq7/6bG0H1SYVu0x7vl4Lmzw==
X-Google-Smtp-Source: ABdhPJy3Nqgd6MRL81ECqIQqY6DRWIZ+hD9vIeH8yHHvPsFEreTwXeQsyGNYWH6if9e/Wa/v1gWXLQ==
X-Received: by 2002:a9d:1913:: with SMTP id j19mr3740651ota.166.1632982829691;
        Wed, 29 Sep 2021 23:20:29 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id x4sm421228otq.25.2021.09.29.23.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 23:20:28 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Shunsuke Mie <mie@igel.co.jp>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Maor Gottlieb <maorg@nvidia.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, dhobsong@igel.co.jp, taki@igel.co.jp,
        etom@igel.co.jp
Subject: [RFC PATCH v2 0/1] Providers/rxe: Add dma-buf support
Date:   Thu, 30 Sep 2021 15:20:13 +0900
Message-Id: <20210930062014.38200-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an user space counter-part of the kernel patch set to add
dma-buf support to the RXE driver.

Pull request at GitHub: https://github.com/linux-rdma/rdma-core/pull/1055

This is the secound version of the patch. Change log:
v2:
* Fix code formats that were indicated by Azure CI
v1: https://www.spinics.net/lists/linux-rdma/msg105380.html
* Initial patch set
* Implement a callback function for reg_dmabuf_mr

Shunsuke Mie (1):
  Providers/rxe: Add dma-buf support

 providers/rxe/rxe.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

-- 
2.17.1

