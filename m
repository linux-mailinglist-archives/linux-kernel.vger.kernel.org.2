Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30673A4488
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 16:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhFKPB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 11:01:28 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:36366 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhFKPBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 11:01:25 -0400
Received: by mail-lj1-f180.google.com with SMTP id 131so10105025ljj.3;
        Fri, 11 Jun 2021 07:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w+w3f5U3pFKKo+MRudY4zkE/DD31vq/T708Ozk8AEO8=;
        b=k/UsRWbH7KtsSomlx4S1xzQjieljZPFppy1YfMfuJEfCMf6uTSdYc6IPFGzwnF/p83
         5nxnKXmLT6qlpSGYBBosxKRLFXR5XmJl9J+IyFOK8nuqVq03MP9EMsVU9KKgq6hlCUhk
         al5Llac1ghQo5T12pjlzc8Rfid2TVJqCyCWJSS8DENSCC2mZxStuZfgrA1KKSIRiyZEU
         eb/2txeVpnGTYhdMppYEGrXA/ha0BXY9hV78wai016ZjEBdUtmiEdPXJT3QWxDwDF38h
         NMQOIdAMf3XXPIkPADqsRiI/YjbrjWjE2xlu+GaSPnDgs2yG+WjPqBNI3rxB1CjNhmbs
         zPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w+w3f5U3pFKKo+MRudY4zkE/DD31vq/T708Ozk8AEO8=;
        b=OgH13X7KDvL+SejkvtkLJzlNo+q8d1kDUTeGLd2at7o8PcpZiXaCevC0QUmVHV4+AQ
         kyhwaX8h+7aJ4yk5k/QmEUxLp4n7v1rWBfrHzAyzCuitjhm6Wl0sk7QsO3tboVRCij/q
         QIbNIWhqvMSWaOl6VH2k4QAecZyyP68yJiVSOuG5A/2FlN2qefk3C8KJlJ2tu/tFp7pW
         effuwvD88B35qw9LNwiBqZ4hfaL3/Wkz4/LNXuoNWbUDzuQqIkc0XRnN/6xDPpKuJUJi
         MKjmUQwLq9jfA7S5dLkxAPTDsE8qQynovZeSBG/+CwNd13XjsCou/LcGkxay0mg93wLs
         +pEg==
X-Gm-Message-State: AOAM533fiddLgy0J2GnkqyBpczI9ulVSUOPZASUpSDGv0y1iyPP71SBE
        /Acu8o63x/S5ENJCdAFpbKyNwTxD0c7HsvWEjqM=
X-Google-Smtp-Source: ABdhPJytclHzrB/R0k5jSua3KyutaoJZxty30z6FNamSFgDTpEgsQqFDW8uoFbTmLRobyzLJnZIZKhtK+ahxzyzatAg=
X-Received: by 2002:a2e:a4a4:: with SMTP id g4mr3382766ljm.376.1623423490556;
 Fri, 11 Jun 2021 07:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210611014755.124483-1-breno.lima@nxp.com> <VI1PR04MB59358BDBE0A6FA8A8966C66789349@VI1PR04MB5935.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB59358BDBE0A6FA8A8966C66789349@VI1PR04MB5935.eurprd04.prod.outlook.com>
From:   Breno Matheus Lima <brenomatheus@gmail.com>
Date:   Fri, 11 Jun 2021 10:57:59 -0400
Message-ID: <CAC4tdFUBGUiX4ydq4VeJcEXqmx6f2fvu4cq1ETw5mtueADz6yw@mail.gmail.com>
Subject: Re: [PATCH] mx8mm: usb: chipidea: Fix Battery Charger 1.2 CDP detection
To:     Jun Li <jun.li@nxp.com>
Cc:     Breno Matheus Lima <breno.lima@nxp.com>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

Em sex., 11 de jun. de 2021 =C3=A0s 02:24, Jun Li <jun.li@nxp.com> escreveu=
:
>
>
> > -----Original Message-----
> > From: Breno Matheus Lima <breno.lima@nxp.com>
> > Sent: Friday, June 11, 2021 9:48 AM
> > To: peter.chen@kernel.org
> > Cc: gregkh@linuxfoundation.org; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > dl-linux-imx <linux-imx@nxp.com>; linux-usb@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > brenomatheus@gmail.com; Jun Li <jun.li@nxp.com>; Breno Matheus Lima
> > <breno.lima@nxp.com>
> > Subject: [PATCH] mx8mm: usb: chipidea: Fix Battery Charger 1.2 CDP dete=
ction
> >
> > i.MX8MM cannot detect certain CDP USB HUBs. usbmisc_imx.c driver is not
> > following CDP timing requirements defined by USB BC 1.2 specification a=
nd
> > section 3.2.4 Detection Timing CDP.
> >
> > During Primary Detection the i.MX device should turn on VDP_SRC and IDM=
_SINK
> > for a minimum of 40ms (TVDPSRC_ON). After a time of TVDPSRC_ON, the PD =
is
> > allowed to check the status of the D- line. Current implementation is w=
aiting
> > between 1ms and 2ms, and certain BC 1.2 complaint USB HUBs cannot be de=
tected.
> > Increase delay to 40ms allowing enough time for primary detection.
> >
> > During secondary detection the PD is required to disable VDP_SRC and ID=
M_SNK,
> > and enable VDM_SRC and IDP_SINK for at least 40ms (TVDMSRC_ON).
> >
> > Current implementation is not disabling VDP_SRC and IDM_SNK, introduce
> > disable sequence in imx7d_charger_secondary_detection() function.
> >
> > VDM_SRC and IDP_SINK should be enabled for at least 40ms (TVDMSRC_ON).
> > Increase delay allowing enough time for detection.
> >
>
> Fixes: 746f316b753a ("usb: chipidea: introduce imx7d USB charger detectio=
n")
>

Thanks for pointing this out, I have just sent another version.

Best regards,
Breno Lima
