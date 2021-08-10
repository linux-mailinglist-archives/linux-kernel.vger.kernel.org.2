Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FBF3E85D2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 00:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbhHJWBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 18:01:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231372AbhHJWBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 18:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628632846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jnm1Zmw19qNhqSQJBRvHbG/m+wn8+38ktsT4aKE9dWo=;
        b=Q3WPMBJ0byPHSXCxuNHJPYsvVc8womZMu+FdhClmGYgzmRsP+2fKFO88v34Pc28i0zhncz
        tmpJUhuo7mDEh4859+Cjhacfvp0luoBpEBLmyDRLtNjoip3Q28MmzOxdhIa5zQyMKo1XeR
        0s9OyJWEPMWwyd2VShE4HBuZ/9+KOiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-crXEs2ZdOpSi7tyJL34LZw-1; Tue, 10 Aug 2021 18:00:44 -0400
X-MC-Unique: crXEs2ZdOpSi7tyJL34LZw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9B6A108087A;
        Tue, 10 Aug 2021 22:00:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B60725C1A1;
        Tue, 10 Aug 2021 22:00:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-88-willy@infradead.org>
References: <20210715033704.692967-88-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 087/138] mm/filemap: Convert mapping_get_entry to return a folio
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1814925.1628632841.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 23:00:41 +0100
Message-ID: <1814926.1628632841@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> The pagecache only contains folios, so indicate that this is definitely
> not a tail page.  Shrinks mapping_get_entry() by 56 bytes, but grows
> pagecache_get_page() by 21 bytes as gcc makes slightly different hot/cold
> code decisions.  A net reduction of 35 bytes of text.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

