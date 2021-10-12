Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921E8429E99
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 09:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbhJLH17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 03:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbhJLH1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 03:27:45 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E37EC061753
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 00:25:35 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t2so63876215wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 00:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=kxug8zb/EGJmL2xGeTXvkDk7vUlZHkHARgIrRXZWVYY=;
        b=J4zVQsKIW0Fn+dUAqKQfD6f1xldVD6mI7fPCF+GfT8rigWHeW3pZfm1uVE+zEIJ/Fl
         kydgpXuDZnam1OfImxkpgpoIAOpM+2qCW4mU1Qhhi3DfWqjEbhFVrIwan+L+sWAdqYxf
         HJKJzZ17edGlKeRgOdvPbcwkhK2XAYK8RhTZgvJsFdhnkn1h2/JfRFj/dcpmwMuYWh/z
         inI4q2lq88tmFDgB0ep6caL711yJBB0rYdtrb5WfD6dV2F6RKhb/Vad+A+k+bgaDf6K8
         yixFzptHDMHadsVnB9FjAjlAsmVoC+zGi65UMklwBgJUfrlqT+OftgbeiTxsxLednWp9
         rfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=kxug8zb/EGJmL2xGeTXvkDk7vUlZHkHARgIrRXZWVYY=;
        b=OIGJToKA+fW6uzhCU+9hesEovz4ikmtcvg00eu9L/oDaanJ724xsrutGG50h7OvEl3
         Mfo+egpcuB8EwPzOdggLTMXFok05y54CnyebDk+q/XuieKzWuoHS1KVq2DzhjZkX0CWP
         AYHbwynQBRm6BSMn1xBcxE3FiTMLc+h/mf/tUcq6EYPL7fTnCtFU/vXVv9+0uj/wct8O
         Pw20gcVJrKEPFTdeBw3ncxd/EClcM//dTmvnqS2AboNXOdluOwrueD/vGAVTOhzOe9/a
         /4zxnbeB+mEP/DmijkQev7F4fC0DL3rQMw81BPNBQi/McHpDrS0okBxv58/l97Nn8x6A
         Wskw==
X-Gm-Message-State: AOAM532/mMtI900HSpOvzFcGQWdnGnGCjOcEwPibFe7bfJTV/lRqe8wT
        2C/hiXJW5rUoziZRVrirrr4NTrayGVtalA==
X-Google-Smtp-Source: ABdhPJyWcLdcIK2F1yvYuz94KzMR4N0FArd3m10As4uYLTdeJ+s/yHqkz9aeF94peco5a1PRmNj64Q==
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr3798000wmc.86.1634023533805;
        Tue, 12 Oct 2021 00:25:33 -0700 (PDT)
Received: from [192.168.1.21] ([195.245.16.219])
        by smtp.gmail.com with ESMTPSA id b2sm1798371wrv.67.2021.10.12.00.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 00:25:33 -0700 (PDT)
Message-ID: <7cd9ccc118c1955b5f3b48f6f8a7157a72d5213e.camel@gmail.com>
Subject: Re: [PATCH v2 6/8] ASoC: cirrus: i2s: Prepare clock before using it
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 12 Oct 2021 09:25:15 +0200
In-Reply-To: <e23f7de1dbb02def413d721a3bf5759100380937.camel@gmail.com>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
         <20210726140001.24820-1-nikita.shubin@maquefel.me>
         <20210726140001.24820-7-nikita.shubin@maquefel.me>
         <20210726165124.GJ4670@sirena.org.uk>
         <e23f7de1dbb02def413d721a3bf5759100380937.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On Mon, 2021-09-13 at 23:43 +0200, Alexander Sverdlin wrote:
> On Mon, 2021-07-26 at 17:51 +0100, Mark Brown wrote:
> > On Mon, Jul 26, 2021 at 04:59:54PM +0300, Nikita Shubin wrote:
> > > From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > > 
> > > Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
> > > to Common Clock Framework, otherwise the following is visible:
> > 
> > Acked-by: Mark Brown <broonie@kernel.org>
> 
> would you take the patch to a tree of yours, please?

I still cannot find this patch in any of your trees, but I've found this one:

commit 726e6f31b1026f62206f1d32b5cbb7e9582c4d03
Merge: b09bff2676be 7c72dc56a631
Author: Mark Brown <broonie@kernel.org>
Date:   Tue Aug 3 23:27:27 2021 +0100

    Merge series "arm: ep93xx: CCF conversion" from Nikita Shubin <nikita.shubin@maquefel.me>:
    
    This series series of patches converts ep93xx to Common Clock Framework.
    
    It consists of preparation patches to use clk_prepare_enable where it is
    needed, instead of clk_enable used in ep93xx drivers prior to CCF and
    a patch converting mach-ep93xx/clock.c to CCF.
    
    Link: https://lore.kernel.org/patchwork/cover/1445563/
    Link: https://lore.kernel.org/patchwork/patch/1435884/
    
    v1->v2:
    - added SoB
    
    Alexander Sverdlin (7):
      iio: ep93xx: Prepare clock before using it
      spi: spi-ep93xx: Prepare clock before using it
      Input: ep93xx_keypad: Prepare clock before using it
      video: ep93xx: Prepare clock before using it
      dmaengine: ep93xx: Prepare clock before using it
      ASoC: cirrus: i2s: Prepare clock before using it
      pwm: ep93xx: Prepare clock before using it
    
    Nikita Shubin (1):
      ep93xx: clock: convert in-place to COMMON_CLK


... which claims to merge both "ASoC: cirrus: i2s: Prepare clock before using it"
and "ep93xx: clock: convert in-place to COMMON_CLK", but they are actually not
merged.

Could you please consider ASoC patch, while I will resubmit the final clock conversion?

-- 
Alexander Sverdlin.


