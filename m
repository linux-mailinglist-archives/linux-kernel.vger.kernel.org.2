Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74F0368F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241825AbhDWJeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241759AbhDWJeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:34:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE6CC061756
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 02:33:34 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m9so34930852wrx.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 02:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Y9sjCGRBeC9olD1ipL8CilaBrM51tepXMv+9DOr/vcA=;
        b=IdByi7XRnG6bTBkYTyr4CaMa5Nfbl4pVA7Yx4gu/FsVVGIyqZP6SbSkqaUUOD3bU3y
         UadZLBdrcoIatneM6gVlCPRzuyeUMR/m8ojc+WeqAbKIsTgXxfvepMOpEhHt1HXnPBv/
         dewdHTevMuS4bCqms2tpztBfTIN5G6wQ4cgIIfK5Gq22J71Q5e8D5eBus10Ofw36zuGI
         jFvmTru4QlpTaUkwI/d6IewwEK9/CucL9VhofbVJV832jVKprPyDWpq2vqgvU/q7aFgW
         Cdm7oY2dBfUIJOb57+aouNSiEQeZnK2UiK6zZW2sZDRTZFWtWCvABVY12MB0cWwxw3ME
         Kuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Y9sjCGRBeC9olD1ipL8CilaBrM51tepXMv+9DOr/vcA=;
        b=m9MHSMLXj0A70/d6vXzfL5NDDiU1aABcpomrMI+Q9yQBvcJ46sPiCLWc+nKLCJM7Ge
         EwTdZrdhCAsL+f3nlwdXt5O/i+DoJPIPFKBtg2Xbgfwx1yNhVMSXiEIfohc1c8gUWLQb
         r/FD0eFrojCuPLY4ryBsIwTj3tm3aPmqxQmomTxpal+8ma5bQwFkzm3XvEK/NkCoRavX
         /+oI0SWTM8Wy2jdZ1APHUaVjfIPcfNIZrzj7iBI1mYFXFWAGrCawQHHybpROPhfLfFhE
         U1WZnN13YDMv7pKzUBRYGyq0LJsjItHoLjLtdg/m2Gx2QjDUwX+mQBl2wbF9SzhJP6/N
         Zewg==
X-Gm-Message-State: AOAM531OnjQO+JLSluRB5iszNHoE0AWNjF6eZ2agiFb/syc0JDsQL+zy
        pSJsQXdsisjjuGAfUqiS1d9+ug==
X-Google-Smtp-Source: ABdhPJx/qWGko2tNm6hwMQwKav/UXX7Xf0wKSFXBriRhNUQxT2/YyVJKUtx2iyS7weGO1NGoXQ0fYA==
X-Received: by 2002:adf:fbc8:: with SMTP id d8mr3560558wrs.94.1619170413462;
        Fri, 23 Apr 2021 02:33:33 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id a22sm8154282wrc.59.2021.04.23.02.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 02:33:32 -0700 (PDT)
Date:   Fri, 23 Apr 2021 10:33:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add Qualcomm Technologies, Inc. PM8008 MFD driver
Message-ID: <20210423093331.GF6446@dell>
References: <cover.1618278453.git.gurus@codeaurora.org>
 <20210420164659.GA21665@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210420164659.GA21665@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021, Guru Das Srinagesh wrote:

> On Mon, Apr 12, 2021 at 07:00:24PM -0700, Guru Das Srinagesh wrote:
> > Changes from v2:
> >   - Collected Rob Herring's Acked-by for the IRQ listing patch
> >   - Addressed Rob's comments for the dt-bindings patch
> > 
> > Changes from v1:
> >   - Removed errant Change-Id from dt-bindings IRQ patch and gathered Bjorn's
> >     Reviewed-by
> >   - Fixed up YAML errors using make dt_binding_check
> > 
> > This driver is dependent on changes that have been made to the regmap-irq
> > framework that have currently been accepted [1][2] in regmap.git upstream by
> > Mark Brown but haven't made it to Linus' tree yet. For this reason, this driver
> > has been based on the tip of regmap.git and not mfd.git.
> > 
> > Those changes, and this driver, are the result of a rewrite effort that was
> > promised a long ago [3]. The framework changes and this driver have been tested
> > and verified end-to-end on an internal platform.
> > 
> > [1] https://lore.kernel.org/lkml/20210318183607.gFxO2hoTO274vl3jUuxWbi19rq9wQELzN-y3B4jvO10@z/
> > [2] https://lore.kernel.org/lkml/161726943419.2413.4844313396830856637.b4-ty@kernel.org/
> > [3] https://lore.kernel.org/lkml/20200519185757.GA13992@codeaurora.org/
> 
> Hi Lee, mfd reviewers,
> 
> This new driver depends on three regmap-irq framework changes that have
> been accepted by Mark (please see above) and hence will land only in the
> next rc-1 release. I just wanted to make sure that this patch series was
> on your radar [1]. The dt-bindings has been Acked by Rob already, and
> I'd be happy to address any review comments while patiently waiting for
> the dependencies to land.

Yes, it's on my to-review list.

Linus is about to release v5.12.  I'll review this set in good time.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
