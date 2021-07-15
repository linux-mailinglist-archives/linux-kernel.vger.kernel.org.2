Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02133CADED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhGOUd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:33:29 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:34681 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhGOUdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:33:25 -0400
Received: by mail-pf1-f181.google.com with SMTP id o201so6637017pfd.1;
        Thu, 15 Jul 2021 13:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6MHQfyMmD157rdFuCtZcUqKTVmVaMd/eDEZc8fRU9oM=;
        b=iUDKEMzPyPM0sri46w88b0eIDoe5uQa9yft6RpTZatXFuE3dOwbXQoDvrre1/b5Faw
         FVo85XawwRS6xk6CKv85pzU/mzrgCTAIK1SFjL9UB0wnI2E+HPrCJTrjmkkrq64ERWlI
         LuP5xwVJq3/vYeNtAw9G9JZJz1GkpoPnhLtjnEbtx5ClrftyVlc+rnw7zwDEo41OE41f
         Xx5Kx2gRTGOFzdUBc6kqEbDO/20rsuSf69kIGYAFtfS8kcGYTX/kXB1fP1qR0x+v14LZ
         ioKS9CxPnlmH/xn9yytXkCTU34RL2jx4r/Co6Rz/rRFoQAGYdVtJyIi+4YF3IhaXhse5
         Kgvg==
X-Gm-Message-State: AOAM530S3N+wjEl7MTYB8MbgRZGuGj5oJFcEue47bqdFfg08bbrJNEI+
        mTQpM4Cca3VLC4Xv2NIRhfk=
X-Google-Smtp-Source: ABdhPJw2weQu0g4V03JlDrTrup2+hn8cekSZhEYVNWr2sbWxXpmlKMPj/5QPg/h5Wj8XHQ9PxYcqgg==
X-Received: by 2002:a63:df14:: with SMTP id u20mr6314229pgg.348.1626381031794;
        Thu, 15 Jul 2021 13:30:31 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id t17sm7605114pfg.93.2021.07.15.13.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:30:30 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 0/5] block: use flag enhancement for del_gendisk()
Date:   Thu, 15 Jul 2021 13:30:20 -0700
Message-Id: <20210715203025.2018218-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third group of driver conversions for adding *add_disk*()
error handling. In this series we address the new flag added and use
on del_gendisk() so that it's easier to deal with error handling.

Luis Chamberlain (5):
  bcache: remove no longer needed add_disk() check
  bcache: add error handling support for add_disk()
  block/sx8: remove the GENHD_FL_UP check before del_gendisk()
  block/sx8: add helper carm_free_all_disks()
  block/sx8: add error handling support for add_disk()

 drivers/block/sx8.c       | 58 +++++++++++++++++++++++----------------
 drivers/md/bcache/super.c | 23 +++++++++-------
 2 files changed, 47 insertions(+), 34 deletions(-)

-- 
2.27.0

