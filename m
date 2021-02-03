Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32FB30D90B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbhBCLnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbhBCLmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:42:23 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBB7C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 03:41:43 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id q72so2822666pjq.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 03:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=xR+OMVMVw++6jzb5vqbvGP1RTGBmrEmYExItlXvFh2U=;
        b=Rbdvs9Zl6hyvnUKBtlfOpgCIYmM0pbLg3sBeEC2y9cEMSP2JlqLsPByuxUCLYS1n72
         8pfB5ZGTSuEr/2aouUet362g5g87lB3Ajlcygs6HkvCQQ22niJXJgzL0gsgSwImZJ4f0
         k/rJomkLXBvgGxb6j9DNJRjFEoEHfhCTm5naXiGe0elWS+iMi8hIJ/5+0NtCCqScbSYw
         68YR4CWQ4O74Hs5gQEhNy5lc2+l3XDHrO6QIOC+jWHbM+v0f21GOAsYY5cU1NHBSl3jE
         aia3///KJOa/2jKr2e4xZ15XAIsPZe9ldy8zNg0aKxAjs7b8Ta+vSjRqf2+QRnGGoVrX
         O3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=xR+OMVMVw++6jzb5vqbvGP1RTGBmrEmYExItlXvFh2U=;
        b=ZmAipfAXkAuDpRgf4sC+uQWPC1yoQCWqwqYNWKBDL1s1SsZWDYTCw/bbSZmcYS0Lcu
         eShanGUxxuJzY5ceQ/VHZ8FGPlHpBmr6rIGrtVPBh+JRL1I4sWkBYPCqtRVRVcC7KrJW
         BWWFf31iPni6ZebcHoMyXf79WzIm4bFA0qFCl9uvESnqPeLbjYYqDM2FZinTR69BcTQN
         OpBip2RnJe9sHXneQKbJSzy/b33pU47ROzPmx72v4GBcC7FOPM+/tboIeQy2BywbmSi0
         DP6vDLHTj1Ka82zWkAwYlBydlV3biGatIgA8ViYzx+IL2wRcMWLOHogfkjM8AjrEFiOh
         GkMw==
X-Gm-Message-State: AOAM533w/yhxYBXMUzEx6oE/DdT5CO4tBQNkPKKYegNbRqTc/c995h8b
        7zZCAKjUYMZ7o468SnlbmA7M
X-Google-Smtp-Source: ABdhPJzrZ6goS6KBHLSdJBCgFpo9ChXrhawqr5yJjo9iJQnx4TN+DQTMIZG9p5QgkpONT3OYlpQWnQ==
X-Received: by 2002:a17:90a:b702:: with SMTP id l2mr2820197pjr.13.1612352502679;
        Wed, 03 Feb 2021 03:41:42 -0800 (PST)
Received: from ?IPv6:2409:4072:619f:ff99:700b:51f3:e28:b00? ([2409:4072:619f:ff99:700b:51f3:e28:b00])
        by smtp.gmail.com with ESMTPSA id 199sm2096001pfc.112.2021.02.03.03.41.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 03:41:41 -0800 (PST)
Date:   Wed, 03 Feb 2021 17:11:31 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20210203122422.6963b0ed@collabora.com>
References: <20210130035412.6456-1-manivannan.sadhasivam@linaro.org> <20210201151824.5a9dca4a@xps13> <20210202041614.GA840@work> <20210202091459.0c41a769@xps13> <AFD0F5A6-7876-447B-A089-85091225BE11@linaro.org> <20210203110522.12f2b326@xps13> <EBDAB319-549F-4CB1-8CE3-9DFA99DBFBC0@linaro.org> <20210203111914.1c2f68f6@collabora.com> <8A2468D5-B435-4923-BA4F-7BF7CC0FF207@linaro.org> <20210203122422.6963b0ed@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] mtd: rawnand: Do not check for bad block if bbt is unavailable
To:     Boris Brezillon <boris.brezillon@collabora.com>, richard@nod.at
CC:     Miquel Raynal <miquel.raynal@bootlin.com>, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Message-ID: <F55F9D7B-0542-448E-A711-D1035E467ACA@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3 February 2021 4:54:22 PM IST, Boris Brezillon <boris=2Ebrezillon@coll=
abora=2Ecom> wrote:
>On Wed, 03 Feb 2021 16:22:42 +0530
>Manivannan Sadhasivam <manivannan=2Esadhasivam@linaro=2Eorg> wrote:
>
>> On 3 February 2021 3:49:14 PM IST, Boris Brezillon
><boris=2Ebrezillon@collabora=2Ecom> wrote:
>> >On Wed, 03 Feb 2021 15:42:02 +0530
>> >Manivannan Sadhasivam <manivannan=2Esadhasivam@linaro=2Eorg> wrote:
>> > =20
>> >> >>=20
>> >> >> I got more information from the vendor, Telit=2E The access to
>the =20
>> >3rd   =20
>> >> >partition is protected by Trustzone and any access in non
>privileged
>> >> >mode (where Linux kernel runs) causes kernel panic and the device
>> >> >reboots=2E  =20
>> >
>> >Out of curiosity, is it a per-CS-line thing or is this section
>> >protected on all CS?
>> > =20
>>=20
>> Sorry, I didn't get your question=2E=20
>
>The qcom controller can handle several chips, each connected through a
>different CS (chip-select) line, right? I'm wondering if the firmware
>running in secure mode has the ability to block access for a specific
>CS line or if all CS lines have the same constraint=2E That will impact
>the way you describe it in your DT (in one case the secure-region
>property should be under the controller node, in the other case it
>should be under the NAND chip node)=2E

Right=2E I believe the implementation is common to all NAND chips so the p=
roperty should be in the controller node=2E=20

Thanks,=20
Mani

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
