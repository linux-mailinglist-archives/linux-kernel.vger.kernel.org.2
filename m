Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F9D30D7D7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 11:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhBCKn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 05:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbhBCKnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 05:43:23 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C50C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 02:42:43 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id a16so2566773plh.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 02:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iy/eDo12X7/X/dP07CNNtclY4xvDsxISKIjmhqf7NUg=;
        b=k5MFLbQDq/ojv39xglXJP5+GMcKafiMxwpDWN25g9We8ceWlDa2ronH4HBIJlRSLND
         hZK3Ofz7K5OsHCmRCerGUyqILa9Gqt1YeWVCI5+IOox7bb8gpRItl+MdaVRYim6FrDVT
         MtljRVBkUcDNLale+tcCd6pYR8wC+Spq+yUUHAt1/CyjjybHTPnobVVD6UTju9MDaEgv
         tdfrNRbve9ZOXSGTRLC0WUMmIDEnX4UqSv0SsNQGeTO+fiGUOA2uCk1jqyD/39FVqVW0
         K4IgdWfGsakJFAAl9ZhsWGWRZ8r/7W9/mN42eDXGw7G5hGDI/UIPSFOp6gS0lJ+SDiB6
         V0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iy/eDo12X7/X/dP07CNNtclY4xvDsxISKIjmhqf7NUg=;
        b=l1LWnu9aj9V6MeViPwoIkCv3B6cqSlqjFvqRiu0vXIYNYQX3EELlXEUTpuPo9NsLXX
         UFxAjjpUCcD3wU3jMygY0wUoUIyqD9tceNckct5eEc7jZOVzCTWQGwvbCsmo3awq+RRP
         lAdFH/XOfdUNsW6q4DdbLMDJRacnVfR5SVIl3U6lh8Z/5fvk7uynEjtjwYo3KaVSxKxE
         OG1R9G8aadKN3ZF6j7KjJr/gjFcoXl3e72zr0WrPPH7pz8/e6PtAuLfIaLWkzSa0Nae4
         VVbTsYhKt7WA9VJjEbDwTJG+nKar9B0AqWxssqrnn45FLw1OBxLyD6pBEqbce7qg9NZY
         JWzg==
X-Gm-Message-State: AOAM530Ko7CEoumuHl1K1xbYY5VFA2VHwMjyTzOzPIzkSzFo8HxhwaO6
        aBozaw9nxE5P+Imo2VuB96x7lRP9yRk2fqJQhI7pvg==
X-Google-Smtp-Source: ABdhPJxaJ4FEBmLlfldOXozrJQdmppDfIh0KJQl1KqDLNen4yo6fV/I89C/RcD4X3BHjFLxNvMBQEyQLOmUilTbGy4Y=
X-Received: by 2002:a17:90a:4ecb:: with SMTP id v11mr2595701pjl.75.1612348962588;
 Wed, 03 Feb 2021 02:42:42 -0800 (PST)
MIME-Version: 1.0
References: <20210127144930.2158242-1-robert.foss@linaro.org>
 <20210127144930.2158242-11-robert.foss@linaro.org> <20210201134007.GE3@valkosipuli.retiisi.org.uk>
In-Reply-To: <20210201134007.GE3@valkosipuli.retiisi.org.uk>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 3 Feb 2021 11:42:31 +0100
Message-ID: <CAG3jFytzqBnjB9AT1e0jyePGdD0KLriKfu3EpXYxgnv1Fsq3Lg@mail.gmail.com>
Subject: Re: [PATCH v3 10/22] media: camss: Add support for CSIPHY hardware
 version Titan 170
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, shawnguo@kernel.org,
        leoyang.li@nxp.com, Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, Anson.Huang@nxp.com,
        michael@walle.cc, agx@sigxcpu.org, max.oss.09@gmail.com,
        angelogioacchino.delregno@somainline.org,
        MSM <linux-arm-msm@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Sakari,

