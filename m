Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7321E30A894
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhBANWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:22:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37295 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232102AbhBANVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612185604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IUHx+ZmyPT9Dyu1dEfWtcZBy3fkG4ai+h8kqNZZO+ns=;
        b=iEQd6R+gXrJi29xISgISc8hylCemrl5SV4try4TFl6OwUmeGm2F08Ff8gjlnHU/x6ImB0h
        oWCh+dmvd2OifBWEhjTogwcKZV8XwB2dlBQVcsfOttpYDliYi+YLVmu22Wt8pfoJr8ziM9
        0T3vvOTn/0zAxAd8MMnfk8R2JaDdAMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-HCE66KfhPEWQgCyY3tplGA-1; Mon, 01 Feb 2021 08:20:02 -0500
X-MC-Unique: HCE66KfhPEWQgCyY3tplGA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1F181005513;
        Mon,  1 Feb 2021 13:20:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EBDBD5C276;
        Mon,  1 Feb 2021 13:19:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210129155529.brxbmgzzosvtwrzw@altlinux.org>
References: <20210129155529.brxbmgzzosvtwrzw@altlinux.org> <20210129150355.850093-1-stefanb@linux.vnet.ibm.com> <20210129150355.850093-5-stefanb@linux.vnet.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     dhowells@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: Re: [PATCH v5 4/4] ima: Support EC keys for signature verification
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4162570.1612185598.1@warthog.procyon.org.uk>
Date:   Mon, 01 Feb 2021 13:19:58 +0000
Message-ID: <4162571.1612185598@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Chikunov <vt@altlinux.org> wrote:

> > +static inline
> > +const struct public_key *asymmetric_key_public_key(const struct key *key)
> > +{
> > +	return key->payload.data[asym_crypto];
> > +}
> 
> I wonder why use this accessor which does nothing else, because in all
> other places payload.data[asym_crypto] accessed directly.

We should probably move to using wrappers rather than accessing directly for
type safety.

David

