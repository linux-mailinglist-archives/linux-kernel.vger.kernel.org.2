Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF83344CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhCVRIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29132 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231395AbhCVRHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616432867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wLwToGxEDmc8n5o1OXi9U8H6a1AVaW5DdA44kJP/9pI=;
        b=Phg7D/qY2CKp8bhVJ3fVDdnP/psm2kRsxa8QpO1cYZu3QfRZFRKTxN+wBeo3ob0kf7npWn
        z2uYYNR6jI2003E1rbrBxZKp5b/bSmnDhe+LqC0mN8+OyY/NnsCq3sTzPvcDNAnMCYPgdV
        /leR0UQZCCGzKkzQhEyexTKMx46n8RA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-JhkeyCoUMPurXEwlLsJ25g-1; Mon, 22 Mar 2021 13:07:43 -0400
X-MC-Unique: JhkeyCoUMPurXEwlLsJ25g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44D7C5B362;
        Mon, 22 Mar 2021 17:07:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.114])
        by smtp.corp.redhat.com (Postfix) with SMTP id A916614106;
        Mon, 22 Mar 2021 17:07:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 22 Mar 2021 18:07:40 +0100 (CET)
Date:   Mon, 22 Mar 2021 18:07:34 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     qianli zhao <zhaoqianligood@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, christian@brauner.io,
        axboe@kernel.dk, Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>
Subject: Re: [PATCH V3] exit: trigger panic when global init has exited
Message-ID: <20210322170733.GE20390@redhat.com>
References: <1615985460-112867-1-git-send-email-zhaoqianligood@gmail.com>
 <20210317143805.GA5610@redhat.com>
 <CAPx_LQG=tj+kM14wS79tLPJbVjC+79OFDgfv6zai_sJ74CGeug@mail.gmail.com>
 <20210318180450.GA9977@redhat.com>
 <m1pmzwb7pd.fsf@fess.ebiederm.org>
 <CAPx_LQGBJGgZ+zzhJ2U4RpoPKt3hvf8LRfACtj2LPD7senub7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPx_LQGBJGgZ+zzhJ2U4RpoPKt3hvf8LRfACtj2LPD7senub7A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22, qianli zhao wrote:
>
> Moving the decrement position should only affect between new and old
> code position of movement of the decrement of
> signal->live.

Why do you think so? It can affect _any_ code which runs under
"if (group_dead)". Again, I don't see anything wrong, but I didn't even
try to audit these code paths.

Oleg.

