Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731F53A4FF6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 19:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhFLSBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 14:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhFLSBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 14:01:36 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A800C061574;
        Sat, 12 Jun 2021 10:59:36 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 131so14078713ljj.3;
        Sat, 12 Jun 2021 10:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=91owpaF2W4JTE1rLDzae7eV/utnfUIkLjonIrTqWctw=;
        b=T8e0ZAXkaUaUkD4HeUO7qhqHzDK+IhSwWzQ9/TohafpqcLqKdMvjjhn+DrBpQUKZZC
         rjqWcZ2se/jMMgJ09vPHTBe4uUTo0kmh5/7m3AJzgtZl2Rc1CbNf4GOajsdTs0LBcQUq
         2OrsMLloBV3xfjBuIWd63W/OWrkfnG1OiAcLsFbKNTWTpAkF3h5TkElKjpkJOI9DuFAP
         B+7KKwAFrsjLzCfZht7q4zplsKZyeV6e00ugZ/cFPF717kJPSuNZuCqrItoA2K7n0Psu
         oNproxBU38PkPWVt+bNMf8PYvpZxRePRPYCMy50illm5JRjkyvkaNhnSdLlpW9lGREQm
         pZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=91owpaF2W4JTE1rLDzae7eV/utnfUIkLjonIrTqWctw=;
        b=nPK0PbAKFFWOCnKL6CUMFQDMUUeCVfDTQQjJdsJUDBMLvIMjrPVQfWg9BxZdV4rtXr
         6lt7Ywb4jd3pok/n7LYaX5bZP4++O77JZDp2YuBn9m2TuRQCQ8Z0QUkSG9Ubk5zvix93
         kbXdtVpTPoxH/aVJqrky9xkCLb+gnBScPdugtFzbC3z9bX5+1XOu3eMVcgYBw/U1eCSf
         mVyFz4ekDtCJ/m2D1mPV4B2cxcD4sK1rjrOL3qXUUOoJWT3L+UKpbnsIoULjlCqPoc+K
         W56XcpeqUghW+4Wa+SpuoQQnPJ89NF6VgubJLbrLaYTKaHQbRYBrEYXLOeT+VTzMYh72
         5vQg==
X-Gm-Message-State: AOAM533/Oh0VMFYr7/Elu8tackArBm4zM0Nf7lxhUJWGl58FoFWqTC35
        yC72pHddeUWtRZvAAI5tvYD8PIRHvHv7CFiDLHs=
X-Google-Smtp-Source: ABdhPJzrKD1MyMwrpMGoTcyk7feA6asP4uJ32aZoFpDWXOILBrLXS48SNSKB/XYWWXY/1GJ213e4ijzKPI4ihdpnfX8=
X-Received: by 2002:a2e:9715:: with SMTP id r21mr7632513lji.46.1623520773299;
 Sat, 12 Jun 2021 10:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210611145607.147207-1-breno.lima@nxp.com> <20210612072438.GA4580@Peter>
In-Reply-To: <20210612072438.GA4580@Peter>
From:   Breno Matheus Lima <brenomatheus@gmail.com>
Date:   Sat, 12 Jun 2021 13:59:21 -0400
Message-ID: <CAC4tdFXrGmmgui2uc-K2sgzxsgsQhQoARwO0720_wFb2ehpJ1A@mail.gmail.com>
Subject: Re: [PATCH v2] mx8mm: usb: chipidea: Fix Battery Charger 1.2 CDP detection
To:     Peter Chen <peter.chen@kernel.org>
Cc:     Breno Lima <breno.lima@nxp.com>, gregkh@linuxfoundation.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jun Li <jun.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Em s=C3=A1b., 12 de jun. de 2021 =C3=A0s 03:24, Peter Chen
<peter.chen@kernel.org> escreveu:
>
> On 21-06-11 10:56:07, Breno Lima wrote:
> > i.MX8MM cannot detect certain CDP USB HUBs. usbmisc_imx.c driver is not
> > following CDP timing requirements defined by USB BC 1.2 specification
> > and section 3.2.4 Detection Timing CDP.
> >
> > During Primary Detection the i.MX device should turn on VDP_SRC and
> > IDM_SINK for a minimum of 40ms (TVDPSRC_ON). After a time of TVDPSRC_ON=
,
> > the PD is allowed to check the status of the D- line. Current
> > implementation is waiting between 1ms and 2ms, and certain BC 1.2
> > complaint USB HUBs cannot be detected. Increase delay to 40ms allowing
> > enough time for primary detection.
> >
> > During secondary detection the PD is required to disable VDP_SRC and
>
> What does the "PD" mean here?
>

PD stands for Portable Device, I can send another version and mention
i.MX instead.

Thanks for pointing this out.

Best regards,
Breno Lima
