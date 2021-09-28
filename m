Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBD041AFC3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbhI1NRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240879AbhI1NRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:17:46 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFEAC061604
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:16:07 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id k32so6647479uae.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fi6DG/t7j2/pxu+c0AJPr10+nggoTRsoICFD1lNKucU=;
        b=U2Lf0T2VnVWbOmIYI0oOLx599pU7rDKWZGF4FPFD1mpbfyQlYcxCZNrNblSJc/o+Zq
         8zeLn55dKxuI8iYTKwY1rXtHtx+4ApAMOYaUwVZyKxPhbPtP8u2Qte7VrXpQz7L36NIy
         wDuQDPy66Fqdgah3K1LxinsJ1cDLpBDOfPdNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fi6DG/t7j2/pxu+c0AJPr10+nggoTRsoICFD1lNKucU=;
        b=Tm6qe2I3BdIqqwA8dSiCOf5kSj50SIFB/tkmU5L0W/qGVPdNCpUzP/yaXu/flHaAFh
         HaVmV01JgC3CNXiLjZknTqI3953uWK+6jzuCkb1FU6XGvNO3OKeQNyePsVhL2FwZrpFO
         cKKeXwU7geoyTU7AT5+FMgAqMh6TZvQ2YeTtM5ZXYFjpVl7doQrK7kF+p9BZexjBn6Vj
         XC35NUguNITMIM7ADsFeI/6unBr0hedrRKpApxsKpzNkZBb7jFo185qf/usNf1Hjaztm
         QbtjqF1Nrej7BB3zJB12azd2bMdcvl4cA5iqkUWmMF2RdpQC1YN1yfObAL/abb3F6Yfv
         zmdQ==
X-Gm-Message-State: AOAM532yoSwqVR5wMy2t1/nGevcYrOJ+GM5FKt8oHBajn51ys8dX637I
        uYEc7IhkQq4c8oI5aJHrSbZ3Yi60CGnGi9tJxsYRVw==
X-Google-Smtp-Source: ABdhPJwf0Q1iOmCTn1+wbKGywa5PSrZWCmLjesHM4yZ/rTl8OBM4+F/L2XQ7i2ZiqYRUtl1L1lZgagXReoyxsWCjhxU=
X-Received: by 2002:ab0:73d7:: with SMTP id m23mr4766279uaq.118.1632834966378;
 Tue, 28 Sep 2021 06:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210918072256.3505379-1-daniel@0x0f.com> <20210920112625.fnqayim5mg5iggag@ti.com>
In-Reply-To: <20210920112625.fnqayim5mg5iggag@ti.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Tue, 28 Sep 2021 22:15:55 +0900
Message-ID: <CAFr9PX=xKoa9fCbYf6Mpn=oudnY7A=6meKBSmzNHYLFad364tw@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: Add support for ZB25VQ128
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     linux-mtd@lists.infradead.org, tudor.ambarus@microchip.com,
        michael@walle.cc,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

On Mon, 20 Sept 2021 at 20:26, Pratyush Yadav <p.yadav@ti.com> wrote:
>
> Zbit should be in bank 10, so it should be preceeded by 9 0x7f bytes,
> correct? I don't see any logic to handle that in SPI NOR currently so I
> assume this manufacturer does not implement the continuation codes.
>
> In that case, it should go to the manufacturer collisions driver
> proposed here [0].
>
> [0] https://patchwork.ozlabs.org/project/linux-mtd/patch/20210727045222.905056-6-tudor.ambarus@microchip.com/

Sorry, I'm not sure what I should do with this information. I didn't
even know about the continuation codes thing until now.
Is there something I need to do here or do I just need to wait for the
collision handling code to get merged?

Thanks,

Daniel
