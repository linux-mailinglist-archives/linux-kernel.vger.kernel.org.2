Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE4A3E1366
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 13:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240717AbhHELDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 07:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240367AbhHELDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:03:47 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B18DC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 04:03:32 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b11so5998546wrx.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 04:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HhzrvgmO5ba+fhVLJprYCXwSXtS8k1j17nCMUGFb81U=;
        b=NLLRmvnBBVE6ROi6/LFYw7U0LM7JUn9gP7tJhZPftCPoebU/HZTUs34uR4Stdo7Zkn
         Xc4fVMptQO/OZ1SuuY+is0Ze5Sp+HnK0Bk9PvmkRy2oUA0ezMB93qVjKMt1CqNoOs03I
         AElpq5IZuruKkJ0dt6U9TVGAGlBn6pi47Le3jweoOau/2e4GoJPEPsNo9GV7A6qRfK0y
         /28LsEiRAZtrMdLwM9c+CbjpEKsCpSlOB7WmhdahjWFxdeQs5CTLg6M5oMGdEWrHlb8K
         F4ONAIPi/rKPz/icJD8uPBQgGNEW8reu3yyte1ttruuqHrP+FIac6Q8RAViRhKJWfP6N
         EaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HhzrvgmO5ba+fhVLJprYCXwSXtS8k1j17nCMUGFb81U=;
        b=DFF9XDF76g8+dKchR/dDDh/ATdRunTpCU5P7raWrXUC6gqE8gtt/Tn3pnxMsyPJvEL
         8ZY7vv3QAZPTsFLj8VVTj+xU9kfr4ZcsKze+EZFz1/E8rGcPdKwX3MmxFnG1+nbZqqHo
         4bfKbbyQ9PbpbTtKCVN1l3TXvBHUBQEOMmx5DWBSoc43bcq+4zZ5McTQZSxQ7Kf9yCOY
         QcNQScjIAQmnb0pALlXK/0xiR+d2IKNiC5tJ7zo27MkUWxuteDbxq58aUmI+2+3yPp7L
         J82CI75/3BsZYTPG2q/rOMk5byoLK/fdAybJIPu47i73i2M9PwLKs2LGHibUzhmEqCQQ
         iTSA==
X-Gm-Message-State: AOAM530PalC0CXW0HoFCPUAnSseLl/PGeVcSsloe5LzOJKfHNat4nha8
        ZvaLxhudYOBwtX7MeYMI476LOQ==
X-Google-Smtp-Source: ABdhPJxCL00zUhSPonQCgcwmei7UI+9F74JsQgGpuny40whLY3Our3dIXghXXgHjFq0syk73QoOyaA==
X-Received: by 2002:a5d:680e:: with SMTP id w14mr4575743wru.71.1628161410840;
        Thu, 05 Aug 2021 04:03:30 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id c12sm6168239wrm.29.2021.08.05.04.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 04:03:30 -0700 (PDT)
Date:   Thu, 5 Aug 2021 12:03:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Alistair Francis <alistair23@gmail.com>
Subject: Re: [PATCH v2 1/1] mfd: simple-mfd-i2c: Add support for registering
 devices via MFD cells
Message-ID: <YQvFgMcwv7J5x2L4@google.com>
References: <20210805085611.864188-1-lee.jones@linaro.org>
 <ce1b71f317bff2dbcbf558e989b76087@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce1b71f317bff2dbcbf558e989b76087@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2021, Michael Walle wrote:

> Am 2021-08-05 10:56, schrieb Lee Jones:
> > More devices are cropping up requiring only Regmap initialisation and
> > child registration functionality.  We currently only support that if
> > all required devices are represented by their own Device Tree nodes
> > complete with compatible strings.
> > 
> > However, not everyone is happy with adding empty nodes that provide no
> > additional device information into the Device Tree.
> > 
> > Rather than have a plethora of mostly empty, function-less drivers in
> > MFD, we'll support those simple cases in here instead via MFD cells.
> > 
> > Cc: Michael Walle <michael@walle.cc>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Alistair Francis <alistair23@gmail.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Tested-by: Michael Walle <michael@walle.cc>

Good man.  Thank you Michael.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
