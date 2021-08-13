Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3A03EB274
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 10:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239803AbhHMISF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 04:18:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239773AbhHMISE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628842658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sqXqJy/S48z48l2Ks/2UHAgqYhB0LstlNS9q6S5x3T4=;
        b=HHfYKzHzsReo6XQbci4RZ/jd0fbc5xcESDqXyNVaZicxrETPujsJBZt85PE4jDcDDCQ1AL
        Ffomnn/WiE+YJWCZoV/oYgxO6EhvUozafXFarKePTtDFaAT6btxGbc+H4fPeoNva13vc8K
        eFQH79/VYLO0kpShnOecDDbGPNuPr6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-SIO_k7EWOEKloWx3m5ZmWw-1; Fri, 13 Aug 2021 04:17:36 -0400
X-MC-Unique: SIO_k7EWOEKloWx3m5ZmWw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F7761008061;
        Fri, 13 Aug 2021 08:17:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51BD95C3E0;
        Fri, 13 Aug 2021 08:17:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YRYXAii0zZ0SzDt+@infradead.org>
References: <YRYXAii0zZ0SzDt+@infradead.org> <2408234.1628687271@warthog.procyon.org.uk> <YRVHLu3OAwylCONm@casper.infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] netfs, afs, ceph: Use folios
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3449253.1628842648.1@warthog.procyon.org.uk>
Date:   Fri, 13 Aug 2021 09:17:28 +0100
Message-ID: <3449254.1628842648@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> It actually needs to go away.  There's not real good use for that level
> of API. netfs should just open code the releavant parts of
> generic_perform_write, similar to iomap.

I'm working on doing that in netfs lib, with the intent of sharing it between
at least afs, ceph, cifs and 9p.  It reduces the cost of accessing fscache
for large writes that span multiple pages.

David

