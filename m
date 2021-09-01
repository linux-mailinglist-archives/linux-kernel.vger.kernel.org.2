Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292C53FE648
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243230AbhIAXjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 19:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbhIAXj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 19:39:29 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CB2C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 16:38:31 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id l24so61119qtj.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 16:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tir4KIBG3dCXrYCogu3jCVBol3D5m4vSoqwXylYsFiE=;
        b=ZFxopLROBmPnRktluWCNeHM7I+tzgt0S8c+smEH9kAmM90pFOCGKf1cIwwgMHSu538
         x5dpxPKToHQXd0jahsEVexq7B6Euqq7HxA4T2jVYJ5etI5BOYslvB2TBtBiDxFWQvCHb
         N866HjIeeEcbl66YkNwyWYGXv+Qhb1lb9lu2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tir4KIBG3dCXrYCogu3jCVBol3D5m4vSoqwXylYsFiE=;
        b=FgnAQEpFyErvPNhn2EY6cqYz8etKWWodfF2IpJ3/0/ckQ+qTgZZadD0018GAfyEU5+
         kpqTD25QyPRm+wNvH+TnAybN5W04lq7TInll3Ohm3Q2RkVN68OYKaURN1IVOVkQPCrCH
         LpLHV2bQ0Zjv4y7wW76ws5u2ODGqip2wz9K8QoKgbNDkqaS07Qf9aZ0gL5IGeLNXjL6e
         QC1RhoTSb53ulX0qDSGunDDG38e6AtxV2g08MHRzscQK4Op8tTag7Lt9lmVpC7LhwDPJ
         QfPHabPv0NX3zYc658wIcv2mNJ6BkfkkLwyyUBsceZTxTIiNE4xggD9gN+/7ptEU3wEY
         54GA==
X-Gm-Message-State: AOAM530NRrpQeXbIjkcEFz+sCqluOz6l8Qeg5RIjV+4/q8CNP/dCOYqk
        rJuCjdDuQhdhZM466OLGHMwKJ0cYrwXINz337vE=
X-Google-Smtp-Source: ABdhPJw4rt3vP9gie32nN5C+iz/ULYfm2ZiAjfhjp74z/tLXhYHPnoYnZ9vD90CRNhS0kAuMkT9jEuH1l7bvLU5cdzo=
X-Received: by 2002:ac8:4684:: with SMTP id g4mr322134qto.290.1630539510944;
 Wed, 01 Sep 2021 16:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210724224424.2085404-1-linus.walleij@linaro.org>
 <20210724224424.2085404-2-linus.walleij@linaro.org> <20210821042010.GA1759866@roeck-us.net>
 <CACRpkdYObGTWni3sSa21iNsgikzj7t9MA6y4TNgkBTTYQt+coA@mail.gmail.com>
 <4d87c7af-d2e3-9456-130a-b35b507ff3a2@roeck-us.net> <567a65a8-077b-7394-c8e2-dbd9f063e02c@kaod.org>
In-Reply-To: <567a65a8-077b-7394-c8e2-dbd9f063e02c@kaod.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 1 Sep 2021 23:38:19 +0000
Message-ID: <CACPK8Xfu7K0FosjnfaiETXVP+QX9fOtUE5PymegvHc3MaWy52A@mail.gmail.com>
Subject: Re: [PATCH 2/2] clocksource/drivers/fttmr010: Be stricter on IRQs
To:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2021 at 08:08, C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> AFAICT, the ast2600 does not use a fttmr010 clocksource.

Correct.

When doing bringup of the ast2600, I updated this driver to support
the new layout. Only once I'd submitted it did I learn that aspeed
preferred to use only the Cortex A7's timer source, and only that
source.

The armv7 timer can be lost when a core goes into power save mode, but
I am told the ast2600 does not implement power saving modes, so we set
the always-on property for the arm,armv7-timer. This allows us to use
the timer as a clocksource for hrtimers, removing the need to use the
fttmr010 driver at all.

Cheers,

Joel
