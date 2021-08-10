Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5561A3E858C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 23:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbhHJViY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 17:38:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234842AbhHJViR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628631474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ufkp0vqQj1CrrEXAlqTBSrOE1C02hvGh1EgNYAQwtAA=;
        b=J/0SV//fxwoIe96wLsoFCk+kPKAQi176L6xW8YGPSpth/QBtTHQckS3SCwNJ2xyMtWKzbl
        2+d7cwBUueoTJHUcqw+kPuftuhWb+kY/6TATmb5WYA+2l7+r/NhLlCrKOx/AKvYbRPRVpw
        LeUejq9d5HHghRX2/T815mH20UM0vnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-9MSJCVr8PQq6TNzrQ1ELXg-1; Tue, 10 Aug 2021 17:37:51 -0400
X-MC-Unique: 9MSJCVr8PQq6TNzrQ1ELXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48B791853026;
        Tue, 10 Aug 2021 21:37:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F63760BF1;
        Tue, 10 Aug 2021 21:37:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-81-willy@infradead.org>
References: <20210715033704.692967-81-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 080/138] mm/workingset: Convert workingset_refault() to take a folio
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1813921.1628631465.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 22:37:45 +0100
Message-ID: <1813922.1628631465@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> This nets us 178 bytes of savings from removing calls to compound_head.
> The three callers all grow a little, but each of them will be converted
> to use folios soon, so that's fine.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

