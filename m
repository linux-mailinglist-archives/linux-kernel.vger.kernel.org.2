Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1A13C6988
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 06:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhGMEto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 00:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhGMEtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 00:49:43 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83AFC0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 21:46:52 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id t9so20539566pgn.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 21:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=B7mN8pUEK+PsN4rxzvtJrI4zu8GDWwyoUDEgkpMIvtA=;
        b=VVffs6yqLFSO1bvmduw1ppr+nUinm5pJGtyzlh798GmQVojwS/GJ7sz2MCFt25r1vL
         UVmf1WUzDXvCROejYS/+Gi9QWqS//uAdYagdqx+5avcUsdfvFJmQSfZ51DSMovpnrBH0
         VM8j5XPHHuL7qM1+wGSHZ+ejX2Lto24pkEJV4ofk4oLXQ6SBrtYh9uD0rh8aapQANiYa
         m77A5SUyUGKB0iNZsPZHnFQX9hlriY7s3/R3twpCzP2r1pEmL4Iw+moMp/0nH3LftI5I
         +nWavHH5DXwvvlMgx/L3G3muL1fuoRedib60p6hMwWAjo8pzEooiMz9uwLJQB1u3Dsa4
         L7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=B7mN8pUEK+PsN4rxzvtJrI4zu8GDWwyoUDEgkpMIvtA=;
        b=SCA/TT8SrC0jMFCwQtgVzbaDSabFfG31WsLYm0tiCLx40baXAyBm9xlTWm8d8Djnt9
         DhNzi66cFVUf8WBb3rFfFmkx3JkZC3QBbvAgrCHnaAumFsudzHJlBFc9Sh6f5C0IWHQw
         L6Y7GDiabByQEaRTi2ooDJ9e8gHFUoWkgbjCnYeVqw0w6EnALjYnEvUm4iwqowJvlvJW
         hQ0Tu1SYz1CxgmHCwjHNJSO6ieClgStvBkTochQ9gEv1EbWnYd/j2dXB3G2EIl1drUfc
         EsPV12/RxDHG3TlNUg2zqN2hDOcxm44XTzR2E2VjMIGbp/kE07aPYJjbz8wW0Q1uQ9jF
         IZJQ==
X-Gm-Message-State: AOAM533FdfvJxwlLUq/OlCXEPc0Ygdzyy7K+PADb1R7RXZVadDuFztZB
        olWYRmfIKbCBDrFyIHBkASU=
X-Google-Smtp-Source: ABdhPJyrRTHCaLSpZio9zhxWM6op9AhNay+1WmcfGc7NYxmTK7DOaAnze3pJ615zSU9NnVrqgSH8MA==
X-Received: by 2002:a62:8f86:0:b029:32e:33d7:998b with SMTP id n128-20020a628f860000b029032e33d7998bmr53564pfd.64.1626151612065;
        Mon, 12 Jul 2021 21:46:52 -0700 (PDT)
Received: from ?IPv6:2804:14c:482:92eb:ffdf:6b35:b94d:258? ([2804:14c:482:92eb:ffdf:6b35:b94d:258])
        by smtp.gmail.com with ESMTPSA id w22sm4477765pfu.50.2021.07.12.21.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 21:46:51 -0700 (PDT)
Message-ID: <b25dff0f130b9ab721b8b524e55a3cd4c244a8f3.camel@gmail.com>
Subject: Re: [PATCH v4 07/11] powerpc/pseries/iommu: Reorganize
 iommu_table_setparms*() with new helper
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 13 Jul 2021 01:47:03 -0300
In-Reply-To: <97626d3883ed207b818760a8239babb08a6b5c59.camel@gmail.com>
References: <20210430163145.146984-1-leobras.c@gmail.com>
         <20210430163145.146984-8-leobras.c@gmail.com>
         <e4984fa0-2afe-a987-4fb8-61b878431b1f@ozlabs.ru>
         <97626d3883ed207b818760a8239babb08a6b5c59.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexey, 

On Fri, 2021-06-18 at 19:26 -0300, Leonardo Brás wrote:
> > 
> > > +                                        unsigned long liobn,
> > > unsigned long win_addr,
> > > +                                        unsigned long
> > > window_size,
> > > unsigned long page_shift,
> > > +                                        unsigned long base,
> > > struct
> > > iommu_table_ops *table_ops)
> > 
> > 
> > iommu_table_setparms() rather than passing 0 around.
> > 
> > The same comment about "liobn" - set it in
> > iommu_table_setparms_lpar().
> > The reviewer will see what field atters in what situation imho.
> > 
> 
> The idea here was to keep all tbl parameters setting in
> _iommu_table_setparms (or iommu_table_setparms_common).
> 
> I understand the idea that each one of those is optional in the other
> case, but should we keep whatever value is present in the other
> variable (not zeroing the other variable), or do someting like:
> 
> tbl->it_index = 0;
> tbl->it_base = basep;
> (in iommu_table_setparms)
> 
> tbl->it_index = liobn;
> tbl->it_base = 0;
> (in iommu_table_setparms_lpar)
> 

This one is supposed to be a question, but I missed the question mark.
Sorry about that.

I would like to get your opinion in this :)



