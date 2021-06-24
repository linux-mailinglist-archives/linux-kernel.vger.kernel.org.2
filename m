Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CA93B2B6C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhFXJcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231717AbhFXJb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624526980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eNB6QImZTsEUvPv7cFGlcy7hZAaXO3u/PVt8yIynlso=;
        b=KK4u/UPheC0vmdyfDQqJXDJUrN9A5CV/uZzYbn2dikMNpW/eH1QjI7Djdp8jgAINuWttKB
        K/6SPRZYPZvzmiW94EGiDVQyLhRmo8X6DHXkqYY7icP9yBD2EsSW/h57pNYb5pKwHfMdIf
        IyLBV2owFnysA+Mi+5mxXcmCScg6giU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-QAp785duOPGx24QidhDU9w-1; Thu, 24 Jun 2021 05:29:36 -0400
X-MC-Unique: QAp785duOPGx24QidhDU9w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35FFE804140;
        Thu, 24 Jun 2021 09:29:35 +0000 (UTC)
Received: from localhost (ovpn-12-142.pek2.redhat.com [10.72.12.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD8D75C1BB;
        Thu, 24 Jun 2021 09:29:33 +0000 (UTC)
Date:   Thu, 24 Jun 2021 17:29:30 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        rientjes@google.com, rppt@linux.ibm.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, kexec@lists.infradead.org,
        iommu@lists.linux-foundation.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com
Subject: Re: [PATCH RFC 0/2] dma-pool: allow user to disable atomic pool
Message-ID: <20210624092930.GA802261@MiWiFi-R3L-srv>
References: <20210624052010.5676-1-bhe@redhat.com>
 <YNQ258KHlzlajqo/@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNQ258KHlzlajqo/@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/21 at 08:40am, Christoph Hellwig wrote:
> So reduce the amount allocated.  But the pool is needed for proper
> operation on systems with memory encryption.  And please add the right
> maintainer or at least mailing list for the code you're touching next
> time.

Oh, I thoutht it's memory issue only, should have run
./scripts/get_maintainer.pl. sorry.

About reducing the amount allocated, it may not help. Because on x86_64,
kdump kernel doesn't put any page of memory into buddy allocator of DMA
zone. Means it will defenitely OOM for atomic_pool_dma initialization.

Wondering in which case or on which device the atomic pool is needed on
AMD system with mem encrytion enabled. As we can see, the OOM will
happen too in kdump kernel on Intel system, even though it's not
necessary.

Thanks
Baoquan

