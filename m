Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C663D4544AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 11:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbhKQKJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 05:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbhKQKJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 05:09:03 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D246C061746;
        Wed, 17 Nov 2021 02:06:05 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id q74so5784373ybq.11;
        Wed, 17 Nov 2021 02:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Ae53HUdIl8LFz+bBsVHItIqLX490EPHb3zwvtgS/7Bw=;
        b=QsVzAHjv00Jmu6STYR6irh4zaeW8vZFKlBlyKnCGjQpXPHZr59Wvpp3g5LnOIzZDIL
         fT/drg/fbge7K2fK+W9W+0NnKTLIorrlWXn0hH1tgMAIXIEudNMT6jwlMdCm8w4yZ4XT
         cm/cLlPMGzsh+TidWmGT3SK0JFysCzIDlxtP0+QfA5KjKU4hJPsfPm2Gi/nNyyJsN7q/
         GV9ujcFxIpGewMW0eCJusPqBjOICGJ5Y+Pj/6dv/C4D0GlW3VFc79jwHcJTHeiyC+Rw1
         Wuy30Yi33T9XBxEitlsjrS1DYBADbwxxB726C073E1MQmyIEaHbESNS8OqzGcnvjDDut
         D0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Ae53HUdIl8LFz+bBsVHItIqLX490EPHb3zwvtgS/7Bw=;
        b=SmESWmXTpIrcFa/jnncGJneXmCAsfngBIFLYf8pbSF4+9eOpDyjB2JIu1VIejcrrj2
         9+7CKBST0I3Q9ue15AYGueImqfmPf2eVbF5tF/PLTU9LpiJN2Ulsxq67909EfIhdnzHY
         KWodghWu+BsC9iAvtIhoFD5ImOFwCpTFIWTjLoyhWnywnUqF7CXHldU6pSUlWPH8p6V7
         zy59X9Rh1zvjF6E3prQ2ZGiLMPRBBnVyIVSCvBjCc6ORL01N5Gb5D53rkZSOd3rIea8E
         k8NS/V+lLy6of6QsXQpV/0pJZweBCwQWEgXL/z8pYRmO6Zscc4k1piel6gjH3DT8OR5q
         RhSQ==
X-Gm-Message-State: AOAM533PPnSbK5jNmiDgQ0K6fOkmq9eYPebotWp6pDbcj4zauxORT0Ni
        JkNG2+EKnHExiernI/a/oxgc94IQJa+JzK1eZoY=
X-Google-Smtp-Source: ABdhPJzU1BgAUSR7puZxQLDS+Mr79o55Z4vi4pUEiUI2aegBc0O9017bjF5iDE9lWxfrX9RSWbDJoldTysHQCHYYZGs=
X-Received: by 2002:a25:e016:: with SMTP id x22mr15764494ybg.534.1637143564337;
 Wed, 17 Nov 2021 02:06:04 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 17 Nov 2021 11:05:53 +0100
Message-ID: <CAKXUXMzqgyNGEnxAMQqZiXJYSK-X8uB-nxHWwPg41H6yS0GWNg@mail.gmail.com>
Subject: Reference to the non-existing kconfig symbol SND_SOC_AC97_BUS_NEW
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Robert,

In commit 1c8bc7b3de5e ("ASoC: pxa: switch to new ac97 bus support"),
you changed the select in config SND_PXA2XX_SOC_AC97 from
SND_SOC_AC97_BUS to the non-existing symbol SND_SOC_AC97_BUS_NEW.

Hence, since then, ./scripts/checkkconfigsymbols.py is reporting this
invalid reference:

  SND_SOC_AC97_BUS_NEW
  Referencing files: sound/soc/pxa/Kconfig

Robert, it seems that you were already informed in the past and
already acknowledged that some work is required to fix this in this
email response:
https://lore.kernel.org/all/878skf1zmp.fsf@belgarion.home/

As of next-20211117, this issue is still unaddressed, though. Are you
going to address this issue? Is this patch just pending somewhere?

Best regards,

Lukas
