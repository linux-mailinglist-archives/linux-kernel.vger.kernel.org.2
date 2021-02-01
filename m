Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9922A30B380
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 00:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhBAX0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 18:26:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230122AbhBAX0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 18:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612221919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=3NlvvSEK6Q9k5kOj7hFhTGXtCazv2Lc7Wa4M2xagkr4=;
        b=H7QYMsq6/nePKFE31tnmOdn7ufUb4q1aAlbu0q0FZOz1kjVG/PQ9YIbxX9qCbZG9ppqgnm
        dGSH9CR+ng5XZ57AC8M68IMYSz3IXZE5x9V9vDIHoFS5Biwv0dMiYjsTCW0du/lNICo9Pb
        WDsz6l1f5+MSArSlQKTo/E4qF435wzU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-0OtaBacANfu6zrux6NWS0w-1; Mon, 01 Feb 2021 18:25:17 -0500
X-MC-Unique: 0OtaBacANfu6zrux6NWS0w-1
Received: by mail-wr1-f72.google.com with SMTP id u3so11324415wri.19
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 15:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3NlvvSEK6Q9k5kOj7hFhTGXtCazv2Lc7Wa4M2xagkr4=;
        b=RhkeyXGrUlGgUpRM8VMsY4xcg/Vv4no/T+9fsTaEYJsfz/tskPC2lTS0orDYt6CGrA
         G5whFkZy0Q6bl9PuavLXit9qIzxmEXNQU6Q2T6EMOsjr12z6PK0jwLNZO4BtbKzYhPtl
         QAeKrjahT9LCoLAMB52QS681Menr+mcNWdCsLspc0WJfqKFpNPkamq7fGdr62Luzk780
         uZaVeH1Fs55PpJXDksyXLnvgHhmWJlD1RQAnyXST2oBvGXp5rWeq9bemM6A7iINius15
         eP6bfJrpBIVLYdZru14Bkt4eBhs4VG/WN1ldvGyA5IFuLVBy4gN/ZKVl1JoD6uj/hlAB
         Mv8A==
X-Gm-Message-State: AOAM533TetRdXd9UZ7pvUWeFDkLebWGdl7pYoadNZJpmrxChagAleKKt
        Gw+3qzkc+9TzYY97x9HODlENLdgWj5cIFLk6S8J8FHarWwb2hnGICD96K5Nl2c1VA7DxYXI3TLL
        rQnvmjphvZEd0v/b6StUoqJ8i
X-Received: by 2002:a5d:4389:: with SMTP id i9mr20449595wrq.272.1612221914737;
        Mon, 01 Feb 2021 15:25:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4HJP0YlL5i0Gxd468JQgYWduTKkfVlwthOeclSr3eUKT2z3XdRpKPsU0NR9y8yC+/NJR5iA==
X-Received: by 2002:a5d:4389:: with SMTP id i9mr20449577wrq.272.1612221914513;
        Mon, 01 Feb 2021 15:25:14 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
        by smtp.gmail.com with ESMTPSA id z15sm27405334wrs.25.2021.02.01.15.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 15:25:13 -0800 (PST)
Date:   Mon, 1 Feb 2021 18:25:10 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        elic@nvidia.com, jasowang@redhat.com, mst@redhat.com
Subject: [GIT PULL] vdpa: bugfix
Message-ID: <20210201182510-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 19c329f6808995b142b3966301f217c831e7cf31:

  Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 710eb8e32d04714452759f2b66884bfa7e97d495:

  vdpa/mlx5: Fix memory key MTT population (2021-01-20 03:47:04 -0500)

----------------------------------------------------------------
vdpa: bugfix

A single mlx bugfix.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eli Cohen (1):
      vdpa/mlx5: Fix memory key MTT population

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
 drivers/vdpa/mlx5/core/mr.c        | 28 ++++++++++++----------------
 2 files changed, 13 insertions(+), 16 deletions(-)

