Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35ECD33B3AF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhCONTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:19:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229681AbhCONTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615814358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NyrHZhLk2mzWrjjWzosQShTj66uqpwj8Oob2TjWtefA=;
        b=hJDUXJNJmLzeju7LFGiPG2Z0Q8fbR9TsR7NgMJZ9fvaNvq/du/4bs11h20q8lZK0yXwqDU
        HmorTVfmpybLOS8kuuN8u7LXGW1uJVMFlAVdeHBfXsbyy+HO7xiO90rS1py/EFLq4kuqI3
        sFmXHe1lWxrLOioOGI5V7lgfAnOlCuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-OHMPYE5JM1WChdmu3OxJpw-1; Mon, 15 Mar 2021 09:19:16 -0400
X-MC-Unique: OHMPYE5JM1WChdmu3OxJpw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32C8E10866AE;
        Mon, 15 Mar 2021 13:19:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.107])
        by smtp.corp.redhat.com (Postfix) with SMTP id 986C219D7C;
        Mon, 15 Mar 2021 13:19:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 15 Mar 2021 14:19:14 +0100 (CET)
Date:   Mon, 15 Mar 2021 14:19:12 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH] prctl: fix PR_SET_MM_AUXV kernel stack leak
Message-ID: <20210315131911.GB13620@redhat.com>
References: <YE53QiJuxsCUeoiu@localhost.localdomain>
 <20210315120803.GA13620@redhat.com>
 <YE9ZGl9jlnDz1OBP@grain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE9ZGl9jlnDz1OBP@grain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15, Cyrill Gorcunov wrote:
>
> On Mon, Mar 15, 2021 at 01:08:03PM +0100, Oleg Nesterov wrote:
>
> >
> > And why task_lock(current) ? What does it try to protect?
>
> As far as I remember this was related to reading from procfs
> at time the patch was written for first time. Looks like this
> not relevant anymore and could be dropped.

I think this was never relevant, ->alloc_lock is per-thread, not per mm.

Oleg.

