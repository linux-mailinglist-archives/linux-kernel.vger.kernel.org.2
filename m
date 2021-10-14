Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4678442D969
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 14:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhJNMlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 08:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhJNMlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 08:41:02 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DE4C061753
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 05:38:57 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w14so23604726edv.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 05:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8OYfFNdhKlh5vCRuRw3rL+lpyG6Iz3zsndXlWQuOqNI=;
        b=rO8Cimbu3ArvFcSKskAMaEz7aYPRXYb1TiaXDvaU2b70yNbLMOWMpDmGJFMN1Rnz7G
         M297CLhdxw2O0YteyYq9YLtuf9NyzJWhkonUS9AlKuTCLX+CrlBF3jbIZ1vLEbv5JyfN
         cq9XMY7pO8xXwClCitODDk8MvmypSpa56G3dGbCHCnwUA1DHpXSTI+VBZQ5QRFvuARgD
         rnQqcQgS7V45c7G2eEvq3qx6CxbpHc1h2Zfqt8gRETh7npquNH5NFa9Iv1o2PkOi7Rq2
         EAzYMngcgh029FfDuYQ8j5b/8ea7PNtfWGsSImewcj1GyCS1CqkK4rdJsai0iuCsWFE0
         01UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8OYfFNdhKlh5vCRuRw3rL+lpyG6Iz3zsndXlWQuOqNI=;
        b=M3Sb/Nj8gboaW7Do+2buHL2S8F2oFABAwcznAGTtwUqa+6hEg60MjKo3GeDaiEuOFE
         tRkLBpV/H5wNBRf+Ty+lbVYX4hU15Mx853Zlkm+2qGdISE4VHBQfPpxmKlQJOPRro7Xr
         yzOBjMxQsFpxdIwS1yVy1nbhgK76QF4MN/fzfo43WJM4ccTBZ7eqdHDDVFbOdbZeQQFW
         onUdm6aKxZZkDCwPnog54rpMG7sJcKBiE8muX2KBGt9rp2TzCgmJl/MDMc5XJ8LdfB9k
         pAHFxS3QGwuxki/kKUko+8DuEp/xhsdi3dSOZtWzTbn/GUKsmdzXVX93BeJo63O2TRV2
         rSYw==
X-Gm-Message-State: AOAM532AfPO2ylp3JltTp4NQHnaizh5VlDjJG0L/7VtUphq/eu3QhPty
        6bu8mEcJRuBs0fzKeo+oadYqBITeYYsKGhjM6lF5zg==
X-Google-Smtp-Source: ABdhPJw5RwGlWi8DUKaA9l8+IoPQsOFoPKhiFW27/0Uo29ALZMFUdlPeJGnIjKW+HthuHqOmJG3IW10gLCzTjzFq+d0=
X-Received: by 2002:a05:6402:40d2:: with SMTP id z18mr8324506edb.362.1634215135566;
 Thu, 14 Oct 2021 05:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210901083215.25984-1-yunfei.dong@mediatek.com>
 <CAAEAJfDOt_GyDPojcj5P6Wou9HC2GC8YzRt2wYyqdrCOjfeOog@mail.gmail.com>
 <3b9463e88d88ce85205da08f8263252da7726ade.camel@mediatek.com>
 <aba7fb4ffe6e45ac90869b5017468386bce64d28.camel@mediatek.com>
 <b7ed8b71578a98704e9b8ca29cac63c67cc14b3f.camel@mediatek.com>
 <CAAEAJfCHEBFc8B7C0bu7UxtJdffvDarqgA-rset1wPjLOiV01A@mail.gmail.com> <b3fa00e8b66658e120279e37261cbdb5db7edf52.camel@mediatek.com>
In-Reply-To: <b3fa00e8b66658e120279e37261cbdb5db7edf52.camel@mediatek.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Thu, 14 Oct 2021 09:38:43 -0300
Message-ID: <CAAEAJfD0=0zNOS8ydu-BwpdoCsADAjdpm1LXBzZ2T8D=JQmYtg@mail.gmail.com>
Subject: Re: [PATCH v6, 00/15] Using component framework to support multi
 hardware decode
To:     "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>
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

Hi Yunfei,

On Tue, 12 Oct 2021 at 22:17, yunfei.dong@mediatek.com
<yunfei.dong@mediatek.com> wrote:
>
> Hi Ezequiel,
>
> Thanks for your feedback,
>
> The driver can work well now according to your advice with
> of_platform_populate interface.
>
> In order to separate parent node with children node, parent node is
> master device, children node is component device.
>
> The master and component are registered platform device.
>
>
> Could you please help to review the patch again when you are free:
>
> https://patchwork.linuxtv.org/project/linux-media/cover/20211011070247.792-1-yunfei.dong@mediatek.com/
>

I'm glad you managed to simplify the driver. I tried applying the patches
but they don't apply on media master. Please push a branch to gitlab or github
or somewhere public.

Keep in mind that when you need people to review your code,
it's generally good practice to try to make it easy on them.
The harder you make it, the less inclined people will be to
spend time on your work.

Thanks,
Ezequiel
