Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FD23F5B34
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 11:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbhHXJqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 05:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbhHXJqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 05:46:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954ABC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 02:46:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id mf2so24514160ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 02:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GrvCsUcjOz7dr6yABmwTuSZ2PSKxdeNbsF0RweGK1nA=;
        b=SfrMyhqSjfQbmPAWlBf7A8NR1eYktlZG2/doJX1lPcFWXKrUqHC20co4Rqt2090JZf
         l7dPmSiswukViMZ3kJt24xlHREf2prZjK4R+NndnlrJ4aEaW9C8ontAlSyakwd/k2X+o
         2rnqqGQ3Yso7ZCgMdU+OC5WfLNEepewf+SA28tx/1M24yYgZJkGri8LXnF/1rAGg2YlI
         BouxtR/pHMsFVaTyRrpKB7Bp4DZ6WnbrwHfuiD6PbSzuoK2ESbwWFGk8IIpm5iH9vU4B
         VgvCy4QbR0PTRYSmFXU/UPURFFIBZPQARujNioRHj6W9AB/1H2v+KiCOAtp7T2AwwOmk
         +jsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GrvCsUcjOz7dr6yABmwTuSZ2PSKxdeNbsF0RweGK1nA=;
        b=VVMyxpwqHkPcZJuNuH4gje29S33M39gRK4UxbNWBn2pFh1ugfZnAMvrIrNozvZXaZh
         qgKNAzenvb1jv+SMh2SiV+dLUkV9Ds2BCQE5capJjm5lOkmqDQnnDYLtKiJZkGQlL/jF
         FU4bL4yedQsXFHHRTpTrmLfNu5/NjTVdq0bolR9937337wpIdOkr2ARAQeNyrabaURcd
         wRn4sYaUFrqUO02PejQIO3VjLEZmGPm0XYnPSp6Lyolq4ZYcJ3Aqvqsma5MAi9kOWDsg
         126A0zpg6/Q31f9hnNMIYTFSegaelKTU2M3peMkzWGGtIYr8pNW97VLrb2mEUFhJnkhR
         dkfA==
X-Gm-Message-State: AOAM533/D9HeN8/18vBJboq8IiHEjYYr8sO5yKZjerhQeDmMsl+ce93b
        aKnv1m5ak/Lvm0lHFaGygSo=
X-Google-Smtp-Source: ABdhPJys7aXWCtp4RAyhTul41UcH3nZpR9j313wpdENzXAAZFuZ7ldTClOl+ysxSqrzr7WO5rwzUWQ==
X-Received: by 2002:a17:906:38c8:: with SMTP id r8mr40555690ejd.172.1629798365221;
        Tue, 24 Aug 2021 02:46:05 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id qh2sm8839076ejb.75.2021.08.24.02.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 02:46:04 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 5/6] staging: r8188eu: add error handling of rtw_read32
Date:   Tue, 24 Aug 2021 11:46:03 +0200
Message-ID: <1970955.u25yFflyLQ@localhost.localdomain>
In-Reply-To: <96e3703e-a5e2-3c6d-ea3c-b5d3892849b2@gmail.com>
References: <cover.1629642658.git.paskripkin@gmail.com> <77da7c63-a5b1-a09d-39ec-32c5485b8eac@gmail.com> <96e3703e-a5e2-3c6d-ea3c-b5d3892849b2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 24, 2021 10:53:35 AM CEST Pavel Skripkin wrote:
> On 8/24/21 11:47 AM, Pavel Skripkin wrote:
> > On 8/24/21 11:38 AM, Fabio M. De Francesco wrote:
> > 
> > Hi, Fabio!
> > 
> > previous usb_read16() realization, which is 100% right:
> > 
> > 
> > static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
> > {
> > 	u8 requesttype;
> > 	u16 wvalue;
> > 	u16 len;
> > 	__le32 data;

Ah, it was in plain sight! How didn't I notice it? :(

> > 
> > 	requesttype = 0x01;/* read_in */
> > 	wvalue = (u16)(addr & 0x0000ffff);
> > 	len = 2;
> > 	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
> > 
> > 	return (u16)(le32_to_cpu(data) & 0xffff);
> > }
> > 
> > 
> > Bases on this code, I think, it's oblivious, that data comes in
> > little-endian. That's why I leaved temp variable for casting le32 to
> > cpu's endianess.

Yes you did well (if we trust the old code :)), anyway I guess it
was correct because I've just seen that data is __le32 also in other Realtek
drivers.

> > 
> > I could just read into u{16,32} * and then make smth like
> > 
> > *data = le32_to_cpu(*data)
> > 
> > but static analysis tools will complain about wrong data type passed to
> >    le32_to_cpu()

Obviously the (not broken) tools should catch that and complain.

> > + Phillip tested fixed v2 version and it worked well for him. I guess,
> > Phillip was able to spot weird driver behavior, if this cast is wrong.
> > 
> 		^^^^^&
> 
> I am wrong with this statement, I guess. Most likely, Phillip is testing 
> on smth like x64 and this arch is le, so...
> 
> With regards,
> Pavel Skripkin
> 
Thanks,

Fabio


