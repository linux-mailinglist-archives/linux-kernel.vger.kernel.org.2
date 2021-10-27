Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D79B43C35D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 08:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbhJ0G6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 02:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhJ0G6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 02:58:38 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EDAC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 23:56:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m17so6314038edc.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 23:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eh1zUcLfUh7eSHNed8rYw+K65ICLbNghHYjNf7zZN4Q=;
        b=rw132ZOjFbSpCAf7udfdZbPJgylOX1tTl6fRNnPpYigkKvpRRdb2a7QD+Q2uDDJq3x
         qkDKDmB9cF9N8dK7ohBlPx/CYcT/10BN9OonUrH578I1gz2cFkRqHjDmhU5XcSYJnnSc
         ovGDNtlhGWtnrsh6M+Eeqh+dDhwcj7WvAfq19d+4RTbm7mwB4F6xQYXVixwfxeNlrBcM
         HtIIAX14Ic6jdyc7tiKaVfGmhVZiaqiO4QNf47uWiGQRaF/c6MgCinMaYU/YeQKPZXpB
         WqAg2cduLCSdrvEUSMqsXP6UF2I7eEu6hI/hzEIm29nz0eq92z0Dh5kOmdAB/CgE6TZC
         1JUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eh1zUcLfUh7eSHNed8rYw+K65ICLbNghHYjNf7zZN4Q=;
        b=63DbIYmMSNk7gE88dMQiOkKsy1UK0+pUSJXDQMTxoSMOwKc+WpIp3dJ5eMMD+3oAjs
         tXQCh+D9nX1J1QIVhifqcnMuwNf1itXYcyQ1nsdc9cvPBKHWyewclCrTDuxn+wgrz49Z
         yfZDRyH55zGVHXJ3E9RfZ++4bd9jH7PJ/8faxSRhZWBoG5XODNZPa+HKx6U4UbWXrC1/
         XyGccKv7mSUsss/4jcdCvGW+dzYd1I2GKQLNCzexhY9/zpILgITysnWR4IZfTyHR+oqL
         NVPo0cZE6L57NFaXnVRipdjw1bdjVYZooq5LiusiNzfVsVzdZ4nHgpd2kV9X3oxeUwCu
         EHag==
X-Gm-Message-State: AOAM530XuaUVf+NHNDnXK+BJCgdsAu+9FE1kCUgXL85PP8kM9ClOYA/f
        qPlAlTEtPgLP7bnfi3Q/htS6+oYBrn3CsqdNthZvAzyq0Wk=
X-Google-Smtp-Source: ABdhPJy1EQgWgTtUeOuI5j/eATtlYTSdJI87vKsj7Qr0yqiPo8g20whrIlSSk9DAlryzcJz6shgk03KHwAj3+Jitqdw=
X-Received: by 2002:a05:6402:14cc:: with SMTP id f12mr42370685edx.242.1635317771408;
 Tue, 26 Oct 2021 23:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211026152128.5834-1-etienne.carriere@linaro.org> <20211026152128.5834-2-etienne.carriere@linaro.org>
In-Reply-To: <20211026152128.5834-2-etienne.carriere@linaro.org>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Wed, 27 Oct 2021 08:56:00 +0200
Message-ID: <CAN5uoS9z63L33xRHuqi8jsvOSh6wbLcOXjrUtAR8y82nxvkvvA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] firmware: arm_scmi: Add optee transport
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 at 17:21, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Add a new transport channel to the SCMI firmware interface driver for
> SCMI message exchange based on optee transport channel. The optee
> transport is realized by connecting and invoking OP-TEE SCMI service
> interface PTA.
>
> Optee transport support (CONFIG_ARM_SCMI_TRANSPORT_OPTEE) is default
> enabled when optee driver (CFG_OPTEE) is enabled. Effective optee

s/CFG_OPTEE/CONFIG_OPTEE/ (again!)

i'll fix in v7.

br,
etienne

> transport is setup upon OP-TEE SCMI service discovery at optee
> device initialization. For this SCMI UUID is registered to the optee
> bus for probing. This is done from the link_supplier operator of the
> SCMI optee transport.
>
> (snip)
