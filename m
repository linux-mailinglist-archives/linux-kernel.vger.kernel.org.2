Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D343C339CD8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 09:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhCMIOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 03:14:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20166 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233414AbhCMIOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 03:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615623240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HD8GasGxLOGjWEPXW1RDIOCj5Ig8QuD9ZoJ4u7PPXP0=;
        b=hTCpdZFE+dA7WqMnLtH+WcLomsXvUUO6ShBPmLiZUpug5A+QnCsSufyv5BMz4NXYDTRDZO
        nSXNfRewRG3NZoX8hvo2gQf97gBmp4Npv2ihYJ/aONHeEShGwfl4X3nDQN07B1B/l4CjWQ
        7AeCnOHEdOMBbaJoYcUkE5VEDkv90Fw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-w_ZGOYuuO2OX7mnkzaBhgQ-1; Sat, 13 Mar 2021 03:13:57 -0500
X-MC-Unique: w_ZGOYuuO2OX7mnkzaBhgQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81E2A1084C83;
        Sat, 13 Mar 2021 08:13:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C328E5C3E4;
        Sat, 13 Mar 2021 08:13:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <337B72A8-C81A-4C53-A4D6-FFFD7FA66CEC@oracle.com>
References: <337B72A8-C81A-4C53-A4D6-FFFD7FA66CEC@oracle.com> <161428671215.677100.6372209948022011988.stgit@warthog.procyon.org.uk> <161428674320.677100.12637282414018170743.stgit@warthog.procyon.org.uk> <4b275a33-28ac-78c2-e075-ea2eda4f13a8@canonical.com> <92182F5F-327E-4F1D-A7D9-42355625C84C@oracle.com> <b10f51dc-b9d7-e84d-3a52-438ebd358a7d@canonical.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     dhowells@redhat.com,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] integrity: Load mokx variables into the blacklist keyring
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2579342.1615623232.1@warthog.procyon.org.uk>
Date:   Sat, 13 Mar 2021 08:13:52 +0000
Message-ID: <2579343.1615623232@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Snowberg <eric.snowberg@oracle.com> wrote:

> If MOKx will be available thru a config table in the next shim, 
> I'll prepare a follow on patch to add this support. 

Can this go separately, or would it be better rolled into the existing
patchset?

David

