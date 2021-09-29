Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476BB41C890
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 17:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345341AbhI2Pi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 11:38:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345314AbhI2Pi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632929806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fCsQXHaiBhTWq49Qc34C4OlyaDWuuMUrzPi6iUoflNE=;
        b=B2L/ts4nAlB/lI4saFojEPjqhbJH5njlZDrn35o8T1JLrvob94j71Ku6mSCb1V1hH40O4z
        39zqmyv0/K8XkV+WvJGwX0shgMo6yOnZ5xCGNgJzFSetAlVnUISmnQ+czegBuecYllFMk+
        iR+kxVeZmihjo3GpbS2k+sC7K1orxKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-oH7PXhp8NBeHgGo4-9ZO2Q-1; Wed, 29 Sep 2021 11:36:42 -0400
X-MC-Unique: oH7PXhp8NBeHgGo4-9ZO2Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E5871006AA5;
        Wed, 29 Sep 2021 15:36:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DC0617B4F;
        Wed, 29 Sep 2021 15:36:38 +0000 (UTC)
Subject: [PATCH v2] afs: Fix data corruptor in page laundering
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 29 Sep 2021 16:36:37 +0100
Message-ID: <163292979744.4004896.11826056491597096493.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Can you apply this patch, please?  It fixes a potential data corruptor in
afs_launder_page() whereby the file position isn't calculated correctly for
the StoreData RPC.

Thanks,
David

Link: https://lore.kernel.org/r/162880783179.3421678.7795105718190440134.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/162937512409.1449272.18441473411207824084.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/162981148752.1901565.3663780601682206026.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163005741670.2472992.2073548908229887941.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/163221839087.3143591.14278359695763025231.stgit@warthog.procyon.org.uk/ # v2
---
David Howells (1):
      afs: Fix afs_launder_page() to set correct start file position




