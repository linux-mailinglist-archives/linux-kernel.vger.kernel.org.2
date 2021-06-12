Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595503A4FDE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 19:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhFLRLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 13:11:44 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:38772 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhFLRLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 13:11:43 -0400
Received: by mail-qk1-f176.google.com with SMTP id c138so21508657qkg.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 10:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eF4uJPB1UaQG346iytYDyBpac2Jv1lo69omQv4FTdC4=;
        b=cHKQSVaqm+BdymJww/7MwVyuig7oIOR2OF87mHmkRq4Y0XMWHuVEodG1Rs3SEZojWG
         mT+D5tMfWxF3B846nUjegE0nfMz4RZIz/8FXvSt4YgR07l/JrUKThEY0zYqNEaamfcLK
         tEpeWZ2f0pvepQD1WLHvNjOX1MOSMUVRBEq0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eF4uJPB1UaQG346iytYDyBpac2Jv1lo69omQv4FTdC4=;
        b=l51nFmz/DRyPAQAnltOkckqkmzNppMwa7sU/KzdQwWoC7FStIxqlphqpezIVqpIOi7
         HliA660YjhCQ2IMOLDJbuFNZEum0OjWVia85NSjl3Iq0CdIHwyVTDIwN5Yhb/j/mNff2
         agzdf2o6ulvXYWBBgrrQOD1nodNHAtqqqUO4Oio/KIu76T8wOE3N5H15mhKeaT9+zSfj
         1ZqRiI54XQa4rH+rrnMOyCQwXFHW5sjjkv+Q3h2MKks2yQm9bC4TT+tuinNoPWLK+c3j
         zq9u8ZAWdq50uVwL6hWYOIktXn2JRroB7hk7nBuO7MwWEf/j9FxiYFgYaABh9jaEBJxa
         /vkA==
X-Gm-Message-State: AOAM530NkJKuq7mqQ0K3PB2fIjr/b4j3WkH2xEwjR6GPGYp01/BIbPR0
        FeGkSa6ELXlrHHYx+MjDkDTCusKpXUyc9JPEXPCloA==
X-Google-Smtp-Source: ABdhPJwFU4RBCkdvdeNBdtOCaz0q40IMdBvpCN+yhDZleT31VF0xTooIotPrY4HPtY77MZOBq2SudPXLZT60HVIbzr8=
X-Received: by 2002:a05:620a:a87:: with SMTP id v7mr9357572qkg.468.1623517715113;
 Sat, 12 Jun 2021 10:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210611200801.52139-1-romain.perier@gmail.com> <20210612125915.GA320112@roeck-us.net>
In-Reply-To: <20210612125915.GA320112@roeck-us.net>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sun, 13 Jun 2021 02:10:37 +0900
Message-ID: <CAFr9PX=j3UxbawtuvQnyoToH=3iT_k+j_LByUF-uDd0yDOk2ZQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Add watchdog for Mstar SoCs
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Romain Perier <romain.perier@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mohammed Billoo <mohammed.billoo@gmail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter, Romain,

On Sat, 12 Jun 2021 at 21:59, Guenter Roeck <linux@roeck-us.net> wrote:
> This works better. I applied patches 1 & 2 to my watchdog-next branch for
> hand-off to Wim. Note that the arm dts patch needs to be pushed through the
> arm tree.

I will take the dts patch and send a PR with it to the arm tree.

Cheers,

Daniel
