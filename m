Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DD63F615D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbhHXPQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238120AbhHXPQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:16:27 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CA2C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:15:42 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id dm15so7227102edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=S8GovWtMK5eubaGQxzejb5uS/zTWAuF/XISVTn3NrSk=;
        b=CYJV+1REzF4SLuHOght+yAnmV5zMNpmzW0t/LDQjxsbFruPK5IHQ4xgTsUuvDOOXja
         R1ocAOWP3V6Z9fQQdJWScsDFdYfCj6Dy7+oqsP8S0xjyJrfkEFDm/xniPizx1ALX03Fv
         KFBEsaYxhdWYPpa1pFq/kFVxttCVmlbG9t6gHzJAQ/oSjfbOMt3wieXRElkwonRYbq//
         eBb9OTgSWZFM8sqwzOH0bqWF5Y1Dt3BLbrCcSpsIhMU54sddNQNfA/X2vMAzDYp7kMye
         WUgp9xKT1FKo7PlBizsD8y1uHF1yStfEsyP9ndmnkNLwTW235OPhuQWfP71RE4KCiOFP
         hshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S8GovWtMK5eubaGQxzejb5uS/zTWAuF/XISVTn3NrSk=;
        b=t8JMuAKtBgpscZj9b3IcC2OJMSajysKmIuLu8XH+LPJ5A+FoKv7+zFtEe3KuH3lP+b
         t6d64DOzFLaDn+ji/r1GmOHmAZujIMPNbjoyG3KKktQn1w7sIvfRxPSwQbGG1pIA8lbP
         RyUfFkfQJsSiXroZEMLV0uq95O585wB38U8IzgGWYevLnfZij1xF/kaRI4EcT4sY54oP
         GhOCQxvIMFynxa7U9te60N1qpIMLAa75MiWlCC/A7PfdDlFRoBouKO4kI3LEiitIECSy
         C0Lp0v/m+Ge8avzMZunY5FDQpSNGgkZ7COSktW4oEo4jlblIslFnX4/eiX/+lqPtuZfi
         9pPw==
X-Gm-Message-State: AOAM530amIbQyvpekxJeubJvEhZAXfusbxxsm6yvxI6lDiTaB2jn/Bd0
        sd+0PkTONprr6o27KP7FPnE=
X-Google-Smtp-Source: ABdhPJyJRBFsFUhAhJdMn39ets+xdiwQQX7DjNW18pwzQxGPH0AFtC6i9JDFd++hUlNSz4PR13tq7g==
X-Received: by 2002:a50:f1c6:: with SMTP id y6mr12864741edl.354.1629818140129;
        Tue, 24 Aug 2021 08:15:40 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id w13sm12448875ede.24.2021.08.24.08.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 08:15:39 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH 2/2] staging: r8188eu: Make some clean-ups in usbctrl_vendorreq()
Date:   Tue, 24 Aug 2021 17:15:38 +0200
Message-ID: <3740714.KPokl01s95@localhost.localdomain>
In-Reply-To: <27c7e4ef-06a8-2f0c-d388-1a64e7d4a735@gmail.com>
References: <20210824142823.16845-1-fmdefrancesco@gmail.com> <20210824142823.16845-3-fmdefrancesco@gmail.com> <27c7e4ef-06a8-2f0c-d388-1a64e7d4a735@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 24, 2021 4:39:51 PM CEST Pavel Skripkin wrote:
> On 8/24/21 5:28 PM, Fabio M. De Francesco wrote:
> > After replacing usb_control_msg() with the new usb_control_msg_recv() and
> > usb_control_msg_send() API of USB Core, remove camelcase from the pIo_buf
> > variable that is passed as argument to the new API and remove the initial
> > 'p' (that probably stands for "pointer") from the same pIo_buf and from
> > the pintfhdl and pdata arguments of usbctrl_vendorreq().
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >   drivers/staging/r8188eu/hal/usb_ops_linux.c | 22 ++++++++++-----------
> >   1 file changed, 11 insertions(+), 11 deletions(-)
> > 
> 
> I cannot apply this one on top of the first one:
> 
> error: patch failed: drivers/staging/r8188eu/hal/usb_ops_linux.c:33
> error: drivers/staging/r8188eu/hal/usb_ops_linux.c: patch does not apply
> 
> With regards,
> Pavel Skripkin

This is the same problem that yesterday Philip had. I cannot understand why it can
happen, because I've worked on this soon after 1/2 and in the while Greg didn't 
apply nothing. I've only worked on one function both in 1/2 and in 2/2 and I would expect
that either both of them apply or none of them. What am I missing?

Thanks,

Fabio
 




