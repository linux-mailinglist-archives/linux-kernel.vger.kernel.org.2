Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3236B39395D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 01:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbhE0XsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 19:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235933AbhE0XsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 19:48:08 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330A8C061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 16:46:34 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 131so3041230ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 16:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oUMq5gMakuTv+VxVCawBoEv0d6hHmUUnitcWr50QPbU=;
        b=n0nnJj3xNV7aoppJdcUWyqnujztsYmLvtUZZGXI8rspgnNsSoUcFFO2nRMYl4LngJR
         i35dmrfNWtbjLVeuNXKEtG96fCcdPE/CRCUGnRQ8dLyl1qfC9cqcErJeZ00Cs537VlJb
         nRBtj6x8BRASrwlvxGCXczuZvPyQ7+RIW3UbY+TVH6yCOPURf8Hfnx8J8gylc+BA/PIw
         mB4asa86kLk8SgBxCTIEINX/nlnGEKXEFSbkXwjSNC+R3mGDNNNIH1fL19ZzRiWYP7oo
         KswDkl4XlEJ7yMY90phpeO1w5UK9OzJ0rG9qotvVc0Dqhiw99s6e9RuZGdVzibJiMCvf
         tgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUMq5gMakuTv+VxVCawBoEv0d6hHmUUnitcWr50QPbU=;
        b=SYzoKaDuWxqBvnePcgiFGsOklmBMBLC/NaHu30waqfBCstXbvtooFcEGigsY0Hg3sC
         dbw+qXy8tqoY2Qndn3xneSrNADOMt0lEjzPCRTy/7CH/DENWQqSzRtwDvVrB9gPOQ+Tn
         pID1S2GanRRQ6X2s+WlA+eGeSCyWYhgBtEZWM5MHsn7p2UgOz0aEnXbJg5nF4r5D5g/p
         6m5BC94jATps5cOG4RbLVs74eaXeCmD3T8Ae54lH37rw/Yvw7bnxTl6T7sSrkOJFYqgq
         EhMp99mmMGxxdNFaQe07wnc570xjAo8veFjdH7Nr+i6hXv2Xl6LyVY/ZcUhcLe5C7zHu
         kIKg==
X-Gm-Message-State: AOAM530G48i3fNu57g5a4Xnf0OAVcBMvyPgukfW0j/zSsHnKLtptLr4f
        vpEeOgqzNlqK59hoQvbD7vUr/8+/Z8CC6s5Qp38N2A==
X-Google-Smtp-Source: ABdhPJxmDdGYglPiAFXs4Eu7ptrL+GCuuFiVIJrOFzslyzTdz+YvWNKCStjMplLuqgpzYu5Swlu4HGv5Pt7x5GCAszY=
X-Received: by 2002:a2e:b805:: with SMTP id u5mr4620596ljo.74.1622159192598;
 Thu, 27 May 2021 16:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210525055308.31069-1-steven_lee@aspeedtech.com> <20210525055308.31069-4-steven_lee@aspeedtech.com>
In-Reply-To: <20210525055308.31069-4-steven_lee@aspeedtech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 May 2021 01:46:21 +0200
Message-ID: <CACRpkdb90ruzyyz9xmKQRSB+cxZAn6t+bfjGahQio_kyk-5_Ug@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] pinctrl: pinctrl-aspeed-g6: Add sgpio pinctrl settings
To:     Steven Lee <steven_lee@aspeedtech.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "moderated list:ASPEED PINCTRL DRIVERS" 
        <linux-aspeed@lists.ozlabs.org>,
        "moderated list:ASPEED PINCTRL DRIVERS" <openbmc@lists.ozlabs.org>,
        "open list:ASPEED PINCTRL DRIVERS" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Hongwei Zhang <Hongweiz@ami.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 7:53 AM Steven Lee <steven_lee@aspeedtech.com> wrote:

> AST2600 supports 2 SGPIO master interfaces and 2 SGPIO slave interfaces.
> Current pinctrl driver only define the first sgpio master and slave
> interfaces.
> The second SGPIO master and slave interfaces should be added in
> pinctrl driver as well.
>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Patch applied to the pinctrl tree.

Yours,
Linus Walleij
