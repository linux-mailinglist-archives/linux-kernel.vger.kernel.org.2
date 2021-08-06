Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75D03E28C5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 12:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245231AbhHFKhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 06:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245218AbhHFKhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:37:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE196C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 03:37:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u3so14407801ejz.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 03:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TVGZoE5gGRjdrzp11QJfyMJlwcXTvAtUoyy+JrT+IQA=;
        b=tQEG6YzPxZYaUfm8emfjyn1WQFufEBobsHOf2wIgqUNzArRiVwdyJkOY9t8gOk+3IR
         vT4VvKckYd0jrRQzATYiCfUCoy0TfUxwzzwpq1OiS3Q2AVq4m4gWgAuxZTIlEjnWwt59
         pru94xbHnAJzrcoxhCAjzHTTkUatiOXaVXRPaBj3jlvDw59GHBlSTGPMwoAw9FgvgDPE
         ImlV2e+CmYICx4ZkMx2AEiu4CTp7EN4OJRYRS8xKzf8vFaCKrEczCWyGFdtMOUcU2Y8p
         xKBVtmt6XWAeTvFKPxe/ZbI+NAH/K7fa1hKIbwr16XrJzECI4N3fCdDLiTLk5l4e8CEQ
         aVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TVGZoE5gGRjdrzp11QJfyMJlwcXTvAtUoyy+JrT+IQA=;
        b=Wa7rmdL+Pp7CzHMDtBSyCw6S7Cxc3s/BVcVxNBS0h8EAjvs6dQfWn1ZxwSY4+MmXFF
         TvRUtcD6v2MkuvebQHW/AxzNaP1KupHlaJbm9hIDamGQH+mxVk4ZQd//2dYZYVO1ea4E
         y2Jx+CqUT31jLSPk7LF0dKWb/oLUJA5tS1msw2lVynzA4JHtozVpJC7N1TyqNmxL2Aj8
         llHwcPA+ZmA+gC7WNyCw9brm1Mda/vX+LG/TN0HUQF/bKObkdORmcDDeRkE3PTMTNq+b
         7Eglb4jzPmuhoGdgHvmS6jwyzZTMKOLkRi3j00niLHfHa2wJBXW4wLB/hTWp1FwW0SJ8
         umMg==
X-Gm-Message-State: AOAM530UTZDytopkRb9wezT9YvtyLyroXzFk4ZQ5rzpgcZP3nHlG9R+k
        Xjvsx/lKu+OPbW10+t2RaSBvuEcTSZlMLbxZhhBlzw==
X-Google-Smtp-Source: ABdhPJxTJcwPze+uSxEQwjciI5+zYaAJQYWtC+KmZeML3RJiEQnV0SiGzTiN96DDfWVpuQf7vTNj/fNHDmuyFMk/5Lc=
X-Received: by 2002:a17:907:1b06:: with SMTP id mp6mr9404647ejc.188.1628246238490;
 Fri, 06 Aug 2021 03:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210323025501.1568039-1-quanyang.wang@windriver.com> <YFquZaW4JTTM7ogS@pendragon.ideasonboard.com>
In-Reply-To: <YFquZaW4JTTM7ogS@pendragon.ideasonboard.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Fri, 6 Aug 2021 12:37:07 +0200
Message-ID: <CAHTX3d+uZsqevn0+7Lo+z62mk-1+S7n7VuO-QU8Q1Y-gP0Ugyw@mail.gmail.com>
Subject: Re: [V2][PATCH] drm: xlnx: zynqmp: release reset to DP controller
 before accessing DP registers
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Quanyang Wang <quanyang.wang@windriver.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

st 24. 3. 2021 v 4:15 odes=C3=ADlatel Laurent Pinchart
<laurent.pinchart@ideasonboard.com> napsal:
>
> Hi Quanyang,
>
> Thank you for the patch.
>
> On Tue, Mar 23, 2021 at 10:55:01AM +0800, quanyang.wang@windriver.com wro=
te:
> > From: Quanyang Wang <quanyang.wang@windriver.com>
> >
> > When insmod zynqmp-dpsub.ko after rmmod it, system will hang with the
> > error log as below:
> >
> > root@xilinx-zynqmp:~# insmod zynqmp-dpsub.ko
> > [   88.391289] [drm] Initialized zynqmp-dpsub 1.0.0 20130509 for fd4a00=
00.display on minor 0
> > [   88.529906] Console: switching to colour frame buffer device 128x48
> > [   88.549402] zynqmp-dpsub fd4a0000.display: [drm] fb0: zynqmp-dpsubdr=
m frame buffer device
> > [   88.571624] zynqmp-dpsub fd4a0000.display: ZynqMP DisplayPort Subsys=
tem driver probed
> > root@xilinx-zynqmp:~# rmmod zynqmp_dpsub
> > [   94.023404] Console: switching to colour dummy device 80x25
> > root@xilinx-zynqmp:~# insmod zynqmp-dpsub.ko
> >       <hang here>
> >
> > This is because that in zynqmp_dp_probe it tries to access some DP
> > registers while the DP controller is still in the reset state. When
> > running "rmmod zynqmp_dpsub", zynqmp_dp_reset(dp, true) in
> > zynqmp_dp_phy_exit is called to force the DP controller into the reset
> > state. Then insmod will call zynqmp_dp_probe to program the DP register=
s,
> > but at this moment the DP controller hasn't been brought out of the res=
et
> > state yet since the function zynqmp_dp_reset(dp, false) is called later=
 and
> > this will result the system hang.
> >
> > Releasing the reset to DP controller before any read/write operation to=
 it
> > will fix this issue. And for symmetry, move zynqmp_dp_reset() call from
> > zynqmp_dp_phy_exit() to zynqmp_dp_remove().
> >
> > Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Can someone pick this patch?

Thanks,
Michal
