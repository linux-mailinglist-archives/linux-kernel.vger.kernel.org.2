Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADDC3E1270
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbhHEKTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39385 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240017AbhHEKTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628158764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=tPLv8/FqEnF6zrBT0uL4PeS5Q8+ujikNSGDD6GSwxto=;
        b=L5I/eSx6icegeYWa5DasTkK8aCr1SNwvNF7vkBiYjcOb+e5rLI8PfSPU3ptY4Bg/HW+4cf
        H/FaG3JxwZp4ebmDvutdH2XBAEXA7Er/7Qo1CrNwR+rnHX53eAsKke1lq+Bib0BE7NvhMu
        1O0nYX9DaQx97EYXUN1yJKZfwQqSNO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-9SCv9aALMnql9atHZRlg2g-1; Thu, 05 Aug 2021 06:19:21 -0400
X-MC-Unique: 9SCv9aALMnql9atHZRlg2g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 852AC87D541;
        Thu,  5 Aug 2021 10:19:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E55B0100238C;
        Thu,  5 Aug 2021 10:19:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org
cc:     dhowells@redhat.com, jlayton@kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dchinner@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Could it be made possible to offer "supplementary" data to a DIO write ?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1017389.1628158757.1@warthog.procyon.org.uk>
Date:   Thu, 05 Aug 2021 11:19:17 +0100
Message-ID: <1017390.1628158757@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm working on network filesystem write helpers to go with the read helpers,
and I see situations where I want to write a few bytes to the cache, but have
more available that could be written also if it would allow the
filesystem/blockdev to optimise its layout.

Say, for example, I need to write a 3-byte change from a page, where that page
is part of a 256K sequence in the pagecache.  Currently, I have to round the
3-bytes out to DIO size/alignment, but I could say to the API, for example,
"here's a 256K iterator - I need bytes 225-227 written, but you can write more
if you want to"?

Would it be useful/feasible to have some sort of interface that allows the
offer to be made?

David

