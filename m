Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A759E3B66B3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 18:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbhF1Q1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 12:27:46 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59984 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhF1Q1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:27:41 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B70B0B8A;
        Mon, 28 Jun 2021 18:25:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1624897513;
        bh=PTVouAjir6usC63yLGX1KM3ZF+0S4PlEQNTD7pbjgjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wN6Asf9EI2bthREFOQyceNmJ2tgepCv9DalpxhQD+eY5r8eeEareeXyaEx7lyZweQ
         5xRo3GH7/hpnoHyulgJFbTpOgGqOUEWpJRWbfWQLx0NH1ON/wzTSPPSIySVrEeGP/e
         P82BV1y03TGcjfAqsDhcR3YNQZichEUqoxvMI/QY=
Date:   Mon, 28 Jun 2021 19:25:12 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rajeev Nandan <rajeevny@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@gmail.com>, Lyude Paul <lyude@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rob Herring <robh@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>
Subject: Re: [v8 4/6] drm/panel-simple: Update validation warnings for eDP
 panel description
Message-ID: <YNn36Bnc3MkhMC7L@pendragon.ideasonboard.com>
References: <1624726268-14869-1-git-send-email-rajeevny@codeaurora.org>
 <1624726268-14869-5-git-send-email-rajeevny@codeaurora.org>
 <YNjA+jg9Khn+a9K+@pendragon.ideasonboard.com>
 <d75afefac48229657d36e12b6bac0e9f@codeaurora.org>
 <YNnPqYjaZjmmrQTA@pendragon.ideasonboard.com>
 <CAD=FV=WTuexwn8gWR8-VV_-5Frb-NCNHA7m0xhxdsc_riRUC8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=WTuexwn8gWR8-VV_-5Frb-NCNHA7m0xhxdsc_riRUC8g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Mon, Jun 28, 2021 at 08:34:04AM -0700, Doug Anderson wrote:
> On Mon, Jun 28, 2021 at 6:33 AM Laurent Pinchart wrote:
> > On Mon, Jun 28, 2021 at 05:46:24PM +0530, rajeevny@codeaurora.org wrote:
> > > On 27-06-2021 23:48, Laurent Pinchart wrote:
> > > > On Sat, Jun 26, 2021 at 10:21:06PM +0530, Rajeev Nandan wrote:
> > > >> Do not give a warning for the eDP panels if the "bus_format" is
> > > >> not specified, since most eDP panels can support more than one
> > > >> bus formats and this can be auto-detected.
> > > >> Also, update the check to include bpc=10 for the eDP panel.
> > > >>
> > > >> Signed-off-by: Rajeev Nandan <rajeevny@codeaurora.org>
> > > >> ---
> > > >>
> > > >> Changes in v8:
> > > >> - New patch, to address the review comments of Sam Ravnborg [1]
> > > >>
> > > >> [1]
> > > >> https://lore.kernel.org/dri-devel/20210621184157.GB918146@ravnborg.org/
> > > >>
> > > >>  drivers/gpu/drm/panel/panel-simple.c | 6 ++----
> > > >>  1 file changed, 2 insertions(+), 4 deletions(-)
> > > >>
> > > >> diff --git a/drivers/gpu/drm/panel/panel-simple.c
> > > >> b/drivers/gpu/drm/panel/panel-simple.c
> > > >> index 86e5a45..f966b562 100644
> > > >> --- a/drivers/gpu/drm/panel/panel-simple.c
> > > >> +++ b/drivers/gpu/drm/panel/panel-simple.c
> > > >> @@ -772,10 +772,8 @@ static int panel_simple_probe(struct device *dev,
> > > >> const struct panel_desc *desc,
> > > >>                    desc->bpc != 8);
> > > >>            break;
> > > >>    case DRM_MODE_CONNECTOR_eDP:
> > > >> -          if (desc->bus_format == 0)
> > > >> -                  dev_warn(dev, "Specify missing bus_format\n");
> > > >> -          if (desc->bpc != 6 && desc->bpc != 8)
> > > >> -                  dev_warn(dev, "Expected bpc in {6,8} but got: %u\n", desc->bpc);
> > > >> +          if (desc->bpc != 6 && desc->bpc != 8 && desc->bpc != 10)
> > > >> +                  dev_warn(dev, "Expected bpc in {6,8,10} but got: %u\n", desc->bpc);
> > > >
> > > > You'll still get a warning is bpc == 0, is that intentional ?
> > >
> > > This was not intentional, I missed considering bpc=0 case. As we are
> > > removing the warning for bus_format=0 then a similar thing can be done
> > > for the bpc=0 also. The bpc value should be a valid one if it is
> > > specified. Unlike the bus_format, bpc has few possible values that can
> > > be checked here along with 0. Please correct me if I misunderstood the
> > > concept.
> > > I will fix this.
> >
> > What's the point of specifying bpc if it's optional though ? Users of
> > the panel will need to support the case where bpc is set to 0. Have you
> > ensured that they all do ? Can they meaningfully use the bpc value if
> > they need to be ready to support bpc == 0 ?
> 
> I must be missing something, but to me it seems like Rajeev's patch is
> fine as-is. From my reading of the code:
> 
> * Removes the warning if bus_format == 0. This is correct since I
> don't think specifying bus format for eDP panels makes lots of sense.

This is embarassing, I've been reading it as desc->bpc == 0 from the
beginning :-( My bad. The bpc change is correct.

> * Removes the warning if bpc == 10. This is correct since we've seen
> eDP panels with 10bpc.
> 
> * Keeps the warning if bpc == 0. IMO we can/should still require
> panels to specify their BPC. I guess I'm treating this as a "max BPC".
> I know that we use this field in the sn65dsi86 driver, so if it's OK
> for this to be 0 then we'll have to change that driver to handle it.
> 
> Does that sound right to you Laurent? So since I think Rajeev's patch
> is OK, I'm happy with:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> Unless I missed something and this patch needs to change then it feels
> like Rajeev's patch series is in pretty good shape to land. I'm happy
> to commit it but since Sam made comments on the previous version I'd
> plan to wait a bit to make sure he has a chance for another look if he
> wants to. I've also only got 2 days left before I vanish for 1 week of
> vacation. ...so my plan is:
> * If Sam / Laurent come back before tomorrow and say they're happy
> then I'll commit.
> * If I hear nothing then I'll check back after my vacation. If someone
> else has committed then I'll be happy. If not and there has just been
> silence then I'll commit it myself.
> 
> Please yell if that's not OK. :-)

-- 
Regards,

Laurent Pinchart
