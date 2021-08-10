Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6953E3E8433
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 22:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhHJUS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 16:18:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31448 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229764AbhHJUS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628626683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HARNjb41hnTeF9Agrw8P+yql+2IGaltxIkM7QljMlr8=;
        b=ZUs4H1n5rM54nnKETbYdXbhlz66GqoGHpnC+dpYGeA4HFOAC96KDOmWxeV8OKM9YxArk+F
        g/Tyd5pM0jkipq4VcTRQLMfwNKoTwkFLv090+SHPN45pIT2e4z68OrDAe+Ha1jydiWFk+M
        6boZU6P3KmdDLFFvi0RlOetDqebKudQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-PuB4BO-hMf2X8vvdEYmL3g-1; Tue, 10 Aug 2021 16:18:02 -0400
X-MC-Unique: PuB4BO-hMf2X8vvdEYmL3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60EEF100F7A2;
        Tue, 10 Aug 2021 20:18:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F70D18A9E;
        Tue, 10 Aug 2021 20:18:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-39-willy@infradead.org>
References: <20210715033704.692967-39-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 038/138] mm/memcg: Add folio_memcg() and related functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1810115.1628626679.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 21:17:59 +0100
Message-ID: <1810116.1628626679@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> memcg information is only stored in the head page, so the memcg
> subsystem needs to assure that all accesses are to the head page.
> The first step is converting page_memcg() to folio_memcg().
> 
> The callers of page_memcg() and PageMemcgKmem() are not yet ready to be
> converted to use folios, so retain them as wrappers around folio_memcg()
> and folio_memcg_kmem().  They will be converted in a later patch set.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

