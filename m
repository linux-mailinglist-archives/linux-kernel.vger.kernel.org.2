Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309983E1555
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 15:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241623AbhHENHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 09:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241574AbhHENHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 09:07:25 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C37C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 06:07:11 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id r1so4999393iln.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 06:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8XZGlmMnozvfdSQq3/qba/o7U1T3UG3EMARXu8VFnck=;
        b=WJ9FDdHToJ+YNPJzVpB8FBhEmi9AlPSVPW5tPnnY6aA2HwfCU/POEBxy+kCnjS0hWN
         CyGfXoItDGxFk9K9akF6lca56Aa2YlXOUy1ozonyf+IWD3bOOuVfCm31tAz5s8ZzI3cP
         VruqGsEh+wzW8zwbrbWV9AI6IHQ9Tkxn8fg3n6rNtMblLX/K8TxvG+8sxQBFbeF+/ow8
         5wxCqsU2IpcMlzMYAeGj2+GluGIedSwgqzwora7bnaVR2NnZt6+Rbho2AevXpzbHQM/J
         WHe8B6pk1lUN3clR92MUj3cQHJHUxrDWswmuX+UF8PN83PORqKYDgcuUVCZ8YpQLOm80
         rF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8XZGlmMnozvfdSQq3/qba/o7U1T3UG3EMARXu8VFnck=;
        b=dMo1JmE/juDCiatZkc9xpMzhBUWoF7tG63QEtDMwebSyjqFXNnnTEJ9hjg/Czmm3Aa
         kDhXgOO6NVkWf7LDCqm+A0mBDdsCUFDBdQBDo39gROqIDJ+m/bTn9zbpofFYb1eNUfre
         zDmVX5FXOUwx0RFVqBO1bw/wDoBqWo7rccUDuHNTa1gjnU7IADvG7lpYRUWtA0t4QjoS
         GCDEW5W8wWZZgcPH7N9xgR4LzVYb2RJiIfnhmIS/yNNSn5q8vP3DPD4eewlAC9rODZs/
         o3wM8Za7uTiXMPtsXfKal+RSgt+hjZGRqJ+mJbMoiVFF70i39HPF++fr3eD2K55LwnzE
         rLpg==
X-Gm-Message-State: AOAM533mRExFcHEawxpq1r292hJPrcWV+mjh3RsdZbpsPpXwvguyrK+z
        MUd/OxIiY0zCpF9maUVISSgQF28us9DIKsq8ZiE=
X-Google-Smtp-Source: ABdhPJymZ/shcD4u5zECMXsINrvUZ/FCY38VtOVoFrGHtvKKE+t+zaVQ0PIQ5Jit0l5p7PfpDJ/zB/IYwgU7zxj7iZM=
X-Received: by 2002:a92:cb52:: with SMTP id f18mr60685ilq.97.1628168830875;
 Thu, 05 Aug 2021 06:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210706030904.1411775-1-chenhuacai@loongson.cn>
 <20210706030904.1411775-3-chenhuacai@loongson.cn> <878s2j8udi.wl-maz@kernel.org>
 <CAAhV-H51iX1DC54wczkwwambtfWutqg-hfoZ-A7DSxTonmruHA@mail.gmail.com> <87mtpxwaol.wl-maz@kernel.org>
In-Reply-To: <87mtpxwaol.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 5 Aug 2021 21:06:49 +0800
Message-ID: <CAAhV-H6+e8M2fLkanOCPVrwN1yyMEvyZUsDXyQQnnhkju9qOfg@mail.gmail.com>
Subject: Re: [PATCH 2/9] irqchip/loongson-pch-pic: Improve edge triggered
 interrupt support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Chen Zhu <zhuchen@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc,

On Wed, Aug 4, 2021 at 10:23 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 09 Jul 2021 04:00:58 +0100,
> Huacai Chen <chenhuacai@gmail.com> wrote:
> >
> > Hi, Marc,
> >
> > On Tue, Jul 6, 2021 at 9:06 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Tue, 06 Jul 2021 04:08:57 +0100,
> > > Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > >
> > > > Edge-triggered mode and level-triggered mode need different handlers,
> > > > and edge-triggered mode need a specific ack operation. So improve it.
> > > >
> > >
> > > Is this a fix? How does it work currently?
> > Yes, some devices (e.g., RTC) is edge-triggered, they need
> > handle_edge_irq(). Currently we don't use RTC interrupt in the
> > upstream kernel on Loongson platform, so it "works".
>
> If you want me to queue this independently of the full LoongArch
> series, please resend it with a Fixes: tag.
OK, I will send V2.

Huacai
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
