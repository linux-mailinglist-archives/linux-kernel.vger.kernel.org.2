Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17453AB714
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhFQPOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhFQPOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:14:47 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A70C061574;
        Thu, 17 Jun 2021 08:12:39 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id i8-20020a4aa1080000b0290201edd785e7so1676038ool.1;
        Thu, 17 Jun 2021 08:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tC24+pOMac4To09F5eTA/4RPnsOweW0hc6BAA6YoMnQ=;
        b=nfdW0YeVWdjSUYyB1QdDtOIkMgLIcyXIgaCbmVm0QNd02N18EysBAPAZVS0Y00W8Io
         v58Ms5itK3EwlYgaA2+hbdWamVl+v0RxVJLl8HaF590nSiywo+e1ptFgo0eutIq2tYpk
         EyKgtefeB9h3op9njcrE2k813gvyGx0yc0hsGyuTLSZhGb8kcBm24UOQrDuF0E2dBFlh
         fJPBUEfGkKpWm1U/2LbY67MFOS5oCBGU/cp1RJxbvuxxas7cCLSe8gumB89G4U9GLXud
         okRLvVeVbBu9+AcJjkhWnXGzq9HiuKo93TpR04+C+TifxL1+ai1zgSSjNb6iv0RqWT/Y
         j9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=tC24+pOMac4To09F5eTA/4RPnsOweW0hc6BAA6YoMnQ=;
        b=RYcKRR1Mm+ZZjtBSTBexZchBi5+jG2xKpEVvRz5KXtLUMxeyJJuzyXjTq6C3oNS1Ch
         TLcPYBftaVCXdA+8y8rxLAELTa/hk3OSKC7gpwCRf4vywYp0aagkGcQfhDwK2IyaH3nl
         wUXuWdnVc84/S0L32vnFIvFjBRGW2ZWPOYMQdXn0KrCeKxWF+T9oPhQu15VVRU/xvQhQ
         OnZotrtcxqLVSW8q2f8pCuQk9p1EAnwjzzVXZ4mf2/Al0utzLhkyoywNjfErmXmoKFdQ
         Edfeu2INzPeALKMgWrcot/wDuJKoHoG1Zu9WKCiwo/MYJIMxEvueNr7slvkAhgSXlB1R
         LqVQ==
X-Gm-Message-State: AOAM530SCeiETDmnuRce7NCaLkKdGp8EPGTPCSoAQJuPY9lr/+wbzmSU
        5JNDd9KORTbELwiu3jJ6o/0=
X-Google-Smtp-Source: ABdhPJwxvDzV5BxEOinFYI/F3uUaXXWyUCdGvnrSUcc2CnbllyTqgykS/87aVytNWz3Vi0XliNzxfA==
X-Received: by 2002:a4a:9c8a:: with SMTP id z10mr4903692ooj.56.1623942757913;
        Thu, 17 Jun 2021 08:12:37 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j132sm1154974oih.11.2021.06.17.08.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 08:12:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 17 Jun 2021 08:12:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v1] hwmon: (lm90) Use edge-triggered interrupt
Message-ID: <20210617151236.GB2676642@roeck-us.net>
References: <20210616190708.1220-1-digetx@gmail.com>
 <20210617001243.GA3211292@roeck-us.net>
 <3c6cbaf3-187b-1682-69b8-a2b34f23b928@gmail.com>
 <20210617131205.GA59767@roeck-us.net>
 <de7682c2-ae34-c594-d237-330ea33cbc78@gmail.com>
 <20210617141300.GA1366442@roeck-us.net>
 <bc3e3595-fe10-c7ae-9560-0c7676facba2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc3e3595-fe10-c7ae-9560-0c7676facba2@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 05:46:33PM +0300, Dmitry Osipenko wrote:
> 17.06.2021 17:13, Guenter Roeck пишет:
> ...
> >> This is a device-tree based system, in particular it's NVIDIA Tegra30
> >> Nexus 7. The interrupt support was originally added to the lm90 driver
> >> by Wei Ni who works at NVIDIA and did it for the Tegra boards. The Tegra
> >> device-trees are specifying the trigger mask and apparently they all are
> >> cargo-culted and wrong because they use IRQ_TYPE_LEVEL_HIGH, while it
> > 
> > Be fair, no one is perfect.
> 
> This is a very minor problem, so no wonder that nobody noticed or
> bothered to fix it yet. I'm just clarifying the status here.
> 
> >> should be IRQ_TYPE_EDGE_FALLING.
> > 
> > It should probably be both IRQ_TYPE_EDGE_FALLING and IRQ_TYPE_EDGE_RISING,
> 
> For now I see that the rising edge isn't needed, the TEMP_ALERT goes
> HIGH by itself when temperature backs to normal. But I will try to
> double check.
> 
The point is that a sysfs event should be sent to userspace on both
edges, not only when an alarm is raised. But, you are correct,
IRQ_TYPE_EDGE_RISING is currently not needed since sysfs events
are not generated.

> > and the interrupt handler should call hwmon_notify_event() instead of
> > clogging the kernel log, but that should be done in a separate patch.
> 
> Thank you for suggestion, I will take a look.
> 
> > Anyway, the tegra30 dts files in the upstream kernel either use
> > IRQ_TYPE_LEVEL_LOW or no interrupts for nct1008. The Nexus 7 dts file
> > in the upstream kernel has no interrupt configured (and coincidentally
> > it was you who added that entry). Where do you see IRQ_TYPE_LEVEL_HIGH ?
> 
> I have a patch that will add the interrupt property, it's stashed
> locally for the next kernel release.
> 
> IIUC, it's not only the Tegra30 dts, but all the TegraXXX boards that
> use IRQ_TYPE_LEVEL_LOW are in the same position.

I still don't see a IRQ_TYPE_LEVEL_HIGH, though.

Thanks,
Guenter

> 
> >> The IRQF flag in devm_request_threaded_irq() overrides the trigger mask
> >> specified in a device-tree. IIUC, the interrupt is used only by OF-based
> >> devices, hence I think we could simply remove the IRQF flag from the
> >> code and fix the device-trees. Does it sound good to you?
> > 
> > Yes, that is a better approach.
> 
> Thank you for reviewing this patch. I'll prepare v2.
