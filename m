Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25623EF3ED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 22:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbhHQUW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 16:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbhHQUWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 16:22:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922A0C0612E7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 13:21:50 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id n12so33239060edx.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 13:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aElaQY59KXNPtiLMXlPfttrGWOlXzIX0OonVI0K93CQ=;
        b=Vat3cvxN0e9+MaFZvF7B+FaV2NKJFQuMbMXn8KQ8MPAjcakztpp5gb9rEJoA4hZIRF
         TfxDNA3kE5Vd1hFPKYG+JFR9scuQxfeymknlhKo89/SziVd7cnovFAPzR4t8n1u3CVN0
         VEYjHbhqBBzPgJJK1ExSyHC8s5Ijl5N3e11BDgZlL/8GsHsbj6tXmPc5eMyvLroQuUZw
         LQmJwpltP3glVvoMIkvwV48skmc+AuC2zxYTbz9nA+a5AZheRhLPoyfSJO5uha2e+La5
         1AuzrqTNv+Pdzoz5kOi5HjMaq2Ha3bYqt3jJebrbn2kAtqJ3EvtJDnoFOYJWcjLGgza0
         lYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aElaQY59KXNPtiLMXlPfttrGWOlXzIX0OonVI0K93CQ=;
        b=tRJzNFsdV/EMXV9tIgQKqCs7e7bVOiXnyCWRsD/w8zUuhpbiTxE5q/nJ/Vcb6CeQAN
         5M7DKNYL34O1anyNaUp/a2l8I8i73P2E8hADiuKF/OPFckNQc8SZBCowmFdqxKPNOoz6
         u2uwLhKddVqwczfQPbjptrNIifGlvHwW1J/rvXmLeFET5FvtvwCMTazMozhjZ/7RG+qZ
         a09ccVgVJDM6Z+EHFD/7httf18teHt8ilq5pywOj4QgMX58iFOqsf4iFm+aTiJp0ali1
         1B3+kVTK2jV+8RIx9ioFmQEUTT42qsRZ0HYEIzh3g3q3XJkvsMIGDlhHTOO6oL13QSYI
         Fs5w==
X-Gm-Message-State: AOAM533JRxnnYbkPqAb0nNNv6GJbm2TqvF1YuA/ZQVW2v9Jlr4BBXYkG
        jS7oSvEQ62d1ewBQVVwz93w=
X-Google-Smtp-Source: ABdhPJzwjn9F8+5ManWa8VXN7eBp5yaOnUO8gvrfNaPb1wO23hszNQBUUXG/V0aZAYIajfvkj52e+Q==
X-Received: by 2002:aa7:dcd1:: with SMTP id w17mr5827652edu.322.1629231709244;
        Tue, 17 Aug 2021 13:21:49 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id z6sm1434472edc.52.2021.08.17.13.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 13:21:48 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] staging: r8188eu: Remove code depending on NAT25_LOOKUP
Date:   Tue, 17 Aug 2021 22:21:47 +0200
Message-ID: <1873149.OoslLVuAm5@localhost.localdomain>
In-Reply-To: <YRv4GLL0BsMm/lf3@kroah.com>
References: <20210816175138.21633-1-fmdefrancesco@gmail.com> <YRv4GLL0BsMm/lf3@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 17, 2021 7:55:36 PM CEST Greg Kroah-Hartman wrote:
> On Mon, Aug 16, 2021 at 07:51:38PM +0200, Fabio M. De Francesco wrote:
> > Remove all the code related to the management of the NAT25_LOOKUP
> > method in nat25_db_handle(). The only function that used that method was
> > the now deleted nat25_handle_frame(). Remove the NAT25_LOOKUP entry from
> > the NAT25_METHOD enum because it is not anymore used everywhere else in
> > the code of the driver.
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> > v2: Patch rebased against the latest Greg K-H's tree.
> > 
> >  drivers/staging/r8188eu/core/rtw_br_ext.c    | 112 -------------------
> >  drivers/staging/r8188eu/include/rtw_br_ext.h |   1 -
> >  2 files changed, 113 deletions(-)
> 
> This change adds a build warning, which is not allowed.
> 
> Please merge this, and the 3/3 patch into a single change, so that it
> all is removed together, causing no build warnings at any point in time.

Sorry, I didn't know that, within a series, no patch is allowed to add build warning
that are then fixed by the following ones. I did it for the purpose of splitting
different logical changes into different patches and the removal of code
related to NAT25_LOOKUP (2/3) introduced some warnings about a function
and a variable that were not anymore used. Patch 3/3 had the changes that
removed the above-mentioned no more used objects. 

According to your request, now I've merged 2/3 and 3/3 into a single v3 patch. 
I had to drop the numbering of the patch because neither 2/3 or 2/2 seemed 
appropriate to me after the merge. I hope it was the right thing to do. If not,
let me know, please.

Please see:
https://lore.kernel.org/lkml/20210817185723.15192-1-fmdefrancesco@gmail.com

Thanks,

Fabio

> thanks,
> 
> greg k-h
> 




