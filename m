Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED7C3065A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhA0VJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:09:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59443 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229771AbhA0VJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611781702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1puqfUrW81YUtJ9m3vPXWi/7nyLg0XoBzWiX+sT6Lzk=;
        b=aOeJ48zZMdzHBv0c8AMuECse8+XndobxCQgclHTEz2MURJVsU3trlgLo9XHr9Odz/hOBjT
        1k9kmVwLDwc7XIIbcaG1klNLJvsQsVeGs6lOPnjs2L1XJvlFipXHQWnrLJetI0IXd0FJ7j
        iWD8RCNgNwW68ny6YttTY8JcHWbqVHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-Cb9oiZtJMtiYvPBBQsdpdw-1; Wed, 27 Jan 2021 16:08:18 -0500
X-MC-Unique: Cb9oiZtJMtiYvPBBQsdpdw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A5FC100C600;
        Wed, 27 Jan 2021 21:08:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D2955C1BB;
        Wed, 27 Jan 2021 21:08:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210127193215.GB27505@gondor.apana.org.au>
References: <20210127193215.GB27505@gondor.apana.org.au> <20210127123350.817593-1-stefanb@linux.vnet.ibm.com> <3114062.1611757328@warthog.procyon.org.uk>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dhowells@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        patrick@puiterwijk.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v3 0/3] Add support for x509 certs with NIST p256 and p192 keys
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3291024.1611781694.1@warthog.procyon.org.uk>
Date:   Wed, 27 Jan 2021 21:08:14 +0000
Message-ID: <3291025.1611781694@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> > I've pulled this into my keys-next branch.
> 
> David, please drop them because there are issues with the Crypto API
> bits.

Okay, dropped.

David

