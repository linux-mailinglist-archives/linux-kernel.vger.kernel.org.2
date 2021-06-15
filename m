Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A026C3A8B06
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhFOVXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhFOVXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:23:31 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADB0C0613A2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:21:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o10-20020a17090aac0ab029016e92770073so454462pjq.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PfwRUU7eVNZsvc9b0Pp6xofj5lHce4If1zuLClVqHds=;
        b=k41872DXg9wkp86KhOxBvcu0Ci6VIoYHAyuQo8qqIykaP05jTvRdRw2iM4HROlZWB9
         v/xBFRgNloNRzQQcKx3HdBPMzLzERLP/q43nxD2Z3VGshkG8KI6qgVYIawdS4aeRCUUN
         QY+xm4+6E8MDYk5JQid0hjit2pFbHdVbRZWXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PfwRUU7eVNZsvc9b0Pp6xofj5lHce4If1zuLClVqHds=;
        b=h5htzwlrrjlQVBkE9LJyOjHxa/ShltLiHg6URKucCpBgFUANbdjZbHqejBUUGxsd07
         1TK61EDm3ZFQKb3TxXFOdXX4GpcaTDZbTFTla/I+eHgtSXbM+l9disC6wuFUmaWld4SI
         3pJKiuazW79H47TUi1LlXKa+PMJnwQwpe86zSCCvJijmzwMiDMd5Q4fGXbA73VB0hl30
         i0EkASt/e8tv3gblYaTW9HHENgWgSzzYR7XoqeViguLMSOqv4Qalu8so3vFsuXfvA4Eo
         e79SZeSdtbgGD6JXyrVZg2eL7RuuWQeQl61hdBibBB4eXYu7sUQH44oEuZ5UR1u5TtbO
         5v8w==
X-Gm-Message-State: AOAM533Ev+ejQVZ6HIc9niJore/QNNHUlcT5cVnQUwbul8zQmp0WD+FV
        /FA/HND0ShgsplJgv2/c1pEvVQ==
X-Google-Smtp-Source: ABdhPJxpvHbLjArJ3owM3JpRLH76Noir2n39FVfDmLx1tALshgWOs9Zy3GRdpG3sW+GGql2IjG+4vA==
X-Received: by 2002:a17:902:7c05:b029:11c:1e7d:c633 with SMTP id x5-20020a1709027c05b029011c1e7dc633mr4646731pll.48.1623792085105;
        Tue, 15 Jun 2021 14:21:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v9sm96686pfn.22.2021.06.15.14.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 14:21:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, gmpy.liaowx@gmail.com,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-doc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/4] Include zone in pstore_device_info
Date:   Tue, 15 Jun 2021 14:21:17 -0700
Message-Id: <20210615212121.1200820-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This fixes up pstore/blk to avoid touching block internals, and includes
additional fixes.

-Kees

v1: https://lore.kernel.org/lkml/20210614200421.2702002-1-keescook@chromium.org

Kees Cook (4):
  pstore/blk: Improve failure reporting
  pstore/blk: Use the normal block device I/O path
  pstore/blk: Include zone in pstore_device_info
  pstore/blk: Fix kerndoc and redundancy on blkdev param

 Documentation/admin-guide/pstore-blk.rst |  14 +-
 drivers/mtd/mtdpstore.c                  |  10 +-
 fs/pstore/blk.c                          | 371 ++++++++---------------
 include/linux/pstore_blk.h               |  27 +-
 4 files changed, 141 insertions(+), 281 deletions(-)

-- 
2.25.1

