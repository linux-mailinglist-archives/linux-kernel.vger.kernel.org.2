Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E613C72D2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbhGMPNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236873AbhGMPNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:13:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ED8C0613E9;
        Tue, 13 Jul 2021 08:10:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ec55so8757718edb.1;
        Tue, 13 Jul 2021 08:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GXSApPPLGUhhXM/V78f8wajJ1bbfuwFyK0zy0kRxBqA=;
        b=tLM2bZBt40bgP5Vo+Gh6dkRxvT+9Sr8VSaJWjxsi90cSlMfCWM90/OhXLI6uHq7BtK
         RpjBkoU29VPD7/3V5PLHRn4dGaWEy22WHP4FX3DMYZYT50UyPrKKZ8g2+Q1C8JPfP4OI
         4Kmw+o23DEBPHF/VRXclj+xENv2LnWhMDnV/OsjbkihotRXXfd+vdYhIxKYt/OCrtItf
         aKVw6fB4kh/6ZDsK35gAKPc//Ibd4gHwno4abwP2H6BPrhpPP8anuS7FOl72RwJ+BbA2
         DVy6NBq6+XZzdj85xrqyZ/LYLvOjoysbhEzBfDiidmeZAGNXiOFGhA1UEvWyZNBgSbDB
         E4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GXSApPPLGUhhXM/V78f8wajJ1bbfuwFyK0zy0kRxBqA=;
        b=GzJqsdHHCu8L4ZKMrVXLGgDDAfxLznO+SCAc2ZJVzYijNmJXHox4sf6xu4chDGKaI/
         VLDkbgInLdEUhlW2/i+pRTy60awpQSStUwq/DQXnGUHQIAQU9WqiWuOyuOtGPovJEYb7
         UMcaRdYtw15UUhKVoanO0XRGZBZSO8dnzYy/ABv0Zaf8j6f2JZqKtrSPQ75pUcw+uI2g
         E11JxJK12h+x/iFoaYq4x2ZsOz1TwfWQbrxjaci9DJG7lTAD2c/yLOy3YH0XY/5V76GJ
         +lsGv7K02yICJHm7dFclhHhSGt6r5thyKlcxR6Fdpg/n2ICL3Kr3wZ30oMBljcrkP76b
         v5gA==
X-Gm-Message-State: AOAM530+jaRF+9ccHIuqWr9MfZvcAXC4AijeWwUmSwuRmerGcUsI59dn
        lt0G1SfcxStzvSs2BB0RATrZ8hLtmC0IZtaDQ/g=
X-Google-Smtp-Source: ABdhPJzCxYkRS51Xrr9LI81R5hzAdh5tZIviK3d3m2EE0Sh2KMgNVn6R7JxtZZxPw8xNgGZ3DtaTSVLMPZOFuUzzmYk=
X-Received: by 2002:a50:fb04:: with SMTP id d4mr6302757edq.143.1626189026249;
 Tue, 13 Jul 2021 08:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210713055227.1142-1-linux.amoon@gmail.com> <20210713055227.1142-3-linux.amoon@gmail.com>
In-Reply-To: <20210713055227.1142-3-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 13 Jul 2021 17:10:15 +0200
Message-ID: <CAFBinCC9rR1F7Fgg5sao4h3qtFZU6OTTJMgmSJMibyBv0nGjMQ@mail.gmail.com>
Subject: Re: [PATCHv1 2/3] phy: amlogic: meson8b-usb2: Power off the PHY by
 putting it into reset mode
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 7:53 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Power off the PHY by putting it into reset mode.
>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
based on code from the vendor kernel [0] this gets my:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


[0] https://github.com/endlessm/linux-meson/blob/0672f0b61eb92ba63c91d858a678d2c3a0bba06a/drivers/amlogic/usb/dwc_otg/310/dwc_otg_attr.c#L706
