Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65073A9831
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhFPK5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60090 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232030AbhFPK46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623840892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B+PwrPHBq3pTuKKG3BfQq6KS6b3Dt4OWtFDFB1BsQlc=;
        b=N0AUKpCMjP64BtOZ9SisA0iOPbbeA2xMm3Yn+Rnuqj2dBsYlOgfsWEfcuTvyJ8n5VWrNkt
        r71ZCj3oXD6HpbHY3BTrLGJD9wIdkjTRKoF8jL4bk1UJxoYnW4OAhpFeXisCvJ2I/GGzDH
        Aiq9T6jab1+b2E9v4yYAz1u8oGbLfks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-YElwmKJ8Oa-h0YlclpZSjQ-1; Wed, 16 Jun 2021 06:54:49 -0400
X-MC-Unique: YElwmKJ8Oa-h0YlclpZSjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A9121015C84;
        Wed, 16 Jun 2021 10:54:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5F8B1002F12;
        Wed, 16 Jun 2021 10:54:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210614201435.1379188-1-willy@infradead.org>
References: <20210614201435.1379188-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 00/33] Memory folios
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <817591.1623840884.1@warthog.procyon.org.uk>
Date:   Wed, 16 Jun 2021 11:54:44 +0100
Message-ID: <817592.1623840884@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason I didn't receive patches 3, 12, 17, 20, 23, 25, 29 and 31.

You can add my Reviewed-by to 3, 6, 12, 17, 20, 25, 29 and 31.

With patch 23, should __folio_lock_or_retry() return a bool?  (Same for
__lock_page_or_retry()).  Looks good apart from that.

David

