Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052EE30CD3B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhBBUo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:44:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31017 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229870AbhBBUo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:44:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612298581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jwJ+IqANNuP7grTt6JHdS5L4cfohUmrDDibLdFhD7tA=;
        b=MOqHs4p0wFqJ9jJYoKdHEzOL5H8ditKkk7o5+0M+w/EvnOEFuZ1geTYGZ/joBtlcba8RpY
        4RJdzuYd8coEM71+zSOES82mFO1kwMxgDAp42WwW6XGJLiY5uJWsNq6iAVkzUGPpJYqwl1
        cT5Ii1ocf98l9opIV9NUfP+iEAq4OYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-wevFCdoVMHmMRlmQBE9YWQ-1; Tue, 02 Feb 2021 15:43:00 -0500
X-MC-Unique: wevFCdoVMHmMRlmQBE9YWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E59C0107ACE3;
        Tue,  2 Feb 2021 20:42:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE35F6EF57;
        Tue,  2 Feb 2021 20:42:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210203070915.06a1a574@canb.auug.org.au>
References: <20210203070915.06a1a574@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     dhowells@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the fscache tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <600006.1612298577.1@warthog.procyon.org.uk>
Date:   Tue, 02 Feb 2021 20:42:57 +0000
Message-ID: <600007.1612298577@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> In commit
> 
>   51721d69bb95 ("afs: Fix error handling in afs_req_issue_op()")
> 
> Fixes tag
> 
>   Fixes: 0dd1a43b5d74 ("afs: Fix error handling in afs_req_issue_op()")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> I have no idea which commit you meant :-(

Oops...  I made the Fixes tag refer to the patch I was adding it to.  Fixed
and repushed.

David

