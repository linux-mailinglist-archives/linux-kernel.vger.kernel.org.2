Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1DB340741
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhCRNwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:52:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231354AbhCRNw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616075548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UprCVl9Z9D+zE6R7kV/byYJErag/BNbjRXXDocssQUE=;
        b=E92tOHy1lbzIH4ujLmvoghKcsntjuBS+03AnqaLAFGlbzrYXZiHzklSJCL2IK7qocI9DiW
        uxdx832oUVDUYITjGOYvThUQ00PaKbpGr5PLjeBAeuia2kGR/D1O5tcqaydnGL6gUmFe7Y
        FELYJEm3PgsEo/m5IRA6kPs9S7oaPYI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-603-ARni0ZGSOEK_SjkJgvOuXA-1; Thu, 18 Mar 2021 09:52:26 -0400
X-MC-Unique: ARni0ZGSOEK_SjkJgvOuXA-1
Received: by mail-oi1-f197.google.com with SMTP id l63so14308501oia.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 06:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UprCVl9Z9D+zE6R7kV/byYJErag/BNbjRXXDocssQUE=;
        b=TD0LF2OqlUDEc0pc8X22/p934OcSMTsBlPPIlJeSlbYVfkO+5Ay+IGyGDF8Czz/Qa0
         A447Adumk6a8d0WUyubxa8I6jKnDYjEPlv9eqig2vA/9PAa17OMPXdIbcn57dHjvZAEG
         bnJYgwfuyxE/RCLZcZ9T5Y4bk5lOI+VCk+CYOdXNegO30TFqoo+JohYumEpNMr2Xy4SR
         g2ptnLtA/XuyPrk7BFdFZehoBoy6kRlL7hqIDC7p71nsot0tT6UQuH9bZwZ7UQA+sHoe
         NNu1UeoI65RvHx2ULRVQQZguLMlPBB8GbEJAtCh9n2kw76PDXMvsS4L6lWGubpMtuwFK
         B5fw==
X-Gm-Message-State: AOAM532rcbN+UComPb0Towslm6B3mY6A0dsDZchITkhcNg4c+AWS78di
        Qw9aKk3IBZXoGXc9OCYqM3DDpa3BjQplnn6qJRQKEXvvw4ai0sYTSGVzO6MMR7zzosO+5UBARq1
        6tFIm0+xbwwZejm/gldWK80B+
X-Received: by 2002:a4a:a74d:: with SMTP id h13mr7581114oom.50.1616075544557;
        Thu, 18 Mar 2021 06:52:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqQKp9ps6vRkAHFyh5PBk8krVl2W3790JAj4xZcjYW5dNRB7Y9EOHxE69gqTWfJuA7/b3Exw==
X-Received: by 2002:a4a:a74d:: with SMTP id h13mr7581096oom.50.1616075544410;
        Thu, 18 Mar 2021 06:52:24 -0700 (PDT)
Received: from redhat.redhat.com (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id i11sm465342otp.76.2021.03.18.06.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 06:52:24 -0700 (PDT)
From:   Connor Kuehl <ckuehl@redhat.com>
To:     virtio-fs@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        vgoyal@redhat.com, miklos@szeredi.hu, jasowang@redhat.com,
        mst@redhat.com
Subject: [PATCH 0/3] virtiofs: split requests that exceed virtqueue size
Date:   Thu, 18 Mar 2021 08:52:20 -0500
Message-Id: <20210318135223.1342795-1-ckuehl@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I also have a patch in this series that fixes a typo I saw while I was
in there.

For testing, I have been using a toy program that performs a readv or a
writev with a large number of iovecs that exceeds the number of
descriptors available to the virtqueue and observing the number of
scattergather lists generated don't exceed the size of the virtqueue.

Connor Kuehl (3):
  virtio_ring: always warn when descriptor chain exceeds queue size
  virtiofs: split requests that exceed virtqueue size
  fuse: fix typo for fuse_conn.max_pages comment

 drivers/virtio/virtio_ring.c |  7 ++++---
 fs/fuse/fuse_i.h             |  7 ++++++-
 fs/fuse/inode.c              |  7 +++++++
 fs/fuse/virtio_fs.c          | 14 ++++++++++++++
 4 files changed, 31 insertions(+), 4 deletions(-)

-- 
2.30.2

