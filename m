Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0848644BCE1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhKJIcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:32:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229791AbhKJIcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636533004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZFcWdRsz7OaakLNSt9pmiFaVGZ1WxUx5Us6fbMaYsT8=;
        b=B8AEhfi/oDYnTFDt2Zs4/cGbHoj20wQpY1H63iS524d2F3ds8KbslLXlm+sLxnJbzchojM
        lkNJzsmduI84+LDLt8glEOAPbGKtV0lX88rKlB3bKilsMfMjIzq0EtSS74bEqP1O9/2wIV
        C1WtEnI7sX9rofoobpVk2JUl9qmsRv4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-AHufwAS_NxS7U5c2G9FcxQ-1; Wed, 10 Nov 2021 03:30:03 -0500
X-MC-Unique: AHufwAS_NxS7U5c2G9FcxQ-1
Received: by mail-pf1-f199.google.com with SMTP id h21-20020a056a001a5500b0049fc7bcb45aso1557406pfv.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZFcWdRsz7OaakLNSt9pmiFaVGZ1WxUx5Us6fbMaYsT8=;
        b=H4zgcF6EwGkbq+xISrZtl7LO4u4VHUEyx4IufwI0RUzvHrTSXYmjJ8kC49M5/mm5jV
         8cUhYArgXiOFhX8+Zqi3l93+U+M9BR8VsjA6SKriJsN0GQ2mB7wCT0zjH1tcI7eF1Vo0
         P8YbrhPRjpfxSH117Wp3HFpHHpm5kOGfYer+JI7WCPLMnp8Zog1ZLUWwPER/w18rzK8M
         cvvpKRUK9BtfmAhQKdYQDt7bmkFrsMECUVqxM+Rv/5Q5thUp/mE3lhVJkmCXgVeIPIri
         pQ6uZ4gxmUz8YBsLRhxhJ4ySZfEK4Yray+HLLdkNgV5AFAd6bMGPfuPPBqILg1e+HLAU
         RYyw==
X-Gm-Message-State: AOAM5312OVVz1wMmKz+4YaIN9Sjh1B9Y1YXBsDUUHEalyoF8C7YdVOkT
        5ptP2w4xpen4gZedEZgLTcOwLsvO6nsjD6ZKSvVsTmt3IPsEWjGc2bQH+ux715s37LcGI3avcYM
        cC/OXdurTKMswthuml5Aagkpj0//ujQjUO0FbZy+hPwHidzAuaU15IX1Vfs8jPvsM+t5tGao6Og
        ==
X-Received: by 2002:a17:902:a50f:b0:143:7dec:567 with SMTP id s15-20020a170902a50f00b001437dec0567mr5309247plq.18.1636533001855;
        Wed, 10 Nov 2021 00:30:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEERck+ZH1HW6dD3qoJ6BXiElxaGglbRCS3RSwZktnCqTK+ZBWrGu2dU61vN+ChCkGIUOkGw==
X-Received: by 2002:a17:902:a50f:b0:143:7dec:567 with SMTP id s15-20020a170902a50f00b001437dec0567mr5309214plq.18.1636533001499;
        Wed, 10 Nov 2021 00:30:01 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.35])
        by smtp.gmail.com with ESMTPSA id s7sm23709986pfu.139.2021.11.10.00.29.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 00:30:00 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH RFC 0/2] mm: Rework zap ptes on swap entries
Date:   Wed, 10 Nov 2021 16:29:50 +0800
Message-Id: <20211110082952.19266-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this small series is to replace the previous patch (which is the
5th patch of the series):

https://lore.kernel.org/linux-mm/20210908163628.215052-1-peterx@redhat.com/

This patch used a more aggresive (but IMHO cleaner and correct..) approach by
removing that trick to skip swap entries, then we handle swap entries always.

The behavior of "skipping swap entries" existed starting from the initial git
commit that we'll try to skip swap entries when zapping ptes if zap_detail
pointer specified.

I found that it's probably broken because of the introduction of page migration
mechanism that does not exist yet in the world of 1st git commit, then we could
errornously skip scanning the swap entries for file-backed memory, like shmem,
while we should.  I'm afraid we'll have RSS accounting wrong for those shmem
pages during migration so there could have leftover SHMEM RSS accounts.

Patch 1 did that removal of the trick, details in the commit message.

Patch 2 is a further cleanup for zap pte swap handling that can be done after
patch 1, in which there's no functional change intended.

The change should be on the slow path for zapping swap entries (e.g., we handle
none/present ptes in early code path always, so they're totally not affected),
but if anyone worries about specific workload that may be affected by this
patchset, please let me know and I'll be happy to run some more tests.  I could
also overlook something that was buried in history, in that case please kindly
point that out.  Marking the patchset RFC for this.

Smoke tested only.  Please review, thanks.

Peter Xu (2):
  mm: Don't skip swap entry even if zap_details specified
  mm: Rework swap handling of zap_pte_range

 mm/memory.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

-- 
2.32.0

