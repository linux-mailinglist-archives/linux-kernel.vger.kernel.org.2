Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3643CCD46
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 07:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhGSFU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 01:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhGSFUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 01:20:25 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DD1C061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 22:17:26 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id z9so15632616qkg.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 22:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DHVrqtdYh0+ezX5UJ5k9Sd/FBBWh5d9n+IK0Mwb7sUA=;
        b=WOKLVuTZ2DH2z86799jz/I3LHftCfoCUttYlx5QOAGNYSNQNe5J/o33YCauJZZQX6R
         IIBbTs2OlFXWMZKd1+T1JPai8T0VMYMVT7ETHSBVJuDphrnMZV6VLRIOiGar8e0gr7wJ
         7TfWlWgRsjoasfI1HBdolgwnIEAiABc6BHKik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DHVrqtdYh0+ezX5UJ5k9Sd/FBBWh5d9n+IK0Mwb7sUA=;
        b=jAWoojC4kid36e51++r0SohUJljDUPfNNuAk02FKsaYKIIueNff2QXTRNX/2weEsQ8
         VlORD3SNQNy/DQeyiYj1R30fxA2FVnkXyF7bOVBbqELMaMvMbppoAQgCksDYGdFT0mwB
         emhrusgx0yZX/mJIHTQDvf9jw8Eo3I66DoTX/n8mw+CASRMbe1gQp4C5WQfNt4R0bpu5
         LwCicJE85+2wDDO2bxCUVx4o/Ol2Bhwub5/ZiL5MqQDzKaEwvAvhFWEvS+/SwLBNAXH2
         gtq6triCsHCFYpaeTytwMS0dttJ1PwHJgu+kWLXcUIoe7Cet7WK0WqYVT11ayQJFTE8y
         FBtQ==
X-Gm-Message-State: AOAM530GdttawIDAvo0KxiXCmNeWkM5Z9QjC2SrakOypJahvu6bpZniL
        ghLAhcY3dMGFlMR0A1HE4jIo+9eeVhoYMZrb3d+cYWJ5UCo=
X-Google-Smtp-Source: ABdhPJx1bZbfBzlkU6aXDmMJEi/cGfv5vrFsnI0MUjB1+6nx1xbSqSp1ohZGeAgksa22rG4d77V/k3Zddp2Kb50to0w=
X-Received: by 2002:a05:620a:1242:: with SMTP id a2mr22037379qkl.443.1626671845953;
 Sun, 18 Jul 2021 22:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <202107190200.Z2RoQoYz-lkp@intel.com>
In-Reply-To: <202107190200.Z2RoQoYz-lkp@intel.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 19 Jul 2021 14:17:15 +0900
Message-ID: <CAFr9PXng3dVVeHm8Xcy3i7MfjnPOM8ewCtGAWWUcgBZcM+RJqw@mail.gmail.com>
Subject: Re: [linux-chenxing:mstar_v5_14_rebase_i2_drm 257/349]
 drivers/clk/mstar/clk-msc313-mux.c:27:2: error: implicit declaration of
 function 'regmap_field_read'; did you mean 'regmap_field_write'?
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2021 at 03:52, kernel test robot <lkp@intel.com> wrote:
>
> tree:   git://github.com/linux-chenxing/linux.git mstar_v5_14_rebase_i2_drm

Is it possible to stop this bot from building branches that don't make
any sense?
This branch for example was a work branch for reverse engineering the
display hardware and has a lot of junk in it.

Cheers,

Daniel
