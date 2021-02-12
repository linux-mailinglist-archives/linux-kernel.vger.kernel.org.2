Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFEC319C78
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhBLKQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:16:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:48952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230357AbhBLKQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:16:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DE1164E74
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 10:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613124923;
        bh=vlHMdzyjzGP5SzoL127tVyiiXraiYGgnOOp4JvS16DM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pvAd6zjrJTF+R/+zw/HrHC+h1wLzYmH2DicwdTq7H95tcBhn9x6+jBIRInQ2VaOZP
         Sw8nzLQBSByXavhSUIBx2F5MZC4Gn74CO0AOZ8OzVrLXVC+SUzDKkRfIV0OvmNyIM+
         i167UDDOWITwbBLtMozVWJKfp6tgSliIJDHfDI889UlIp+4hpmiiLw3XmDMOxEfps0
         t4YMRI4jBBmA1eYBEsflz9AJDr9t4i5FC3iGzqTm/L2ZiGrjVEV5F0cdNAZmG12T3+
         790ADUQ9kff9lAwzhxNHeXu7lWMYo8iHZP1eXa8jfm9vhNrOceBkyH+OOz67R/SAOj
         kHKcaZco3l47g==
Received: by mail-ot1-f52.google.com with SMTP id y11so7926509otq.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 02:15:23 -0800 (PST)
X-Gm-Message-State: AOAM530VeUmkr9sW/dvJM35+kR2+x6dAg5iTBQQvSJePK/pjXDOro87Q
        muEArthVzskF+nPZDucYBlbaSwUNXb8XOwsGjyY=
X-Google-Smtp-Source: ABdhPJzAi2iCo+K6P2S07zESNOn/rW/yClLsrW8kuCuJBtmX/prb3dplqjouy81JI7GQPyi5bHQ1JZ0fiF18bN9q+VQ=
X-Received: by 2002:a9d:3403:: with SMTP id v3mr1476688otb.305.1613124922601;
 Fri, 12 Feb 2021 02:15:22 -0800 (PST)
MIME-Version: 1.0
References: <1613121426-15585-1-git-send-email-mihai.carabas@oracle.com> <1613121426-15585-3-git-send-email-mihai.carabas@oracle.com>
In-Reply-To: <1613121426-15585-3-git-send-email-mihai.carabas@oracle.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 12 Feb 2021 11:15:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a25p_uU2toSkTK4O8cEb07QPNmn4CaKKO1bYjLd2OEZyg@mail.gmail.com>
Message-ID: <CAK8P3a25p_uU2toSkTK4O8cEb07QPNmn4CaKKO1bYjLd2OEZyg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] misc/pvpanic: add PCI driver
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 10:17 AM Mihai Carabas <mihai.carabas@oracle.com> wrote:
>
> Add support for pvpanic PCI device added in qemu [1]. At probe time, obtain the
> address where to read/write pvpanic events and pass it to the generic handling
> code. Will follow the same logic as pvpanic MMIO device driver. At remove time,
> unmap base address and disable PCI device.
>
> [1] https://github.com/qemu/qemu/commit/9df52f58e76e904fb141b10318362d718f470db2
>
> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
