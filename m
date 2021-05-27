Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143E23929BF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbhE0Ipl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbhE0Ipc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:45:32 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CB1C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 01:43:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m18so3887537wrv.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 01:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3L68bacZr0PwfRAm8hFSUVoyJv0NBxuRAhL667AuTWc=;
        b=nDtehq73M+4wZnrQ176gTUypOQxMAGzZCelnnQEMdA4Ue1zkPgmV5Ug2vLEydPtU3e
         eMf3mTHDAaV15LfakVzjNi5cY7RDxfHOuS7nNga/XElt4NMKG2bJ5F/WwXmG7SL+tvvt
         uXYNA4oVYp3nx/7qm8bQwKt+ohvE/IBiF37Im/hO0RmY40gMVSVWxlGtE6t7SCy86xIi
         KL7vPmbghjcDkIOUfXxM+zZwOvyu/usKu0iC68SKUEJgMBGQ74j9pRRg2CQ/cA0k64D/
         YzqcoCffyAhgqFo175DLeM5qu16yhWz8e4RR28stArmEyWWJdZ+uvQbRwRtscaEHvSN4
         mWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3L68bacZr0PwfRAm8hFSUVoyJv0NBxuRAhL667AuTWc=;
        b=qsH6wz0u+kelfhrtdQYenHV2xRL2yTo9ClCMMuGrfqmGppmKxbcuXbjSdHXeTInvGl
         Q5xivdGcmAHLMvFbEmB+XCf5pSlsskj/8WU0/8M5+S5QyYvQcj8TeDV22zFeLcUFwFga
         MzWwM7UvCQCorjDFVuHKTnra012zHBYEk/mWhuUKLuUBYQ4/2lC43pT0UlCo8g8+V21M
         tB+Boov0rrCx+Ai/3hH7z1Gn0YalXwLsdofCNDlaD6p3FwHLU5mYQrj+A1Bn2Da+Venx
         srRBTGYgXEAJ/tFjAaetHjj0j90aGIPv2Qtg3pc6WH/BXJriwaaqyUqaqYiLN5CejSIQ
         43ug==
X-Gm-Message-State: AOAM532HxnffykVK7O7++hzx2wlvFHCURrGsS/ve322mKKp5Y5qpG/V9
        cgQ+WLGRqSBLoWPLWGjjNU+L5Q==
X-Google-Smtp-Source: ABdhPJwpUHtR6b1jBYiaOEHNxKmLgkQf8QQbbg9t709yLkdkhRxReXsSbCUv4edxfYoBMyHsZT2+7Q==
X-Received: by 2002:adf:decf:: with SMTP id i15mr2149088wrn.300.1622105035953;
        Thu, 27 May 2021 01:43:55 -0700 (PDT)
Received: from dell ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id h67sm2160856wrh.44.2021.05.27.01.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 01:43:55 -0700 (PDT)
Date:   Thu, 27 May 2021 09:43:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Message-ID: <20210527084353.GJ543307@dell>
References: <1619466246-11198-1-git-send-email-min.li.xe@renesas.com>
 <20210519080807.GH805368@dell>
 <OS3PR01MB659398F1C336CA2A03A0A7EABA249@OS3PR01MB6593.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3PR01MB659398F1C336CA2A03A0A7EABA249@OS3PR01MB6593.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021, Min Li wrote:

> > 
> > > +	ret = rsmu_dev_init(rsmu);
> > > +	mutex_unlock(&rsmu->lock);
> > > +
> > > +	if (ret == 0)
> > > +		dev_info(rsmu->dev, "Probe %s successful\n",
> > > +			 rsmu_name(rsmu->type));
> > 
> > No thank you.  Please remove this.
> > 
> Hi Lee
> 
> What is the rule for adding informational log in the driver probe function?

The rule generally is 'don't'.

Especially if it doesn't provide any actual information.

Strings are expensive with regards to binary size.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
