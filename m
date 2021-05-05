Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5907637390E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 13:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhEELKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 07:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhEELK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 07:10:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74CDC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 04:09:29 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id a10-20020a05600c068ab029014dcda1971aso1072677wmn.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 04:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BXOPEgevTuuM7YW5o4XEB+yh8uQ/yRiyPYvEuyt9rlk=;
        b=ANuorpiua0sGgLlVBH2gdNw0j0TpmyM8D/T6TBE666cw43U0J5AASfftojQGfhRT+r
         KKYkKgN2aqIx7jAsUD/tejnQ3QSPpGMcFtDJYDJqEUVAaZPykkGVKC6I+IzJifykGBUP
         RsKWslk3Rv+NenACT2hX862+jkr/r98KS1a711Qgj0T3NcY2rkzXYrANQ+t8H6yqywdQ
         0olQA0btEKn2Daqpq7JPbQfhw59sWYYLRPWErF17BaDwgMEGwpB3x/C9sMj5bi97eMiD
         tyedil6vbMW4CQHCppzAepeOGmdTA7eGSne9mOM9PrYn5nOf5FZ1gzsgYgaEPmPnjuO/
         zOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BXOPEgevTuuM7YW5o4XEB+yh8uQ/yRiyPYvEuyt9rlk=;
        b=OOHDCTYP2Tyk4eoTRdlA0hnxVXSa+fj09IDlKquXD1Z5jNeOY1MBKZsKh4oFj71eXY
         Ckb4oYi46zoaJW8mjaJwuw9pv4xlk4dIm9tgE8xtjwxooPZlSsDGjEd/1hhiuG4GxrOf
         Xxh/CTBHNZTStNKlfdO+8XHYO9l1J/RlYYs/8jt0fmP0/BQ65bxtUk5ufphCQwvHQCyn
         ltqr6V2pmLF7j3lSBRNCud0FB2ewE3q99qq5aPWltMsHOtJuh5NQ65034bLSagl6wT9P
         V86cVtFqE8CVliRlCkNAFAvrdYlfpor14iIEUOwtXP+uu7icJ4UxA9a3m+EUOae7g+tp
         1LsQ==
X-Gm-Message-State: AOAM531XJ8bxcwm1Wfqu0zxwt468LLncXCSQHr5rGZMawJrdWF5RbfMO
        YogsQd2FWzYqTEJbefjqYstlgXKPLc6FBlLRG0jklQ==
X-Google-Smtp-Source: ABdhPJyHD8cyhtTQbTODDMIM1PMek+Jbkt4kcJVY0oCvd3Gvpnddd223L28FLguuZ9+oUuRSr43pX43UL1K0ekQP3Ls=
X-Received: by 2002:a1c:9a88:: with SMTP id c130mr32441575wme.3.1620212968537;
 Wed, 05 May 2021 04:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <5057c53afb568fa70234de2f23b0ffeff75af426.1618421014.git.Rijo-john.Thomas@amd.com>
 <5072c20c-7912-4307-6e04-caa1fe54bf1a@amd.com> <20210503114734.GI21598@kadam> <01387b92-263c-edf1-52bf-b2244ebbd311@amd.com>
In-Reply-To: <01387b92-263c-edf1-52bf-b2244ebbd311@amd.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 5 May 2021 13:09:17 +0200
Message-ID: <CAHUa44HSaFYHUNEJ9S13czP5EZd2NdpWqaQN6zXaAn0ekt88Ag@mail.gmail.com>
Subject: Re: [PATCH v3] tee: amdtee: unload TA only when its refcount becomes 0
To:     Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Mythri Pandeshwara krishna <mythri.pandeshwarakrishna@amd.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 6:26 AM Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
>
>
>
> On 03/05/21 5:17 pm, Dan Carpenter wrote:
> > On Mon, May 03, 2021 at 09:04:35AM +0530, Rijo Thomas wrote:
> >>
> >>
> >> On 14/04/21 11:08 pm, Rijo Thomas wrote:
> >>> Same Trusted Application (TA) can be loaded in multiple TEE contexts.
> >>>
> >>> If it is a single instance TA, the TA should not get unloaded from AMD
> >>> Secure Processor, while it is still in use in another TEE context.
> >>>
> >>> Therefore reference count TA and unload it when the count becomes zero.
> >>>
> >>> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
> >>> Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
> >>> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> >>
> >> Hi Dan,
> >>
> >> Can you please give an Ack if you are okay with this patch.
> >> I have incorporated your review comments for v2.
> >>
> >
> > Oh, Sorry.  Thanks!
> >
> > Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> Thanks Dan!
>
> Jens, can you please pull in this patch.

Done!

Cheers,
Jens
