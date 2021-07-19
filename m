Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C584F3CD5AA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbhGSMpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 08:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237775AbhGSMpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 08:45:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07886C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 05:47:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c12so4018379wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 06:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3L2qOwfDPDPficyOPSVrr5/aBYeZ+EOYlXkatvhjE3Y=;
        b=LC6U6FSxiXkRjCjGQGyv2SxbG2oywh0SlI6mQB1kOJ5HT5+AQdTzZWxJrglkPJ5EU5
         9MeECtrm+KbyrTK4u4Z4359uPzkab+fMOHxVB4q+b5erLOZOL1HuS1SkEHb6g3htIOlV
         PJ8XFo0a3PKB0TxVG9DHvCU6Naod8fyXOLcezr3WDhaoL8LYZOBd/vzixR7pVxaMeTCg
         O1jVzv7RPxbKL9w/aPacwlO+e8NbXvsJZp0V5UQaykC9vcnBCyM1DerYuF0G28kHthJL
         MwGpwlDsKgkf6PKakfrE6a5FGBX/c/50MQsU/r1gugTRMZgHdI3G6li7bnJGuyU8tPuK
         JDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3L2qOwfDPDPficyOPSVrr5/aBYeZ+EOYlXkatvhjE3Y=;
        b=M3bfdQUanfeqzmV9Gpo8HdsWQuFIwOOAgNWRj+FYpY33wWGDfhXGqZEIWxZ81LYxB0
         D92bgQMvFVIjTNAsoj1b7eeHkIXNNt82bOVYsLNRq5lFAKX+Pa72/VSQ5fIgqdqqOM8R
         PLXYqkC04GopEmGvNn73XUX1uGIq1SdSZSgr7lITOpXdJlliC/TN+FbutZOt+AnEFi3p
         ua0fdQ/NPYeDpwfjHYMhrDApDg9AnQbbyRbkNffaTuvL6Lh9z64BiOBKbBiaCVsWGPL8
         Jf2S+OMAGkDeIMFjU3lEzVfFe8m5yRNeuKM3iK60sLRtb2Sg3T0fTQPNpdgUWve1K+so
         XEYw==
X-Gm-Message-State: AOAM533Dkamn52Qi2Bv5W4xxFt5YndSv5t/k/GBy0+HXlo5AO8fcJpPr
        SCUQwk3TArwTwKO0rUwWhZXV5g==
X-Google-Smtp-Source: ABdhPJy2QV7gxdjcSzGLI/i8ubjGI7JF6q11jcJ8k/Da3LTjSIYSUsMqWnzt1wJh7UB/IRS3FAywfQ==
X-Received: by 2002:a05:6000:1844:: with SMTP id c4mr29984208wri.38.1626701179131;
        Mon, 19 Jul 2021 06:26:19 -0700 (PDT)
Received: from google.com ([31.124.24.141])
        by smtp.gmail.com with ESMTPSA id l18sm21961507wme.29.2021.07.19.06.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 06:26:18 -0700 (PDT)
Date:   Mon, 19 Jul 2021 14:26:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v14 7/9] mfd: hi6421-spmi-pmic: move driver from staging
Message-ID: <YPV9eAOrruDdRMvn@google.com>
References: <cover.1626515862.git.mchehab+huawei@kernel.org>
 <6c64fa6abae6c9fa78ace1bf240b33b47eccae52.1626515862.git.mchehab+huawei@kernel.org>
 <YPVaCCu498lNY9a2@google.com>
 <20210719134537.0cab0827@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210719134537.0cab0827@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2021, Mauro Carvalho Chehab wrote:

> Em Mon, 19 Jul 2021 11:55:04 +0100
> Lee Jones <lee.jones@linaro.org> escreveu:
> 
> > On Sat, 17 Jul 2021, Mauro Carvalho Chehab wrote:
> > 
> > > This driver is ready for mainstream. So, move it out of staging.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  .../mfd}/hisilicon,hi6421-spmi-pmic.yaml      |  0

Ideally Rob would give this the once over.

If he's reviewed this before and there haven't been any significant
changes, perhaps you can bring his Ack over with the file.

> > >  MAINTAINERS                                   |  7 +++++++
> > >  drivers/mfd/Kconfig                           | 16 ++++++++++++++++
> > >  drivers/mfd/Makefile                          |  1 +
> > >  .../hikey9xx => mfd}/hi6421-spmi-pmic.c       |  0  

Looks good to me now, thanks.

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
