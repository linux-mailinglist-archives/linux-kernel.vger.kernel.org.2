Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95943F76D4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241129AbhHYOFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:05:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42503 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232058AbhHYOFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629900268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kE8Hzeh9FYFuKZ/G19btpp2uodcRTcaVsAerPbdqFCE=;
        b=fq1mK5PFxezxJ+S1MiFs+SzpY1o8wENGyRuNA8IvROS7U4jd36PVxr40tW36pFwmyyLDUu
        BKm9MvMZFdV2D7oaIGhWIWkAKEMhUvLMK5bLetE8oDZM0YCx4MX/NinVeNPBr8AKvTWXEO
        FeoVIOGJd6f/B6GfKDg7puZYOSVYc4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-ASdezzy4PASj34NJfVUMLw-1; Wed, 25 Aug 2021 10:04:25 -0400
X-MC-Unique: ASdezzy4PASj34NJfVUMLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28BC01853026;
        Wed, 25 Aug 2021 14:04:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB6F72B3DF;
        Wed, 25 Aug 2021 14:04:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <3d98729b59c2afcad1299a7742211bcdf1598623.camel@redhat.com>
References: <3d98729b59c2afcad1299a7742211bcdf1598623.camel@redhat.com> <162431188431.2908479.14031376932042135080.stgit@warthog.procyon.org.uk> <162431201844.2908479.8293647220901514696.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] fscache: Fix cookie key hashing
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2030820.1629900248.1@warthog.procyon.org.uk>
Date:   Wed, 25 Aug 2021 15:04:08 +0100
Message-ID: <2030821.1629900248@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Layton <jlayton@redhat.com> wrote:

> What happens when this patch encounters a cache that was built before
> it? Do you need to couple this with some sort of global cache
> invalidation or rehashing event?

At the moment, nothing.  cachefiles generates a second hash value, but doing
so is a duplication of effort.

David

