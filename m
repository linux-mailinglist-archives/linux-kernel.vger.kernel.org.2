Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B8131C026
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhBORJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhBOP5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:57:35 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE62C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 07:56:47 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id l23so6412895otn.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 07:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tVRxOWQGs4gFZYzB77EOG1YDIE4NKBpSovtJYt/WT6Y=;
        b=PdpPlec3It+OUT+a+pn8aTMutRpDQIqUdkitzv5ZpSqCHsK6Ty8ql4Y8YgE+KDsdah
         JaOBdS9ELXriDUUYiHNOz1wpSLV7p7cBfUUjN+aFtEfrI7QG0IG1RaqMJmDbVax7Es+z
         ar593lv/jNJxPOnI+PpzEFYDjY+ICORnxb04kHr7kTObyPqDcLUhoBJUMPu0mjmfWaMt
         Ev8NsAVtA6gxBcTR2tJaKmn56BgFSAEZi7907B1XpOA5/WMRNKH4YLn474LTYA2yIeQE
         QmAd5trT5uLzewTZwxBnr55TL8cYN828DA8W1BmvMV1jC2fBqamd9mH3LwXTB8m1RDLS
         +iRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tVRxOWQGs4gFZYzB77EOG1YDIE4NKBpSovtJYt/WT6Y=;
        b=Hm7Emqx4x234nZXTmtbeEeEP/TCuzj22cdwj7sI+j5p+7vvt4ucjSyJs8jiLxf1HW6
         1tXNdpuL/JSyz5jKnadShSQQKYEwCFd+sSkVqQV9LQ+YJwpbLGYI9V1tw0WDaXupDvrQ
         1tbKAEEtJOMrOwo6zjZLPpQxe8FFXHLoTA11cf4R1wsyrGZQpT2F6T2PA/3MYtKC7aN6
         3k8wEkQXHBDra+m2MtnnVfSh2QyYvFp3q0oA75SGKakVorcbM+jvx4Uidtf0EkivU0NM
         n3FdVoXO8YY/7UaA76XP84oJdhcTwbkzCmHjflSccgknClgBY0EQyRroqqWa3qd9EGgw
         yn1A==
X-Gm-Message-State: AOAM532aFdh2A+FL9w4lD6hlbZ0Aedc882wu6aZWKOIzcCizHO7qtTFh
        q2j4j2kUJtWZEV+Uc2pYdCTJ2ZqlKFPegZV+2Y6u
X-Google-Smtp-Source: ABdhPJyiYhFCshoCwdxjY8Ab8Kny7g2Frfd2DDdlb6v66NODKy4ENGVVrpBg4rw2onGBEIWgwHa5+nLpb5H23wjGvF4=
X-Received: by 2002:a9d:7dda:: with SMTP id k26mr11942219otn.284.1613404606483;
 Mon, 15 Feb 2021 07:56:46 -0800 (PST)
MIME-Version: 1.0
References: <20210211232312.2082334-1-iwamatsu@nigauri.org> <81880da7-3a9d-cb6b-1391-b8f59fcd1a37@xilinx.com>
In-Reply-To: <81880da7-3a9d-cb6b-1391-b8f59fcd1a37@xilinx.com>
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date:   Tue, 16 Feb 2021 00:56:20 +0900
Message-ID: <CABMQnV+UHyuC6y345BnFcqeDkBWrp9+Xn27GXQPAPvediwcFPg@mail.gmail.com>
Subject: Re: [PATCH v2] firmware: xilinx: Remove zynqmp_pm_get_eemi_ops() in IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2021=E5=B9=B42=E6=9C=8812=E6=97=A5(=E9=87=91) 21:53 Michal Simek <michal.si=
mek@xilinx.com>:
>
>
>
> On 2/12/21 12:23 AM, Nobuhiro Iwamatsu wrote:
> > zynqmp_pm_get_eemi_ops() was removed in commit 4db8180ffe7c: "Firmware:=
 xilinx:
> > Remove eemi ops for fpga related APIs", but not in IS_REACHABLE(CONFIG_=
ZYNQMP_FIRMWARE).
> > Any driver who want to communicate with PMC using EEMI APIs use the fun=
ctions provided
> > for each function.
> > This removed zynqmp_pm_get_eemi_ops() in IS_REACHABLE(CONFIG_ZYNQMP_FIR=
MWARE), and also
> > modify the documentation for this driver.
> >
> > Fixes: 4db8180ffe7c ("firmware: xilinx: Remove eemi ops for fpga relate=
d APIs")
> > Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > ---
> >  v2: Added the comment pointed out by Michal.
> >
> >  Documentation/driver-api/xilinx/eemi.rst | 27 +-----------------------
> >  include/linux/firmware/xlnx-zynqmp.h     |  5 -----
> >  2 files changed, 1 insertion(+), 31 deletions(-)
> >
> > diff --git a/Documentation/driver-api/xilinx/eemi.rst b/Documentation/d=
river-api/xilinx/eemi.rst
> > index 9dcbc6f18d75df..53416d25d309a8 100644
> > --- a/Documentation/driver-api/xilinx/eemi.rst
> > +++ b/Documentation/driver-api/xilinx/eemi.rst
> > @@ -19,32 +19,7 @@ device to issue or respond to power management reque=
sts.
> >  EEMI ops is a structure containing all eemi APIs supported by Zynq MPS=
oC.
> >  The zynqmp-firmware driver maintain all EEMI APIs in zynqmp_eemi_ops
> >  structure. Any driver who want to communicate with PMC using EEMI APIs
> > -can call zynqmp_pm_get_eemi_ops().
> > -
> > -Example of EEMI ops::
> > -
> > -     /* zynqmp-firmware driver maintain all EEMI APIs */
> > -     struct zynqmp_eemi_ops {
> > -             int (*get_api_version)(u32 *version);
> > -             int (*query_data)(struct zynqmp_pm_query_data qdata, u32 =
*out);
> > -     };
> > -
> > -     static const struct zynqmp_eemi_ops eemi_ops =3D {
> > -             .get_api_version =3D zynqmp_pm_get_api_version,
> > -             .query_data =3D zynqmp_pm_query_data,
> > -     };
> > -
> > -Example of EEMI ops usage::
> > -
> > -     static const struct zynqmp_eemi_ops *eemi_ops;
> > -     u32 ret_payload[PAYLOAD_ARG_CNT];
> > -     int ret;
> > -
> > -     eemi_ops =3D zynqmp_pm_get_eemi_ops();
> > -     if (IS_ERR(eemi_ops))
> > -             return PTR_ERR(eemi_ops);
> > -
> > -     ret =3D eemi_ops->query_data(qdata, ret_payload);
> > +use the functions provided for each function.
> >
> >  IOCTL
> >  ------
> > diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmw=
are/xlnx-zynqmp.h
> > index 2a0da841c942f6..4ef77deaf7918c 100644
> > --- a/include/linux/firmware/xlnx-zynqmp.h
> > +++ b/include/linux/firmware/xlnx-zynqmp.h
> > @@ -355,11 +355,6 @@ int zynqmp_pm_read_pggs(u32 index, u32 *value);
> >  int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
> >  int zynqmp_pm_set_boot_health_status(u32 value);
> >  #else
> > -static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
> > -{
> > -     return ERR_PTR(-ENODEV);
> > -}
> > -
> >  static inline int zynqmp_pm_get_api_version(u32 *version)
> >  {
> >       return -ENODEV;
> >
>
> I can't see any difference compare to v1. Don't you forget to commit
> your changes?

Oh, sorry. I will resend with update.

Best regards,
  Nobuhiro


--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
