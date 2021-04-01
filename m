Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A11351C40
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbhDASPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbhDAR4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:56:42 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6333AC031172;
        Thu,  1 Apr 2021 10:00:27 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso2685608oti.11;
        Thu, 01 Apr 2021 10:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qrwXsuHqxeca6djxeZsefOCVnSzkGGzt5ErigLswIqs=;
        b=iDF7jqiaFMeHuQaKARu9stZPSM13OGjexjTnLQuDeTRxizkCrLNQGpGE5AFCdcZVUc
         dAfG5o0o+R5UfaQDZGTD+pjwDYS07bQsjQleeMIUYTA19jsHtFAD8pXT5xIRmh0yLcrW
         GzBtnWn69QQx076tlEZWnAKNBXfJu8pSmkDolGuO1OaYhqupcJk/AQ2kd5Otmgrb1lxa
         u6qKOAOgLt0MtWq4AmVbmeFagwf/ippvhF0mpB2aCblcKA8An2jLHD/JvY9pWBI5TGX+
         l3IFSrlOZhySm1dP6BLiwzmFJdGEslVwz687zrcaz/DeL6id3k06oyAlNtWv0sBZ8oN+
         Rlwg==
X-Gm-Message-State: AOAM531paiKoMrkBWhl4cl1ppCC5O1xlNT/KcAZZtNF9/CxRBYkgFuH1
        nloMIKvtCcKjm8cqjeAdjA==
X-Google-Smtp-Source: ABdhPJzH4ytmFQ978P4N4lw84SIT1Gw4I6uSES4ev+O/Jfcklt34kk4k4T/vhX7Py5mfhNguQjie0Q==
X-Received: by 2002:a05:6830:15cb:: with SMTP id j11mr7560825otr.126.1617296425226;
        Thu, 01 Apr 2021 10:00:25 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h20sm1153284oor.8.2021.04.01.10.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 10:00:24 -0700 (PDT)
Received: (nullmailer pid 609353 invoked by uid 1000);
        Thu, 01 Apr 2021 17:00:22 -0000
Date:   Thu, 1 Apr 2021 12:00:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     peng.fan@oss.nxp.com
Cc:     shawnguo@kernel.org, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        o.rempel@pengutronix.de, robh+dt@kernel.org, kernel@pengutronix.de,
        mathieu.poirier@linaro.org, Peng Fan <peng.fan@nxp.com>,
        ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, bjorn.andersson@linaro.org,
        s.hauer@pengutronix.de
Subject: Re: [PATCH V2 1/8] dt-bindings: remoteproc: imx_rproc: add fsl,
 auto-boot property
Message-ID: <20210401170022.GA609295@robh.at.kernel.org>
References: <1617095574-6764-1-git-send-email-peng.fan@oss.nxp.com>
 <1617095574-6764-2-git-send-email-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617095574-6764-2-git-send-email-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 17:12:47 +0800, peng.fan@oss.nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add an optional property "fsl,auto-boot" to indicate remote processor
> auto boot.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml       | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
