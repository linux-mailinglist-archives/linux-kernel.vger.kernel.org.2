Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666F63161CC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhBJJFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhBJI7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:59:10 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1804C061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:58:29 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id d2so762895pjs.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=14cbO29LuktGiYaDXOwJMmB+J2xlnJQtq+WESBAPEX8=;
        b=aLrLlunIXBW4l/SEpI0298+gRoeV8AZtghYW1QkIuJ/V+OG24lrpSEdjVi5qZudQz5
         gjpLHfTyC4a/j6yMuIOPU0TGDotDs2vX/7glIKdahctRamp9fhH3D0vBOWwifzoseHkb
         5nhG/KA79EYz1U/3eaOuEnUCZkaiQJubBkisI11f2IoTpiK1o/jlKOfr0pcZVap6kr2f
         /ub3LS9W+YD9xApR+1fIzbcxP65k0vd31KQLASWvtFdjDwxBu0nwpCBTx6aKuHfKHDJS
         KzrydVZWCite0l/IgeG6yVmI6RJrVawWnCXiqAGfHcUAKPx374iSzPjWJTMcsaYQoeZd
         XPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=14cbO29LuktGiYaDXOwJMmB+J2xlnJQtq+WESBAPEX8=;
        b=pywl8EZvWsMAfJHl0iR/hXDmy4tUkhYJAs8tt/aAuUHHo1C8c37S4DR9ZsZIbKd7a/
         AHFflQBcy6V9li8f8N/JT4z/wk+jVoMBsNO4xQOSNjjWAlk6vCS7lGgINYvRhLuBQ/v9
         ywOYalfvZHdWQ6jQyLCTB+2Mw8w3VLzaEXMv0LgrsipH1gAJEga4xPmWwIOegaubWNCj
         N6GK8vVoeIxEzQr6+aCNsF3YpBnBAbemh0Iun013+Ql8g8GAQQq9c8Vo5McHfDLTYFxI
         2jdef4eratOolEnaUoQ35j4d8HAOwoZtVn0M28Jf+8MzGahBsHE7BDUfqqQ4UQOk74Bo
         oEaA==
X-Gm-Message-State: AOAM533RHi80RU0QvPEivtKUmmGR1pBEgNi7x/AqgJd1N/HY+rsGi6AC
        nCkJ9to49eA2LfscVm/qbCPlMVYLbg9b
X-Google-Smtp-Source: ABdhPJyZPCjK0q7RrLm0H6OU6gbb8dvQSi/mrS4BL38zEe9km08JQh8tcG6lMD1xsBNfqDppLjDbMQ==
X-Received: by 2002:a17:902:9b90:b029:e0:6c0:df4f with SMTP id y16-20020a1709029b90b02900e006c0df4fmr2075706plp.60.1612947509380;
        Wed, 10 Feb 2021 00:58:29 -0800 (PST)
Received: from work ([103.66.79.29])
        by smtp.gmail.com with ESMTPSA id k13sm1420146pfg.146.2021.02.10.00.58.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Feb 2021 00:58:28 -0800 (PST)
Date:   Wed, 10 Feb 2021 14:28:24 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: Update register macro name for 0x2c
 offset
Message-ID: <20210210085824.GD19226@work>
References: <1612037236-7954-1-git-send-email-mdalam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612037236-7954-1-git-send-email-mdalam@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 01:37:16AM +0530, Md Sadre Alam wrote:
> This change will remove unused register name macro NAND_DEV1_ECC_CFG.
> Since this register was only available in QPIC version 1.4.20 ipq40xx
> and it was not used. In QPIC version 1.5 on wards this register got
> removed.In QPIC version 2.0 0x2c offset is updated with register
> NAND_AUTO_STATUS_EN So adding this register macro NAND_AUTO_STATUS_EN
> with offset 0x2c.
> 
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 9484be8..c238a35 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -27,7 +27,7 @@
>  #define	NAND_DEV0_CFG0			0x20
>  #define	NAND_DEV0_CFG1			0x24
>  #define	NAND_DEV0_ECC_CFG		0x28
> -#define	NAND_DEV1_ECC_CFG		0x2c
> +#define	NAND_AUTO_STATUS_EN		0x2c
>  #define	NAND_DEV1_CFG0			0x30
>  #define	NAND_DEV1_CFG1			0x34
>  #define	NAND_READ_ID			0x40
> -- 
> 2.7.4
> 
