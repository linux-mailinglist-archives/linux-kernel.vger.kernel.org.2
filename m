Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9A640BDFB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhIODI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbhIODIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:08:53 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD426C061574;
        Tue, 14 Sep 2021 20:07:31 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id p4so1977490qki.3;
        Tue, 14 Sep 2021 20:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lzGNTe0N1omRaVLKHYnbdAwVLZaGW4vyfSP4Y4f6x7w=;
        b=CVDF7i2VGhoEck1p4Fx5yvFrH6R7YTq+jdWrAO2fCpOvlC6lWZZSKP9BLr9fnCIrSu
         FSHiKvqMv4zALE0C2zPAKfnYyxT5U2T/pfLiVPpIy/9NWRPk7j60vG0IeV7Dnk0pgHvH
         oCg5ljKyHBiFQbf8ALrngZFvwIKTtLL5QYrL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzGNTe0N1omRaVLKHYnbdAwVLZaGW4vyfSP4Y4f6x7w=;
        b=lm3PqaxmF+pVQ3HVVHPrv5VztHreOU3fkbd+Gyc+2TwCQDBYzjuhgdRys9MpAaQAy3
         WaRhO+0RnoFYt6La/XZeCdEASYptO3in84lzuZDClxDT0wfyBwh0YGZWU/FXEgsTYif3
         uq4wSRi/zpZIFxijtMrbduYmsHPvzYjKaQOVMEWmjWOk6FesFbqBPa5HOEtW4H621swT
         C6GSFqNX5D9d4H0vP9rwD6C7jjAbWwblTGaf+VXBaorW/nF2eIZ7fK56TJ4KTrpgIdPC
         BVNwojAM2J2jtkdPOFh5812k1SKdJBTgtez/ZQxfVRPxtmbeDOW5o8XM4b84tpqQO7vf
         igcQ==
X-Gm-Message-State: AOAM530qqjGm8P2RAAAp1sE2uJO53hv+20Wb8FTq11mNAPCFf1NgYVnR
        um7YiB2LELRxVTLTMDl8NiW7amCmVFDN2tZX1tM=
X-Google-Smtp-Source: ABdhPJx4kp7o4gJWXZYceApw0+pTlgsuD5T3QXuEgB02qyltrnDN5eU/3k+mJgjXkPbLnNrygxP8xCwr+MhkqEOJ24o=
X-Received: by 2002:a37:67d7:: with SMTP id b206mr7986446qkc.395.1631675250410;
 Tue, 14 Sep 2021 20:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210908091845.4230-1-ryan_chen@aspeedtech.com>
 <4571c9ae-0287-4f70-2adb-9c227e706736@microchip.com> <HK0PR06MB33806C10EB8B3F87FE144F8DF2D99@HK0PR06MB3380.apcprd06.prod.outlook.com>
 <163166864956.763609.8140689140101809508@swboyd.mtv.corp.google.com> <HK0PR06MB33801C3DADFD87363C09BFAFF2DB9@HK0PR06MB3380.apcprd06.prod.outlook.com>
In-Reply-To: <HK0PR06MB33801C3DADFD87363C09BFAFF2DB9@HK0PR06MB3380.apcprd06.prod.outlook.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 15 Sep 2021 03:07:18 +0000
Message-ID: <CACPK8XfN9YxTveoOVUFoJjq1_R_8mdvDQnF+DOVvkNaosnKN0g@mail.gmail.com>
Subject: Re: [PATCHv2] clk:aspeed:Fix AST2600 hpll calculate formula
To:     Ryan Chen <ryan_chen@aspeedtech.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "Claudiu.Beznea@microchip.com" <Claudiu.Beznea@microchip.com>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sept 2021 at 02:52, Ryan Chen <ryan_chen@aspeedtech.com> wrote:
>
> > -----Original Message-----
> > From: Stephen Boyd <sboyd@kernel.org>
> > Sent: Wednesday, September 15, 2021 9:17 AM
> > To: Claudiu.Beznea@microchip.com; Ryan Chen
> > <ryan_chen@aspeedtech.com>; andrew@aj.id.au; joel@jms.id.au;
> > linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org;
> > mturquette@baylibre.com
> > Subject: RE: [PATCHv2] clk:aspeed:Fix AST2600 hpll calculate formula
> >
> > Quoting Ryan Chen (2021-09-12 22:31:46)
> > > > > +               if (hwstrap & BIT(10))
> > > > > +                       m = 0x5F;
> > > > > +               else {
> > > > > +                       if (hwstrap & BIT(8))
> > > >
> > > > You may write it directly:
> > > >                 else if (hwstrap & BIT(8))
> > > >
> > > Hello,
> > >         Like I commit message M = SCU500[10] ? 0x5F : SCU500[8] ? 0xBF :
> > SCU200[12:0]
> > >         it need keep from register read, if BIT(8)/BIT(10) not 1.
> > >
> >
> > I don't get it. The review comment was that the else { if (...) can be collapsed
> > into an else if (..) What does commit message have to do with it?
> Sorry for confuse.
> Or do you mean like following modification?
>
>                if (hwstrap & BIT(10))
>                        m = 0x5F;
>                else if (hwstrap & BIT(8))
>                        m = 0xBF;

Yep!

Take a look at my review of v1. I wrote it out there.
