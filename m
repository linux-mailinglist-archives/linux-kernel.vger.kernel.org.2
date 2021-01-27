Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82DC3056C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbhA0JVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:21:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235073AbhA0JTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611739083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iEOd8vpkinaEVhuUUyJbryZi0B7SBQ8xpoSs7XR8Nms=;
        b=VSjsYFh5pXx/PKYele5B9mCe0vskNCPGj4e21AE8bNCqzrvGXbId9QlDSl+M5F6FwhQKFM
        RJwb3QvDYjiZzMJxXaDkooGvtoOy+DRl0fTW0zc5ckseCSXO22FpMr9sWjWDvLPVL3Fpi1
        59Oe9fJWO4CDL0fNEU9cbdzyFQmk6GY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-AwKrDE-LN4q48ZEOMoS92w-1; Wed, 27 Jan 2021 04:17:59 -0500
X-MC-Unique: AwKrDE-LN4q48ZEOMoS92w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B2E9107ACE8;
        Wed, 27 Jan 2021 09:17:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EEFE1F40D;
        Wed, 27 Jan 2021 09:17:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210126191115.434842-1-stefanb@linux.vnet.ibm.com>
References: <20210126191115.434842-1-stefanb@linux.vnet.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        patrick@puiterwijk.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 0/3] Add support for x509 certs with NIST p256 and p192 keys
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3047992.1611739074.1@warthog.procyon.org.uk>
Date:   Wed, 27 Jan 2021 09:17:54 +0000
Message-ID: <3047993.1611739074@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:

> keyctrl newring test @u

This should be keyctl, and I would recommend you do:

	k=`keyctl newring test @u`

and then use $k for it.

You also need:

	#include <linux/scatterlist.h>

in ecc.c in the middle patch.

David

