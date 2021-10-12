Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50CC42A47B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 14:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbhJLMeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 08:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbhJLMeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:34:01 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC5DC06176E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 05:31:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e12so66504562wra.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 05:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=R1Ct5vyNPAZ0T7oTekL4gDr61oOOk/9HTK9il68hSlE=;
        b=oh6FIN17b7KQdDaecOXdnI/rpi3FnsQnY0vccXX4ZRvFY5HZ56IBxetBpOAGuHmbMn
         NClZvEw7CF67oLakJhtKTQET7h+6ktX9TtSDYBmNIfoBHhCJETZWjtdfk6/7Zg/50d95
         LLyGrfNC1MVBl6VFirD/+gN2OYm06Ste+nAxMxxsEATJmE6j9uoxnNKrBC1GEcMuGYYZ
         TavAJBPcgZ1dN31c0bz73GtisMZcxsBuVAtCYuJrA52WuiVwN9/z6xwrP9LnNYI9OhOo
         XTokWkpPRpGkgSi25pIrDmoHsSf4HXGMLjA1od07/03k8qCgljboWy8oIv3Jh35CKqK8
         LHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=R1Ct5vyNPAZ0T7oTekL4gDr61oOOk/9HTK9il68hSlE=;
        b=q+fZvuNpM9t3kqh9RDohMogwB6KUAZG7c5G1pqjHmy+H5xQULXGAiYp6SnWv4469tU
         Br+nlS6dM95VkXA2O3GdI4Bu6ql4DSPSbRG/vJeYv/DEZ50NdBjmft3tRW4Ye2TLivOo
         FR184dkmYFyywRylMRfb+jeWQkYWnRPY3/pJqI0Tu1YlWnAARerJM8dbG90uNA/o4nKW
         YT3VoQNToMPcr8CjMJ1gVZhECAmFPehO8qAztsGHEkin/kG9tR7Plc+pId1qfsBJUTA3
         qL74cJeIBOLfcLD0V5/y0nunO01maIuGfIKTavs1jb0ZHMNPIov/bPum34Y7Un2eJE41
         TKpw==
X-Gm-Message-State: AOAM533z3VHfl3fbdSA5Zamf7BsnD6huMp31d0Vfwr7S+f9vaIb5aVC4
        gcMyCJmJmEyXBjuU4Wjwg6I=
X-Google-Smtp-Source: ABdhPJxxTEZshi/e0EgdWzT3n4K9vgXQhUVECxr6XcXmL2FxLOmMaAKdcS2PYaOp4HFhCP+cxEL4kw==
X-Received: by 2002:adf:ab43:: with SMTP id r3mr31978341wrc.225.1634041908769;
        Tue, 12 Oct 2021 05:31:48 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id q204sm2514112wme.10.2021.10.12.05.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 05:31:48 -0700 (PDT)
Date:   Tue, 12 Oct 2021 14:31:46 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Subject: Re: [PATCH] ARM: handle CONFIG_CPU_ENDIAN_BE32 in
 arch/arm/kernel/head.S
Message-ID: <YWWAMk2PbYOxUdWU@Red>
References: <20210929181645.21855-1-clabbe.montjoie@gmail.com>
 <CACRpkdZgXW4HOTsiw30-oncfiU54Jr_nDvZL-ZznRp8Tym=TmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZgXW4HOTsiw30-oncfiU54Jr_nDvZL-ZznRp8Tym=TmQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Sep 29, 2021 at 09:08:38PM +0200, Linus Walleij a écrit :
> On Wed, Sep 29, 2021 at 8:19 PM Corentin Labbe
> <clabbe.montjoie@gmail.com> wrote:
> 
> > My intel-ixp42x-welltech-epbx100 no longer boot since 4.14.
> > This is due to commit 463dbba4d189 ("ARM: 9104/2: Fix Keystone 2 kernel
> > mapping regression")
> > which forgot to handle CONFIG_CPU_ENDIAN_BE32 as possible BE config.
> >
> > Suggested-by: Krzysztof Hałasa <khalasa@piap.pl>
> > Fixes: 463dbba4d189 ("ARM: 9104/2: Fix Keystone 2 kernel mapping regression")
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> 
> Good catch!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Please put this into Russell's patch tracker.

hello

How to achieve that ?
Do you mean https://www.arm.linux.org.uk/developer/patches/add.php ?

Regards
