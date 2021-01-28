Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C325D307B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 17:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhA1QtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 11:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbhA1QsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:48:08 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4ECC061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 08:47:28 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id ew18so3086122qvb.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 08:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e7iU22Wk/7b73ZzTZHjo/p7phjhlEJ3Rp3uNLWW8Bi4=;
        b=gnygahTvd6LC+Z7HLh9l/VftImkK7fL37Qmg9sV2j060VynwjhQIeSzwpK0/ifSf8d
         D5RHb3dul8gpNOwGz4J5ALa92P/wZnodnCfsNXBqh2owlU8PXgfm6SBL6dI3E2nl6vGz
         Yj5xGevzgQjc4+3Gd3ciuEagHPlWUWlnio4kID4ZBCPpUjUo/8ubTe43q9XNjNz54sVz
         vOC6OKI5xVNiubUNN4AZcbrI1lDML7FY6sE6a8sz8p0eiWEgD2hnFa7xt3iPw9krDgF6
         3x1Q3MQOmxsGo/2X+eJXcpOPEUx1GWquvWAFHOj0m222+wEdMk18BRAz4yUd7Q/fGVj2
         sYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e7iU22Wk/7b73ZzTZHjo/p7phjhlEJ3Rp3uNLWW8Bi4=;
        b=maXE3Ah7H5xycxI2VSOdx1reyTNiD6Ph+QfjF0zFrRVyN7iOJ7MxQT2BTgdFHeQal+
         fTdxUt8VlbzodD6n84aXTP+rgqxvLW/T722ZpOvRoU+SXNwFeNZqwLANMtYhLSaGaiHQ
         vwN9WcAjNqFvLfDIPNHHM+uGlW/IE63AXVZzfoVbktQRF20X4q99GQGXWQd0Jq33KJPz
         1i08uef8FM4lsx+3BTDkFhg0+eFJ9Lt03bJIWwummLvNNTbXyHd59M+M2TFtq2Rbbmo3
         LGenZu8sPhXCB0LtI9Yf49uTfqco7EG0i58pJO3aZAlAxVdwBNC0aMFo30f7Kz5/mIeM
         HMyw==
X-Gm-Message-State: AOAM533NdKNP6pHvRyvtuPqTYUQwnHBRhsrM7rlXKP0z2T/NyMfTSwHj
        WmVs6ohcsuFijjGzVbEihb0X7POL9/kJJL56r2cNOw==
X-Google-Smtp-Source: ABdhPJwYo4rlO6Y8iaR9HVtY9VAyhCp1VJNqnpcHDNN2aQnwK2n0NcducxVoIyDclYZeUDX5nXorPMAaTL7YBIbxAmM=
X-Received: by 2002:a05:6214:a54:: with SMTP id ee20mr116366qvb.16.1611852447371;
 Thu, 28 Jan 2021 08:47:27 -0800 (PST)
MIME-Version: 1.0
References: <1611747815-1934-1-git-send-email-stefanc@marvell.com> <20210128164317.GS1551@shell.armlinux.org.uk>
In-Reply-To: <20210128164317.GS1551@shell.armlinux.org.uk>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Thu, 28 Jan 2021 17:47:17 +0100
Message-ID: <CAPv3WKcbfJ=LujR3_Vtbncu5sEC7Qb3kMhr6KaAAVJyvpB7A=g@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 00/19] net: mvpp2: Add TX Flow Control support
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Stefan Chulski <stefanc@marvell.com>,
        netdev <netdev@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>, nadavh@marvell.com,
        Yan Markman <ymarkman@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        atenart@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 28 sty 2021 o 17:43 Russell King - ARM Linux admin
<linux@armlinux.org.uk> napisa=C5=82(a):
>
> On Wed, Jan 27, 2021 at 01:43:16PM +0200, stefanc@marvell.com wrote:
> > Armada hardware has a pause generation mechanism in GOP (MAC).
> > The GOP generate flow control frames based on an indication programmed =
in Ports Control 0 Register. There is a bit per port.
> > However assertion of the PortX Pause bits in the ports control 0 regist=
er only sends a one time pause.
> > To complement the function the GOP has a mechanism to periodically send=
 pause control messages based on periodic counters.
> > This mechanism ensures that the pause is effective as long as the Appro=
priate PortX Pause is asserted.
>
> I've tested this on my Macchiatobin SingleShot, which seems to be Ax
> silicon (and I've checked a couple of my other Armada 8040 platforms
> which are also Ax silicon too) and networking remains functional
> without flow control with the gigabit port achieving wire speed. I
> have not yet tested the 10G ports.
>
> --

Thanks Russell.

I'll stress and verify CN913x platform with the appropriate firmware.
This should happen after the weekend, as I don't have an immediate
access to our lab in order to replug the cables. I'll update here
about the results.

Best regards,
Marcin
