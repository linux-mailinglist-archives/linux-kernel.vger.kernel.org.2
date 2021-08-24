Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD0C3F5D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 13:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbhHXLbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 07:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbhHXLay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:30:54 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE2DC061796
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 04:30:10 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id l18so29492031lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 04:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FreLuXtpPO5M0wpQU/au7ZiAqtijlcsGc59gKKgk/cE=;
        b=CSa5G9X9T10H39Cf/4WsJMIxldeEYSZf5kx/O07w10fZxVPEumBmJD1Kf2LVpJKp+g
         8iS5NXOGRh+fdG+c2yAcHS6cf2m6CK/Am3BaWXW/hjiMg6RW/DTv4Qb9ykuxIwhE4mSO
         tYrJumdu2IGkMZwbAFIdJCTZhunSMPu/qf9L5JBmLd3rEAomkKZ2ysTC/ESmnWk+uoLH
         dhTdigaeNI3a7Ibl2b/f+kWgNubmfACJ6CgL5aC4vWMEvCJQZnMQpI2GgQ5Ggf5PYrLD
         B/T4J+orYR8TXEg7Gl9rtKcV/bhxs/Qfzg1ja7iPm4UNCSG/8xr5MSxG++9UDXW47kET
         aUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FreLuXtpPO5M0wpQU/au7ZiAqtijlcsGc59gKKgk/cE=;
        b=RPUZwA6qUemD77wIS7uhZm0OYvRIhjHWErcPly+sNH6BdKhb2wo6ihAVtXBibQHds/
         w3sYUMU5MVlbF8Etl9gGml30db4OJB2CxCH/H0K1w8Ob5oXzo9/1VoIqZquMR0T3gKgB
         q8ip8f+nMPflBj9+Ocg93HroaKMsb/2VR5telygtO/eTYlUp/ZSPvDxEvjQM+CEpK/ai
         tu14V+esgc/mhXkGLaHI7urnQTQY8yDwiTPTUD6+B8hzCj6xqw4dFgaZQiSM0G4svP3K
         wb9gRAh17+JgDJ9NNkDPxON7igrfrNLmyIwZnExh4Co9RI38ASMlWNnHhljpepYJ2Gum
         i2Lw==
X-Gm-Message-State: AOAM531Cyv+Kvu7xBTSZH768qdJbAnj/1MTI/eVq0WURtINGI8qhbi3N
        aIIRAn895YjDxl4uR1tDkrazyocELY1iIROLKR7Jaw==
X-Google-Smtp-Source: ABdhPJxQH8k8XULO0z2A31EiJpmeQRdAX6jY9QPJ8haOSv/5nXSkOoXHLu6IrdzQGyKAfdrldcuInPU7bxrN6lLg18c=
X-Received: by 2002:a05:651c:83:: with SMTP id 3mr31894238ljq.341.1629804608413;
 Tue, 24 Aug 2021 04:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210713053458.1441-1-oracleks043021@gmail.com> <DM6PR04MB65754DC90E423A79D80263C1FC149@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65754DC90E423A79D80263C1FC149@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 13:29:32 +0200
Message-ID: <CAPDyKFp_HGSfm_ZR6=CSzNAK9jXZ+hNBh4=9Ld67-fSkKPJ_4A@mail.gmail.com>
Subject: Re: [PATCH v1] mmc-utils: Fix for Firmware Version string printing
To:     Avri Altman <Avri.Altman@wdc.com>,
        "oracleks043021@gmail.com" <oracleks043021@gmail.com>
Cc:     "beanhuo@micron.com" <beanhuo@micron.com>,
        "kenny.gibbons@oracle.com" <kenny.gibbons@oracle.com>,
        "kimito.sakata@oracle.com" <kimito.sakata@oracle.com>,
        "rkamdar@micron.com" <rkamdar@micron.com>,
        "chris@printf.net" <chris@printf.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jul 2021 at 10:00, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> >
> > From: Kimito Sakata <kimito.sakata@oracle.com>
> >
> > Added a local buffer to create a NULL terminated string to print the
> > Firmware Version instead of attempting to print directly from
> > ext_csd buffer. The last byte of the Firmware Version field may not
> > be NULL and the next field may also not be which may cause it to
> > print garbage.
> >
> > Tested on x86 platform.
> Fixes: 89cd01ed865a (mmc_utils: add ffu support)
>
> Signed-off-by: Kimito Sakata <kimito.sakata@oracle.com>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>

Applied for master at git.kernel.org/pub/scm/utils/mmc/mmc-utils.git, thanks!

Kind regards
Uffe


>
> > ---
> >  mmc_cmds.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/mmc_cmds.c b/mmc_cmds.c
> > index afa85b7..205e6e5 100644
> > --- a/mmc_cmds.c
> > +++ b/mmc_cmds.c
> > @@ -1392,6 +1392,7 @@ int do_read_extcsd(int nargs, char **argv)
> >         __u32 regl;
> >         int fd, ret;
> >         char *device;
> > +       char lbuf[10];
> >         const char *str;
> >
> >         if (nargs != 2) {
> > @@ -1833,8 +1834,9 @@ int do_read_extcsd(int nargs, char **argv)
> >         }
> >
> >         if (ext_csd_rev >= 7) {
> > -               printf("eMMC Firmware Version: %s\n",
> > -                       (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
> > +                memset(lbuf, 0, sizeof(lbuf));
> > +               strncpy(lbuf, (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION], 8);
> > +               printf("eMMC Firmware Version: %s\n", lbuf);
> >                 printf("eMMC Life Time Estimation A
> > [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x%02x\n",
> >                         ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]);
> >                 printf("eMMC Life Time Estimation B
> > [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]: 0x%02x\n",
> > --
> > 2.31.1
>
