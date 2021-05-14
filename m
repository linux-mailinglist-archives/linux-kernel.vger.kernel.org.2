Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFE63809F2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhENM6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:58:16 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:46794 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhENM6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:58:15 -0400
Received: by mail-ot1-f47.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso26291715otb.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2PUY6+lcZya65xL2jteI62slaBcVWnrYWPQ9BJUcQuE=;
        b=OHIaVDTQP2NggYNTrzPVw3KC1LoQJzwB8eo7D1q1Bod93DIxIn0emmzDGviID1Zlv2
         6gLX90l78Og2I2EMEju/mOQJX4PeSwDde5tcmw5Z9u2d6bWM58SCYkzYXo/BCEvdvRFs
         DHw5t6gThAnzOoEDMtmQkM/40CMD0R11VrT5lLpfooV5aeRIwkYVwsowECmB2AyWLE1P
         qK+lPHdq6doEsyKSBoUSJnwGU3syuCWXtqayonWTeGP3WQF0AfFKMKnUSuKN9L08fN1D
         UeRiukhiewh1cqJoViQnC1zd76PY96iQdO6FMN7Zi48aRK8doJ4B7agA9U+bC7nxv+SJ
         mcQA==
X-Gm-Message-State: AOAM533U89Tk4JR+fnSOuJm0IibB5yyAc/OpCsq1NL5zL+rIWk+Vk/ER
        +TBzjWY7I5H5WswtgzO2jpCyuE4Sr4ZjsUmL4NjhurFR
X-Google-Smtp-Source: ABdhPJxy2gNl72sXNKEKPsn2g+fDb1vhLoOtWSv1i9vmTESRkTKObltyJFXAS3tuOtLl81Y9Sz/yMH5g3TllTczyq+Q=
X-Received: by 2002:a9d:3bcb:: with SMTP id k69mr41220763otc.206.1620997023213;
 Fri, 14 May 2021 05:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <11761395.O9o76ZdvQC@kreacher> <YJ5uZMEpWXvtnJuQ@kroah.com>
In-Reply-To: <YJ5uZMEpWXvtnJuQ@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 May 2021 14:56:52 +0200
Message-ID: <CAJZ5v0hvKb3tyTLZtvVZcrAY_=p6fEni4j=7UguLEA2s9s82+w@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] drivers: base: Device links removal fix and cleanup
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        chenxiang <chenxiang66@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 2:34 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 14, 2021 at 02:08:16PM +0200, Rafael J. Wysocki wrote:
> > Hi Greg,
> >
> > Patch [1/2] fixes a device link removal issue that may trigger a "scheduling
> > while atomic" error in some situations and patch [2/2] is a related cleanup
> > on top of it.
>
> Thanks for these, I'll take them on Monday after -rc2 is out.

Thank you!
