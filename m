Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A573132E215
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 07:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhCEGXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 01:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhCEGX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 01:23:29 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC642C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 22:23:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DsHjn6wf6z9sVt;
        Fri,  5 Mar 2021 17:23:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1614925406;
        bh=vhZ+ardqsQ5ea5DSlNBSfyBBFPtTVFoe3/Aq+lA3Wms=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=W4Na6DiUpEajZaPOVjPsUiELSE3AFsUzknC3uEpdrbr+GqXVXR6GB/iZbets36I8A
         pUnaWA+0qviuS9Pj5qwEGIlx3JYely+VBLeNBKajvLhvT+Bs2YUc5IjytsHwRsjI4p
         L5KSUQ7yKZ4+DG21cPtPoQOqtj5MamKnd5o0ipHWAH/+R55Uj+PNcmEKJ10w6lNZ/g
         f0audOESlXLc2hBgO9zFi1lnNy9gpEFWO6/DPWqqCmeEFTkLirs68osCaSu7KpzNcg
         XdWMF4GO8LP3EXk8EPY2ywYy8g577rJpxuqrzySILgpk1uDlqZBtgWwb9gwcY0tOEo
         AX7XnJJyFQlIA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Laurent Dufour <ldufour@linux.ibm.com>, benh@kernel.crashing.org,
        paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Cc:     nathanl@linux.ibm.com, cheloha@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries: export LPAR security flavor in lparcfg
In-Reply-To: <20210304114240.54112-1-ldufour@linux.ibm.com>
References: <20210304114240.54112-1-ldufour@linux.ibm.com>
Date:   Fri, 05 Mar 2021 17:23:21 +1100
Message-ID: <871rcuruee.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Dufour <ldufour@linux.ibm.com> writes:
> This is helpful to read the security flavor from inside the LPAR.

We already have /sys/kernel/debug/powerpc/security_features.

Is that not sufficient?

> Export it like this in /proc/powerpc/lparcfg:
>
> $ grep security_flavor /proc/powerpc/lparcfg
> security_flavor=1
>
> Value means:
> 0 Speculative execution fully enabled
> 1 Speculative execution controls to mitigate user-to-kernel attacks
> 2 Speculative execution controls to mitigate user-to-kernel and
>   user-to-user side-channel attacks

Those strings come from the FSP help, but we have no guarantee it won't
mean something different in future.

cheers
