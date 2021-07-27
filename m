Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2394D3D6FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 09:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhG0HFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 03:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbhG0HFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:05:23 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8980FC061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:05:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d1so7451437pll.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aA9KzM1YQpeMy8flwFCJF+abB2VNYPrrTMZe7/kNPGs=;
        b=aDd5cPFiOJD1MYOLMADwtAS2QlfogGnOEPQgTMzb99aWr3VeMZdTAVo8KeO+wRTYGX
         5EWJa4rV6slTdQaxgTnur8K2gZKo0rHsuS1cqREPNoDx1sG5U5nsCAQSFbytUhgOeE44
         hmTXxayBE3CAHh1hAEVu3z6vTnCNMtLPhuIvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aA9KzM1YQpeMy8flwFCJF+abB2VNYPrrTMZe7/kNPGs=;
        b=TsIX430fw4UyioYZ0p3TG0P/cLS+PM5bJu9/x7qYijHlLXFUwibRzPBruhJV+LDlfl
         MbaR9QorN3yB9qohxR80Dei9j+XIY5GhP5xz6LTRM6o1hZG4ASlFQVekwg1mOuQZzEUl
         obJXB3Zbk2JGdCPRKRtyoufa3nPXGD8TZPkTDrvvrPAWpU02eVumje25ZnAy+f98HNxE
         QkGA150tp7+g23+TM7rY1T1Xhr0X2XPmE/X2FpSv2Vt3s/4XDPssgd09NoHJIa1qBQS5
         Z5RODep5DNqlE2vglfLsdkoof4mm6NtqFqQRS7juvgYd85VwPTFJn+q7jR304zWRbawE
         kihw==
X-Gm-Message-State: AOAM531MH6wp9U09rGvhqT6vWyC09cnXx7Vzk+cV8d4whwvwYKbU0DkP
        /yuxNJ3Bnc+VMUIF7G14borBkw==
X-Google-Smtp-Source: ABdhPJw0eV7LCImKcYBCHhHCgwQJSFomf7kjjdphAENe/t3wQ//GyhIGFfrbhjvLU0PSnUA7kVu+KQ==
X-Received: by 2002:a65:5c01:: with SMTP id u1mr22166032pgr.181.1627369522989;
        Tue, 27 Jul 2021 00:05:22 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:ba3e:509b:495:ec84])
        by smtp.gmail.com with ESMTPSA id 30sm2343447pgq.31.2021.07.27.00.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 00:05:22 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 0/8] videobuf2: support new noncontiguous DMA API
Date:   Tue, 27 Jul 2021 16:05:09 +0900
Message-Id: <20210727070517.443167-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	The series adds support for noncontiguous DMA API and
V4L2_MEMORY_FLAG_NON_COHERENT UAPI.

v4:
-- addressed Dafna's feedback

V3: https://lore.kernel.org/lkml/20210709092027.1050834-1-senozhatsky@chromium.org

Sergey Senozhatsky (8):
  videobuf2: rework vb2_mem_ops API
  videobuf2: inverse buffer cache_hints flags
  videobuf2: split buffer cache_hints initialisation
  videobuf2: move cache_hints handling to allocators
  videobuf2: add V4L2_MEMORY_FLAG_NON_COHERENT flag
  videobuf2: add queue memory coherency parameter
  videobuf2: handle V4L2_MEMORY_FLAG_NON_COHERENT flag
  videobuf2: handle non-contiguous DMA allocations

 .../userspace-api/media/v4l/buffer.rst        |  40 +++-
 .../media/v4l/vidioc-create-bufs.rst          |   7 +-
 .../media/v4l/vidioc-reqbufs.rst              |  16 +-
 .../media/common/videobuf2/videobuf2-core.c   | 127 ++++++++-----
 .../common/videobuf2/videobuf2-dma-contig.c   | 176 ++++++++++++++----
 .../media/common/videobuf2/videobuf2-dma-sg.c |  39 ++--
 .../media/common/videobuf2/videobuf2-v4l2.c   |  59 +++---
 .../common/videobuf2/videobuf2-vmalloc.c      |  30 +--
 drivers/media/dvb-core/dvb_vb2.c              |   2 +-
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |   9 +-
 drivers/media/v4l2-core/v4l2-ioctl.c          |   4 +-
 include/media/videobuf2-core.h                |  59 +++---
 include/uapi/linux/videodev2.h                |  11 +-
 13 files changed, 399 insertions(+), 180 deletions(-)

-- 
2.32.0.432.gabb21c7263-goog

