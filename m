Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDEA32CA4A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 03:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhCDCCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 21:02:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232818AbhCDCBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 21:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614823196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=67CmUKUe+TmQG3UkcCcwTlXVexG5QMLko4/9hpCBQsc=;
        b=XsW4PYFDwC67Bk9Mi3ugW2TUb8mbe1MXabEjASqHn8x6ODXTcExz/o4HPbURzcgwfmPJWc
        oP/bhNJKKJbHvt3uOF7mm3uixYGlLd6ZH2WpmRoHZMRXNDeycWTcD/o0W0asnV2+L54iRZ
        ussL/iN7mmsEGEsgRWKbiMTkuGKFaks=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-7sj3XE10Mp2EzkZPvfZ1pg-1; Wed, 03 Mar 2021 20:59:55 -0500
X-MC-Unique: 7sj3XE10Mp2EzkZPvfZ1pg-1
Received: by mail-qt1-f198.google.com with SMTP id b21so9557148qtr.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 17:59:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=67CmUKUe+TmQG3UkcCcwTlXVexG5QMLko4/9hpCBQsc=;
        b=hd2R6bG1Y/12nw2LVPLDR0UVnzsVXITS4/px/+8OiVeDxwEDCuuyU7MlC9PGBug9mz
         oVK6gS9navKsiC/xRVUecA8UCknqdUca8RQ50sStk4eGL0R6Yi9vMRbRQLvEUv2dhnXQ
         HThMCyqVVSxHLiQqevMzSY3S/Vr4L7fNi01ad648zdyWJNP42mGJw/9Va/6xBdrcQ65T
         Ouj9GGPOq/MQpd0SMScwBoQyYL20ovEfcctAbPg16pVczrbLB5r0OaESzoXaRa6uur2X
         aIdPLPkzN3+9eRo6cidbF3uDqW7gT22hIp+pHQxuHXtvyCIFSUXEcSPq4qZLSJ0k6z4p
         TX5Q==
X-Gm-Message-State: AOAM530f45LkoZEtUiyGz/SMYbBRQGHXKJ4nyNs2CGRqrd4Ox3dOdM23
        oI9kzXjEgofXuJZp9ZTFhpw41DM8qMSwfO7RED9VkaqNuwnvkTW1sxBdzIbglkrQVSv9Nr62h1/
        Ehw7RgDgs4Vf7DH2kiJhEPJWh
X-Received: by 2002:a05:620a:887:: with SMTP id b7mr1915872qka.215.1614823194811;
        Wed, 03 Mar 2021 17:59:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxo2VGf7bBuTU7j/MVXQgMA7Qwe9+C87OoGoXi+q2ohdE1GsIQSeuTM/aQKjlxmq66uapauvw==
X-Received: by 2002:a05:620a:887:: with SMTP id b7mr1915861qka.215.1614823194633;
        Wed, 03 Mar 2021 17:59:54 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id b7sm18610766qkj.115.2021.03.03.17.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 17:59:54 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-man@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linux MM Mailing List <linux-mm@kvack.org>,
        peterx@redhat.com, Axel Rasmussen <axelrasmussen@google.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [PATCH 3/4] ioctl_userfaultfd.2: Add UFFD_FEATURE_THREAD_ID docs
Date:   Wed,  3 Mar 2021 20:59:46 -0500
Message-Id: <20210304015947.517713-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210304015947.517713-1-peterx@redhat.com>
References: <20210304015947.517713-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFFD_FEATURE_THREAD_ID is supported in Linux 4.14.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 man2/ioctl_userfaultfd.2 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
index 47ae5f473..1965d1932 100644
--- a/man2/ioctl_userfaultfd.2
+++ b/man2/ioctl_userfaultfd.2
@@ -208,6 +208,10 @@ signal will be sent to the faulting process.
 Applications using this
 feature will not require the use of a userfaultfd monitor for processing
 memory accesses to the regions registered with userfaultfd.
+.BR UFFD_FEATURE_THREAD_ID " (since Linux 4.14)"
+If this feature bit is set,
+.I uffd_msg.pagefault.feat.ptid
+Will be set
 .PP
 The returned
 .I ioctls
-- 
2.26.2

