Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43B03675FD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 02:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343819AbhDVABW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 20:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbhDVABV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:01:21 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BF8C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 17:00:46 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a25so36439552ljm.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 17:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vP82rZfUtsib5WAxJoWL80HDlGBtl+Yr06vR/s2yI1A=;
        b=b8KEuQwfbdeJskL9p/vOI78uX4NjwjHug3dN5Ue7OmHjsvKYodnvrpqZrePOxEjpE5
         v1whTg/4eYEPGolNo+qE8yOy3s01g40WqTbzYlOyCKKsMGtKdMekTlOwg2dkUDzToeJy
         9tarCQ9Eq7tyAWygFSBzJktoHU7tYcCWBJybY+JRrJ727yzKHnsDMQ/R9dwnEYuKqCFm
         7iYwGvRxgKCGt8CAC1yhT54syIFkK8doun/ZWKVjg0wTYpFDR0d1iHyUCu2cJuy4U54k
         mfedzddMQzJqtSLcQbk7KJjEFskhOKq2ddl+T4ZPJbVOE8sIFuTEBlluag5/0U6fKHKB
         +VIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vP82rZfUtsib5WAxJoWL80HDlGBtl+Yr06vR/s2yI1A=;
        b=nBTtx+E+vAuU3wYGl6jAqVdcOEHufHGqUuXfhu6Weqvmk3SYrtCKC/QvB3l1WnUPG9
         VQ15oXnkzEWmHFww7v1Kr5p3ogzj574+sBmx45/nkPpW9WRCpE5hHyejU3LtJ+gpr7Or
         /WUJBEniw7b4DMozAS+oaNPVEAZK8l51aXM9Tai5vVZBo3l/D2Ai/R+6XE6gA9IkDPz4
         tAobYcfI1oaDwF3m+UWSd+M9xmQU+36KZWT2EykFDjs9BRboU36Oiv/WxMIPjV//FkY3
         Ei3u4oz8OEBLWyUaWAUxsaGeSvK9JOap0mFYA298C+8sGAzaHESqRUiN52m0MHZAfv+t
         TsRA==
X-Gm-Message-State: AOAM532zuly4MCPq7bIzjNjohEkYoXkaS43CoxfdyyswL9FiimvHWv12
        AhHtc3Zw7apqztehQrooD7g1R0+PZH2vMXa8mXpqbQ==
X-Google-Smtp-Source: ABdhPJyukDxnvl+KqgkeR2DwdKiQpsKRoXappdMdqijpppQIzbKoCm6kCuY2SoJuGKoITL7V7AoVQFVljVqGIng7XnA=
X-Received: by 2002:a2e:555:: with SMTP id 82mr542235ljf.200.1619049645095;
 Wed, 21 Apr 2021 17:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <1618485193-5403-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
In-Reply-To: <1618485193-5403-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Apr 2021 02:00:34 +0200
Message-ID: <CACRpkdZie6KTqhRJTr14R5KA7hUXUqjiwgO2Am5-gZHN+Je-Gw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add ZynqMP pinctrl driver
To:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        git <git@xilinx.com>, saikrishna12468@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 1:15 PM Sai Krishna Potthuri
<lakshmi.sai.krishna.potthuri@xilinx.com> wrote:

> Add support for Xilinx ZynqMP pinctrl driver and also update
> the Xilinx firmware driver to support pinctrl functionality.
> This driver queries the pin information from the firmware and
> allow configuring the pins as per the request.
>
> changes in v5:

v5 looks fine but does not apply to my tree, I applied patch 2
(the DT binding) as that is pretty much stand-alone though,
why not.

Please rebase the code on my "devel" branch in the pinctrl
tree:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel
and resend.

Yours,
Linus Walleij
