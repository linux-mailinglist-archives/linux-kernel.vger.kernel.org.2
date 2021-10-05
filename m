Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8963422F49
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 19:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbhJERgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 13:36:07 -0400
Received: from relay05.th.seeweb.it ([5.144.164.166]:35721 "EHLO
        relay05.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbhJERf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 13:35:58 -0400
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id A557E3EBAC;
        Tue,  5 Oct 2021 19:34:01 +0200 (CEST)
Date:   Tue, 5 Oct 2021 19:34:00 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] backlight: qcom-wled: Fix off-by-one maximum with
 default num_strings
Message-ID: <20211005173400.lyu3gabbalv2l3uq@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211004192741.621870-1-marijn.suijten@somainline.org>
 <20211004192741.621870-6-marijn.suijten@somainline.org>
 <20211005091947.7msztp5l554c7cy4@maple.lan>
 <20211005100606.faxra73mzkvjd4f6@SoMainline.org>
 <20211005103843.heufyonycnudxnzd@maple.lan>
 <20211005105312.kqiyzoqtzzjxayhg@maple.lan>
 <20211005114435.phyq2jsbdyroa6kn@SoMainline.org>
 <20211005140349.kefi26yev3gy3zhv@maple.lan>
 <20211005152326.5k5cb53ajqnactrg@SoMainline.org>
 <20211005162453.ozckxhm47jcarsza@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005162453.ozckxhm47jcarsza@maple.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-05 17:24:53, Daniel Thompson wrote:
> On Tue, Oct 05, 2021 at 05:23:26PM +0200, Marijn Suijten wrote:
> > On 2021-10-05 15:03:49, Daniel Thompson wrote:
> > [..]
> > > > At that point one might ask why qcom,num_strings remains at all when
> > > > DT can use qcom,enabled_strings instead.  We will supposedly have to
> > > > keep backwards compatibility with DTs in mind so none of this can be
> > > > removed or made mutually exclusive from a driver standpoint, that all
> > > > has to be done in dt-bindings yaml to be enforced on checked-in DTs.
> > > 
> > > So... perhaps I made a make offering a Reviewed-by: to a patch
> > > that allows len(enabled-strings) to have precedence. If anything
> > > currently uses enabled-strings then it *will* be 4 cells long and
> > > is relying on num-strings to ensure the right things happens ;-) .
> > 
> > Unfortunately Konrad (one of my team members) landed such a patch at the
> > beginning of this year because I failed to submit this patchset in time
> > while it has been sitting in my queue since 2019 after being used in a
> > downstream project.  This is in pmi8994 which doesn't have anything
> > widely used / production ready yet, so I'd prefer to fix the DT instead
> > and remove / fix his comment:
> > 
> >     /* Yes, all four strings *have to* be defined or things won't work. */
> > 
> > But this is mostly because, prior to this patchset, no default was set
> > for WLED4 so the 0'th string would get enabled num-strings (3 in
> > pmi8994's case) times.
> > 
> > Aside that there's only one more PMIC (also being worked on by
> > SoMainline) that sets qcom,enabled-strings: this is pm660l, pulled from
> > our local tree, and it actually has enabled-strings of length 2 which is
> > broken in its current form, exactly because of relying on this patchset.
> > 
> > Finally, we already discussed this inside SoMainline and the
> > number/enabled leds should most likely be moved out of the PMIC dtsi's
> > as they're probably panel, hence board or even device dependent.
> > 
> > > We'd like that case to keep working so we must allow num-strings to have
> > > precedence. In other words, when you add the new code, please put it at
> > > the end of the function!
> > 
> > Since there don't seem to be any substantial platforms/PMICs using this
> > functionality in a working manner, can I talk you into agreeing with
> > fixing the DT instead?
> 
> I've no objections to seeing the DT updated. However I don't really see
> what benefit we get from breaking existing DTs in order to do so.
> 
> "Cleaning up annoying legacy" is seldom a good reason to break existing
> DTs since, if we could break DTs whenever we choose, there would never
> be any annoying legacy to worry about. When conflicting properties
> result in uninterpretable DTs then a break may be justified but that is
> not the case here.

As mentioned in my message and repeated by Konrad, the only "existing
DT" that could possibly be broken is a platform that's brought up by us
(SoMainline) and we're more than happy to improve the driver and leave
legacy DT behind us, unless there's more DT in circulation that hasn't
landed in Linux mainline but should be taken into account?

Anyway the plan is to leave qcom,num-strings in place so that the
default enabled_strings list in this driver actually serves a purpose.
Then, if num-strings and enabled-strings is provided the former has
precedence (assuming it doesn't exceed the size of the latter) but we'll
print a warning about this (now unnecessary) ambiguity, and if possible
at all - haven't found an example yet - make the properties mutually
exclusive in dt-bindings.

Disallowing both cases would only simplify the code in the end but we
can spend a few lines to support the desired legacy.

- Marijn
