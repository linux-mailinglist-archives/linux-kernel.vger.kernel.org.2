Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D1133C5E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhCOSk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:40:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40015 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231637AbhCOSkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615833645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UQyD3QKu3caWkZUuTQn9pF4ZV3ttdN3IwL6Y9T1OnFE=;
        b=bhDQaLdZbjosqcWZI06fzU5BWoiKof7Y+srU/UxN2hUx/knwuBIyQRZ6CtwDbaPwJvl41N
        rQX8M/EkWBPopr2P8ia1ngBkFiVRs3Vqx1A/cnSvfsmM4z+PD286jYeLNCuONpLhjn6tb1
        oj+BfPWCwmTqXxXT/OX1EcG8RThGUGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-P1v6eay2Ot6NtFrA0tl0sw-1; Mon, 15 Mar 2021 14:40:43 -0400
X-MC-Unique: P1v6eay2Ot6NtFrA0tl0sw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07DB718D6A2A;
        Mon, 15 Mar 2021 18:40:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.107])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7F36D5D751;
        Mon, 15 Mar 2021 18:40:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 15 Mar 2021 19:40:41 +0100 (CET)
Date:   Mon, 15 Mar 2021 19:40:39 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jim Newsome <jnewsome@torproject.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
Message-ID: <20210315184038.GC13620@redhat.com>
References: <20210314231544.9379-1-jnewsome@torproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314231544.9379-1-jnewsome@torproject.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/14, Jim Newsome wrote:
>
> Since v5:
> * Switched back to explicitly looking up by tgid and then pid.

OK, as I said I won't argue, still looks good to me.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

