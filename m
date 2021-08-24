Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5843F60DA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbhHXOpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238004AbhHXOpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:45:32 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204C6C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:44:48 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so38182145otg.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AeRXMAsFKFtCmgO4aNf9vhF215sQMxa0Gch/8WOqfAM=;
        b=eyWlUTkwhOd0cFWHm8X30LzO/K/KeLiPSU/BsB3sXTZChAtoqXj8FbzYThh5W19/Qe
         CiYT8dd6zlJzDEteo+RXCzGZ+CG43gaJ+qZH/dx2EbT7Rko+mRyP+/tPf1Q4MS2eov13
         vMM+NFJ2eIiOBugMLiAyb8DcfwP0XGdvCixVCF7ppjOngF3550ISqaeCRVkExUCiUYcT
         1yelGthl31bS/NXyAzjy0xaIWWvhcdwpXKuA9yf8YyEZDz4kXZM2jyjHvIpzw+GqwVGH
         lbxIk7z9Z0N/yA/s1qEAVJb3uQIfjFtjMlu2TcN2CyvRb5kScqnBxvk55F2owTs8A55B
         Uxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AeRXMAsFKFtCmgO4aNf9vhF215sQMxa0Gch/8WOqfAM=;
        b=PqH6IGLpLYzu0HE+RHzwPT0DePhriI7/eGUYaWm+0tf7ejWyoRP6FttrV85+g3J8Ia
         TUaqX1N7hIqb9CcsDo6sZm2qwS5NoQCDOi9VSqub5qEb9ubThho/7ZhSCeTvXk44Z3jQ
         yCuPtxgo1AOj+cJeQFn43beBMCGQxZyYIRCXPbZ23Jtax3sGOuVnU+swTdAaDwNynzQz
         XRcVPdRucP9s3gCBiMQZbMSRUsL4EUIQy8e32MIrVIbgyoHnYL3W+d2NEy+TpJknZvqK
         Uk5Ik8WwUqJlzfZ0YO6/VxNdVqAUPWRYCLb+Oty/qvZIi9jygZrXuniIhvdLoZhuAuNK
         XezQ==
X-Gm-Message-State: AOAM531OcfkKvBvDQlW7iVMNxB6JWBDlwVYrfDr2fUp0uZvLysYoXtja
        ZbBrb/8+yEiSEwMPUo8of/MxpQ==
X-Google-Smtp-Source: ABdhPJyjK+cseOpauaCEYkJSxmOEm7lMp3SVSrhTVW0tyOit41rfYetFtw7kZrCji3qezu8PJBGa7g==
X-Received: by 2002:a9d:5f07:: with SMTP id f7mr32002492oti.183.1629816287441;
        Tue, 24 Aug 2021 07:44:47 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m206sm4378456oif.23.2021.08.24.07.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 07:44:47 -0700 (PDT)
Date:   Tue, 24 Aug 2021 07:46:04 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        An?bal Lim?n <anibal.limon@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: db410c: Update firmware-name for wcnss
 and mpss
Message-ID: <YSUGLFx2QST9vgIU@ripper>
References: <20200108055735.660475-1-bjorn.andersson@linaro.org>
 <20210217223406.1422005-1-anibal.limon@linaro.org>
 <CAA8EJpqXyQCFGgTRk+dqxD6TdJycLeGx4EQ0OBov5_3hVogM1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJpqXyQCFGgTRk+dqxD6TdJycLeGx4EQ0OBov5_3hVogM1g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24 Aug 05:39 PDT 2021, Dmitry Baryshkov wrote:

> On Thu, 18 Feb 2021 at 01:38, An�bal Lim�n <anibal.limon@linaro.org> wrote:
> >
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> >
> > Enable the mpss remoteproc node and specify the firmware-name for this
> > and the wcnss remoteproc on the Dragonboard 410c.
> >
> > Link: https://lore.kernel.org/r/20200108055735.660475-1-bjorn.andersson@linaro.org
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > [rebased and moved to use pronto label]
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > Tested-by: An�bal Lim�n <anibal.limon@linaro.org>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

Thanks Dmitry, not sure why this hasn't been merged yet.

Taking a further look at this I noticed that we never pushed the
firmware to linux-firmware either, which I think was because we where
uncertain of the directory structure at the time - a discussion which
has been settled since.

> > ---
> >  arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > index 3c7f97539390..8f1ada75d3ed 100644
> > --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > @@ -301,6 +301,11 @@ &lpass {
> >         status = "okay";
> >  };
> >
> > +&mpss {
> > +       status = "okay";
> > +       firmware-name = "qcom/msm8916/mba.mbn", "qcom/msm8916/modem.mdt";

But if we're pushing things to linux-firmware, does anyone object
against following the existing style and squashing the mdt+bNN files
into .mbn (and thereby making this modem.mbn and below wcnss.mbn)?

Regards,
Bjorn

> > +};
> > +
> >  &pm8916_resin {
> >         status = "okay";
> >         linux,code = <KEY_VOLUMEDOWN>;
> > @@ -308,6 +313,7 @@ &pm8916_resin {
> >
> >  &pronto {
> >         status = "okay";
> > +       firmware-name = "qcom/msm8916/wcnss.mdt";
> >  };
> >
> >  &sdhc_1 {
> > --
> > 2.30.0
> >
> 
> 
> -- 
> With best wishes
> Dmitry
