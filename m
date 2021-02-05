Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE91A310278
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhBEBy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 20:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhBEByw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 20:54:52 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96F0C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 17:54:11 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id f2so5832724ljp.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 17:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ShbIhCma3Ofzl1YsQV1kyZSX2IjqpOpYQcd5Mqync0=;
        b=cWuXefvSVZcBI0OCD6JO0UDwOjDIMjCRWWikFYuXVkmFSxA+ysm3FUSW/7Owr8jRH/
         NAHagYK0T/bKDDPBMLe8JQc3h5e3LAtBiCESoqEsqTROi4bCb4yWHVEkMTpm9dkOsg2+
         7LfNuiZEw/Gli+bdTIGgzRKDiTLaXkXx+/bTxzDnaJoX7X72t2yh5EOq60/W9PXijFm+
         JJYVo78QwFhPatO8xSAtiknca/p2YvLryvD9IjEbuNHS0Rca/1Fq+kX5hGhKVf1FuWg0
         5sUz76XPh2h2shLL4aA6Eb2lRDYRV3umHwjLJrIoKqhA+Z7oJMWOXjtRRxz0RfViHg7v
         vteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ShbIhCma3Ofzl1YsQV1kyZSX2IjqpOpYQcd5Mqync0=;
        b=hIL57aiImOT+nvc//j1i+cX6A7wB6MGLJ2RYn+9cRSCNffPTITiV561dpBYElYaFYf
         Yvbsy3JouKOhHCtPlFsUPhzEse9FL0CZoPfPK5gUv8ht9AsnCgpRChGNzGE4KrLcUp3Q
         uPh0kW5TEMQ8HuiXpr14zc5nZVS4LJxGU0W35jwPz0isVbFb4mmUH6jOxqZ+vuy9vfhI
         jr29fywJuWrmyQdCD+KtxYdvXyVlskBjC2xTgwgCNyZdlR3uj6iS+XFG32ItL4jqvRga
         DSAi9PJm/+4ANoCuIqY9FClHGVgWgo94rpqSB3lBIje91PebXbAPDGkFBbMNDS6dL7D0
         ua6Q==
X-Gm-Message-State: AOAM533jE8mQzDE/j00zGICYtbpRzHH5G6bQKmkg9gaJpanVpt12DPgx
        dpPDcj/vl7b/eyax2j3XT5K3wwjag3hlPAqmZQ4=
X-Google-Smtp-Source: ABdhPJyQRd8xw4LdG8wBJJ+fyx519fSOoltf4Drn4aki9bUdg4hwBcwz1uTsbKGxhyjt+qql+QO1mOynBkdP4NTkyjU=
X-Received: by 2002:a05:651c:205:: with SMTP id y5mr1251385ljn.53.1612490050195;
 Thu, 04 Feb 2021 17:54:10 -0800 (PST)
MIME-Version: 1.0
References: <20210205013847.1736929-1-saravanak@google.com>
In-Reply-To: <20210205013847.1736929-1-saravanak@google.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 4 Feb 2021 22:53:58 -0300
Message-ID: <CAOMZO5DRjT4d8gzSZZX4itcOXO_pye-1aq658EX2vQJ5xhEi8A@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: imx: avic: Convert to using IRQCHIP_DECLARE
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

On Thu, Feb 4, 2021 at 10:39 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Using IRQCHIP_DECLARE lets fw_devlink know that it should not wait for
> these interrupt controllers to be populated as struct devices. Without
> this change, fw_devlink=on will make the consumers of these interrupt
> controllers wait for the struct device to be added and thereby block the
> consumers' probes forever. Converting to IRQCHIP_DECLARE addresses boot
> issues on imx25 with fw_devlink=on that were reported by Martin.
>
> This also removes a lot of boilerplate code.
>
> Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
> Reported-by: Martin Kaiser <martin@kaiser.cx>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Tested-by: Martin Kaiser <martin@kaiser.cx>

Thanks for the respin:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
