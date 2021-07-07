Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD803BE2EB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 08:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhGGGGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 02:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhGGGGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 02:06:23 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E29C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 23:03:42 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id n14so2033913lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 23:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bsNR85tqDq0Nnn+qEiX/ciVIvYBVMUZ7RHqxFZuZ7ac=;
        b=blo9Hicsv9504zHLVbxs8UBByiL7wgPHsEGttVgdYefQyIWPkuDVrZRisx9joq7Mz/
         Qu7N4YHMeiKdJl/rnFaBwKd+y7LtyFKFzqX6DyGXHJnw5la3DS32G1qr9LtwDltkCqZb
         HynWKzVzkf73s9lm/k5Gtb+2rFR0Nje3miol3zMdoTAGvyiHr/S0E47EZ2bnhDcfRlUF
         Cs37svVCH+kFq9isxxHAZ/w9flWKtpeMSapTxG+U5/MLRWNr4G9vidfiBnFXeXciMd/o
         SAliSgQrhlxOZd5x8LHWOrXkONosjNtuUGODCTc2u6TS8mEhENJItDcu8OnxOCUfdZ5T
         QmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bsNR85tqDq0Nnn+qEiX/ciVIvYBVMUZ7RHqxFZuZ7ac=;
        b=rQqnHtvNe/pXZLu1wmpkELKcqfnSJFvu2Y7EJk8v7WJId856DPpTAM+dU8GeNsCKC9
         weRuCGOx6gSx+Bs0xZZ6+0cVz/y0lzCHnvsSbFA71ELWYg4uSsikdjygWI5kvQaYz5yz
         GO5/Iza02niV3BFuis6CVbrtAo1thiZUJSBndXBC67qWJcpQIsxSHMsdZvrwAKpRWXdT
         v0YDTivK0jL8hX0wNT7dzVRzUrc8jebPyQRf0AusPBQpNknO2KBLvx/w7KWhYespZ39T
         RZwbUvIVs6z+deHmn234SoARz4s58AZagYIs7K0deT15dO5nbG5Stg3g26eN/4sM4ROY
         zdsw==
X-Gm-Message-State: AOAM533Ge0jL9RIsQ7VfcmEenaHza2QaCW+I0QqRK7Hb1AJH9fTw75s8
        INnQUpe4dhDVdUafcRkdeN+0BAhNfXgNXkz+cVDTlw==
X-Google-Smtp-Source: ABdhPJwuDZGs0hKLyoVnwNvI32TWwNFM1Ftg1kj8S0JdGejmefRNqnJcECXZmHEq2+4WMvIsxFQsowp575HfDWJxKa8=
X-Received: by 2002:a19:e002:: with SMTP id x2mr17608887lfg.84.1625637821291;
 Tue, 06 Jul 2021 23:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
 <CAFA6WYNn0+yxntkebqDVnOoq50gxY4Zvi1wGLAZTJyWGc7VLkw@mail.gmail.com> <f1aae58230a81e63cd380d1a45d5a2ee@kernel.org>
In-Reply-To: <f1aae58230a81e63cd380d1a45d5a2ee@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 7 Jul 2021 11:33:29 +0530
Message-ID: <CAFA6WYN3CvdP0DMMq3WBMGNju7h2tpMidFaTOvghLdxhWh+7Sg@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] arm64: Add framework to turn an IPI as NMI
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        julien.thierry.kdev@gmail.com,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>, wens@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jan 2021 at 16:13, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2021-01-05 10:34, Sumit Garg wrote:
>
> > Do you have any further feedback on this patch-set?
>
> None at the moment. We have tons of issues to solve with the arm64
> interrupt entry code vs instrumentation at the moment, so it is
> pretty much at the bottom of the priority list for now.
>

I hope you were able to resolve most of the issues. Is it an
appropriate time to have a relook at this pseudo NMI feature?

-Sumit

> Thanks,
>
>          M.
> --
> Jazz is not dead. It just smells funny...
