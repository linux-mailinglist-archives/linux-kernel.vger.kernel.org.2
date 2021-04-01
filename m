Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07753522B3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 00:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbhDAWQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 18:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhDAWQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:16:23 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5897BC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 15:16:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j25so2439092pfe.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 15:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jKf/bIRuPNdm99ftg+yWOdYdbkeJfbztmf6+BPi3ElY=;
        b=X76vwLT0ntTAWOqsz8Btk1VEg5vPVNk1nmpwaxxyJIF09eN/IEPp6XA4T4ZI8ptzaT
         hSZYH0ORceccsuZI3SHstGm+vUz3jALF7vsVgUjDxxQ+DVHEFVO2AWGiewl38t/dCDQ1
         2bSGeikoQ6Wd51f6QWHVm9Teoh7rXDH6YR6XPgwyn2lrDSh07m9aW8/QLobKMN+hYHKB
         i9hIj53hO3YLAgW+Fi8mHMLsV9nIYUFPVLhiNo243JP9DWwjWfbMKr8SjEBhfPEC3VUr
         SqhKadcZ4++9/0pUePggaXY9fcd3hsqMvufm08Habk4J0SZgYEw9u0tCNsww0CbX5v2r
         NEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jKf/bIRuPNdm99ftg+yWOdYdbkeJfbztmf6+BPi3ElY=;
        b=o8pODQIx8jUScrmeYD6VsSsH09VKIneNlBDWx3ExaAphBb4kASPNgwkgnnhK0xZNbN
         sTUGwDbCvDbay/R1wFBX8+fn2mCiKLUeV8FXIJJ4AulvqB4QH8MjrL0EJx/6WwVSpSXz
         t5pRLCtiTXySUCvrGtr9aftbL+lErusSwK0Bi5PxXOPwncetmS+7yHciC84jrhSKwvsr
         uvnEPrYDtSPEom5d1MHSnXaDMSv7txXrgUZUC2eVBrJsxE1GGNbqaYG86gG0Inu5fBU0
         1rDSjcDvVzwhHGCQ8PfQHPHQ4OE+eAZgQTst1Lhtwvb8xVmK9Ki55ITUKxlJqdHtvCtM
         lsYQ==
X-Gm-Message-State: AOAM531DjTjFBcnFBW7vz5WJScDny93FrCLw9wLcAVCjM9G9DBOCU/4/
        SNGQs4oAAgbpTYf2p1HaHJw=
X-Google-Smtp-Source: ABdhPJwq98b+N3OmXaW1KI7KAXTj63JC2IIm3/JD4nBy0uhhR/VSx5K0dj+qF9ws4h1GNTJxnpQCqA==
X-Received: by 2002:a65:4c43:: with SMTP id l3mr9284964pgr.327.1617315383009;
        Thu, 01 Apr 2021 15:16:23 -0700 (PDT)
Received: from djbComp.hitronhub.home (S0106ac202ecb0523.gv.shawcable.net. [70.67.120.89])
        by smtp.gmail.com with ESMTPSA id d13sm6671494pgb.6.2021.04.01.15.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 15:16:22 -0700 (PDT)
From:   Deborah Brouwer <deborahbrouwer3563@gmail.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, fabioaiuto83@gmail.com,
        dan.carpenter@oracle.com, phil@philpotter.co.uk,
        amarjargal16@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>
Subject: [PATCH v3 0/3] staging: rtl8723bs: core: block comment style changes
Date:   Thu,  1 Apr 2021 15:15:39 -0700
Message-Id: <cover.1617314121.git.deborahbrouwer3563@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Style changes to block comments.

Changes since v2:
	- add subsystem/driver prefix into 0/X email subject line
Changes since v1:
	- all commit messages more accurately describe changes

Deborah Brouwer (3):
  staging: rtl8723bs: core: add comma within a comment
  staging: rtl8723bs: core: add * to block comments
  staging: rtl8723bs: core: remove empty comment

 drivers/staging/rtl8723bs/core/rtw_xmit.c | 61 +++++++++++------------
 1 file changed, 28 insertions(+), 33 deletions(-)

--
2.17.1

