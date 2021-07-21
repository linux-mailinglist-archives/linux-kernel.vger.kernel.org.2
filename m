Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C423D0E17
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhGULDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbhGUKyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:54:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76DFC0613DB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:34:36 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id hd33so2720857ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PwGcv3K9+/fZntIbMMSYVNFpVjwRYL0TiDMPAIGioqk=;
        b=dK85GgVIzBeoZpKaj6jnIjgvauVXwA83Dt9rpmb6PMdVLM4o6RuDepeW+HxDaLPOLU
         cmSc17JhSWrNiO7PvNbmJhM2+wg+3uHRymRhtVtch+KsSUbfTy07bis5ssbV3mviQWP/
         HRQKSvJxLDsgDSE1agijIJHN58G0H3mukJf+aHLpPbW2JUc8Rl6pVgP8i84sBUzj3xRp
         ShwTwWRdWwcA2XaqCXrdNsGlsw2xYUZTz1Cbal4PyDLGcn9xsRulj0ecJTT5s3jHAJEV
         sk0x1l3+rX2Q54+kyZXSV8BUnqYxtNYRqrG1TJmDxWNj+aD0HnEQamSlRUhsV0hjcLdo
         mocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PwGcv3K9+/fZntIbMMSYVNFpVjwRYL0TiDMPAIGioqk=;
        b=XIquweJca3j0LEkBbR+Vd1ir8pF3Ns5beXCzy/8b/F2ic6Ew8Uv1YIGUTiaLslvWNr
         SEkPC1cQ+An30Ri+qK4ANHK12wbH+ik8ExX6T46oBWRP8fAdNyolydIvyHEzthfzQKiZ
         6Mcnr4kcLGREhGRU7Al8B+8FFMY1FJikioaR68Nirt2/eD8eNMTAkRQGFGG/bk9C2JLq
         3JwVSsps4Ugx+a6SLjQtw1x5PAFrZFILfuE+BfR4YrcYxv3atn8/BA8P4kjJU92q6vq4
         mkEPBG5IyiaaWhR4YIs/5gYpW6qCb2+p0wS8wonRV7iuOp+KR3erp8OJdpkgH+X12zpg
         uPCg==
X-Gm-Message-State: AOAM531yiY1TGCpgR7/kMCL4nmc9A0a0KmeRLvqqG93VB6c5PyTzU17Z
        lZNJPrnhT+PrSfu/f+6dqFA=
X-Google-Smtp-Source: ABdhPJzdJ64/3yvm9dTSLwZ2K9adWnKQ3cLecGfacs3CIZF5EBdHO4FiLPzglFD5UlvIZQ2AQuISIQ==
X-Received: by 2002:a17:906:5e51:: with SMTP id b17mr38098962eju.270.1626867275390;
        Wed, 21 Jul 2021 04:34:35 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-97-200.retail.telecomitalia.it. [79.27.97.200])
        by smtp.gmail.com with ESMTPSA id n2sm10732686edi.32.2021.07.21.04.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 04:34:34 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8188eu: Remove an unused variable and some lines of code
Date:   Wed, 21 Jul 2021 13:34:33 +0200
Message-ID: <22299777.3ztAgAtxqs@localhost.localdomain>
In-Reply-To: <YPfYlf25CtKckRQx@kroah.com>
References: <20210705134151.15143-1-fmdefrancesco@gmail.com> <YPfYlf25CtKckRQx@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 21, 2021 10:19:33 AM CEST Greg Kroah-Hartman wrote:
> On Mon, Jul 05, 2021 at 03:41:51PM +0200, Fabio M. De Francesco wrote:
> > Remove set but unused iw_operation_mode[]. This driver doesn't support
> > SIOCSIWRATE.  It just returns zero and does nothing.  Change it to
> > return -ENOTSUPP instead.  (This is an API change but we don't expect it
> > to break anything).
> > 
> > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> > v1->v2: Delete rtw_wx_set_rate() and its association with command
> > SIOCSIWRATE as suggested by Dan Carpenter <dan.carpenter@oracle.com>
> 
> Does not apply to my tree :(
>
Hi Greg,

It cannot apply to your tree because, while it was waiting for acceptance, 
someone else did a large part of the removal of the code related to the 
unsupported SIOCSIWRATE and you applied this other patch.

However, the no more necessary iw_operation_mode[] is still in your tree. So 
I'm about to send a patch that only removes the above-mentioned array.

Thanks,

Fabio



