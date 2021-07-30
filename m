Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2291F3DBAF5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239250AbhG3OpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238873AbhG3OpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:45:22 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0750C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:45:16 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id t66so9688838qkb.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zIFyuAd42T9MX3qAoYpiIH7RLSS0/Rx9i9YWLtwvrgo=;
        b=MZMNdU90T1mdr8f+FlrQaQK/8xRSpuWb+VLJYY04eQAnQjNSfuvvE2QrwqSops4AMK
         YoYRYQLiThc0bxkrK9iOOdLLSyRaxse1aXajornOiRMRdWKS5p4sY2rCHlwWqgP+HZyz
         zkt6k0YfRmN5zyErzIxLsFY5wJEXsdX68OBlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zIFyuAd42T9MX3qAoYpiIH7RLSS0/Rx9i9YWLtwvrgo=;
        b=O0NnFfADrcwvyDPL8q6bUOyReNlaL2WE5IfFUbjPpHq5+d6uDDvQImnVWN2QXBBK4l
         FSUIXjBeIE4CKljqZDANT9AI+mkVSwO9SX8jlcrg36E6sGDcZ8SzrHLrGBwX8BA/NkDD
         2qO9uqBc1j00cKYad0DyqXBkUcHabRpPxJDTLn3mCWxLtXv1pQC3Mol7K+z55dJUDF57
         Qa9KN4eGUEMa90P5N6gloQOFV17HhvnbqY727OXBYqe0dfQFv8O7pZdNVM9G/3DGe8r6
         6pO0d9T2UM0syNg2KVJANbqfCVNuRinJFA1z+MVDSwuY2m8W548RoGBwG/8zB+NbFouY
         thlw==
X-Gm-Message-State: AOAM531sIhjRq77Optg8gmv0lJVLp9nJEmaoF7IILsFa0RRtL2WJup1K
        5Vsb7uhFiMMcpL0iTHijaxhoTwHeg8SBk5rM/faWPA==
X-Google-Smtp-Source: ABdhPJyz3l2sQZ+SSXfddd6sETZFkOS5YZXDtdPgdR5B3eaKCu+XhEgm3upVc9TljLMB6v7V3xiiVDe05DNMJPnsckQ=
X-Received: by 2002:a05:620a:1242:: with SMTP id a2mr2651740qkl.443.1627656315951;
 Fri, 30 Jul 2021 07:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210730134552.853350-1-bert@biot.com> <20210730134552.853350-4-bert@biot.com>
In-Reply-To: <20210730134552.853350-4-bert@biot.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Fri, 30 Jul 2021 23:45:05 +0900
Message-ID: <CAFr9PXkHfncDq=XybcTu-W=Q0ieFRSP5vvSk1nNz2F3jfoS50A@mail.gmail.com>
Subject: Re: [PATCH 3/5] ARM: dts: Add basic support for EcoNet EN7523
To:     Bert Vermeulen <bert@biot.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bert,

On Fri, 30 Jul 2021 at 22:53, Bert Vermeulen <bert@biot.com> wrote:
> +
> +               cpu0: cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0x0>;
> +                       enable-method = "psci";
> +                       clock-frequency = <80000000>;
> +                       next-level-cache = <&L2_0>;
> +
> +               };

Super nit but looks like an empty line snuck in here.

Cheers,

Daniel
