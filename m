Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF523B37B6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 22:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhFXUVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 16:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbhFXUVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 16:21:18 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82001C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 13:18:59 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id b3so5166588qtq.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 13:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mdCrysfxWqAqrBAEJbk2pV4kE289NH197rWy91TRue0=;
        b=J3UNp7fycefSlxiA3mkRZdfEG3spTLib7gsbR+gNSs2vBpre7+KL7zuGUa5h2j+3C2
         m2tXLocDWlWn+5z1Ln6zP0psDRiNIBz5Hsg2+UE45J0MeRXZiY5gH8oOlVwRCQ3zockh
         yJ8JRjDiEyknOA7nHDsHLLvwlG9O/fNruBlVNeawGcY10XIohXhffo2ahykLn5PMzAM2
         RiYGmzUuHaR45ZUnc1dJcRCogzpYZyoSQARuXSiJtoNkukVnzYTE1khkrrTzXVdhtVnU
         EQUtPnj8I+9Biekm2q1/SiHbMDfgO/ron+ATRuLx8dm4mQJsYQzK6UaH+Ylq/pOtiqfU
         YysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mdCrysfxWqAqrBAEJbk2pV4kE289NH197rWy91TRue0=;
        b=YMG7dYG0IImlFFVmn1V3wB4kDLhp2zcP1ODJuBmRVzCYI9gFQYo0twT/n4TJDNiulw
         0t7kLH89U4PhSyS+PMLyHrR+tqUjsPxFzBeNOAwxie/4VLlYUUZx1/6L7U9/xAysHXsm
         oKKAWuYGt7PS3DJ+xEgU0aWA+Bovrfzv5lf/KY53sabjnw60Z7Gwm5tJx/2plzbOtFcg
         ZpE/261ZUIZ5I+8b9DI2VoVKDnNXbxXw3I4vxo35k0l5dAf4OMpHsgDxB+JakvBcZ106
         ckzlKts+12cXgMRXqGhslRfKgzb6fU32gLnlyYX5pTUolaMJ3A9m3FbNwHjDdbhKZEr9
         3guw==
X-Gm-Message-State: AOAM530Nn7uit8NR6BzAY4cXa2qGMyOhSaRdVLHCA0l+3QYCBZT8Cq/2
        xA46KEjp1WIp/sGbQI9IidkvCHJbfeuMXHIp9/dAxQ==
X-Google-Smtp-Source: ABdhPJya9rAenFjimUfW1E8WtTyhpryokAVJlemxaygbzKzlIzWpb3wMdQpusHFqDZKDkOEm+8TLqVM8SVmddmrdVzg=
X-Received: by 2002:aed:2064:: with SMTP id 91mr6409571qta.318.1624565937026;
 Thu, 24 Jun 2021 13:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210624082911.5d013e8c@canb.auug.org.au> <CAPv3WKfiL+sR+iK_BjGKDhtNgjoxKEPv49bU1X9_7+v+ytdR1w@mail.gmail.com>
 <YNPt91bfjrgSt8G3@Ryzen-9-3900X.localdomain> <CA+G9fYtb07aySOpB6=wc4ip_9S4Rr2UUYNgEOG6i76g--uPryQ@mail.gmail.com>
 <20210624185430.692d4b60@canb.auug.org.au> <CAPv3WKf6HguRC_2ckau99d4iWG-FV71kn8wiX9r5wuK335EEFw@mail.gmail.com>
 <3d6ea68a-9654-6def-9533-56640ceae69f@kernel.org> <CAPv3WKdjE5ywVFB+94invSLg=jG5JHBdvLQLKDTPq13+8PjqmA@mail.gmail.com>
 <20210624121424.51d754bb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210624121424.51d754bb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Thu, 24 Jun 2021 22:18:44 +0200
Message-ID: <CAPv3WKdz6n0CZDusDcxDYJFgUNiEj7h=w=iVUAayiwy4Qjz3SQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

Thanks for your prompt response.

czw., 24 cze 2021 o 21:14 Jakub Kicinski <kuba@kernel.org> napisa=C5=82(a):
>
> On Thu, 24 Jun 2021 20:15:00 +0200 Marcin Wojtas wrote:
> > TL;DR, we need to get rid of a helper routine (introduced so that to
> > address review comments of v1), as it causes a depmod cycles when
> > fwnode_/of_/acpi_mdio are built as modules.
> > It can be done twofold:
> > a. 3 commits, i.e:
> >   Revert "net: mdiobus: Introduce fwnode_mdbiobus_register()"
> >   Revert "net/fsl: switch to fwnode_mdiobus_register"
> >   net: mvmdio: resign from fwnode_mdiobus_register
> > b. Same diff but squashed.
> >
> > Please let me know your preference, so that I can do it properly up fro=
nt.
>
> Not sure if Dave will notice this mid-thread question. It probably
> doesn't matter as long as (1) doesn't introduce further transient
> build failures.

I think I'll go with the squashed rollback commit that removes the
problematic helper, as it may be easier to apply. I'll double check
modules_install before.

Best regards,
Marcin
