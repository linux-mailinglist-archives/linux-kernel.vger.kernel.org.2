Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A5D3A4E52
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 13:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhFLL13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 07:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFLL12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 07:27:28 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF695C061574;
        Sat, 12 Jun 2021 04:25:28 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id c11so13142004ljd.6;
        Sat, 12 Jun 2021 04:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o0wO5bT+5/3wJfzKFCtGQ3mV474XVeVqdnyyvbVk6mI=;
        b=strGZZWea2Rly+Mrzv1nw/2TB7vFF7mR6CY7At74zLU2w5wQ0HaoIhmWI/NUPIl7by
         h4/KcXsAbOGbWhuQrMbXMC1RvsqdxgDie4+7kKS9qln5lWruzeLkcAO3PO80RDloHD7X
         y4Y/WnsY/d+pEGeTk+a/3PsjlSQJRD9FlOVr+hDRHCkjJUX2wyQbkyrT/qZ873yURwP0
         stej8J1UvnqZC324Y24gqlB/1OcF4U0f4j3l6K1xI+PAjJ87MDU815EIB4OxydBDEO/7
         /KMT3KTujNxj2URzu1HQ2Mb5O8swj8kNtgbxytUNkkbl32B0Jwld+yes7+5pLd1Qa9tB
         DmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o0wO5bT+5/3wJfzKFCtGQ3mV474XVeVqdnyyvbVk6mI=;
        b=oHXVD8CQ5LvazKK7RqffyIkioSBmxAymihefyHbkiu/Cz8sewEH7FGFsuCOpFQ+if4
         0qKDMCBBVTX8i0gBipAV2gztPLRSwi+E9a3vIKn4GQPOa7hqPe7vfwgePFc0gMDw4vdg
         eCki8J7wI3RiuqoH59GzBOoHx5qirL08Dbaz/aRMXZho/1hZjscJrD7lG9h1oTTFutnk
         kvDJxUZbNWgHEFGQoOXtFnmMKs/FnCyCgbmeYCUeWUnchOmgg8CIJJBAIkdOREZlItL5
         HnrmV/x7g2362vM9wq4LCGyHzqDGxcf2vQoPR56nD74OhJ494xi8F+qtPyjoOWJYTbU4
         0fVw==
X-Gm-Message-State: AOAM531MFYspDbsiiiZhSmsgbc76+s9+ypaSl97rCH3mKA4SMEFM3NwN
        xcC12OHGrxliuZEXt5F7I9iDvzohJ/xAMFqU6Ls=
X-Google-Smtp-Source: ABdhPJz1ZcfQJdludqHQ7YdtsU5jfSssrBkqeXci9YCTbcy2bFo3aPJ+r/RuY/tG8uvkDcw1gif0RezTE6/nDkGWHyw=
X-Received: by 2002:a05:651c:1111:: with SMTP id d17mr6482908ljo.116.1623497126417;
 Sat, 12 Jun 2021 04:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210612003128.372238-1-leoyang.li@nxp.com>
In-Reply-To: <20210612003128.372238-1-leoyang.li@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 12 Jun 2021 08:25:14 -0300
Message-ID: <CAOMZO5AFpzUJeUm6jeRwiRAo1c09nY4pLbncGAi5UJVXi8LPkQ@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: fsl: properly remove remnant of MXC support
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        USB list <linux-usb@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Ran Wang <ran.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

On Fri, Jun 11, 2021 at 9:31 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> Commit a390bef7db1f ("usb: gadget: fsl_mxc_udc: Remove the driver")
> didn't remove all the MXC related stuff which can cause build problem
> for LS1021 when enabled again in Kconfig.  This patch remove all the
> remnants.
>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

Thanks for the fix:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
