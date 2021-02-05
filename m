Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791023101B8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhBEAk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhBEAk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:40:28 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDFCC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 16:39:47 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id p21so7351060lfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 16:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7HolQyszhP1TP9eLLRKX/cy07uYeacM3hjpIAHXgJ8=;
        b=bRzhO6jcIZagd5NVu/e1KqLOfw4pk6a5dOKWPWvYEpiy5lx8cV4P07PvMwfVCQv5gL
         FbMH9W1dzbnRXUKvpBoKi/fnSCWGM+8cMuPJO8SSDTEQP2a2v0D3ZXIiVoQMJd555KMX
         HmEzBd8PbCBIKOlQWVPGOByYa91h6crP+jXXFETlkM6GKujLc8IOA1dydZUS09ezqtyJ
         YqbCm60aq/NEuSN67OfIOfgXryQDNj25GTglfrMsKHoRgp1/fRr0vHNj5N7w4aXSsJmW
         Ic/gm4fATqWcCFGMgThodW1gZcg0g8tm5Ae9mvYlI5lQAW/nBv25K53CZXafK87UAe2v
         jcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7HolQyszhP1TP9eLLRKX/cy07uYeacM3hjpIAHXgJ8=;
        b=GTjoNY5/8gadZlt75a8nZJIJyY/dRq8n04Ft57PGKi2T1vqvWBckvqq4bnkM83t5HR
         j+78hhPIN+HqRg5iKf2yBbsurwiXzSE5wBl6JJsArmOxscX3MDZc53U2bJxCZ9dS5Sg1
         fkodu0a80eQEKdOM0Nk6NevY0179wq17NkkwhtTN0fUM5WC8h1KzScOfQ+hX4NuojDl5
         B0GtdplCImpkYZsZavKq9Gbrj+I52oRAPEvIpzfXxfSahjJh1+/DuGRyv/ZRtxFFig8F
         O6FaZ/4q8BX7uMfPd71MngdEZ0Xlxy5H4zesxlkJJFKIb1Xx6wjpm4VsVj1VwvAcTT16
         v5Tg==
X-Gm-Message-State: AOAM530Wz34MGLqY8pwJCz5ojgwtpHV6U4BTj/5KJLAnKqWe+9ukoslR
        7doN4f9LNuRStD6VzdXhphdxKWE9KIVEQaGuBpSvYLeD/cv5Bg==
X-Google-Smtp-Source: ABdhPJyJu84jXKL1PIn0i0Nd3Hx1rdIvQfPDg9K7b3tyxDGCfukLD6LGK6moqUssqZzCSCl/dCPr79zDTtgm1V6Mmhs=
X-Received: by 2002:a19:ad0d:: with SMTP id t13mr1074086lfc.539.1612485585979;
 Thu, 04 Feb 2021 16:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20210204225652.1707066-1-saravanak@google.com>
In-Reply-To: <20210204225652.1707066-1-saravanak@google.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 4 Feb 2021 21:39:34 -0300
Message-ID: <CAOMZO5C=pkBtaEL6sSLx9rDxXHzrzC-qwfAUBaQEcoaG8TxnGw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: imx: avic: Convert to using IRQCHIP_DECLARE
To:     Saravana Kannan <saravanak@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>, kernel-team@android.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Thu, Feb 4, 2021 at 7:56 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Remove a lot of boilerplate code. Also address boot issues on imx25 with
> fw_devlink=on that were reported by Martin.

The commit message could be improved.

It starts like it was just a clean-up and then it says it fixes a boot
issue on imx25.

Please explain why converting IRQCHIP_DECLARE fixes the boot issue.
