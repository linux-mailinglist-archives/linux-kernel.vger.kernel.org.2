Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17983AE2FE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 08:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhFUGOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 02:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhFUGN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 02:13:59 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8921EC061756
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 23:11:44 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id q9so573409ilj.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 23:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lMOacCUVxIkKoB2CAKwTgiKnjRqpZaGysTfPqeXImQc=;
        b=lncX7f1GdteiNPCdRxtaRd1qBnCKLQE2b6yk+By0toNDvm+BdNVeB0/f+2sI5hzSmR
         02oghVxH6sT31iQvjKvhbnIHkNm9+RWHtTG0PBgBRRz1K8pLAd8ZPeHOSBC2IrWD9+/9
         6DEwRGtxVVUGlJ3slJcltzCctb83jTDddG1FKVp5eVvjgJLBN0Jha5aw1wixGcpvW9zt
         ZtlfnOhN3uSkhIMlJyOWieC7TFKx1a+5SLDoEf93hG69tD5S56K8AKRzv/Z6tr5Lq/7F
         nDcwcd8GmnoFrRx/BJ8X0W/RUvyPHqElrE2jvgLKuRmVsNQxldiq2d6TbdoKckVAYQ4S
         Onkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lMOacCUVxIkKoB2CAKwTgiKnjRqpZaGysTfPqeXImQc=;
        b=GlfswsCcgGyRXKAmQ5xoxyA0EyatPDx6Efgwebz2fpWgX44eEMJuYFK2Z1XIWVs4GH
         s84AH4bbXcd2HrPuARw+mo63iN1DXP71Jpl0jKwFighjDqBWdmhwHaI2Er9YXczMd3A8
         +WWHeS7a11V9MwMxHqyL6xYj+t+v+27uTIjdEeALJ2zmm5sdnst3svagZn1reS347fYl
         iUNicO8gjvdinLFFQdF/MdAMTng/OZJC3tDUJ4x2un1nstYA2MieVo6SrdntdAi5iocn
         g4NQMeOKyY2aBqQ1Cp+/BmH96RIdgSerF9wFOS5kQkASW27gU0x5AF89Tl4fEzU0uIKi
         5dDA==
X-Gm-Message-State: AOAM530euTYQJFpWplOT/TFJngqp4ELbmBwquBNPhFFvvlf17mADBEfc
        v+Sl3/qe3IAshFg0b3O8C25isKp3SYOTTsRpohQCCw==
X-Google-Smtp-Source: ABdhPJyBUx+kDh5PhVgm49aok5ViJo5axj804RUR4VXWG5zl53SfBNieGoNHqgkLRe36C71utxsarKSrRKqntMmTLfE=
X-Received: by 2002:a05:6e02:16c5:: with SMTP id 5mr8911651ilx.72.1624255903713;
 Sun, 20 Jun 2021 23:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210620134954.15233-1-Christine.Zhu@mediatek.com>
In-Reply-To: <20210620134954.15233-1-Christine.Zhu@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 21 Jun 2021 14:11:32 +0800
Message-ID: <CA+Px+wXWMRM_O7Y8h50DWoKfMapgMzuVppe7AaRPDiRdWDF06g@mail.gmail.com>
Subject: Re: [v1,0/3] watchdog: mt8195: add wdt support
To:     Christine Zhu <christine.zhu@mediatek.com>
Cc:     linux@roeck-us.net, robh+dt@kernel.org, wim@linux-watchdog.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        seiya.wang@mediatek.com, linux-watchdog@vger.kernel.org,
        rex-bc.chen@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        srv_heupstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 9:50 PM Christine Zhu
<Christine.Zhu@mediatek.com> wrote:
> christine.zhu (3):
>   dt-binding: mt8195: update mtk-wdt document
>   dt-binding: mt8195: add toprgu reset-controller head file
>   watchdog: mt8195: add wdt support
Please provide some information in the cover letter to let people know
what the series fixes about.
