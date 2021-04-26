Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBAE36AA32
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 03:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhDZBJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 21:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhDZBJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 21:09:45 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B391FC061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 18:09:04 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w9so1895221lfr.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 18:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L2VpWKoOVfYEo6kHFmSEnNLX5GYV9LU7lbiX0Pj9gv0=;
        b=rhqeQag84PNpKAFdfNOozRRlP8xeBHIu0121V314rBoXRVAX943zgFlx2sZT9WMRPt
         YY5BO5UqdOVPFU0GG6R3npWe/OzxZ5VcXIM4uvk9rw391j1WHgrO1/GrNOFJTPtPqkid
         YZ4KF3tPTQ/1IQDTyTXfLL/1vX/QJN9sACsmpUZxCbOCai2q8UU/5ADTWq5k5pHWwjEx
         BTIb8QEMN5VyMnqgclEqK44WeDFRc1H632/kQCmX7SxFplUuUlERF1uU4l+SxRr/+M5F
         fD2P/IH4VJpAirwNAABF/4AQ/tCl4ZWqt08AVa3VCg6iy1RT7zuD2PBTOH9/n8zH8X0R
         4btA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L2VpWKoOVfYEo6kHFmSEnNLX5GYV9LU7lbiX0Pj9gv0=;
        b=OeKyiR4zE09z9Esp3PCFxUnbxr82f2T9Pj5CNUKURMNrVgQTcxwjy7qI9/N9yjVrRL
         x6sJRGdNgi3NPOx1aQFz/LJbG4+GyJcLhplZ6erjL/6bUYjRzWVj0Dk4/RY3aNMgdyTI
         +wUx8C01aPAblFLZdYlhudaV2vPAUxeYrriVFZvp0792V4DsZs16HP6kjjZEKKS2Gj8j
         4cVBwIkl5vUMMLudqv981aCbw3FVPtvAPaOo+Qzb/Y9PNQHJ9Uc4vhznqS+1TNgcPai/
         aVf0oEAAAEEsWYGD0IggQiwdIyOt0xm70gpSCZ87y5kjqAlODt2CBd9syWGcl/NZNrsN
         x8DA==
X-Gm-Message-State: AOAM532yvP8kh79KZEEKZz0kUXK0OqRixc9ddQioBOXVwawQprLTIdvX
        PvMnz/WJP9+q22XEi7+bK2NbeyTDB4Eozf9zQKs=
X-Google-Smtp-Source: ABdhPJwP9j9OEN9mF/QhmMqpI871n8tFykgSyn+TMFG3OUiTc3Z0jozOinHLGVeoeNQwHbTXDQG2kefiVnBaadVaae4=
X-Received: by 2002:a05:6512:1031:: with SMTP id r17mr10579328lfr.583.1619399343228;
 Sun, 25 Apr 2021 18:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210424162133.680213-1-j.neuschaefer@gmx.net>
In-Reply-To: <20210424162133.680213-1-j.neuschaefer@gmx.net>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 25 Apr 2021 22:08:52 -0300
Message-ID: <CAOMZO5D--BCUyP3LGWnw5-ecphXgaUaBrqYLwh8-OXqoX-tnKA@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Initialize SoC ID on i.MX50
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sat, Apr 24, 2021 at 1:24 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> As on i.MX51 and i.MX53, initialize the SoC ID based on the SoC
> compatible string of the board.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
