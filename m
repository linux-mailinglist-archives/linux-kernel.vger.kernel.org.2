Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908FF389A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 01:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhESXxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 19:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhESXxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 19:53:46 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52B6C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:52:24 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a2so21645156lfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n7Oe0V/LUeDNOz9LkGrom9GQWiVN8MKh46gdzx9kyn4=;
        b=P7JJ918ULNWha1Y2qK/4BUen5FQObNbFSdCHY6KFXjpvaIDcPFreflGKgQm1PkPHZc
         gqthbxu65Xrl95/rB3Bt4Sz4D5ImK0uJxzi5bQu2Exe6Jer9iWOqC81COHBH4tzCebp8
         yshZcI27WA/rrWi5mVRVguOki08ih/MbvEMNpbAcGwnJDIjCerYFKQLcsMoH5yXpEns8
         lIisNKxRhCcNSnAeI2jYifAwMLN5c+ijx4o7Qyu+wTdB6oUSgwew+5M/oRE0CN7oAKR7
         c9g9BS8qiMewuOgXE8yLh3sZp7eKBLbGUVaYXdAWCB8mkmj6RDxlbf7exaKZ2iRAlw1o
         NV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n7Oe0V/LUeDNOz9LkGrom9GQWiVN8MKh46gdzx9kyn4=;
        b=d1/U9oep06Oi9P8fXF7XbWW5vBeN66k/CpiANvM2pZrW07bQH7n4NNNSKFV2Rl68ci
         4WYPB3wLw5/aeAr5jV/weooUjym7Gg/YcJtfbKnLmDRHIq5M2/D4KAzFSn9cB5Omnkqg
         WGnpxYRL+88JRTFWzILSDEMSXgPDjkjwn0oDQetKn5Fm5gHUbWF4Lp1apKIwC7F/HX8A
         rzzzEfNYi8RJPcUXPfCETho5r6CzREsRSGQeeSeepTwlmcfsDN0wzmTAZRJgG+eHD68S
         c9bRCpUI8zEwXcLGXnFg1OgFAmuGVgYywbftjNubxcbmthffcwfSG7Jveo1L+cleK2K3
         k4PQ==
X-Gm-Message-State: AOAM533pxnx80Qnj6C5wfPnriJHYWEXaJQevEVu5yMbSmp/ps8fl/ZzN
        BLqejzUAx29Nr5apOgdl2HD1yLC+T4Eer+EdNLFZjA==
X-Google-Smtp-Source: ABdhPJx70MZQEQx8AgJ1R/ChQ/H4NYiC4ffvNrsd2zJ1jxM74BJtoinqAm4WkL0RKVNfL+N3CSxXneaPIlCwoe32Xjk=
X-Received: by 2002:ac2:544f:: with SMTP id d15mr1357798lfn.465.1621468343155;
 Wed, 19 May 2021 16:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210513160947.1716185-1-j.neuschaefer@gmx.net>
In-Reply-To: <20210513160947.1716185-1-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 May 2021 01:52:12 +0200
Message-ID: <CACRpkdZLeEDipA1C3bjHF9J=JELakhKaxCsm=uDfVYsHpG-twQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: npcm: Align a few entries in the pin function table
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 6:09 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> The entries for GPIO 33 and 34 are not properly aligned. Fix the
> alignment.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Patch applied.

Yours,
Linus Walleij
