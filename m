Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D648F32587B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhBYVRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:17:00 -0500
Received: from ms.lwn.net ([45.79.88.28]:37892 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhBYVQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:16:55 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 45E198B2;
        Thu, 25 Feb 2021 21:16:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 45E198B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1614287773; bh=HXpU5t4ZCsLP8BkNSkXT52ij4c0xZVCAGleignyH9bg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ABQS9PRvrjPCv+E6gZQLBMdV5A2FJVPv3sJNXZa96r/K8dhE4XCb+R0woxkawPqMn
         ziNBF7D6cDFnYnFqptQuIv7vQq/TnfkIaCkDqKpUCMOzAEqs/GWP85oevPvJagIFHl
         dT8SyzvvMyaey2bRPLIP5HHCcEoPCZzRdbPj4Q8ZTep2anqHTO7FItElfSQXXFPrqO
         /6pdiZNKelme2tLDcF38+AAoXMm09JRgGjD2gg59xkiPTeTV5dQ10HWashMAvMKyDj
         HmGafbew6zeDLFWTWpK3xCMCCoEHfR9uDCULBlOAqjQdZOk53OaagBv61WaKQvuqQE
         bJVkswBCvH1Vg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/2] checkpatch: add verbose mode
In-Reply-To: <CABJPP5AARO3h2mt-piPWuOD3kY_XzNfW-s2mi=btfOayVPURHg@mail.gmail.com>
References: <20210222075205.19834-1-dwaipayanray1@gmail.com>
 <bcee822d1934772f47702ee257bc735c8f467088.camel@perches.com>
 <CABJPP5AARO3h2mt-piPWuOD3kY_XzNfW-s2mi=btfOayVPURHg@mail.gmail.com>
Date:   Thu, 25 Feb 2021 14:16:12 -0700
Message-ID: <87mtvrc0gz.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dwaipayan Ray <dwaipayanray1@gmail.com> writes:

> On Thu, Feb 25, 2021 at 11:03 PM Joe Perches <joe@perches.com> wrote:
>> I don't have any real objection to this patch set, but as this
>> might be added to the Documentation tree and in .rst format,
>> perhaps Jonathan Corbet and/or Mauro Carvalho Chehab might have
>> some opinion.
>>
>> Also I do not want to be a maintainer of this .rst file and
>> likely neither Jon nor Mauro would either.  Perhaps you?
>>
>
> I could take it up if everybody is okay with it!
>
>> Ideally, the patch order would be reversed so the .rst file
>> is added first, then checkpatch updated to use it.
>>
>
> Sure, if Jonathan or Mauro has no objections to it, I will be happy
> to resend it so that it can be picked up properly.

So I haven't been copied on this for a while.  Looking in the archives,
I see that you have a manual table of contents at the top of the
document; you could take that out and let Sphinx generate it (and keep
it current!) for you.

Either way, though, if you want to merge this via some other path, it's
OK by me:

Acked-by: Jonathan Corbet <corbet@lwn.net>

Thanks,

jon
