Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C023E8519
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 23:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbhHJVTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 17:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234151AbhHJVTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628630354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cnxCt8QWZgAhjEG2eKWaY7Qim4IZ3G3PhV73vNy+RzQ=;
        b=P39H77Vz8rsWsabKZW88Joe8Olv7WrTIrQcR6XSUoo+bsLp1nh1hqIwkFSeD3j7HnsjiK8
        lrRBx8BH43FTuzQdaktn+8iP+v1gCdRpxuLgbb2QXMzIs/gaj7M2Fqo9PoM+2QjDN71m5c
        q1x/uiWxiBaw2ybzObNx5+8x+ODVftc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-Iax4_KXDNKuQfYbevFwUug-1; Tue, 10 Aug 2021 17:19:10 -0400
X-MC-Unique: Iax4_KXDNKuQfYbevFwUug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E3B15A08D;
        Tue, 10 Aug 2021 21:19:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 401C7669F3;
        Tue, 10 Aug 2021 21:19:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-70-willy@infradead.org>
References: <20210715033704.692967-70-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 069/138] mm/writeback: Add __folio_mark_dirty()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1813002.1628630345.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:19:05 +0100
Message-ID: <1813003.1628630345@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Turn __set_page_dirty() into a wrapper around __folio_mark_dirty().
> Convert account_page_dirtied() into folio_account_dirtied() and account
> the number of pages in the folio to support multi-page folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: David Howells <dhowells@redhat.com>

