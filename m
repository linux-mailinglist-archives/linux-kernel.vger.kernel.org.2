Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B660E45CE08
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 21:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhKXUb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 15:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhKXUb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 15:31:57 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00894C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:28:46 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id y5so7698578ual.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engleder-embedded-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NjHH3i4cKOuPr1Ljxjn7FXAF9VpfnkioyuQhHGL8nqo=;
        b=lfg5QoE6xDdp69EPhHUp8UdrmdizIEtJ1PvxJa+hEE+t7mj3RvLgVCjRzvTTI69bRj
         e6RmsLBnbshsSWAenOCc5tAHb+XyNA/Zr0rr4jsa8v1+ZF9AeG4XVfs7hPvLuDFCBOT8
         v8V5UfLi1SvNGYr16y9JPJazmeOYc5WlpPj5753fQ1gs6twa2BL9KhsNnSHA9Pz1yUfs
         RkNQu/GelCdHt5FPuIlMCrBxhnUdDc2D+D9kToGF+/+/g13sfwJxh3gf5PQc7+LdoUZo
         vz9i1CF7Us+cEWeLMWTdxFuxTJpd7bvw7D3MmxUlo+biGPFgt4r5ptH1U2pnN4DiFd53
         fv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjHH3i4cKOuPr1Ljxjn7FXAF9VpfnkioyuQhHGL8nqo=;
        b=XtdrtjwdnMCJqT5Wc14MVMRu8ZNB1mBDOkQxvxXdC4Oe9nvxLjETwhIP3pZS7TjPRW
         JQAl2EgePfagGj0TKskmSuMctmkCcnvdWsxzCSU0obCyncnUaAG+qnA4A8X2RgLTbXza
         f+sx+c77YP1Ic4Bpomawjip3yn9g2fDcioDzM2fNCC+JBKCc8ImRyuQPL2Uq2IvhMPxj
         eoMgEByE/w6JJqwsOktqiDh00MM4q79XMci84DfbtdxN2NLx3sahE7f9eoaajN+UqIoW
         jTx2LdBHVCwfvja6RK1DRRf4TCpotHhBdTRX5hLHCGZHq1XUY33nzdbN31ogM87u9pP3
         Cj2w==
X-Gm-Message-State: AOAM532op3K3IeRMsOQmvznMHT3iJWlVzBf0vawdBvYSZCzDwe/hObsv
        LncDDtkp+0SVaXrcuoUDPVRD4y83h89oocgk1NfK+g==
X-Google-Smtp-Source: ABdhPJzBMhjwTGK3hQCiNYB7yqE9O9MdHrE4g6U3RaW8cqcLT46j14s31Va0VBnOJi0zE77y/0LH/aJCMnL19XjPaDw=
X-Received: by 2002:a05:6102:32d1:: with SMTP id o17mr28010224vss.19.1637785726120;
 Wed, 24 Nov 2021 12:28:46 -0800 (PST)
MIME-Version: 1.0
References: <1637721384-70836-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1637721384-70836-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Gerhard Engleder <gerhard@engleder-embedded.com>
Date:   Wed, 24 Nov 2021 21:28:35 +0100
Message-ID: <CANr-f5w8YBr5UpC0rES+5P+A=ojK-9sqRnUMtRtf6VGCk6ifUg@mail.gmail.com>
Subject: Re: [PATCH -next 1/2] tsnep: fix resource_size.cocci warnings
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>         adapter->addr = devm_ioremap_resource(&pdev->dev, io);
>         if (IS_ERR(adapter->addr))
>                 return PTR_ERR(adapter->addr);
> -       adapter->size = io->end - io->start + 1;
> +       adapter->size = resource_size(io);

In fact adapter->size can be removed completely, because it is used nowhere.
I will submit a patch.

Gerhard
