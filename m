Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60240445D27
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 02:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhKEBEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 21:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhKEBEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 21:04:32 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEA6C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 18:01:53 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id v15so5288570ljc.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 18:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=79ZKQZn6O1IkafVjDwZ+j3jAYbT2DQtY9V0AzRB5LOE=;
        b=axm33hmfgPNDbFW8M7zbtqsr9jCWF/3lTmgL2TTu2T0wBTNKmAot9PMmut8/Gn1Fff
         5SFieg25LBaoEwbIQIqlx7qBBoa7jp2W0t+CgaPpt3i4GjFiqahCdSwobYV9l7AkAkT2
         8He3HEpsgFMVLDflbpIVIkfMapMOpA5/P/KPEyn1YhmP46te/eb5BDYvh5/qkQWR0AE3
         TPr8zqd7qb8rpt0zZHxNcZn2p1X3IJ6SebfSqI9u57tM1wPvuNZA6E0M7K3dz6Zj+1wL
         zZ5f+2qV6pgCRthgDMbzfL86NoG/gDBtiGmi4B4GsGRaLwqCNX3+YuZzx3g4bYcCTrY0
         Nr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=79ZKQZn6O1IkafVjDwZ+j3jAYbT2DQtY9V0AzRB5LOE=;
        b=3QJ48ns3j+Xc4RADpvBsVPyxmxEiBiDpTszJwBLEupea510H3fH66HkeGqVAklyT/H
         XEMN5eUQ6D/MKVq0rx3W5kulxyewqwLx9COOgtfihhUonTi84yKz598ej3efWQIxFhjP
         ogk18YxpYrj7BzJPQuF4Ujk3grj0UBKEICSxaQ569q+78g22/UopSbcMgSpV1tvERIgi
         LkJMQtmNXTlwD+gt7xNVoK02tkOxwaHcPoIrlwPA8rcvnMiFS93TpwNQz5R+tNUE3Dfn
         8PdZWfXOQPlMs/0xp972f0Q8zr9endRkoW4GJ8FWxxlFesPh60fy22bxAn1NciJcnlEp
         DnEQ==
X-Gm-Message-State: AOAM530rMQL69i/Qe+Ngt2cu9/Zqok32wkLOZI17BoYrsGtPC5dOIVXY
        x6COt3rJvXNbLNT/GlKTBZwZuSAOz6xd7QhX63ucJ9ce5bQ=
X-Google-Smtp-Source: ABdhPJwdiE12gp4pr+/pTmBIp1OutEv7sqvDKuwDARDTCB2kQkZPfuDkOicHQjBYUEqEn73iODSbdC7q9FPi2Lj6REc=
X-Received: by 2002:a2e:986:: with SMTP id 128mr12328634ljj.253.1636074111609;
 Thu, 04 Nov 2021 18:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211104210914.4160448-1-osk@google.com> <CACPK8XfXuU4i4khbpo8rxqxT9zz021N_m=s8uinoT+nHbCa_Yg@mail.gmail.com>
In-Reply-To: <CACPK8XfXuU4i4khbpo8rxqxT9zz021N_m=s8uinoT+nHbCa_Yg@mail.gmail.com>
From:   Oskar Senft <osk@google.com>
Date:   Thu, 4 Nov 2021 21:01:35 -0400
Message-ID: <CABoTLcQkds=-RjoY+fTVKyR1r+7Axb2-kFC7DiqMcEQTtJgk6g@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: tyan-s7106: Update nct7802 config
To:     Joel Stanley <joel@jms.id.au>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel

> > +               channel@0 { /* LTD */
> > +                       reg = <0>;
> > +                       status = "okay";
>
> The status = "okay" should be redundant; as long as  you don't specify
> a status, a node is assumed to be enabled.

My apologies! I know you mentioned something similar for the DTS
binding patch. I didn't realize that this was a generic statement,
rather than limited to the example in the binding. Fixed in PATCH v2.

Oskar.
