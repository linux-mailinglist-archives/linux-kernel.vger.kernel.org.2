Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE8032C25D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352234AbhCCTmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:42:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378692AbhCCTXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614799336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vuqL4R1aVNoQaCDvAzbxloSbPYIjHmk3t/7rdEcOT6I=;
        b=GShRVFl0aKXUO2CA0yjpsn3yXbD6S4VAJYYSxdU8s2M3S/ucJz9SL2aYJ/1UT4wFzh+zvE
        gHHia3RymfRqrdzKnHvjLADQ5aE0e1Bu8Mm/5XwRHECRW2wy0VmtCbtweSp0WElEdwhxYF
        a0RB+fO/M4e3Y8UHDdpsptslnhoH62s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-Oy1-iFG8MnGVsz9CGbnvIA-1; Wed, 03 Mar 2021 14:22:14 -0500
X-MC-Unique: Oy1-iFG8MnGVsz9CGbnvIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB88CC73A0;
        Wed,  3 Mar 2021 19:22:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11FEE100164C;
        Wed,  3 Mar 2021 19:22:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210303190146.GA155680@LEGION>
References: <20210303190146.GA155680@LEGION>
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: remove the unused variable
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2633304.1614799331.1@warthog.procyon.org.uk>
Date:   Wed, 03 Mar 2021 19:22:11 +0000
Message-ID: <2633305.1614799331@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've fixed this already, thanks.  The fix should turn up in linux-next at some
point.

David

