Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401A539BE22
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFDRMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDRMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:12:33 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F099CC061767;
        Fri,  4 Jun 2021 10:10:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EB5AF738;
        Fri,  4 Jun 2021 17:10:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EB5AF738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1622826646; bh=vJNivl7SR9ek+8wa31F0Nt6UYvCOVHJpOIdhOSpcrmg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DI071yGlwfBt7RqJzRl+/ANE4fCQr+1dOq0zsQD5aILsicCv+PM4rngoLB4LcIUI9
         HZdzVLxhEqaOCJnRfjT9WX0aiM8zDRCX9kfI7UFHV55Es/gma0UhvPnx4geX1vMfBI
         KwK6CDInhSOhRKwri+WmbH95N814VyzXbm6LPpPa4tbjopM8FkfOP9g6Da2xNKJE5h
         yRofaV606/Eqr5JoPZ9p2qEC3hFkMmyeHCzYIyghMU2a4pxbk+7VNRa+cXi3J2zVZ+
         ZUEIH4LfVXQfkrfD5pQb1K4QtAKqhGJm4zarqO6bMWYDPA4bmdhuSvGUIwUnnAE3XG
         ho81IVm6E4L1Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        samuel.thibault@ens-lyon.org, jani.nikula@linux.intel.com,
        gene@collinsnet.net, w.d.hubbs@gmail.com, steve.holmes88@gmail.com
Cc:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        speakup@linux-speakup.org, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        chris@the-brannons.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs: Convert the Speakup guide to rst
In-Reply-To: <20210603145953.10982-1-igormtorrente@gmail.com>
References: <20210603145953.10982-1-igormtorrente@gmail.com>
Date:   Fri, 04 Jun 2021 11:10:45 -0600
Message-ID: <87zgw5zhbe.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Igor Matheus Andrade Torrente <igormtorrente@gmail.com> writes:

> Modify some parts of the text and add the necessary formatting to leverage
> the rst features. Including links, code-blocks, bullet lists, etc.
>
> Also, add a table of contents at the beginning and changes the license.
>
> This change helps integrate this documentation to the rest of the rst
> documentation.
>
>
> Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
> ---
>
> v2: Rebase the patch to cover the commit cae2181b498fe
>
> v3: Adds some Jani and Samuel's suggestion, and changes the licensing.
>
>     And, therefore, this patch should only be accepted when we have
>     all acks from the copyright owners.
>
>     Current status:
>
>     Gene Collins <gene@collinsnet.net> - Pending
>     Samuel Thibault <samuel.thibault@ens-lyon.org> - ACK[1][2]
>     Christopher Brannon <chris@the-brannons.com> - ACK[3]
>     William Hubbs <w.d.hubbs@gmail.com> - Pending
>     Steve Holmes <steve.holmes88@gmail.com> - Pending

This looks good to me, thanks.  Please send me a new patch when the acks
are in and I'll gladly apply this.

One final note on the licensing: it's fine to keep the document
dual-licensed with the FDL if you want to retain it - that's entirely up
to you.

Many thanks for indulging us on this - I know this led to a whole effort
that you weren't counting on when you started this project, and I do
appreciate it.

Thanks,

jon
