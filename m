Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224FC3AB65B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhFQOsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhFQOsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:48:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C46C06175F;
        Thu, 17 Jun 2021 07:46:36 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d16so3528047lfn.3;
        Thu, 17 Jun 2021 07:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9j+Wyv6gEsr4bQvSqZKhNp0tbHi8dmvVZ6iYWoKc418=;
        b=UjnzfFEQ/4oJrwosy918uSLpxJIEklHylQ+O8/XfG/6w+Z6sMZtM4bce19YMnHJmjX
         sVXWyTwn4IO2BqyUaVfk2cbm1i7H24GU022Epq3xNx0TSTf+xpyyN/UhGRUtAflH3OeY
         1AfoXK52vLasLsUzcTw96f341vgQNPjPCi2M09rMMBz565k8NG1IKlgfCcDpIuxtzuIH
         cutkZlB9jLCdKC7mZXAdRUaSQmoGrfe1aBzjVKddWzL+9VPf2kFyRNmtOqHNuYuQ9Gwi
         +F30gUEtFPzvydQWCumlwHA4o+6BoU4YmM/H9PaJGu2ddDURLBmW0UJO4sgRCjSLRpns
         Fa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9j+Wyv6gEsr4bQvSqZKhNp0tbHi8dmvVZ6iYWoKc418=;
        b=HqrbjVuETl85oX1FttVtb96vFAccWjcvaQOB0c1GRmEAAyfESYlogvx0jn89m9nP80
         1kgsdl31dgo8ialLgoujSDW9aTW7F62T+ViQD4V5bcdUwmeX2FvHdlWERD6e7YfW6/lS
         SiqPSJcNha4lOMtqLBtJbq3qIE9JFDKCLx5T8RxHWe5Wn2Ziuuk+XoggxJHEVPcDFu4k
         0nQs9U+2XDuZNwNFxQbdM09A3COMBNcaSKKTGF7KDao+myZo1sPMPzigQonWaf2FwRrQ
         QeuxlBnElcOhN6/1tmH/4ZbrxJArh1Ecp3ulZ5rqr86hNTsBqyfkYK70AiVHvmiyi+lN
         VHNg==
X-Gm-Message-State: AOAM533XSD9wCU+BrFNMMsuCBRHttPudHYQiaktdE8iwHEttOEHb3SRY
        SVC6hCDxD03yGdypY2oLnMJlEpsB/b8=
X-Google-Smtp-Source: ABdhPJxNQWvk6I5WMxpYLjKYKCq31Nat1HT+gbIT8U/E+EiI+oIIWNig9aPa2YMg+l6lTvA1uTA/+A==
X-Received: by 2002:ac2:5b8f:: with SMTP id o15mr4181380lfn.606.1623941194516;
        Thu, 17 Jun 2021 07:46:34 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id y12sm600339lfg.135.2021.06.17.07.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 07:46:34 -0700 (PDT)
Subject: Re: [PATCH v1] hwmon: (lm90) Use edge-triggered interrupt
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20210616190708.1220-1-digetx@gmail.com>
 <20210617001243.GA3211292@roeck-us.net>
 <3c6cbaf3-187b-1682-69b8-a2b34f23b928@gmail.com>
 <20210617131205.GA59767@roeck-us.net>
 <de7682c2-ae34-c594-d237-330ea33cbc78@gmail.com>
 <20210617141300.GA1366442@roeck-us.net>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <bc3e3595-fe10-c7ae-9560-0c7676facba2@gmail.com>
Date:   Thu, 17 Jun 2021 17:46:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210617141300.GA1366442@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.06.2021 17:13, Guenter Roeck пишет:
...
>> This is a device-tree based system, in particular it's NVIDIA Tegra30
>> Nexus 7. The interrupt support was originally added to the lm90 driver
>> by Wei Ni who works at NVIDIA and did it for the Tegra boards. The Tegra
>> device-trees are specifying the trigger mask and apparently they all are
>> cargo-culted and wrong because they use IRQ_TYPE_LEVEL_HIGH, while it
> 
> Be fair, no one is perfect.

This is a very minor problem, so no wonder that nobody noticed or
bothered to fix it yet. I'm just clarifying the status here.

>> should be IRQ_TYPE_EDGE_FALLING.
> 
> It should probably be both IRQ_TYPE_EDGE_FALLING and IRQ_TYPE_EDGE_RISING,

For now I see that the rising edge isn't needed, the TEMP_ALERT goes
HIGH by itself when temperature backs to normal. But I will try to
double check.

> and the interrupt handler should call hwmon_notify_event() instead of
> clogging the kernel log, but that should be done in a separate patch.

Thank you for suggestion, I will take a look.

> Anyway, the tegra30 dts files in the upstream kernel either use
> IRQ_TYPE_LEVEL_LOW or no interrupts for nct1008. The Nexus 7 dts file
> in the upstream kernel has no interrupt configured (and coincidentally
> it was you who added that entry). Where do you see IRQ_TYPE_LEVEL_HIGH ?

I have a patch that will add the interrupt property, it's stashed
locally for the next kernel release.

IIUC, it's not only the Tegra30 dts, but all the TegraXXX boards that
use IRQ_TYPE_LEVEL_LOW are in the same position.

>> The IRQF flag in devm_request_threaded_irq() overrides the trigger mask
>> specified in a device-tree. IIUC, the interrupt is used only by OF-based
>> devices, hence I think we could simply remove the IRQF flag from the
>> code and fix the device-trees. Does it sound good to you?
> 
> Yes, that is a better approach.

Thank you for reviewing this patch. I'll prepare v2.
