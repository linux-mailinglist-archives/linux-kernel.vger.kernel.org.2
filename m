Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFB733FBB8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 00:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhCQXKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 19:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhCQXKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 19:10:18 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084DAC06174A;
        Wed, 17 Mar 2021 16:10:18 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id b10so329646iot.4;
        Wed, 17 Mar 2021 16:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LP5IWSMRP8RZgtYzJ/AWviI0W1pO/EoAwNzy2cazgHo=;
        b=b048VUHARtXjGvQZgKMCLn9MNWtaGzfmG0RTBNDev4DFRX8hKCoUYAA8p/xRWgAYx3
         LmdIgaS2dUeyFDqqmjSHKqZmCRXYparo6lai9bmonjiJx9zCCktypKELvN5gksMmEMD+
         K8ybtIGWbyNCFawqz+4s4pLj+87+jtDZqTIGqUJqm5GXmXPituD5cmPJJS5Lm+n9ROYX
         ACGZPdaLe9bCcudg/Chi1ocdXNYx070/7wRhGofWj8ahacpYT7dNBtO5PhuTkpxmU81L
         xDhTAPKgrmrMJINUE9JKCSLsc9ylPFI/nbbsy4Vh9zWRGg2uGmyQRWcXHXzLkfHPtF1M
         eonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LP5IWSMRP8RZgtYzJ/AWviI0W1pO/EoAwNzy2cazgHo=;
        b=OpXZ1kHUN63CGqYTAs4Hn9+E8YTx+d70yEGJtcdVUj8JtPjm0CarlNA9E0XvgcMTam
         nEuY7BPBAkt4Et8t8gpsHDQqNTWyUg5Kaw6saxa0jmEvctzXd+04wT6imuBFVxEAXyjp
         5W1P7ONWAZYLjJDOMg5esNSendXj1TnzC5ayvOEpq590U/jfzZDswFvc4X6jZt9DKkrZ
         jNq04S7KW3yb7vyBTSKZfKGZ9LJXqlLzwxJWOeoxt+cT1V5Xk8/D7DAD08GC9fhOooEO
         ssxYh+/9IhfH9yWvP3qIGtuBgzcJOOv8n+CUkb8HpKOLRPeIDzU+XmjqcJoAc/Lp3GwT
         xZiQ==
X-Gm-Message-State: AOAM533X+xt4D96X2BeeEePdQb47kat7eWa99CbO3yVDzHPwATj83H5Y
        XX70Op4fbFP1eeTKMHdpFwu46JKwfx9GjMdb0K1YF5umZRoyOw==
X-Google-Smtp-Source: ABdhPJxwnPpwFM6till0nCzyyWds9TCykW07ptWvBOVrZExXHqb5U9gkWUESyORm3SAiluxesOy+SEnsZXyFPjO2STg=
X-Received: by 2002:a5d:9e03:: with SMTP id h3mr8415319ioh.94.1616022617429;
 Wed, 17 Mar 2021 16:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210313192033.2611349-1-ztong0001@gmail.com> <YFJp+It0/f7O9YId@kroah.com>
In-Reply-To: <YFJp+It0/f7O9YId@kroah.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Wed, 17 Mar 2021 19:10:06 -0400
Message-ID: <CAA5qM4DHbMv8LAN0EucFHokk5jjW2m6eKACTGTFbSMJ7zZ020A@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: udc: amd5536udc_pci fix crash if dma is used
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        linux-usb@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
Thanks for the comments.
I tried to find the commit that introduced the use of dev->dev in
init_dma_pools()
and added that commit to the Fixes tag in v2 patch.
Please see if this one works.
Thanks,
- Tong
