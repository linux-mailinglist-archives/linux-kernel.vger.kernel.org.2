Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FE5340743
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhCRNwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:52:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231376AbhCRNwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616075550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K3FmGDDjg4x6Qh11aJHy8AEuyBdl8B9I2jc7mXW+DQQ=;
        b=gHi7jrEYyhRr17PmZMvRpxm4iye0ed0lt5R8haMFrpoolDRLIiDiDCO1/SiX/rJnOsG2Kd
        MBKhHetEfXGfxsXOTks8hSix0YrWEDw8+uADrOO6FfH9dfunZuzWDjg04QXHMouXYIgTDW
        XtHb90qkjXp6+xw5Qukcq/YvehNZmng=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-12JKo4fIONmEvJ3s7M5ZVQ-1; Thu, 18 Mar 2021 09:52:28 -0400
X-MC-Unique: 12JKo4fIONmEvJ3s7M5ZVQ-1
Received: by mail-oi1-f198.google.com with SMTP id k15so3386478oig.19
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 06:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K3FmGDDjg4x6Qh11aJHy8AEuyBdl8B9I2jc7mXW+DQQ=;
        b=SR1vvAOmCeE69TAAkzAKQ0P+dn4ZX0rTthswotDKVpL+uvk4qkOWsa7kqxHlIJaqX2
         2/LSp+bf3sfq340Ii5B26TEfng8gi5DZYsd/MjAOBa+M2pZhedz05InnqEHKqXAAE1qT
         enITfnWiW3OZMwxjEYbiefX97zShzlafzn4ksQSVRekm2qTGT6lV0/MAyR24/TndMuWW
         03cTLSn8UTEzgi9TcINdRlcSDHpYkueW8F1kGFrFIU9jt+CH8ugLuAgjs0OqpCyV5n1/
         kBG0JLyFo5oySKDeJn9XrTcdNSzkEKOxi3RYC8fzWPGGMIZJwBNm7QwQIyFnOsFyUoMR
         N0Aw==
X-Gm-Message-State: AOAM533wS5Z0d5RQfP9aQHjaPGb/Se2vqMWZxdNGgzO2hhToQbFmqQHj
        KrifFTwpn89rIKAT4nbwIUV2ZNRCkpFenBvVVEjJH5EuBgC445gzsvd/+VoemFhn9pWuwCeFJKz
        w6QXnb8q68+bTjGMH3RXyUsve
X-Received: by 2002:a9d:62d1:: with SMTP id z17mr7347733otk.118.1616075547683;
        Thu, 18 Mar 2021 06:52:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUVm8g2gqvSzP7zKMkWvD+pr2sw5M/w6HMmQg74ODAc1kSZtztAuf92THPXJ0Aw5kJfl5jAw==
X-Received: by 2002:a9d:62d1:: with SMTP id z17mr7347719otk.118.1616075547545;
        Thu, 18 Mar 2021 06:52:27 -0700 (PDT)
Received: from redhat.redhat.com (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id i11sm465342otp.76.2021.03.18.06.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 06:52:27 -0700 (PDT)
From:   Connor Kuehl <ckuehl@redhat.com>
To:     virtio-fs@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        vgoyal@redhat.com, miklos@szeredi.hu, jasowang@redhat.com,
        mst@redhat.com
Subject: [PATCH 3/3] fuse: fix typo for fuse_conn.max_pages comment
Date:   Thu, 18 Mar 2021 08:52:23 -0500
Message-Id: <20210318135223.1342795-4-ckuehl@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318135223.1342795-1-ckuehl@redhat.com>
References: <20210318135223.1342795-1-ckuehl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'Maxmum' -> 'Maximum'

Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
---
 fs/fuse/fuse_i.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f0e4ee906464..8bdee79ba593 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -552,7 +552,7 @@ struct fuse_conn {
 	/** Maximum write size */
 	unsigned max_write;
 
-	/** Maxmum number of pages that can be used in a single request */
+	/** Maximum number of pages that can be used in a single request */
 	unsigned int max_pages;
 
 #if IS_ENABLED(CONFIG_VIRTIO_FS)
-- 
2.30.2

