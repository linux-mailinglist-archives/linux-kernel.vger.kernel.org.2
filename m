Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2371831D44C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 04:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhBQDiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 22:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBQDit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 22:38:49 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E441C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 19:38:09 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id n1so4432911edv.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 19:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kL25i8Zz9G4d7AUFP51OG9jU0cPZgNzUVGr5+p5yT3A=;
        b=EZRAxdpojciOJtQmt+mWxk42W5j54FKU6esBNiyrMLkROt4kVy4rnatzjpn6EozfTs
         kVoJSAXlWtceQ0iWkT6OBSH4PdLxdnXfRDS6YWOsrGGA9yNKhUN3Q+s0BbqTi7obE9iF
         QaN3tCCpXd0dJhZrWt0A3xBdjGkaA4r4f1SXZygROYxP2Z3MJc/ip0GGC+EmN2nJr3MY
         MEkwjmobcosipCuOO/9yB/8L4a4DKUNIg9V2wPJx0KlbADUMWAFwBwTJ3fwzBOFlGcI2
         m7MlH43LPwpIz9S1l7g+PaBfSXCV6mMJTRFvQ3NgDHRLHcxbVB/BKrIBNFN2ETAc22PK
         khbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kL25i8Zz9G4d7AUFP51OG9jU0cPZgNzUVGr5+p5yT3A=;
        b=fDUYT0I2Y7e6bXo0H1RPplpIH632ONwm/T2M8ZO9ny/oyrpvfGMIs5m9T3IRltRjOC
         omb4a7Zxctv6HQqeLRZ78mZVC1tFVb92b5K9U1Dql4EEqxnj8hb4c2/u9t4i1Y21iBla
         M8VKNsHGH1XWj6AwVRrxTZqvwiaqzeXxyJhvzcVvuMjRF+mtDA6fNuLe2WGTMWL0eL9j
         /DoGttG0gMOQ2QXtGxkFxT0ICOMP6z6KKJtzZU6t9EpZkBcw0H5epgVYTJYScHM42Y2A
         I2GfKGVrMIx45AYyeC9noAtkEBQoYhv4QXODRdN77uvrYUzBq0gWK9xzwVfmfhfbgpfs
         fL+w==
X-Gm-Message-State: AOAM533o+S7M/80EO331yya5vDBhaXnLhbpic1wf3CDpinhRx2ONOUQi
        D5JS4rfmbSUCCfxt12qd93pFm6bID/ZN2j1M9zoGWg==
X-Google-Smtp-Source: ABdhPJzmEDnNgd7IqCzjUQKrXhbKhY+f/9y2AvYFB6jH8yvpz7j9l35QNyenrz406rsJoK7+pFPQBYpfA9D0wos5jvA=
X-Received: by 2002:a05:6402:306c:: with SMTP id bs12mr24297164edb.348.1613533087806;
 Tue, 16 Feb 2021 19:38:07 -0800 (PST)
MIME-Version: 1.0
References: <20210212171043.2136580-1-u.kleine-koenig@pengutronix.de> <20210212171043.2136580-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210212171043.2136580-2-u.kleine-koenig@pengutronix.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Feb 2021 19:37:58 -0800
Message-ID: <CAPcyv4jVw6o7Yznxs7UDMnSoJLozx86v5YCg6YZGeGm6emyooQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] libnvdimm: Make remove callback return void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@pengutronix.de, linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 9:21 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> All drivers return 0 in their remove callback and the driver core ignores
> the return value of nvdimm_bus_remove() anyhow. So simplify by changing
> the driver remove callback to return void and return 0 unconditionally
> to the upper layer.

Looks good, thanks.
