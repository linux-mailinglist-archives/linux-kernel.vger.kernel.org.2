Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0243EE0AF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbhHQAEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 20:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbhHQAEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 20:04:40 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3743AC061764;
        Mon, 16 Aug 2021 17:04:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso3073431pjb.1;
        Mon, 16 Aug 2021 17:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8OcYoQrjOQIm/iOfn/qGg5WXk6OnAW5qFwcrs/rMErI=;
        b=H/LgA0e0aRuTUYHHg7c8649E/r5biZOpoBg7KtUO38aR75LQrqKye4P6cMEfwu1L7W
         SBx12BW7i+wEh9nBFnKidZ2L3P1aKg7lWLx8Bj0H8InXsT2eCkjIpyrCXiUeehllATnV
         pTmPzGF7O9Y8nNyeoan4jkhMCmJI8Ld60Dxdc2LBRmaxonfZjkz1EM+gHGfbbwzu+nbC
         eBt7HfmcSqtsWnPjC8XebqAigfK/YsYZDA+22jz1RmFyCVT1s4s0x/cMVib3WZCupllg
         hCBAvki+G4wr4ttmBMf1CllKVXOmRDE1x2yYK6Xi1cwOhzCxgd96e1YAljeFBr7qzYwu
         wLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8OcYoQrjOQIm/iOfn/qGg5WXk6OnAW5qFwcrs/rMErI=;
        b=TN+K7JM/5cL66SnKuPWM6UKRqjfCMlJVCkHKZ5uThsYMavwE9neEDPpjCZXrhlq+b/
         Qgmgv0HfWmyH2QqfP+8xpk5enI/yxhTU5dkR1UiWPmcMFt4QTbXQYc+oVYGxlhJeQDfo
         4oExGgRvfh4aTZHshyYhljGVlVYPgn+DEDHu9TSQcp2l+QifswNVPUGnDDM2nGvK7NP3
         r3QGk1H3RY6dsTM9ntQyqsk0xi3YYt7y1q8AIKUAWT5swaVepqmN4pOCCfSfYONVSBPQ
         yaTIRM749C0FyaYX9Z45cLWLeKh+zZIL4Vaest/9ajfApxz3e8Vec4FxMgmVKBAiQZHI
         89uA==
X-Gm-Message-State: AOAM530vYaYwrsJlwHVHevDOMZm0okGRBa+76ABmCBIAmdqJZ7mvl3c/
        eJ396On9KRiFrfMwxwcKaaA=
X-Google-Smtp-Source: ABdhPJwtLYKDhsKinpch6hw0rT/vGFaK/Jdkg0IXrY1PiIgMwHhRyJEkvRLLKb+Bsf7366YwpdXaRA==
X-Received: by 2002:a62:6242:0:b029:3c6:5a66:c8f2 with SMTP id w63-20020a6262420000b02903c65a66c8f2mr667349pfb.59.1629158647726;
        Mon, 16 Aug 2021 17:04:07 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-92-48-112.hsd1.ca.comcast.net. [73.92.48.112])
        by smtp.gmail.com with ESMTPSA id u190sm282154pfb.95.2021.08.16.17.04.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Aug 2021 17:04:07 -0700 (PDT)
Date:   Mon, 16 Aug 2021 17:04:04 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Subject: Re: [PATCH] ARM: dts: aspeed: minipack: Update flash partition table
Message-ID: <20210817000403.GB7547@taoren-ubuntu-R90MNF91>
References: <20210720002704.7390-1-rentao.bupt@gmail.com>
 <20210813062435.GA24497@taoren-ubuntu-R90MNF91>
 <CACPK8XcAqU3KASespqS3dPterpzyqD4wYH=qOS8Ok2yUrB_F+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XcAqU3KASespqS3dPterpzyqD4wYH=qOS8Ok2yUrB_F+Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 02:11:40AM +0000, Joel Stanley wrote:
> On Fri, 13 Aug 2021 at 06:24, Tao Ren <rentao.bupt@gmail.com> wrote:
> >
> > Hi Joel,
> >
> > Looks like the patch is not included in "dt-for-v5.15". Any comments? Or
> > should I send v2 if the email was not delivered?
> 
> I had missed it. It's now applied for 5.15.
> 
> Cheers,
> 
> Joel

Thank you Joel.

Cheers,

Tao
