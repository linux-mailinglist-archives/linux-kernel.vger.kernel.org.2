Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47C9402DD5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242065AbhIGRor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236862AbhIGRoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:44:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF0DC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 10:43:38 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y17so8722254pfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 10:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqwUbYH10yU7MeGsUaFiPo7qZbwKlSS2XiBb3FPapD8=;
        b=lKx2rrU1ztadshXEidn+Xm1KEocYYVZI9KeUxEWOtzv8EkwbzAloRRnia/EHQ0AUnU
         4/NAEhIc1VIiPrR+F2QQVeT7Tn9aEnfrPM+L/561NwCaEKLVFu1XtxsovCVtIkssmHis
         2pmtR82t9pmP/hiVcIGmVw3wbxCav30E2j9mzM5hIL9sv/LX0aOebmWI9mhTMUee6xzo
         t9Jxj+3SYJFl98ncNPmY5layzsUw8MVLDtZ/AUj+QR0Zd3b+aLlnwxFfLaeZ1j05wzjD
         ux4MvK0xrzWqP2ja29LKhuMxuP2FrBJ+o/vc5b7rtLALWcIo49z4zWpn2LVjkLUHH/d3
         88ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqwUbYH10yU7MeGsUaFiPo7qZbwKlSS2XiBb3FPapD8=;
        b=i8cK9gA5mcY55HTVBMqKnQL0KyJsOeuH5Rl0AtMeOfd0ZAyDaysm+Yq5FuEiWKbOC9
         fgNROB62sBjjr0p3sNOKgpRjLlg5aUF7RsjVrza3h40yxG9LX0cjVV3Lak3ObaTtYnju
         issQaxFQ6mus6jVPcuy2JliwobzgANWq+ckfSoZwn3Cim/Zpq2DsrBOeYHX6X8mc/IAz
         K3yyfxDnV3zf6LWVqoxPIoURbwAUq23jefIqAMd6FFhQ9CFWgtJ2YHQTbgvigouq62tv
         BbJH3PACxpnUzGSoh3JFr7d/WUSlxrP+jJd6eBsNIx6e0cRIF6bBmT8cjwPcQOA89JZl
         0NNQ==
X-Gm-Message-State: AOAM533mN6ifbKCL0yttSPNZyAf/PlKfb1nlYV7vcF8ektpeWvnXgfdl
        cKCk0eEmXFQCO65sLdx5H+y6AQtZYJ34dx0bC64m4A==
X-Google-Smtp-Source: ABdhPJyyDhFDo9smGv6KpQDswNiKCX9+8fgALhkfPGkcKWUVrfkE10SeT/PZSkNnTqVoL2xCobfI3W1cx5t2bZm5SXE=
X-Received: by 2002:aa7:8298:0:b029:338:340:a085 with SMTP id
 s24-20020aa782980000b02903380340a085mr17912192pfm.46.1631036617612; Tue, 07
 Sep 2021 10:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142037.59f76dab@canb.auug.org.au>
In-Reply-To: <20210906142037.59f76dab@canb.auug.org.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 Sep 2021 10:43:27 -0700
Message-ID: <CAPcyv4gSW0Rkz24eCs9gHE_hPZzPWbNXU1TMNGSHGW0sqvUgTQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the cxl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 5, 2021 at 9:20 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the cxl tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
> drivers/nvdimm/label.c:750:32: error: 'uuid_to_nvdimm_cclass' defined but not used [-Werror=unused-function]
>   750 | static enum nvdimm_claim_class uuid_to_nvdimm_cclass(uuid_t *uuid)
>       |                                ^~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> Caused by commit
>
>   d68bc4b2338b ("libnvdimm/labels: Add address-abstraction uuid definitions")
>
> Exposed by commit
>
>   3fe617ccafd6 ("Enable '-Werror' by default for all kernel builds")
>
> I have applied the following patch for today.
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 6 Sep 2021 14:14:52 +1000
> Subject: [PATCH] cxl: mark unused function as such
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/nvdimm/label.c | 1 +
>  1 file changed, 1 insertion(+)
>

Thanks for that Stephen. I'll just back this patch out and retry for
v5.16, it's not super critical.
