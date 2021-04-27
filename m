Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C342A36C70B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbhD0Nco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:32:44 -0400
Received: from mail.efficios.com ([167.114.26.124]:52704 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbhD0Ncn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:32:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6DA0633C85C;
        Tue, 27 Apr 2021 09:31:59 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QLsKmmWU5566; Tue, 27 Apr 2021 09:31:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7451333C94F;
        Tue, 27 Apr 2021 09:31:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7451333C94F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1619530318;
        bh=HgBbATI1CSLr0RA0wZG0OZdu4kf/Su2/ld+8qO5iIiQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=BN3S9IX6b82CNdUAAw61+qg7RywyKDyg2RiEWM5BXt5txeP5PmilTqNInQpN+59Dp
         O3y8TILnDFYuH8ACVAWLbmnaSZxObqvxof8Vu1zxc+nHKTYwCsEXk/0wX2FGDfmsUq
         m61rxeEJFPOhqZkaDUD+wwudzcOYIbMsUmNPYtx0qiBpBjc4UoJY2rNJmYyV21MmZo
         9V7KlLXE1DeZ311mgDFnD/skyQu3ZvCZHB1bDUI3xaDrFl0v13ZHlno0Lwoy2ia2ub
         IsiedNGTCp/6Dlgy34TxksHPXvH8rle7A2U6aOOmeK+gRV2fxF/ySxWhX0EopZAUF7
         LvZAub4hmWDWw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id d1JLAhoBKC1S; Tue, 27 Apr 2021 09:31:58 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 62DD633CA1D;
        Tue, 27 Apr 2021 09:31:58 -0400 (EDT)
Date:   Tue, 27 Apr 2021 09:31:58 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simon.marchi@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg KH <greg@kroah.com>
Message-ID: <1457812105.15630.1619530318280.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210427062619.GB10986@redhat.com>
References: <20210426154539.GA5166@redhat.com> <626936290.15030.1619471040515.JavaMail.zimbra@efficios.com> <20210427062619.GB10986@redhat.com>
Subject: Re: [PATCH RESEND] ptrace: make ptrace() fail if the tracee changed
 its pid unexpectedly
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: ptrace: make ptrace() fail if the tracee changed its pid unexpectedly
Thread-Index: AfOOXZUKw3edtHPGMRcbFcGhSr4WJw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 27, 2021, at 2:26 AM, Oleg Nesterov oleg@redhat.com wrote:
[...]
>> Is this something that should also target stable kernels ? AFAIU this change
>> won't break debuggers more that they are already in this scenario. Or maybe
>> it makes them fail in more obvious ways ?
> 
> Well, I am not sure this is stable material...
> 
> To me the problem is minor, and the patch adds the user-visible change.
> I think it would be safer to not add stable tag.

I'm fine either way. So given the relatively small impact of this problem
(not critical), this ptrace fix may not be worthy of a stable tag.

I just find it odd that a patch fixing an ABI design flaw ends up not being
CC'd to stable, but also does not expose any way for user-space to discover
this altered ABI behavior. It's a rather weird middle-ground between a fix
and a new feature.

That being said, there was no prior way for user-space to achieve a correct
behavior before this patch, so making it discoverable is kind of pointless.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
