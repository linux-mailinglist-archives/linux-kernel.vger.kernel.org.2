Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511AC399EEC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 12:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhFCKax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 06:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhFCKax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:30:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDA3C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 03:29:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w21so6399937edv.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 03:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tamsZZ4GrS0eJgr315W6Rp32jKP5+n6WY10gRy7bKWU=;
        b=YdbkXsL0KkYKS7Ix9rw76X7uWaTzw3/D09NeO78zwZUXrv8yDTgwrT157P28jtHaEl
         Qxq8IJyyhB41PxkvkkFFLaz9szb01NkEIf8DhCwsX9NZTebDQqPDzg4FnE1Y+GOHmjIK
         JSWVMxSSH0OL9LRLzaQkMuvKBmxgRdUDyAtQO9R4gFdn4rTW2FS7fFOnueunkzJfVLZ+
         Oj+Tw0Tnsst+zweB3/sLfxlXU/gyn+B1uPHEiqgybqxBs/5lA2KHz2SY15I1qGmEVd5G
         iOXuSyEj1ZsxsY3xKqa3uM33Rw8pJ3VIBrnsOzLlllZIoMC57897ltPm6rGH8L8B572w
         YrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tamsZZ4GrS0eJgr315W6Rp32jKP5+n6WY10gRy7bKWU=;
        b=IwZ/kl4uuxyV3Eod8ThEjXbz8Epqk+SAuH/lUExAh/hwXvxOJU6VWN1CaDqiOwoioq
         bRj5bPRZ2di+DTx2VlNsrVEXUXGKutznpeFUep+VA8e3PLNjoOQw0ODTuc1buR4HH4AD
         aE/GbPcGIhgv0Gnx119ing0pH1JLfVfSrC/St+aQc0k2tt6P8ZvjEAfNApQXhV7OJL0e
         zWetDTbQXs4j/FdUSVXI19Ebmr5cDZvFWejts01VTHlkf8Gd3JGA++kNNXfxl4Wz6O0S
         7dk9xx/6CXb7I+eDsBXTZhQzi8VfpRBV68+pc0jFMm+bXmK9bOt5icRHKRhfW+Qmq8xT
         gFAA==
X-Gm-Message-State: AOAM532+tADqpYMuGAG+wSbsJdt0Cur1rP1Bl8x8CCZDvvoXjyPk8mLo
        lBOTDMfWmO9BQkzwBIi7w6vnHo71TWh6v8AteqEuLg==
X-Google-Smtp-Source: ABdhPJzRscE5WmBp4a5R8o9GSu2DNqVmZGN5RpAJ7kE8PZal5j3hISmXnHPMsGpT2O/1RtDWD+21ikkZGFU0b3M+dGA=
X-Received: by 2002:aa7:df04:: with SMTP id c4mr13138611edy.147.1622716146797;
 Thu, 03 Jun 2021 03:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210603093809.1108629-1-axel.lin@ingics.com> <1622715641.1034.5.camel@richtek.com>
In-Reply-To: <1622715641.1034.5.camel@richtek.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Thu, 3 Jun 2021 18:28:30 +0800
Message-ID: <CAFRkauDs6nyuboPBf9Q-=KDFkSjwQ4z9mDjzm3o95uzdu5bKCw@mail.gmail.com>
Subject: Re: [PATCH] regulator: rt6160: Convert to use regulator_set_ramp_delay_regmap
To:     =?UTF-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cy_huang(=E9=BB=83=E5=95=9F=E5=8E=9F) <cy_huang@richtek.com> =E6=96=BC 2021=
=E5=B9=B46=E6=9C=883=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:20=E5=
=AF=AB=E9=81=93=EF=BC=9A
>
> Hi, Axel:> Use regulator_set_ramp_delay_regmap instead of open-coded.
> >
> There's some reason.
> You can refer to https://lkml.org/lkml/2021/6/1/1145.
>
> It's because our ramp value order is from small to large, not large to sm=
all.
> It conflicts with find_closest_bigger value chosen logic.

I have verified the rt6160_set_ramp_delay() behavior exactly the same as
regulator_set_ramp_delay_regmap. (both functions get the same selector
for a given delay)

Could you check if this patch works?

Thanks,
Axel
