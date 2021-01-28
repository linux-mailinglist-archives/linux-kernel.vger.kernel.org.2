Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E459030777F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 14:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhA1N4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 08:56:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29192 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229652AbhA1N4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 08:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611842081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ihi+4QwEx7us4kvs/s0v8/+vQIWWSUcpv8nfL3B8Fs=;
        b=P1m8qqvyP/3bVCrBvL3nF+qM7HjH9EccjlUPz8XYazOsq3oxfHtI764iiHj3JJTuexFuEp
        IY4eS1WotzDyxmFjOCTVm02t8OT+EUci85i7d6yroE1KDf8aTIuA4VGArJj/t2dRmO0SEm
        4pOt0zVb/XfF0OEQPEky8O074Mt5tMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-pjSILcRgO_yFJwWDGfb14Q-1; Thu, 28 Jan 2021 08:54:37 -0500
X-MC-Unique: pjSILcRgO_yFJwWDGfb14Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB4D3107ACE3;
        Thu, 28 Jan 2021 13:54:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FBAD5D9F1;
        Thu, 28 Jan 2021 13:54:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <e561f45e-f9be-19a4-478d-15dd003769cd@linux.ibm.com>
References: <e561f45e-f9be-19a4-478d-15dd003769cd@linux.ibm.com> <20210128001412.822048-1-stefanb@linux.vnet.ibm.com> <3451836.1611825591@warthog.procyon.org.uk>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     dhowells@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org
Subject: Re: [PATCH v4 0/3] Add support for x509 certs with NIST p256 and p192 keys
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3561486.1611842073.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 28 Jan 2021 13:54:33 +0000
Message-ID: <3561487.1611842073@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Berger <stefanb@linux.ibm.com> wrote:

> > This (sub)set is intended to go through the keyrings tree or is it all=
 going
> > through the crypto tree now?
> =

> =

> Patch 1/3 should go through 'crypto', the other ones through 'keyrings'.

Do 2 & 3 depend on 1?

David

