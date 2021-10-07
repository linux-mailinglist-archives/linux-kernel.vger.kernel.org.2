Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC652425382
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhJGM5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:57:23 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:34825 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbhJGM5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:57:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HQBBQ5PQdz4xbR;
        Thu,  7 Oct 2021 23:55:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1633611327;
        bh=Y0KQwZsDfOdTg3GKHjg+c55QXVx0McJy0Ytp18M8szA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VEpEllcLwgz2G4MZA7I2RQmq2EXfGMtV2HQq4pqI8wAzGRZcL9maiLMmTv/UcjLtq
         ukJ9T/0IuIoUMHyCcWAbHxF16I1MJRPjqV1QaCCS1MEw6qnEr7O0Mgj8EHBsQYf9yY
         9PcsQniqwDS7oMUu42H/vDSUwnhyVj2Z5+/2W+/k9Ypk3cIusigGPt6Kw7hVA5IaJa
         YnMeUIZMSk2hALgXA2WykJ5mOuG4sEjUD+/6GVU+mTQaOTmYBkKjsBAZegibQ/pvKz
         RlbaFb20Ka0d4XuYWY3Eq4V8vaxxOBM3gHraOnVkS0DZWpgqQFpzYriYoSIjQpjS6Q
         QY9V8LlCGJbiw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Daniel Axtens <dja@axtens.net>, Kai Song <songkai01@inspur.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Kai Song <songkai01@inspur.com>, linux-kernel@vger.kernel.org,
        oohall@gmail.com, paulus@samba.org
Subject: Re: [PATCH] powerpc/eeh:Fix some mistakes in comments
In-Reply-To: <878rze60by.fsf@dja-thinkpad.axtens.net>
References: <20210927023507.32564-1-songkai01@inspur.com>
 <878rze60by.fsf@dja-thinkpad.axtens.net>
Date:   Thu, 07 Oct 2021 23:55:23 +1100
Message-ID: <87ee8xngec.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Axtens <dja@axtens.net> writes:
> Hi Kai,
>
> Thank you for your contribution to the powerpc kernel!
>
>> Get rid of warning:
>> arch/powerpc/kernel/eeh.c:774: warning: expecting prototype for eeh_set_pe_freset(). Prototype was for eeh_set_dev_freset() instead
>
> You haven't said where this warning is from. I thought it might be from
> sparse but I couldn't seem to reproduce it - is my version of sparse too
> old or are you using a different tool?
>
>>  /**
>> - * eeh_set_pe_freset - Check the required reset for the indicated device
>> - * @data: EEH device
>> + * eeh_set_dev_freset - Check the required reset for the indicated device
>> + * @edev: EEH device
>>   * @flag: return value
>>   *
>>   * Each device might have its preferred reset type: fundamental or
>
> This looks like a good and correct change.
>
> I checked through git history with git blame to see when the function
> was renamed. There are 2 commits that should have updated the comment:
> one renamed the function and one renamed an argument. So, I think this
> commit could have:
>
> Fixes: d6c4932fbf24 ("powerpc/eeh: Strengthen types of eeh traversal functions")
> Fixes: c270a24c59bd ("powerpc/eeh: Do reset based on PE")
>
> But I don't know if an out of date comment is enough of a 'bug' to
> justify a Fixes: tag? (mpe, I'm sure I've asked this before, sorry!)

It depends. If you think it's important that the fix gets backported
then you should add the Fixes tag.

In this case I would say no. The comments have been broken for years,
and it's a pretty obscure API.

cheers
