Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3B132A152
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577023AbhCBFfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 00:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574578AbhCBDsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 22:48:05 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39852C061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 19:48:08 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id jx13so1013497pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 19:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rcso78BwGVOEbZ2NnBuym7yv8DVTXrh7hVgCEjGyQuo=;
        b=TY3+B7+M/KvcZe3L7pQoy4X0FdgIq/voYvzOau5FSID24UtVk7v3WE7k/f8iodv8vJ
         LvPLWtETGyGwtpqWEQOFmzZD+S2kYdE5BEfZ+/HUOmKkHyNlBtrV072ZL+C+NTajTC0G
         X5dzGEv9x3caCt++C34TiodYRcYwEAHS6SbsLrC3PGX5G99L79QZ5KdNlJH/IkqmAYZW
         PSaRlQtsJ50wnWAfUR+vF//WXjZgdyQZhSNttorjyfLIcfiKXxSfd1MlmT+9STluUKXC
         xTn82LG52drjqxp1lVKTAzxeXg14nS7IRzuN+C8cW/pHezwOivteZokYW6yWDNjbC8SQ
         UhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rcso78BwGVOEbZ2NnBuym7yv8DVTXrh7hVgCEjGyQuo=;
        b=KHEtuV55IWc9TvytcUHD+vt1Qyk1pVpS2uqWRABUjCJ110odibVSQWAcubOlmDKYbu
         jHhz4cRuMsdE+/o1lpk/5M8E4xIPh2HO8sWxAL/5lKUeYt9gZK3DlRbp7EPKsH7LOLBC
         YyzMR/qRBJ/BHPWthbgzBe/BLsR0V+blovuyzF+miI+yrfoMwyPFaEDl2N9Mf/5PYNpg
         YcIFiEvfpt4MvtQAERel57Ma8PfSPXt/wNUBm6qG5/biTwe5qHJrHjePQLVz3xVJsFDA
         Nz9oWDKRyEhTkgjLw7ndYEgVrnnTkGRAfCKuiLjCKb7rcgo3zDXpghRrZYJh5/yZVlbo
         akyQ==
X-Gm-Message-State: AOAM533EBomVFQ1CRCzn3TX1pot7LyA4JP8rF/UvLW1p3AkiK876njY3
        fKc7dn0sYrE0wL+av4IVKM+WMQ==
X-Google-Smtp-Source: ABdhPJwQKsFEMRoWRT90TATQNSGem8urGVJxtEyweFNWlgRZJY8WyqNn0YwRQh2NawHUw0w9VJDm2Q==
X-Received: by 2002:a17:90a:7c0c:: with SMTP id v12mr2161626pjf.63.1614656887803;
        Mon, 01 Mar 2021 19:48:07 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id b26sm15332596pfo.1.2021.03.01.19.48.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Mar 2021 19:48:07 -0800 (PST)
Date:   Tue, 2 Mar 2021 09:18:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Desnes A. Nunes do Rosario" <desnesn@linux.ibm.com>
Subject: Re: [PATCH v3 2/2] powerpc: Remove remaining parts of oprofile
Message-ID: <20210302034805.o7ozib4pxy3t33ly@vireshk-i7>
References: <50ad16925a66ac53890286ceafbf84f6fc324baa.1614600516.git.christophe.leroy@csgroup.eu>
 <0085280627ee44927fc3f07590a8b4909cf8e56d.1614600516.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0085280627ee44927fc3f07590a8b4909cf8e56d.1614600516.git.christophe.leroy@csgroup.eu>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-03-21, 12:09, Christophe Leroy wrote:
> Commit 9850b6c69356 ("arch: powerpc: Remove oprofile") removed
> oprofile.
> 
> Remove all remaining parts of it.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/cputable.h       |  3 --
>  arch/powerpc/kernel/cputable.c            | 66 +----------------------
>  arch/powerpc/kernel/dt_cpu_ftrs.c         |  4 --
>  arch/powerpc/platforms/cell/spufs/spufs.h |  2 +-
>  4 files changed, 3 insertions(+), 72 deletions(-)

Great, I wasn't sure how the handle the cpu type stuff and so left it
for the right people to handle. :)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
