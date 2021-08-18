Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968313EFF5A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239180AbhHRIjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37049 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238050AbhHRIi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629275902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b+amw47qxCoKw4icq6FPPyv77CAwQdV1ZQlpMJar6JI=;
        b=S0OQGdtOOvx2VP4z2vbnQYFgWTZmabF5C9m7cDFAavPPGwPTfusd5hF6ZlD1mZN/LzxnBy
        F9/SFk7Gqzd5+b/dVfawtWpDACzceUCMJiIxSuqKyPgZ48bN8UdsC82+pCzxPgrZX8jvQX
        6AiQLrDawhvNfrUj9CdtU6zrB8SFrOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-1o05g6u4O7SX6qdbTA33lA-1; Wed, 18 Aug 2021 04:38:20 -0400
X-MC-Unique: 1o05g6u4O7SX6qdbTA33lA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1A61344B3;
        Wed, 18 Aug 2021 08:38:19 +0000 (UTC)
Received: from T590 (ovpn-8-40.pek2.redhat.com [10.72.8.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6791510013D6;
        Wed, 18 Aug 2021 08:38:12 +0000 (UTC)
Date:   Wed, 18 Aug 2021 16:38:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/7] genirq/affinity: rename irq_build_affinity_masks as
 group_cpus_evenly
Message-ID: <YRzG7mMFI+n/QJyG@T590>
References: <20210814123532.229494-1-ming.lei@redhat.com>
 <20210814123532.229494-5-ming.lei@redhat.com>
 <20210817045027.GD3874@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817045027.GD3874@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 06:50:27AM +0200, Christoph Hellwig wrote:
> s/as/to/ in the subjects.
> 
> On Sat, Aug 14, 2021 at 08:35:29PM +0800, Ming Lei wrote:
> > Map irq vector into group, so we can abstract the algorithm for generic
> > use case.
> 
> s/vector/vectors/

One group actually is abstracted from one irq vector, and it can represent
vector, blk-mq hw queue and others. Currently genirq/affinity spreads
vectors across all possible cpus, since this patch we spread groups
among all possible cpus evenly.

Thanks,
Ming

