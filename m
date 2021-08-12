Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBA63EA7A4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbhHLPgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28790 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236426AbhHLPgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628782539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NHxcJB6Dx8/bsst5x+A7CZjcxgMXd7//qJ3xADNRAT8=;
        b=OCpCnr+Xij3BIRm/QVeIG4Xi77IPypy3eKwu7GDiadEXiTtS/VFLWMX9ag7C2YoqAPIxPp
        AJwwnIyyPKZcJGkprIZuojTWI9fPHF1PeUkwougoI12X7gDv25BB+q2Hm+8tCdrAy+m1Zi
        167ZNcEn3LfNn1plMHDvNhJjwz1AmqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-oLMqJgz-PaSewlFGmDQ1nA-1; Thu, 12 Aug 2021 11:35:37 -0400
X-MC-Unique: oLMqJgz-PaSewlFGmDQ1nA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A077E100A972;
        Thu, 12 Aug 2021 15:35:28 +0000 (UTC)
Received: from redhat.com (ovpn-112-138.phx2.redhat.com [10.3.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BFD9783BF8;
        Thu, 12 Aug 2021 15:35:27 +0000 (UTC)
Date:   Thu, 12 Aug 2021 10:35:25 -0500
From:   Eric Blake <eblake@redhat.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, hch@lst.de,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org,
        syzbot+9937dc42271cd87d4b98@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: nbd: add sanity check for first_minor
Message-ID: <20210812153525.hlged76ivhqtffyg@redhat.com>
References: <20210812091501.22648-1-paskripkin@gmail.com>
 <7f9a6877-12d9-0177-d09a-6522e5a557ec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f9a6877-12d9-0177-d09a-6522e5a557ec@gmail.com>
User-Agent: NeoMutt/20210205-687-0ed190
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 12:42:38PM +0300, Pavel Skripkin wrote:
> 
> Fun thing: I got a reply to this email from
> nsd-public@police.gov.hk, which is Hong Kong Police office email. Does
> anyone know what is going on? :) It's a bit scary...

You are not alone.  Apparently, someone subscribed that address to the
nbd@other.debian.org list and it is auto-responding to every message
it receives; hopefully, a list administrator (I am not one) will be
willing to forcefully unsubscribe that address.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

