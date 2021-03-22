Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6F0343CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhCVJ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:26:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28225 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229840AbhCVJ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616405184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t3xNh0IQiWPXNQDETkDqTClNx+pd4IZjU5MRp7ELCs0=;
        b=JUd4jIW4IvS3IKczsImmekNSVHeOdsupIbnj9BQmkqZp4kbfdR+tBK/adnqEkl3+L5dVu/
        ACSecfhP9Ypsv599Io2N2qy/YRn8SjhiL0bgNJ8l77yzBwy3pM64fpToQLzN3zitoOACnr
        ih6YRA3/ylwYFtWJCTYKGKB8gfff1Cw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-jwatDhd5PO-B8OYoPMV0Qg-1; Mon, 22 Mar 2021 05:26:22 -0400
X-MC-Unique: jwatDhd5PO-B8OYoPMV0Qg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8FF584E20A;
        Mon, 22 Mar 2021 09:26:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA6B262A6F;
        Mon, 22 Mar 2021 09:26:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210320054104.1300774-3-willy@infradead.org>
References: <20210320054104.1300774-3-willy@infradead.org> <20210320054104.1300774-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 02/27] mm/writeback: Add wait_on_page_writeback_killable
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1878168.1616405175.1@warthog.procyon.org.uk>
Date:   Mon, 22 Mar 2021 09:26:15 +0000
Message-ID: <1878169.1616405175@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> This is the killable version of wait_on_page_writeback.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-and-tested-by: David Howells <dhowells@redhat.com>

