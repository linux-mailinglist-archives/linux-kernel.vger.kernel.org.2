Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F27357209
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242116AbhDGQSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbhDGQSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:18:51 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED387C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 09:18:38 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso1591292pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1LcGMBgZH+8RdDIvf6DPACgtlrb3AgGczSw0YtcJ21g=;
        b=mvte4mGAyCL+6ff4Iot6AWiyVgPAJ9kDwqtuAStOV7ejnrU77CQnbR0eBHTkFt28Cr
         L+PLJcgz7S5/m/O6U2rvCnvJ+tCTeqii5mG3pBv5eeUdjN0i4cOFcTGlcyKx5el+JeO+
         tt5PaMGKpGYe0Vm5qaGNd8/MiR4kR2AJ114w1/crqAvDip/b2U7OhxEWxnqNV8SoonZe
         DHch0MgxHp/c11LYKAy+wera5iTLYAdU1SFdAG+t/epyqiHG7+izI+wZKK0hJqE6fpwW
         hxQw7HmWika5xu0El1NjyJQg1oia0RX5ayuLDGteTZx+hgVCMHba9UG8t7WH3h+oHL7b
         sU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1LcGMBgZH+8RdDIvf6DPACgtlrb3AgGczSw0YtcJ21g=;
        b=ula4dRkKtJnyhW3VKEavtlP8aNjf+2jHNNUfX2cGP0/V9aO+qZEhIEu96KdkuBYGbB
         qQlHOS+AhZHG5iGua3aKgI8uw8mTf7l4b/dc7/1UsfH1H4Gvav+wXf1N0cuNqJuMXtSs
         VMyadLwEwo+IE/a3IkwobWI30d3lDknfDTNueLRDbOnYzozKhFeH4qfRI+QU9HzTbzTH
         SmYPfN/O+EzCu+IO44p9cW+JBz0ItyjX7dLh3LvBDpDbwtirRdeU002vobLwOD1ZZ5uq
         PrIpFHY7VZPXOj7g+SGYwzTPuP9RWU2UrFNMZjjazZcts6rTCAQX+CcQX+NQf1T+Gei3
         g1Wg==
X-Gm-Message-State: AOAM5332JWF+N+EgkN97mje6T5RCn9jYn04hC82Mfud/u+g+avqrCHtQ
        v5G9Pqnz1RN3df4R2Qcq4pCsEA==
X-Google-Smtp-Source: ABdhPJxks2eNl4omFJDVf4WuMF5fHnJUH9+73bwYL6UxY4qore1JMTAo5acovBACmIIERmlUU3Ah9g==
X-Received: by 2002:a17:90b:2250:: with SMTP id hk16mr4006499pjb.110.1617812318464;
        Wed, 07 Apr 2021 09:18:38 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id x7sm22693363pff.12.2021.04.07.09.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:18:37 -0700 (PDT)
Date:   Wed, 7 Apr 2021 10:18:36 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     peng.fan@oss.nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 0/8] remoteproc: imx_rproc: support i.MX7ULP/8MN/8MP
Message-ID: <20210407161836.GB418374@xps15>
References: <1617095574-6764-1-git-send-email-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617095574-6764-1-git-send-email-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 05:12:46PM +0800, peng.fan@oss.nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V2:
>  Patch 1/8, use fsl as vendor, typo fix
>  Because patchset [1] has v2 version, patch 5,6,7,8 are adapted that change.
> 
> This patchset is to support i.MX7ULP/8MN/8MP, also includes a patch to parse
> imx,auto-boot
> This patchset depends on [1]
> 
> [1] https://patchwork.kernel.org/project/linux-remoteproc/cover/1617082235-15923-1-git-send-email-peng.fan@oss.nxp.com/
> 
> Peng Fan (8):
>   dt-bindings: remoteproc: imx_rproc: add fsl,auto-boot property
>   dt-bindings: remoteproc: imx_rproc: add i.MX7ULP support
>   dt-bindings: remoteproc: imx_rproc: support i.MX8MN/P
>   remoteproc: imx_rproc: make clk optional
>   remoteproc: imx_rproc: parse fsl,auto-boot
>   remoteproc: imx_rproc: initial support for mutilple start/stop method
>   remoteproc: imx_rproc: support i.MX7ULP
>   remoteproc: imx_rproc: support i.MX8MN/P
>

There are glaring checkpatch warning on this set - the "DT compatible string"
ones are fine but the others are not negotiable.  As such I am dropping this set
entirely.
 
>  .../bindings/remoteproc/fsl,imx-rproc.yaml    |  11 +-
>  drivers/remoteproc/imx_rproc.c                | 170 +++++++++++++++---
>  2 files changed, 159 insertions(+), 22 deletions(-)
> 
> -- 
> 2.30.0
> 
