Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D8C419D41
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbhI0Rrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237311AbhI0Rro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:47:44 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D6FC043969
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 10:31:55 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id a13so17372007qtw.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q25abHd9wgNegk3LUcOidVwBOafJNu1U9ST62KJXKh8=;
        b=Ny6AIsS9MNvI6ERmgppnjGwYp+CeoJRk0IArqfNnE6eticiIdzNtufGZQts0fxRfaa
         2La6isn8ClLdLGvpKcRN7Ws+5DbB2alushQpd5Mgdc9x0R4XjR8obr6bX67RKTuetBaA
         VnxeAY+0ch/n5c2/oqU2Ri+Wkk5YXe/CnUMzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q25abHd9wgNegk3LUcOidVwBOafJNu1U9ST62KJXKh8=;
        b=qXQ+0HGfcRDEdUWvji0Pta8fUyyfdTVVOgokEzoUUE6w/dBSU/1Ld6Vg0nz3JPVeLu
         qcnzXOVrdVFihxSgyjGrP4gQSylG+6npYwkxf0hqMUwVOHi3t8AZqXH3Pfs2S4F4P2VC
         CWJI6Nl/kaTEU3Y9agfydAkuzsQKR4rs3ixBiKPTKHhYK8+1Ho3V2ItVu2PCL5p7Pesj
         KBENYtdRV8dgpXpbbxTVqlE1UEBpj/vBH8/nWhUZVNtE2Lkw6JjoJMBh57wIhvraWdmF
         P9tHnGFi+XWJy3Uj3b2biBem3kRaUU9qdRJhZmXAtsEagTNlaGxgqrlS9b3ga5UlTaZw
         4ckg==
X-Gm-Message-State: AOAM533q7jBfWzHR8+sCYC+d7lWAhlYMMNSK8aTQEnHvwUYo3jYLVDHC
        ZQDTo8KH4XaY8y+YXzC0lzzAWWha/euv17QzTTQ9RA==
X-Google-Smtp-Source: ABdhPJx1KC2Sf4WzHgUQwWyPdWRuSlZoOLnjiZdGnYaexNZXkvQiCqTpJJd5W5gO70e5CRvJBsLepizgX3kZwngK+r4=
X-Received: by 2002:ac8:4089:: with SMTP id p9mr1016844qtl.363.1632763914260;
 Mon, 27 Sep 2021 10:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210901083215.25984-1-yunfei.dong@mediatek.com> <CAC-pXoNT8AFA2j1DiD9M_uGb92fVcukTGDKVURaGjwpPstcwqQ@mail.gmail.com>
In-Reply-To: <CAC-pXoNT8AFA2j1DiD9M_uGb92fVcukTGDKVURaGjwpPstcwqQ@mail.gmail.com>
From:   Steve Cho <stevecho@chromium.org>
Date:   Mon, 27 Sep 2021 10:31:43 -0700
Message-ID: <CAC-pXoPrOO8W2Le_-WdgX3_=D-Qde8ut_TAzC++EyGCkdoOoPQ@mail.gmail.com>
Subject: Re: [PATCH v6, 00/15] Using component framework to support multi
 hardware decode
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>,
        linux-media <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > [1]https://patchwork.linuxtv.org/project/linux-media/list/?series=5826
> This link seems to be no longer available.

It is probably because the default state is "Action Required", and
this series was accepted recently afterwards.

I can see the series with the below link.
https://patchwork.linuxtv.org/project/linux-media/list/?series=5826&state=*

Sorry for the confusion.

Steve
