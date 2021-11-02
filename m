Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E925442766
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhKBHFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:05:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229616AbhKBHFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635836585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=739j9R+5ax++itfBAbq2Y8M3UgHf0DU269XaCThUi5U=;
        b=YRxgBIW4+JMdWToH4T37H01Y110MAU00qC3Je5JUbt7Lw+HuR561574Wa+iB4JIuirORR9
        4hENU6xiZgR5iydiPjeIRO+8/C10iFklHE/m1/lGmA1Hto7YsCac/AlUlCouM803d+D7QB
        2N9ieMIZtbArRBubV5BS6lmGXqJGcug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-cnlzvNwMPy6BIOTPHEgt4g-1; Tue, 02 Nov 2021 03:03:01 -0400
X-MC-Unique: cnlzvNwMPy6BIOTPHEgt4g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 457AE19057A8;
        Tue,  2 Nov 2021 07:03:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D5F45D9DC;
        Tue,  2 Nov 2021 07:02:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20211102090507.26f3c9ef@canb.auug.org.au>
References: <20211102090507.26f3c9ef@canb.auug.org.au> <20210921142628.75ba9ef2@canb.auug.org.au> <20210922141910.778a5a86@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the folio tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4010544.1635836578.1@warthog.procyon.org.uk>
Date:   Tue, 02 Nov 2021 07:02:58 +0000
Message-ID: <4010545.1635836578@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> > -	    wait_on_page_bit_killable(page, PG_fscache) < 0)
> > +	    folio_wait_bit_killable(page_folio(page), PG_fscache) < 0)
> ...
> > -	    wait_on_page_bit_killable(page, PG_writeback) < 0)
> > +	    folio_wait_bit_killable(page_folio(page), PG_writeback) < 0)

I rebased it and pushed a new version, but I think I missed your pull by a
couple of hours.

David