On Mon, 1 Feb 2021 at 14:40, Sakari Ailus <sakari.ailus@iki.fi> wrote:
>
> Hi Robert,
>
> On Wed, Jan 27, 2021 at 03:49:18PM +0100, Robert Foss wrote:
> > Add register definitions for version 170 of the Titan architecture
> > and implement support for the CSIPHY subdevice.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >  .../qcom/camss/camss-csiphy-3ph-1-0.c         | 182 ++++++++++++++++--
> >  .../media/platform/qcom/camss/camss-csiphy.c  |  66 +++++--
> >  drivers/media/platform/qcom/camss/camss.c     |  74 +++++++
> >  3 files changed, 290 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> > index 97cb9de85031..8cf1440b7d70 100644
> > --- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> > +++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> > @@ -47,6 +47,105 @@
> >  #define CSIPHY_3PH_CMN_CSI_COMMON_CTRL6_SHOW_REV_ID  BIT(1)
> >  #define CSIPHY_3PH_CMN_CSI_COMMON_STATUSn(n) (0x8b0 + 0x4 * (n))
> >
> > +#define CSIPHY_DEFAULT_PARAMS            0
> > +#define CSIPHY_LANE_ENABLE               1
> > +#define CSIPHY_SETTLE_CNT_LOWER_BYTE     2
> > +#define CSIPHY_SETTLE_CNT_HIGHER_BYTE    3
> > +#define CSIPHY_DNP_PARAMS                4
> > +#define CSIPHY_2PH_REGS                  5
> > +#define CSIPHY_3PH_REGS                  6
> > +
> > +struct csiphy_reg_t {
> > +     int32_t  reg_addr;
> > +     int32_t  reg_data;
> > +     int32_t  delay;
> > +     uint32_t csiphy_param_type;
> > +};
> > +
> > +static struct
>
> This should be const.

Agreed. Thanks for catching this!

>
> > +csiphy_reg_t lane_regs_sdm845[5][14] = {
> > +     {
> > +             {0x0004, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x002C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0034, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x001C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0014, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0028, 0x00, 0x00, CSIPHY_DNP_PARAMS},
> > +             {0x003C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0000, 0x91, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0008, 0x00, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
> > +             {0x000c, 0x00, 0x00, CSIPHY_DNP_PARAMS},
> > +             {0x0010, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0038, 0xFE, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0060, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0064, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +     },
> > +     {
> > +             {0x0704, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x072C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0734, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x071C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0714, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0728, 0x04, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x073C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0700, 0x80, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0708, 0x14, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
> > +             {0x070C, 0xA5, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0710, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0738, 0x1F, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0760, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0764, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +     },
> > +     {
> > +             {0x0204, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x022C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0234, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x021C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0214, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0228, 0x00, 0x00, CSIPHY_DNP_PARAMS},
> > +             {0x023C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0200, 0x91, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0208, 0x00, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
> > +             {0x020C, 0x00, 0x00, CSIPHY_DNP_PARAMS},
> > +             {0x0210, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0238, 0xFE, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0260, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0264, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +     },
> > +     {
> > +             {0x0404, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x042C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0434, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x041C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0414, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0428, 0x00, 0x00, CSIPHY_DNP_PARAMS},
> > +             {0x043C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0400, 0x91, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0408, 0x00, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
> > +             {0x040C, 0x00, 0x00, CSIPHY_DNP_PARAMS},
> > +             {0x0410, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0438, 0xFE, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0460, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0464, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +     },
> > +     {
> > +             {0x0604, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x062C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0634, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x061C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0614, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0628, 0x00, 0x00, CSIPHY_DNP_PARAMS},
> > +             {0x063C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0600, 0x91, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0608, 0x00, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
> > +             {0x060C, 0x00, 0x00, CSIPHY_DNP_PARAMS},
> > +             {0x0610, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0638, 0xFE, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0660, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +             {0x0664, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
> > +     },
> > +};
>
> --
> Sakari Ailus
