Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98ADC451BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354513AbhKPAId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:08:33 -0500
Received: from relay07.th.seeweb.it ([5.144.164.168]:55071 "EHLO
        relay07.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348043AbhKOTuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:50:16 -0500
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id D97583EEFB;
        Mon, 15 Nov 2021 20:46:53 +0100 (CET)
Date:   Mon, 15 Nov 2021 20:46:52 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [RESEND PATCH v2 04/13] backlight: qcom-wled: Fix off-by-one
 maximum with default num_strings
Message-ID: <20211115194652.c4g2mg4budf4lkct@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Kiran Gunda <kgunda@codeaurora.org>, Bryan Wu <cooloney@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org,
        Courtney Cavin <courtney.cavin@sonymobile.com>
References: <20211112002706.453289-1-marijn.suijten@somainline.org>
 <20211112002706.453289-5-marijn.suijten@somainline.org>
 <20211112120839.i6g747vewg6bkyk7@maple.lan>
 <20211112123501.pz5e6g7gavlinung@SoMainline.org>
 <20211112214337.r5xrpeyjgdygzc3n@SoMainline.org>
 <20211115112327.tklic3fggrv5mzjt@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115112327.tklic3fggrv5mzjt@maple.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-15 11:23:27, Daniel Thompson wrote:
> On Fri, Nov 12, 2021 at 10:43:37PM +0100, Marijn Suijten wrote:
> > On 2021-11-12 13:35:03, Marijn Suijten wrote:
> > > On 2021-11-12 12:08:39, Daniel Thompson wrote:
> > > > On Fri, Nov 12, 2021 at 01:26:57AM +0100, Marijn Suijten wrote:
> > > > > When not specifying num-strings in the DT the default is used, but +1 is
> > > > > added to it which turns WLED3 into 4 and WLED4/5 into 5 strings instead
> > > > > of 3 and 4 respectively, causing out-of-bounds reads and register
> > > > > read/writes.  This +1 exists for a deficiency in the DT parsing code,
> > > > > and is simply omitted entirely - solving this oob issue - by parsing the
> > > > > property separately much like qcom,enabled-strings.
> > > > > 
> > > > > This also allows more stringent checks on the maximum value when
> > > > > qcom,enabled-strings is provided in the DT.  Note that num-strings is
> > > > > parsed after enabled-strings to give it final sign-off over the length,
> > > > > which DT currently utilizes to get around an incorrect fixed read of
> > > > > four elements from that array (has been addressed in a prior patch).
> > > > > 
> > > > > Fixes: 93c64f1ea1e8 ("leds: add Qualcomm PM8941 WLED driver")
> > > > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > > > Reviewed-By: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > > > > ---
> > > > >  drivers/video/backlight/qcom-wled.c | 51 +++++++++++------------------
> > > > >  1 file changed, 19 insertions(+), 32 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> > > > > index 977cd75827d7..c5232478a343 100644
> > > > > --- a/drivers/video/backlight/qcom-wled.c
> > > > > +++ b/drivers/video/backlight/qcom-wled.c
> > > > > @@ -1552,6 +1520,25 @@ static int wled_configure(struct wled *wled)
> > > > >  		}
> > > > >  	}
> > > > > 
> > > > > +	rc = of_property_read_u32(dev->of_node, "qcom,num-strings", &val);
> > > > > +	if (!rc) {
> > > > > +		if (val < 1 || val > wled->max_string_count) {
> > > > > +			dev_err(dev, "qcom,num-strings must be between 1 and %d\n",
> > > > > +				wled->max_string_count);
> > > > > +			return -EINVAL;
> > > > > +		}
> > > > > +
> > > > > +		if (string_len > 0) {
> > > > > +			dev_warn(dev, "qcom,num-strings and qcom,enabled-strings are ambiguous\n");
> > > > 
> > > > The warning should also be below the error message on the next if statement.
> > > 
> > > Agreed.
> > 
> > Thinking about this again while reworking the patches, I initially put
> > this above the error to make DT writers aware.  There's no point telling
> > them that their values are out of sync (num-strings >
> > len(enabled-strings)), when they "shouldn't even" (don't need to) set
> > both in the first place.  They might needlessly fix the discrepancy, see
> > the driver finally probe (working backlight) and carry on without
> > noticing this warning that now appears.
> > 
> > Sorry for bringing this back up, but I'm curious about your opinion.
> 
> With a more helpful warning about how to fix then I think it is OK to
> have both the warning and the error.

Thanks - I presume the message we settled upon last time is helpful
enough:

    Only one of qcom,num-strings or qcom,enabled-strings should be set

I'll respin this, together with this warning reordered into the next
commit, and using __le16 for the cpu_to_le16 output.

- Marijn
