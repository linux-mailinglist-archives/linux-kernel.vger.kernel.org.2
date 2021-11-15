Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F309D44FFBF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbhKOIJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:09:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52548 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235166AbhKOIHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636963448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c0+U3p8s/OABhw6SAh8P2t+DkAujdKbUA9hOXLSGPzE=;
        b=Sg8DmQ5O5dor0Bg+yNDJTVNtybLx/wknLH2r4sydO5MTxF2Zb/j4475Bnao/xeQNnd0yjY
        X1BZlsMOvMOE/CX2/dbF0+Yz5TtLWiV97mbiKbr2dkcBe5NNoIajpt95VoLlorqDG/ZKwH
        StM9KmJfE4J21brfM4sULq51xMpVItE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-p6i79mn8PTaHvF27TkBkeg-1; Mon, 15 Nov 2021 03:04:07 -0500
X-MC-Unique: p6i79mn8PTaHvF27TkBkeg-1
Received: by mail-pl1-f200.google.com with SMTP id k9-20020a170902ba8900b00141f601d5c8so5865829pls.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c0+U3p8s/OABhw6SAh8P2t+DkAujdKbUA9hOXLSGPzE=;
        b=cV507/MPw4OY4wJ3psOan/EHbEfavAqB/aCw6HI/1guEjX44z9Zwpg8vYYU420J7nm
         7Jv6DplvKGRj+wq95hGKjEzDy1z9DFZfxP2ORIlTjV7sZoimdlMJVtugFXixfc9XWs2n
         T+6sfv59mbn9mmD8Q1uoTcedBHhBBtQ04OcQCT9h6gASItKh/87REMXNjb1ywbU+Xffy
         8i2e1hrQ780Tsx8lO9IEKq93mAoJiyeozyBJwJDLcgDC09npIycZTAFev2FIOIyeQne/
         U5AK+ic/Ouenb59oS64EUNVl+GDg7a8JFLa0tcosJmRXnpdE+QQGObZrp0LrKmqOwBjC
         J3SA==
X-Gm-Message-State: AOAM531y43QUBgRo8KLI0kuGYrNbCAY90EmwXWN6mt+1k3MDmdLdTgvA
        uHDNp1+n42YxGVP096XuanXxv/iihrsSE/VwjR8nRRCVUPLmlF0WisjcMUTxyldc+1uJEi0LzIh
        sjPNKXJ+HnFXC1A/2ANWKADRu
X-Received: by 2002:a17:902:b7cb:b0:141:b33a:9589 with SMTP id v11-20020a170902b7cb00b00141b33a9589mr33256272plz.9.1636963445978;
        Mon, 15 Nov 2021 00:04:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTzcWj62pK1w0Vg8ojQeBIVMs39QWhoC3KUqbkNjXYhPKFdP/63f8P+4EzznoW07+f/8ytsw==
X-Received: by 2002:a17:902:b7cb:b0:141:b33a:9589 with SMTP id v11-20020a170902b7cb00b00141b33a9589mr33256249plz.9.1636963445748;
        Mon, 15 Nov 2021 00:04:05 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.89])
        by smtp.gmail.com with ESMTPSA id c9sm10948505pgq.58.2021.11.15.00.03.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 00:04:05 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v6 22/23] mm: Enable PTE markers by default
Date:   Mon, 15 Nov 2021 16:03:53 +0800
Message-Id: <20211115080353.75322-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PTE markers by default.  On x86_64 it means it'll auto-enable
PTE_MARKER_UFFD_WP as well.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index f01c8e0afadf..401e4dff5f42 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -898,7 +898,7 @@ config SECRETMEM
 	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
 
 config PTE_MARKER
-	def_bool n
+	def_bool y
 	bool "Marker PTEs support"
 
 	help
-- 
2.32.0

