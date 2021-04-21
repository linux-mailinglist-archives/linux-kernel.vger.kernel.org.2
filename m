Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2B8367030
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbhDUQbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239460AbhDUQbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619022628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wLGrvy+ULMYYKl9rwQC/Ru+yLz8by2LZ3EYX7Mkscks=;
        b=bcaudTQScJZpT+Prr2+er7RAwIJFWpvTI3YrDXso/QOL+P3sBb44dptNChKoJysroX2RxE
        46+AGjeYpX5F8XTs9q6vuIkETuvVYigHkYfaF5oxgfgI3Hse2qwAn7P7M/hdfoR2a33fDy
        6P0Y7RY4E17zB3syqoM3ebcWps08vJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-aKTFIm2mNtqK0OpjLS5LkQ-1; Wed, 21 Apr 2021 12:30:26 -0400
X-MC-Unique: aKTFIm2mNtqK0OpjLS5LkQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0739618C35D0;
        Wed, 21 Apr 2021 16:30:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-33.rdu2.redhat.com [10.10.112.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F33E15D6A1;
        Wed, 21 Apr 2021 16:30:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210421130105.1226686-48-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-48-gregkh@linuxfoundation.org> <20210421130105.1226686-1-gregkh@linuxfoundation.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        Qiushi Wu <wu000273@umn.edu>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH 047/190] Revert "rxrpc: Fix a memory leak in rxkad_verify_response()"
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2189110.1619022623.1@warthog.procyon.org.uk>
Date:   Wed, 21 Apr 2021 17:30:23 +0100
Message-ID: <2189111.1619022623@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This reverts commit f45d01f4f30b53c3a0a1c6c1c154acb7ff74ab9f.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Qiushi Wu <wu000273@umn.edu>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Markus Elfring <Markus.Elfring@web.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This is actually a good patch, so please don't revert it.

David

