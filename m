Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D003220E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 21:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhBVUjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 15:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhBVUja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 15:39:30 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40FEC061786
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 12:38:49 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o6so349319pjf.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 12:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e8a3846E0ppuChgajqq6GqK732eDl4suadOZfr+AkLI=;
        b=R9w1xbhC8wrsZPkjcO7Vlel821Nrbv0TvVKR89+MVfxvhAcrLKt1pXrOCwfFPnMCry
         HMQ7s6XAfVIr+gQTdW7ltsPSPYwq31UwrPo0fm+B39wBYF85128dgNwN/ogPwKByK7la
         mEsrHMLqtMO0gSVaVtvaUPXl3CwYomPZMY+80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e8a3846E0ppuChgajqq6GqK732eDl4suadOZfr+AkLI=;
        b=okBCurTf/q0Z/zOB/4bUIaBX/HCOQzbQcgd2qe3nsaDfP6VWRIPTbzAeZV8ur3s1J0
         57OTn7Fk1dkWiYz+fLTEKLulQuxhCcd2bPEdR8hfFbSYnrbTnYtL3TKrt76y+SSEmYqC
         /NAgQY3GiLbu5sJaX6yuNaI8l0eRFj4PQPADMkoUdVrSMdkTeSlepqxMKj+967D2FDq1
         0NGAlBqPeQR24aT8AJvD8JvFNqtO4yKjOOgsrhmMYdYOKjBaw1gqvGPLYpGvWwI3qtih
         z7GBbqlFs5Czj1beuqp2d+LiYKwPmc7d4iXMEYBU4vjR8nbYphThHNckWtRRa4so1YKJ
         aeqA==
X-Gm-Message-State: AOAM530pmfaIujH6nqg1lZ7fsCwaZ2aJhQ5TgYJ20DUAxw32eB2dyG5p
        q4Goh9izA76yK87eOJnNty44XQ==
X-Google-Smtp-Source: ABdhPJzg6FKl4PkbRsxo9JP0RP7/FGLMIgBAhAArf8HqDPhtXWEyF43sZvLHlYO0QSTFKIBbqlYi2Q==
X-Received: by 2002:a17:902:7447:b029:e3:dbc0:bc5b with SMTP id e7-20020a1709027447b02900e3dbc0bc5bmr12084436plt.48.1614026328982;
        Mon, 22 Feb 2021 12:38:48 -0800 (PST)
Received: from localhost ([2620:15c:202:1:61bd:1a6e:a387:22f0])
        by smtp.gmail.com with UTF8SMTPSA id d26sm3534257pfq.175.2021.02.22.12.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 12:38:47 -0800 (PST)
Date:   Mon, 22 Feb 2021 12:38:46 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc7180: Delete charger thermal
 zone and ADC channel for lazor <= rev3
Message-ID: <YDQWVresOGZGLL6N@google.com>
References: <20210219181032.1.I23e12818c4a841ba9c37c60b3ba8cfeeb048285f@changeid>
 <20210219181032.3.Ia4c1022191d09fe8c56a16486b77796b83ffcae4@changeid>
 <161402520418.1254594.7435679604383921403@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <161402520418.1254594.7435679604383921403@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 12:20:04PM -0800, Stephen Boyd wrote:
> Quoting Matthias Kaehlcke (2021-02-19 18:10:59)
> > Lazor rev3 and older are stuffed with a 47k NTC as thermistor for
> > the charger temperature which currently isn't supported by the
> > PM6150 ADC driver. Delete the charger thermal zone and ADC channel
> > to avoid the use of bogus temperature values.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > 
> >  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts | 9 +++++++++
> >  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts | 9 +++++++++
> >  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dts | 9 +++++++++
> >  3 files changed, 27 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
> > index 30e3e769d2b4..0974dbd424e1 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
> > @@ -14,6 +14,15 @@ / {
> >         compatible = "google,lazor-rev0", "qcom,sc7180";
> >  };
> >  
> > +/*
> > + * rev <= 3 are stuffed with a 47k NTC as charger thermistor which is currently
> > + * not supported by the PM6150 ADC driver. Delete the thermal zone and ADC
> > + * channel to avoid the use of bogus temperature values.
> > + */
> > +/delete-node/ &charger_thermal;
> > +/delete-node/ &pm6150_adc_charger_thm;
> > +/delete-node/ &pm6150_adc_tm_charger_thm;
> 
> Can we disable pm6150_adc_tm instead on <= rev3 boards? It would be the
> same number of lines, but is simpler to reason about disabled nodes vs.
> deleted nodes usually.

For Lazor theoretically this could be done since it doesn't use other ADC
channels, however it won't work for other trogdor devices that will be
upstreamed eventually. Some of these boards have the same problem, however
they have other thermistors connected to the ADC. One could argue that it's
preferable to do things in a uniform way, but I'm open to do it either way
for Lazor.

