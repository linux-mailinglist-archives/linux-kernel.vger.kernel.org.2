Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5FF37C065
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhELOka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:40:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230247AbhELOk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620830361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vC+DDiLBvCP950gYw38LBndpncTBiw4wY9B/u7aFc6k=;
        b=YYqX1CDyg8vh0BGZDCFwr+eHLtoml35z0SvZp/tuxgZoyfHVTK3aICKpRocfTxab5ivZXP
        tywyy7GT/qfhF+ho0VnkpgPySL1CWSwkwDxIvsCW4Zw0TQCgygA2j8fE65sMfrcv3JS5GB
        ZYu7i0lyLJBRE2PzXDSKGAp8xylXNII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-CdNKbv3jNGag5bGdSZ3fsA-1; Wed, 12 May 2021 10:39:19 -0400
X-MC-Unique: CdNKbv3jNGag5bGdSZ3fsA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1623104FB62;
        Wed, 12 May 2021 14:39:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id A42655C8AA;
        Wed, 12 May 2021 14:38:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 12 May 2021 16:39:16 +0200 (CEST)
Date:   Wed, 12 May 2021 16:38:56 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simon.marchi@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND2] ptrace: make ptrace() fail if the tracee changed
 its pid unexpectedly
Message-ID: <20210512143855.GB19594@redhat.com>
References: <20210511165626.GA13720@redhat.com>
 <CAHk-=whLqbTNc1T+rHCm-kxbVAuhK3hjo5fOgDVf5-z--x1mvQ@mail.gmail.com>
 <20210511175341.GA14488@redhat.com>
 <20210511180627.GB14488@redhat.com>
 <20210512133615.GA19594@redhat.com>
 <1879292286.40455.1620827809948.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1879292286.40455.1620827809948.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 05/12, Mathieu Desnoyers wrote:
>
> Out of curiosity: what makes it OK to use either the current task or its
> parent's pid namespace in this specific case ? What happens if they are
> in different pid namespaces ?

Because in this case current == task->parent == debugger.

Just in case... task->real_parent is, well, "real parent", the parent which
forked this task.

task->parent == task->real_parent unless this task is ptraced, in this case
task->parent == debugger.

Oleg.

