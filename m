Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A45430B7BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 07:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhBBGRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 01:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbhBBGRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 01:17:09 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58D6C0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 22:16:28 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id e9so11877338plh.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 22:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1NqKt1tkYjXYw5uT6W0gag7j6UD0Pw2ioTo6s17oNpE=;
        b=LIQE6iXhoVslxswTP0KgBiXobDim0ju5ZYkrmyKvYra9JaoER+znAmc9qT9xTPVIt9
         jtJp4IGHblx4gB7wk3KL0g+Hb00CnXsMXEYUJcWHtjBB8foOwO+AUaKNeRXK9ZgkhRKx
         unkdwcCqhuoaaet8S05RadBgyTo9LLCg4RKzfWTfjpFw0H97MwDGbtL4K8TPiIrR+CLV
         DwRwQ/IGJ8gY6RwwC4QvP+2Eo9r3HN+B83VS/PZdcxWUj5ka7LREzljL9mQeerH3xM4Z
         9xY7VqEODF93PjT/9QkROmbj3BKowCGvzX+TVEKvk4DRJaXjYZyncefY2/3uwm/Blrhc
         kU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1NqKt1tkYjXYw5uT6W0gag7j6UD0Pw2ioTo6s17oNpE=;
        b=o5/0g1PUibiGEz6v8tZwoUEBb/YRcDtd13IeUUj0K6kY6ENB0MN/jwNZUmglXax23J
         VpfKYozK5ZHCyEMGckQk0GhCn3Q7CFE/0danzyvAa4jVpJN4ZUljyDQDwt3JCqgZHZDe
         2lxg+74HT/03VYFVcQqE4epXzxtU261paCZ3CjcXmLaCaLtc7yM9edEVIagxFkB5mQNN
         zer2KoG9mK/xF6ypT4gTTSpt4BuWvBVdT5gkjOXLkjRpZKEYElOVFJ6BLEZavaANCrpv
         U58l874r0INLqUzC+M/TwpJq7ow34E9ZESWil9wgfPaDYTmS4TtdIzp/ecMWrKk7HjK4
         tVlQ==
X-Gm-Message-State: AOAM533PaPslbXBzbbdZNMAUgjbCi52Eh9opGvy3Vm9AtNqaqPYrCmDZ
        VL4y2i0wLq+ojpvHF2PG5xWl
X-Google-Smtp-Source: ABdhPJx0A/UAcWiA3V+ISiM2k6qA5tPlnvHP9HVWN/SYdIrEkyV65T+v0hqfxGwDjC/6oH+Cyvts7w==
X-Received: by 2002:a17:903:1cc:b029:de:98bb:d46d with SMTP id e12-20020a17090301ccb02900de98bbd46dmr21069426plh.54.1612246588193;
        Mon, 01 Feb 2021 22:16:28 -0800 (PST)
Received: from thinkpad ([2409:4072:6d83:1efe:9823:4cab:2941:306])
        by smtp.gmail.com with ESMTPSA id l2sm1447547pju.25.2021.02.01.22.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 22:16:27 -0800 (PST)
Date:   Tue, 2 Feb 2021 11:46:19 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: Add Bluetooth support on RB5
Message-ID: <20210202061619.GA13607@thinkpad>
References: <20210128175225.3102958-1-dmitry.baryshkov@linaro.org>
 <20210128175225.3102958-6-dmitry.baryshkov@linaro.org>
 <CAL_Jsq+nNRv3KceHthgktHR1oRMs+eKWC4O7n0k78izs1aTPfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+nNRv3KceHthgktHR1oRMs+eKWC4O7n0k78izs1aTPfA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 01:15:22PM -0600, Rob Herring wrote:
> On Thu, Jan 28, 2021 at 11:52 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
> > Add Bluetooth support on RB5 using the onboard QCA6391 WLAN+BT chipset.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > [DB: added qca6391 power domain, removed s2f regulator]
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 29 ++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > index b39a9729395f..c65c13994a86 100644
> > --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > @@ -19,6 +19,7 @@ / {
> >         compatible = "qcom,qrb5165-rb5", "qcom,sm8250";
> >
> >         aliases {
> > +               hsuart0 = &uart6;
> 
> Serial devices should be 'serialN'. Don't add custom aliases.
> 

Sorry, this is needed by the serial driver:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/qcom_geni_serial.c#n1364

Thanks,
Mani

> >                 serial0 = &uart12;
> >                 sdhc2 = &sdhc_2;
> 
> BTW, this should be dropped too.
> 
> >         };
> > @@ -689,6 +690,26 @@ &pm8150_rtc {
> >         status = "okay";
> >  };
> >
> > +&qup_uart6_default {
> > +       ctsrx {
> > +               pins = "gpio16", "gpio19";
> > +               drive-strength = <2>;
> > +               bias-disable;
> > +       };
> > +
> > +       rts {
> > +               pins = "gpio17";
> > +               drive-strength = <2>;
> > +               bias-disable;
> > +       };
> > +
> > +       tx {
> > +               pins = "gpio18";
> > +               drive-strength = <2>;
> > +               bias-pull-up;
> > +       };
> > +};
> > +
> >  &qupv3_id_0 {
> >         status = "okay";
> >  };
> > @@ -1194,6 +1215,14 @@ wlan-en {
> >         };
> >  };
> >
> > +&uart6 {
> > +       status = "okay";
> > +       bluetooth {
> > +               compatible = "qcom,qca6390-bt";
> > +               power-domains = <&qca6391>;
> > +       };
> > +};
> > +
> >  &uart12 {
> >         status = "okay";
> >  };
> > --
> > 2.29.2
> >
