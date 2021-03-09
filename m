Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3EE331B8A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhCIASC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:18:02 -0500
Received: from ms.lwn.net ([45.79.88.28]:42594 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231307AbhCIASA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:18:00 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4A7922B0;
        Tue,  9 Mar 2021 00:18:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4A7922B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1615249080; bh=n7wlyMaMbYzb1UQpQtoONC+OZVt9gNvZ4n6Erv9av6k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lEAXGVTGmst4CmEzR2HYBn7sJEMq6Yun6ou/ZKpGVeQ0lRvOfvrx21LyOa80/iZRd
         /LeZ2WkQ1+OzV1QcLsmyHxysukOpeaIKgO9pkv/Di3rwI9+HbzjKTgf0OUhogpIO4i
         p4Ado++Xs41vhUhtcTAVKqcF9AFLInOfD0dKlnqcqbdeKv8KsCgi2aMlgMMADm1M6O
         tPUpsryHB+LZ68qfJuelPxPWy1NbXIqb/KikrALMqWHcnzHtl7ghVH1HI262lhWCCi
         f156P3KGCfbnmOr0vhNf3alqGomh94adT3OYG1tTJICliOCL3GfWRALoZdl+Jby8XG
         MUOw97zXbQpEA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-doc@vger.kernel.org
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: kvm: Fix a typo ("althought")
In-Reply-To: <20210301214722.2310911-1-j.neuschaefer@gmx.net>
References: <20210301214722.2310911-1-j.neuschaefer@gmx.net>
Date:   Mon, 08 Mar 2021 17:17:59 -0700
Message-ID: <87zgzd41u0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> writes:

> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>  Documentation/virt/kvm/api.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index aed52b0fc16ec..3617a64e81fe2 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -55,7 +55,7 @@ not cause harm to the host, their actual behavior is no=
t guaranteed by
>  the API.  See "General description" for details on the ioctl usage
>  model that is supported by KVM.
>
> -It is important to note that althought VM ioctls may only be issued from
> +It is important to note that although VM ioctls may only be issued from
>  the process that created the VM, a VM's lifecycle is associated with its
>  file descriptor, not its creator (process).  In other words, the VM and

Applied, thanks.

jon
