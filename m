Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70233FFAD0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 09:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347544AbhICHDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 03:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347087AbhICHDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 03:03:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24E6C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 00:02:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l3so3050482pji.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 00:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=tX5qYs0dETvoqBWPP8HUyqwljyhj3JImYoPGL2w/Zd8=;
        b=PRH/6+LLhOSqbVBzSZru0205gmu8g6INkPK22GFwFBSTnWVCfPw+AC61/LaLUG1DH4
         47VkeuctfiFS7/CZVN4Pb0VyuyUekqKBRstv8iJMmLG3FBMr26b+4/w/4YwR+h1D+z9i
         gF2+KtIF/ynk9pbTb2ELc3RSH2aOSMP0rm+cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=tX5qYs0dETvoqBWPP8HUyqwljyhj3JImYoPGL2w/Zd8=;
        b=ZuVLhyp6kGWzk7E0PO9pyOC/LbooUDhmkY+Ad/QzU0nY+jZ4Ko5G8eQMEJ+ugj2xFo
         3dkIRdHnVhixJ6b/XiQwEx2PRV5Aec5LMk12z+2BrjghYDybciUBZylXbU1uw8xDdabK
         pY9SeB7uXuDFOhFW26VNazWVq+ZFxwg2XRD2C57cALdtqYPghELuGUeDe2QCyZt3FS8s
         RyLhgW2UQ6OyurAUF+Y+B2xkOgpV756mL3mEaScRZoM0UvmKsJE/WVtmujrT+az6qiWJ
         635aka1yz1A935qJWxkmx5WWmDC6fwQoB3GrGS9r6KnrHAIe+dMUciMrgJh50KIsy7Gf
         L28A==
X-Gm-Message-State: AOAM53322eCuKZ2HS3JqiSRW7lFvBXRKiaClfRPr1XbNzNqgO9qpoNbH
        3CY1jVaXV4Ha0l7Fi38Iym7PNQ==
X-Google-Smtp-Source: ABdhPJwsTOxyAZHH5DdU+UKyd/usnRPUaX8BNpHXz1U2nfu+DzPEh9rxZPDzBA+N0Zb2ucVYoZkdOA==
X-Received: by 2002:a17:902:848c:b029:12c:daf3:94f1 with SMTP id c12-20020a170902848cb029012cdaf394f1mr1865204plo.50.1630652540381;
        Fri, 03 Sep 2021 00:02:20 -0700 (PDT)
Received: from localhost ([2001:4479:e200:df00:ddd7:1b3:9327:fcf5])
        by smtp.gmail.com with ESMTPSA id v7sm4030673pjg.34.2021.09.03.00.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 00:02:19 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/time: Remove generic_suspend_{dis/en}able_irqs()
In-Reply-To: <c3f9ec9950394ef939014f7934268e6ee30ca04f.1630398566.git.christophe.leroy@csgroup.eu>
References: <c3f9ec9950394ef939014f7934268e6ee30ca04f.1630398566.git.christophe.leroy@csgroup.eu>
Date:   Fri, 03 Sep 2021 17:02:16 +1000
Message-ID: <87fsum5eh3.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> Commit d75d68cfef49 ("powerpc: Clean up obsolete code relating to
> decrementer and timebase") made generic_suspend_enable_irqs() and
> generic_suspend_disable_irqs() static.
>
> Fold them into their only caller.

This does what it says, and simplifies the code.
Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel
