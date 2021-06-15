Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59C53A7DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFOMFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhFOMFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:05:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F87C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:03:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c5so18012681wrq.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wyIIvKZl5BU0mdJybfMDo3xuQw5ZjyZpAFg5HLA2+90=;
        b=d+lI8zvaqA8qGqsKGY1MeonI6Jr9dGvTxWiMBaewwYhEhrEz1qQF/ZZFZwOeXq+uK2
         +asDyzp7NJhXGspp1CeQOpNEsPISsS9k2VoNXZdc8YPIWffcls2msiAdL8sgi9qYVcYl
         sfq1z7sTUF9yoglPl3Lm/B8n7cB63giwUCWLsMeMsM4qjqSxLTVUM7sAiVHFHl0VJWRo
         2GhcoODInJ1bwdw3ha+OANdcEHtHr6iA9ejDvfepscqsm6c61tj/CMDbFSlujVOsDTbc
         42ZSo8jletyqIwkXQ/gtKHgJSST48FKOtFmNpNm1Hx5+RBbc5u3PlkP2y0KjKcgLushy
         HqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wyIIvKZl5BU0mdJybfMDo3xuQw5ZjyZpAFg5HLA2+90=;
        b=q08pv8DTE4dMgAAnm2WRDURFkbc6gCDXHIv1gCSSmqU5W7zWAfZ98I7dFXIK7JfXch
         Y2O+5g6ra3HJAQLrbxnO4+ZZQSCX5qNloP/Ealv1KQ85CqntZvmI+6j5DyC661hGWwwb
         LAxqoBLGJ9hvz61QjBIcdkCUmPfN5FThWFEHsd0JfG9J1d42I85/2XoDkkq1Py+mZafv
         Or/tBRe+QPD9bDP3bE0ab9RFdc+Qao9PTSXEOjO/EcPmPurm3zzgh7CYva9aRoHN2ZAf
         Ki3QuoqNinnVLEa847A4vrYPJDNGnGhchY3FAWdS/lOpMmOYjCR7aK+KtX7qQbfB3OQ2
         Sx/Q==
X-Gm-Message-State: AOAM531Td0/12kXM+dwG9WcWCKu/ub4fOkCA9Oxs6DX9NwtTmW+oZ0I5
        JGmf+jJstLO85DXrYc4d3EQpyg==
X-Google-Smtp-Source: ABdhPJxPeyIUmKPLSggSjsvfaGfsexGfhawi/3oVaSLwlBl8ZoXDObYvEk6VoiUjddiThO2WdTKl9Q==
X-Received: by 2002:adf:de91:: with SMTP id w17mr25188729wrl.352.1623758616242;
        Tue, 15 Jun 2021 05:03:36 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id h15sm18670554wrq.88.2021.06.15.05.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 05:03:35 -0700 (PDT)
Date:   Tue, 15 Jun 2021 13:03:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     patches <patches@opensource.cirrus.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/9] mfd: pcf50633: use DEVICE_ATTR_ADMIN_RO macro
Message-ID: <YMiXFVk7gSTbPJvE@dell>
References: <20210602114339.11223-1-thunder.leizhen@huawei.com>
 <20210602114339.11223-6-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602114339.11223-6-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2021, Zhen Lei wrote:

> Use DEVICE_ATTR_ADMIN_RO macro helper instead of plain DEVICE_ATTR, which
> makes the code a bit shorter and easier to read.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/mfd/pcf50633-core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
