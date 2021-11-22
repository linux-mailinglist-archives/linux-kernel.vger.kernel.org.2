Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D413045963E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 21:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbhKVUuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 15:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhKVUuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 15:50:37 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AF8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 12:47:30 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso940884pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 12:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9FObduEZbWdjUpMXz60aZqufbQdzvSRG3lPMBJb7SJ0=;
        b=JneIEC9cvLJCbdtDu2vtG7jOReTI8ksmr7YGpy14cmKopDG1WNnzN9vyEAQ5ZFY1Ll
         wLrz0I8fq9UmpvvAfe8h8Dm9aKo2h0iPbnV+aXW1yLKcF9165JU7Nw0SLTEFehyBU+vN
         6QUq5HYvX2wTw8c3Eu9q6Z+6Y1Ty/R6fmPa7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9FObduEZbWdjUpMXz60aZqufbQdzvSRG3lPMBJb7SJ0=;
        b=FhAn1wHJc28MsFtPS2DlDCxZdzh/FLnfmhcgpL03wDqWkd7xFarVRhIlM+dJiU+zFr
         irghp4wk9hYrKISOQQTXSBYKR5cZ0Rn3EBLCd9y1grnDhlsU6Pqkb70h56mvFQZ4G40c
         G3cSEYJJeXHEI6y6c/CaV7JIYK6/A1pKLazJSnySTqCadnK99jxzodpYFmcpji0ZMunK
         0i5xrtgrb/fFp5p9T1gFCd8cr5KOeQm/iD031vaerjFokSnMP3OoJg6mrCtiVvfnxR4Z
         K8a41v8UKQx0tRw5oIjHeLzDxYFhaDNU7g3UNcVk8up1pnIwq7EY0Qyu0rldIzNTAxnT
         Fdug==
X-Gm-Message-State: AOAM530nV08R8MaaFsEBXsSTvYTdVq7EULmYwKZCuApwofWT0UYcqLYH
        9mrqhxzjIYbX8SQyAAx0Cya++g==
X-Google-Smtp-Source: ABdhPJwcHprzgfWpUQCUPhpzVPFnI4WiDGxFFLzGSTeGQcOoYiccm8mTTcquO4kALyNvrKtHzcsEvw==
X-Received: by 2002:a17:90b:1c8d:: with SMTP id oo13mr36323110pjb.239.1637614049808;
        Mon, 22 Nov 2021 12:47:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v10sm9796801pfu.123.2021.11.22.12.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 12:47:29 -0800 (PST)
Date:   Mon, 22 Nov 2021 12:47:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     LEROY Christophe <christophe.leroy@csgroup.eu>,
        kernel test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] powerpc/signal32: Use struct_group() to zero spe regs
Message-ID: <202111221247.B385EA2A8@keescook>
References: <20211118203604.1288379-1-keescook@chromium.org>
 <1e312cbd-cd52-ddce-f839-db765173c526@csgroup.eu>
 <87ilwkrbhz.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ilwkrbhz.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 04:43:36PM +1100, Michael Ellerman wrote:
> LEROY Christophe <christophe.leroy@csgroup.eu> writes:
> > Le 18/11/2021 à 21:36, Kees Cook a écrit :
> >> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> >> field bounds checking for memset(), avoid intentionally writing across
> >> neighboring fields.
> >> 
> >> Add a struct_group() for the spe registers so that memset() can correctly reason
> >> about the size:
> >> 
> >>     In function 'fortify_memset_chk',
> >>         inlined from 'restore_user_regs.part.0' at arch/powerpc/kernel/signal_32.c:539:3:
> >>     >> include/linux/fortify-string.h:195:4: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
> >>       195 |    __write_overflow_field();
> >>           |    ^~~~~~~~~~~~~~~~~~~~~~~~
> >> 
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks! Should I take this via my tree, or do you want to take it via
ppc?

-Kees

-- 
Kees Cook
