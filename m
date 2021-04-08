Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9396358602
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhDHOIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:08:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232004AbhDHOHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617890819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8hSa8efeV34Ya9UUl4ShXiuzP40qCP3a301EVTQNHAg=;
        b=DLztGcUI9kXi6+AznToX66zjvX7AykvNRyKOh6CgGg4swDabq+IBOImA74324s6EVtBn9t
        Q5X4EdB2bz072rQDNztmAsq4XBA1LpRuQpKvCCW274RO6QnWYRg7nV/duk8HYwG5vRg30c
        nD/H4VNCzMwHh7WvQZJjsHu99dPiCbU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-LqkAPl65PdyDD3hekh0hng-1; Thu, 08 Apr 2021 10:06:58 -0400
X-MC-Unique: LqkAPl65PdyDD3hekh0hng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C37C8189C6;
        Thu,  8 Apr 2021 14:06:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-35.rdu2.redhat.com [10.10.119.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7CB95C1C5;
        Thu,  8 Apr 2021 14:06:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210327121624.194639-1-zhengzengkai@huawei.com>
References: <20210327121624.194639-1-zhengzengkai@huawei.com>
To:     Zheng Zengkai <zhengzengkai@huawei.com>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com
Subject: Re: [PATCH] afs: fix no return statement in function returning non-void
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6574.1617890815.1@warthog.procyon.org.uk>
Date:   Thu, 08 Apr 2021 15:06:55 +0100
Message-ID: <6575.1617890815@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zheng Zengkai <zhengzengkai@huawei.com> wrote:

>  static int afs_dir_set_page_dirty(struct page *page)
>  {
>  	BUG(); /* This should never happen. */
> +	return 0;
>  }

That shouldn't be necessary.  BUG() should be marked as 'no return' to the
compiler.  What arch and compiler are you using?

David

