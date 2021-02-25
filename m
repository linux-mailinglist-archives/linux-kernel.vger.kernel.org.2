Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130FA324947
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 04:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbhBYDLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 22:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhBYDLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 22:11:31 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5299C061574;
        Wed, 24 Feb 2021 19:10:50 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f1so6383791lfu.3;
        Wed, 24 Feb 2021 19:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EnWKtR8Gi6MBZCyGkt9dN20MUD2l2Ye826UGjeumL/M=;
        b=bH9vGPAt9TT8vyB02A3LusGmI+8chLo2PIYd/qdVnAoXcA4p9U8W5tREoMsyzsBZ4Z
         Q9NWpJGzbzKuGHL8s6oMt0bLW3cEcmbC9NdcLISbdy921Vh/wsagj4AH++LZuIzRDEbT
         /WeaCZUdRo1TnFila95eDP1Wh6V9uR/3XL/ldcc37WLU90lRiqTi5RA7028rpBzspYn0
         uzW+qM+xaP557V5nIjT5QocjQY/t2x2za9ZZhZ52SkaDpq5OPJHeeJmMELdtjDXjttJT
         B9WSVRITYzuXvO6JzTkJ79NxGhasXXQhMfU3k2UQOy3nrYfAVvhpTpohOVYNphQy7Wsl
         Pj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EnWKtR8Gi6MBZCyGkt9dN20MUD2l2Ye826UGjeumL/M=;
        b=IO4xRyBtIV27Y0x18dRMPFhwoTwDg+E4I46T2sns8g6uQukn6K9bo+gOYKpeOtH67c
         NfFlWYsUgTz4aFQP8zr2h8TGRxTv6+s3t8XiNSg/vNnnc/+clpcvx3v8LdESIC5K7ZCS
         3QpMePSToxoetgS8TbcsmYtOQ1MZMH4gN+q4tgFs7Ys2lUxJC5uz0iHMWwNldd+KQl5I
         3BJBQ78jApa68swxRC0mFqsw4UbMUNXXA5SymGIe+nooTV7vP1ADqRXM2FMZmXkAkUaN
         9CVZVV0wbonLeR3wwqVVQqNSvZXzx5F6noe98+60b6XFSrE4SXGAwYAWrgil7BmAZAgR
         9v3Q==
X-Gm-Message-State: AOAM531IaFsxZnpn/NO1DEELaxqgUyuFNbmMK6vKEKVondJrS5JhlcIh
        oFwGVeiqZqud9Sbaw/5e1FGmzDvmvv9o2n/dvN4=
X-Google-Smtp-Source: ABdhPJxCV+TqWtFTdMF/6bZM7j6af9TKwjCsqsLP5PqihQfPd5E2/w9l1zUzIOTZC6eXqdEZ1+/twFQLRzEl5p88ras=
X-Received: by 2002:a19:4147:: with SMTP id o68mr691484lfa.295.1614222649170;
 Wed, 24 Feb 2021 19:10:49 -0800 (PST)
MIME-Version: 1.0
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-4-git-send-email-shengjiu.wang@nxp.com> <20210210221252.GA2885308@robh.at.kernel.org>
 <CAA+D8APfd8trC8cFsT8k8G54nhrYDrwXxECx9RpDAgw3rco9DQ@mail.gmail.com>
In-Reply-To: <CAA+D8APfd8trC8cFsT8k8G54nhrYDrwXxECx9RpDAgw3rco9DQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 25 Feb 2021 00:10:38 -0300
Message-ID: <CAOMZO5D3HgVF6Gq6sFo7j7OJ63NVN--ZtmwZCoM7=dmmhVZchQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] ASoC: dt-bindings: fsl_rpmsg: Add binding doc for
 rpmsg cpu dai driver
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 4:21 AM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:

> > rpmsg is a protocol. What's the h/w block?
>
> On Linux side this driver is a virtual driver, it is running
> on Arm Cortex-A core. The h/w block is controlled by
> another core (cortex-M core). so this driver actually
> doesn't touch any hardware, it just does configuration
> for rpmsg channel.
> fsl,version: There are maybe different image running on M core, this
> is the image version, different image has different function.

To answer Rob's question: the hardware block that handles these
messages is the Message Unit block.
