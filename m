Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A74544C2FD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 15:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhKJOel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 09:34:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31619 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231969AbhKJOek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 09:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636554712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3phrxGZVGN2PjrK9Vm6kxLTJu+dLO8uoepoqEAtKI94=;
        b=UHXSTsuYv8Dlg9DjLLIutWNVPhS1qrpnwN6epEMrQxObwatg4x9jlEgdhNacqweoCOoPvR
        U3c1C3ih5JPp0PqAHLfaeJOXo9MEik+4XqRAM7lGrT8SmyOAgV961hTUuzS3RMF+QDX8Su
        RNJ2apJVoC32G7UwUSDuX993gw/LcEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-Ff43LWlCMOO8l0IsSnx29g-1; Wed, 10 Nov 2021 09:31:47 -0500
X-MC-Unique: Ff43LWlCMOO8l0IsSnx29g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C66918125C1;
        Wed, 10 Nov 2021 14:31:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD67619733;
        Wed, 10 Nov 2021 14:31:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <202111100533.Qxw3LycR-lkp@intel.com>
References: <202111100533.Qxw3LycR-lkp@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     dhowells@redhat.com, kbuild@lists.01.org, lkp@intel.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [dhowells-fs:fscache-rewrite-indexing-2 50/64] fs/cachefiles/io.c:483 __cachefiles_prepare_write() error: uninitialized symbol 'ret'.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <758371.1636554698.1@warthog.procyon.org.uk>
Date:   Wed, 10 Nov 2021 14:31:38 +0000
Message-ID: <758372.1636554698@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That branch is obsolete as Linus was unhappy with the way it does things, but
I'm keeping it around for the moment for diffing purposes.

David

