Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824A83DEB58
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbhHCK4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbhHCK4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:56:06 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1849DC061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 03:55:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id hs10so27056692ejc.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 03:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b775T0o3dl9efnhPdKjccZEHW+UAd83dWP0o6EQxnlU=;
        b=PekEqolERyIuleznCHIIji4gaYdHvGg7br58cJEolAT3Ba48AQzXsgjQa0Po55t/9j
         jRQh3xVlSVXvFZAk+E4PyCTVbOomg2yy/qpuiaZ6nc8thaRNRwkqvqzgwWkxdTw+oXOU
         tAlAo0LYj9tMGgQc6D0RuyowJzFzGAu3GXfOoLbZwF3JI4mLmH+Z7jVqmnvmRXLpsgSN
         DkAzar0n+yGPWrwF3r9lg8LA5jeFn4cONwNFzEgxPPxEMWJB6Os/TJjX/7x6vCgQ2NZ6
         vkdQjId5rYM4srAXJ36G+lsRbLPilumZUpm9hXbCLcCZiituQcnvCos5yE2tAIj+14yf
         5Ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b775T0o3dl9efnhPdKjccZEHW+UAd83dWP0o6EQxnlU=;
        b=TaENUxEeuxTy/40CnpOq28fmq5t3S5xXP9N319Poc3/DbhO9lgRWwN4U15MX5bFpUZ
         XK/FC2LGtNhm1AMXF0SExFXZOXfbA8Gal5znngvhTHU1GRtrXolz03zvsXnJttEE37d7
         pW4u9P2rRQTNuupff8rz4fssTgkarNrkIN9HfhpzSNN8/2Hig29KJi4986QP4IAPPnfl
         T3mxLbFO3uINnvWyg9gOa82oxVHs4tkzExaG423aerNRj0PT8yd8AS6w1k54dYGdQxRg
         3m5aLpoRyHRL3c0OITsg7Y9nVBy5D5gJCEY7ut8lshl2MZlkl24mAFyzRF4wypQP4mgL
         6h4Q==
X-Gm-Message-State: AOAM531mncIhrHXPV+ypzKZddtrtp/egpgceRyxYNMijVv5xtlTNBLO0
        27DO5vTyVqARXfa8qNVBr0RbML3fprDKk4vIjNI=
X-Google-Smtp-Source: ABdhPJyx7I7HkjwPoFcPmfDdi4vE09M9E5GaSupBvmXbTos6gneBjF6KoMHmWQ7GL4pBQoTzTUKSv5qjKAAQJ0EqsWY=
X-Received: by 2002:a17:906:9fc1:: with SMTP id hj1mr19596637ejc.103.1627988153633;
 Tue, 03 Aug 2021 03:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210803075159.2823913-1-mudongliangabcd@gmail.com>
 <81ccbbb5-5499-7a75-88ba-bae5328ffbf9@canonical.com> <CAD-N9QXfdossFaQFwa-DPCyY-deHZ-75=LtSQYihvPNDpzwqiw@mail.gmail.com>
 <d248924f-3dca-7be8-39d6-4ac746670ae4@canonical.com>
In-Reply-To: <d248924f-3dca-7be8-39d6-4ac746670ae4@canonical.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 3 Aug 2021 18:55:27 +0800
Message-ID: <CAD-N9QVAR0PCo=5aokYuSNg=W5XwcvWQQxCjPrMj240EDN=zKg@mail.gmail.com>
Subject: Re: [PATCH] memory: fsl_ifc: fix leak of irq and nand_irq in fsl_ifc_ctrl_probe
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 5:51 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 03/08/2021 11:28, Dongliang Mu wrote:
> > On Tue, Aug 3, 2021 at 3:57 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@canonical.com> wrote:
> >>
> >> On 03/08/2021 09:51, Dongliang Mu wrote:
> >>> In fsl_ifc_ctrl_probe, if fsl_ifc_ctrl_init fails, we should free the
> >>> resources allocated by irq_of_parse_and_map.
> >>
> >> Your code is doing much more. You also touch nand_irq, not only
> >> fsl_ifc_ctrl_init(). This looks incorrect as IRQ is optional, isn't it?
> >>
> >> The problem is entirely different than you described here - the error
> >> paths of fsl_ifc_ctrl_init() and request_irq() are wrong. They do not
> >> release resources in proper paths.
> >
> > Yes, you're right :). This patch rewrites the whole error handling
> > code. Any comment on the code changes?
>
> I did not check the exact error paths, I assume you are going to make
> them correct. Therefore only the nand_irq which looks optional and your
> code makes it required.

Well, yes. It seems unnecessary. I will revert this part of the code
changes and send a v2 patch.

>
> >
> > I will rewrite the commit message in the patch v2.
> >
> > BTW, there is a minor issue: if request_irq fails, we should not
> > invoke free_irq.
> >
>
>
> Best regards,
> Krzysztof
