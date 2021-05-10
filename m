Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2801737900A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbhEJOBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:01:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39711 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243847AbhEJN61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620655038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ueHarcaPGWcQI8E59Rcm+H4N/4P07/lLhUlbqdNFOw=;
        b=Noov3WpWqiQ7iyROV8WoVtMVEZbAP+iRAONoaFN+nr/v+hYWYT5XiF6SWFqC3Z9aAPzily
        Xwqqf+8bMmfR3ZqUcD77dbid2IiE5o2sIHqCsIprRWSE4DwKe0INTXAyYz25bJdePfJjtH
        RzW3CR6koak2SoCSqw9BRrAGgY2FVEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-4N3tn565PLaQ8LV2erf73w-1; Mon, 10 May 2021 09:57:14 -0400
X-MC-Unique: 4N3tn565PLaQ8LV2erf73w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25F8A1083AAE;
        Mon, 10 May 2021 13:57:12 +0000 (UTC)
Received: from localhost (ovpn-115-83.ams2.redhat.com [10.36.115.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 349B919C45;
        Mon, 10 May 2021 13:57:11 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Snaipe <snaipe@arista.com>, alexander@mihalicyn.com,
        christian.brauner@ubuntu.com,
        Linux Containers <containers@lists.linux.dev>,
        cyphar@cyphar.com, ebiederm@xmission.com, geofft@ldpreload.com,
        jcsible@cert.org, josh@joshtriplett.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@amacapital.net, mic@digikod.net,
        mpatel@redhat.com, ptikhomirov@virtuozzo.com, sargun@sargun.me,
        stgraber@ubuntu.com, vgoyal@redhat.com, watl@google.com
Subject: Re: LPC 2020 Hackroom Session: summary and next steps for isolated
 user namespaces
References: <87ft6act3c.fsf@redhat.com>
        <20210421172714.912119-1-snaipe@arista.com>
        <87h7jyvfsm.fsf@redhat.com> <20210507133703.GB22450@mail.hallyn.com>
        <87cztyhhc4.fsf@redhat.com>
Date:   Mon, 10 May 2021 15:57:09 +0200
In-Reply-To: <87cztyhhc4.fsf@redhat.com> (Giuseppe Scrivano's message of "Mon,
        10 May 2021 15:02:51 +0200")
Message-ID: <874kfahetm.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Scrivano <gscrivan@redhat.com> writes:

>>> Any comments on this approach?  Could we move forward with it?
>>
>> Can you send these to lkml?  I'll have to go back through our previous
>> discussions, but offhand this looks good to me.
>
> I've just sent them to lkml.

and I've realized I forgot to CC containers@lists.linux.dev.

For anyone interested, the patches are here:

https://lore.kernel.org/lkml/20210510130011.1441834-1-gscrivan@redhat.com/T/#t

Regards,
Giuseppe

