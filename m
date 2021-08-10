Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F723E85ED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 00:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbhHJWHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 18:07:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27965 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235007AbhHJWHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 18:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628633246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hmzm8caQt3TdVyNzd3tgJRC0GlnTJtY3kcYH2J6COrc=;
        b=A7QMdstue/2zD8R0NgQEIolyF73LOTECOqbSvb42Y6dzIQxJhpelnb66clQIDvMxIIG9UP
        eZgu54KKKEh39I68eEbCJe0g5/Xjj2ODGPinyQZjJrOQeWgDtKZAVyFW5qgpuF73KP0KYw
        cjQkZSbn6zf1ax3NFUXbsJCzsnULmlo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-YUI6OfTyOci4zi2LL-OQ9A-1; Tue, 10 Aug 2021 18:07:25 -0400
X-MC-Unique: YUI6OfTyOci4zi2LL-OQ9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D1B62E74;
        Tue, 10 Aug 2021 22:07:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8894E10016FB;
        Tue, 10 Aug 2021 22:07:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-90-willy@infradead.org>
References: <20210715033704.692967-90-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 089/138] mm/filemap: Add FGP_STABLE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1815219.1628633242.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 23:07:22 +0100
Message-ID: <1815220.1628633242@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Allow filemap_get_folio() to wait for writeback to complete (if the
> filesystem wants that behaviour).  This is the folio equivalent of
> grab_cache_page_write_begin(), which is moved into the folio-compat
> file as a reminder to migrate all the code using it.  This paves the
> way for getting rid of AOP_FLAG_NOFS once grab_cache_page_write_begin()
> is removed.
> 
> Kernel grows by 11 bytes.  filemap_get_folio() grows by 33 bytes but
> grab_cache_page_write_begin() shrinks by 22 bytes to make up for it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: David Howells <dhowells@redhat.com>

