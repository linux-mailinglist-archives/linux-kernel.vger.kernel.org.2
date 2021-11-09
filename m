Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F6C44ADB1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 13:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244355AbhKIMp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 07:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244292AbhKIMp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 07:45:26 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFCAC061767
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 04:42:40 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id o15-20020a9d410f000000b0055c942cc7a0so7945661ote.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 04:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiecki.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ZxWs05PNgFFWkmMMVZIbCQopsY+aPrc9xqkCzhdaV0=;
        b=aDBWIiucwrR4twJxh1j09QBuXMtg+nFBsnO8yfr9inGfJNrTSt1egY7oqGSmhTfuwC
         vcaz3Sx1kbHlilCeGj3PMg6oXqs9z06/rThvqWJFf51LG1gitCUprW69S/+skNQV7nql
         CvQSW0VaO6vlINcuTpU/d89xxxnnJ05lBil0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ZxWs05PNgFFWkmMMVZIbCQopsY+aPrc9xqkCzhdaV0=;
        b=sQ5yvok5h/qVi+5X9mFpULaDf1H7PetWoMjDAI5fZQ9bH+UU+CaOU4qu66zeJAboE8
         MN5gdrOb6WT0/VOLdTjGWpEqOdRsE21TIY8tbmBapEb6qHwi8V80qLh/Q5bNIzR1xNqX
         mP8zP6Cvj7HzWEd/78ADBO+z+zWKIAOTz+9xE2/1oT8S9+kvlOMUzWqNnxvNNbQECeX+
         7eqfmAaR+beTb2JyqUMLuDRWMc6Mcg+aFDwu8b/X04tssOzixeve2yYtcOCm48sxUqCa
         dcHQaZprFxi82xcBXvf6A3EaUFKtAjvv+0hiweXJ2Z3lNYgjZQXEURytvsLmJo3Laxls
         CycA==
X-Gm-Message-State: AOAM530pvptB/CRt26n/z7KX4TYBej1TLeZzM/9s5dL3Ug6h2amE7tJF
        ywovKdDxBBikAcqD6YNX85okhx+hNCjU7eElIzgR+g==
X-Google-Smtp-Source: ABdhPJy38nhRcMBXJpyq2S4dQ2zU3L9V/AZ8XtKJjs2aut3JvHhtudp4KIav7A/3isAEGLGD8gW0FtdtOdnqCmJmD80=
X-Received: by 2002:a05:6830:90f:: with SMTP id v15mr5661303ott.62.1636461760200;
 Tue, 09 Nov 2021 04:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20211108212226.253mwl4wp7xjckqz@pengutronix.de>
 <20211109025619.GA1131403@bhelgaas> <20211109065927.26v6xn7d5yyuxw4h@pengutronix.de>
In-Reply-To: <20211109065927.26v6xn7d5yyuxw4h@pengutronix.de>
From:   =?UTF-8?B?Um9iZXJ0IMWad2nEmWNraQ==?= <robert@swiecki.net>
Date:   Tue, 9 Nov 2021 13:42:29 +0100
Message-ID: <CAP145pjO9zdGgutHP=of0H+L1=nSz097zf73i7ZYm2-NWuwHhQ@mail.gmail.com>
Subject: Re: [PATCH] pci: Don't call resume callback for nearly bound devices
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also, this might be unrelated, but the following happened around this
patch (ie https://github.com/torvalds/linux/commit/0c5c62ddf88c34bc83b66e4ac9beb2bb0e1887d4)

I sometimes run Win11 under qemu/kvm/vfio (gfx card), and it stopped
booting (even with the latest patch for pci). Another Linux distro
boots fine under the same qemu/kvm/vfio, but Win11 stops at the boot
screen.

It worked well with 5.15.0 and a few PRs later - with the git tip it's
not booting - and it works well with 5.15.0-rc7

Maybe related to pci/vfio changes, maybe not, just leaving it here for
track record. I'll try to debug it a bit.
