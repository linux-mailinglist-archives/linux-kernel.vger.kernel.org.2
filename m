Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1976D4605E2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 12:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352086AbhK1LYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 06:24:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235611AbhK1LWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 06:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638098340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UGK+Dn6UZl9sr7vGdBkJU4cqFeth9dYn+pKxQkt6tRs=;
        b=eJMHp7tQlsWEWGpfub7gBbnOZ18x3OYp+wzpFUHSNA9JzkIrriLy+dsgTtphG1F7RpjJ4I
        4KGL/wsF/gcimWflxv6elQmrifGRfWzp/yAQWOqfPBMN/TyNOSi/WB8GrQ03x/CrVaY4os
        oLQS7fHMMF1zTSaBB4oH085oT15g3yI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-oWx_jglROaGSvA8_QSgh_g-1; Sun, 28 Nov 2021 06:18:56 -0500
X-MC-Unique: oWx_jglROaGSvA8_QSgh_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E98B1006AA0;
        Sun, 28 Nov 2021 11:18:55 +0000 (UTC)
Received: from starship (unknown [10.40.192.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DADEC60854;
        Sun, 28 Nov 2021 11:18:53 +0000 (UTC)
Message-ID: <e52068a6e98031a386b5052a166a55c94fe940f6.camel@redhat.com>
Subject: Commit 'hugetlbfs: extend the definition of hugepages parameter to
 support node allocation' breaks old numa less syntax of reserving hugepages
 on boot.
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Zhenguo Yao <yaozhenguo1@gmail.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 28 Nov 2021 13:18:52 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


dmesg prints this:

HugeTLB: allocating 64 of page size 1.00 GiB failed.  Only allocated 0 hugepages

Huge pages were allocated on kernel command line (1/2 of 128GB system):

'default_hugepagesz=1G hugepagesz=1G hugepages=64'

This is 3970X and no real support/need for NUMA, thus only fake NUMA node 0 is present.

Reverting the commit helps.

New syntax also works ( hugepages=0:64 )

I can test any patches for this bug.


Also unrelated, is there any progress on allocating 1GB pages on demand so that I could
allocate them only when I run a VM?

i don't mind having these pages to be marked as to be used for userspace only,
since as far as I remember its the kernel usage that makes some page unmoveable.

Last time (many years ago) I tried to create a zone with only userspace pages
(I don't remember what options I used) but it didn't work.

Is there a way to debug what is causing unmoveable pages and doesn't let
/proc/sys/vm/nr_hugepages work (I tried it today and as usual the number
it can allocate steadly decreases over time).

Thanks,
Best regards,
	Maxim Levitsky



