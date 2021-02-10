Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BDB31611F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBJIfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:35:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50636 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229884AbhBJIbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612945791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qcVgQraBw5PgsGVvVLBD0on1pKnJN9TwEpaKo1fWo0E=;
        b=eodV7DBxBb8IfxWSm/2Wp7SlnigJ+hlmgEg8eNPhKkznM9rtSrvX0/s7JyJiTxmRv0tT2x
        g7OIxsnOb303IHolrkhijPRo+ACAoji0Lx6zw9aGo/vzBlq3XFnjFqqe2C5ta3QAoK/PtM
        NoS2k7aL8iXYm07jRMwEfYbvQIcoxag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-7Wvpi0goNve8RpadM8uzzg-1; Wed, 10 Feb 2021 03:29:47 -0500
X-MC-Unique: 7Wvpi0goNve8RpadM8uzzg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70A25846208;
        Wed, 10 Feb 2021 08:29:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D81AA18B42;
        Wed, 10 Feb 2021 08:29:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210210074554.81100-1-songyang@linux.alibaba.com>
References: <20210210074554.81100-1-songyang@linux.alibaba.com>
To:     Yang Song <songyang@linux.alibaba.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhang.jia@linux.alibaba.com,
        tianjia.zhang@linux.alibaba.com
Subject: Re: [PATCH] sign-file: add openssl engine support
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <664915.1612945784.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 10 Feb 2021 08:29:44 +0000
Message-ID: <664916.1612945784@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Song <songyang@linux.alibaba.com> wrote:

> +		"Usage: scripts/sign-file [-edp] [<openssl engine>] <hash algo> <key>=
 <x509> <module> [<dest>]\n");

Do you mean:

		"Usage: scripts/sign-file [-dp] [-e <openssl engine>] <hash algo> <key> =
<x509> <module> [<dest>]\n");

> +		opt =3D getopt(argc, argv, "sedpk");

"se:dpk"?

> +		if (use_engine) {
> +			ossl_engine =3D argv[0];

use_engine ought to be a redundant variable.

David

