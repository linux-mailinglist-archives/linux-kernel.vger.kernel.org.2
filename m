Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE2C41EF5E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 16:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354459AbhJAOXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 10:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbhJAOX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 10:23:29 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A960FC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 07:21:45 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so11708053otb.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 07:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RyljskWxEIj64E0/JKXsfCLMykqvOmjKdzQgJe75r2U=;
        b=yQsH27dcsAfYNORAm1R6gUODOKo31/SdiCD/fT+dVfWd+sVz8HZDJoZm5NQGe7i2gY
         7VEmSxQvd9JqFOs6Sn+Gt587qhhhHXJgHdsnpLDEbFzTzQwax/SmF0sU6pqbi2d3I7dS
         n9G1hzvK13Lv75ThsNaRlHLZre2/xOk7NZ5Lpo5LCwXo28H8jIcMbg403AN5MlIWY5L4
         Eo6QERZ8uyrjeBiBgTzKrP1frovpqd7Dr/33FhGzU9EYPh8vxoEIlmCHQSy731S6ljf4
         0fjJ4tWuuuuRBYwiHYg5MP6mP2vPNqlWeIc/vqCcXkBwh11vH+YUvWjDRzbZfIdtdLXN
         tZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RyljskWxEIj64E0/JKXsfCLMykqvOmjKdzQgJe75r2U=;
        b=Rtft5Ka7DSSCqIRVctu+4D4phWfh1cvtsrghMAdqS7HxsyoMdZqm1YYtK7YW0jXqlh
         iQakHxwIBjLFwK4CJW+F2hQqFdJcxohsyNAQvzRdbBivBD2exbMojYNsrLiFS8mYQ8sU
         qWexT1ADwtWIqNTNUIOtNLVRHIqmS5FJWkoKmDmTuf2VJQ2ie0rfuDe8yUGyhrmpDyHc
         Vq1nekoZtAkfxsaT6y6KknIWyTqV8GK2aTy862yG6cfOD8ROJ1RwSFGsOqzs7iZamJSU
         BTRLZFog93CchdqVRcYYeELHSQb80Sn6Pt6PriJB/T0JEmdlXcc+mYu/guBkCHjUupjp
         1yYw==
X-Gm-Message-State: AOAM532mV3mNNo9lbXb5CYgYzUv59dG+458HnrDjef4DeS1guMJ9fQ6D
        NfPYdnBIl+RaBPosmXXJJ7jZeA==
X-Google-Smtp-Source: ABdhPJx4IXNLQp5mpOgHA767G+AngUBs0pCRIIbB0v5aaUOGgR/hVSObk7E9KZiGC2CkqwZ9AfFg3A==
X-Received: by 2002:a9d:5f9b:: with SMTP id g27mr11101284oti.217.1633098104962;
        Fri, 01 Oct 2021 07:21:44 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id i24sm1176746oie.42.2021.10.01.07.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:21:44 -0700 (PDT)
Date:   Fri, 1 Oct 2021 07:23:32 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Lew <clew@codeaurora.org>,
        Deepak Kumar Singh <deesin@codeaurora.org>
Subject: Re: [PATCH v2 3/4] soc: qcom: smem: Support reserved-memory
 description
Message-ID: <YVcZ5FsM2u+3uoK4@ripper>
References: <20210930182111.57353-1-bjorn.andersson@linaro.org>
 <20210930182111.57353-4-bjorn.andersson@linaro.org>
 <9a4ef69d-df15-0fbc-3735-6d7c861855ac@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a4ef69d-df15-0fbc-3735-6d7c861855ac@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01 Oct 00:08 PDT 2021, Vladimir Zapolskiy wrote:
> On 9/30/21 9:21 PM, Bjorn Andersson wrote:
[..]
> > diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
[..]
> > @@ -895,12 +892,14 @@ static int qcom_smem_map_memory(struct qcom_smem *smem, struct device *dev,
> >   static int qcom_smem_probe(struct platform_device *pdev)
> >   {
> >   	struct smem_header *header;
> > +	struct reserved_mem *rmem;
> >   	struct qcom_smem *smem;
> >   	size_t array_size;
> >   	int num_regions;
> >   	int hwlock_id;
> >   	u32 version;
> >   	int ret;
> > +	int i;
> 
> Just a nitpicking, the index can be unsigned.
> 

It's compared against the "num_regions", which is also signed. So I
think it should be signed.

[..]
> > +	for (i = 0; i < num_regions; i++) {

Thanks for the review!

Regards,
Bjorn
