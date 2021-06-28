Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245213B5C91
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 12:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhF1KlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 06:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhF1KlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 06:41:10 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D662BC061768
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 03:38:43 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n23so11103182wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 03:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0qFQ3U6jsg6qIs7KhbJBNtk6J/Y0oCVBp71I54LXLBM=;
        b=zrbX05ANKJVsOPOZiX2DLCZgzOucc2vNcD5mDLD0rtzXhqPL4j9jXZorortgjgwEOu
         Xmt3ndzxMzAL56ksiYw5gR9v+dDSg0+eih1BD7Dk9QQBrKCNyno4xyVKoDEJNZiLbQPm
         BsPb19xHJVxibC+rc3Bv+zUrFq9r5Iky8VjEs7pr6I4hDlLIINaMfxKax8Kgni49mLT5
         DLRGdH2523pzID0flvfDQQ/8JzCd2uDHMw6S8Ja8Z10hkgr5SZPFrhBUKjxtZdUJj/pD
         jLbGsaOl9YqcdTWLSkepmPO1o5fqU8ZZx6gt6PQ7vQWMEq6AEbNBDV2tRNKbIo/IwbJ9
         iemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0qFQ3U6jsg6qIs7KhbJBNtk6J/Y0oCVBp71I54LXLBM=;
        b=QhKwSK3AQRnaE4TXjwMoK1fiC/tAnT4n4dsAlHo6Vil3vYX5Mpt5TJnnVbngdXt+N/
         tJgUVbagk12HJgRcchBLYPlEOVxOtpODFWwlTR5XtfDgLDsvVKyG66/vvO13ibMaO3eA
         d0oQkkJX/kLZHF9/ALrJsXDu3BQJizCCq4wIQji7Zfbqc8GC/AhR338UqJGBHpZSS7DY
         1ObrERcgkjTeYv65WazC668/w3zENo9yHdFAUFnO6OhsOvDe91WIR1r8YtJRw5aMXJ4/
         WOWgREETj7qhMnyVzxNWMhUEkCuRmrzSyFEvc5ILm8Vo4dfg/nb2BLFvudTg8kO6Ilqy
         wkxQ==
X-Gm-Message-State: AOAM5327LABsSnB2CmtA0FIzdYpCf6QDkJAWQm8vY09h4B3V5jTHAiY7
        HEW9NRhsIBMUrPIvA4g9Ecq7nw==
X-Google-Smtp-Source: ABdhPJwLTkAQajwpkj6Z7Owjep39/6h4h6Ogd+7eakE6TPJFQqHxWWueTSFRYMTddDjl8IJxeyRA9w==
X-Received: by 2002:a05:600c:224a:: with SMTP id a10mr26172573wmm.154.1624876722454;
        Mon, 28 Jun 2021 03:38:42 -0700 (PDT)
Received: from dell ([95.144.13.187])
        by smtp.gmail.com with ESMTPSA id h206sm18855813wmh.33.2021.06.28.03.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 03:38:42 -0700 (PDT)
Date:   Mon, 28 Jun 2021 11:38:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH mfd v3] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Message-ID: <YNmmsON7qP5+yjqp@dell>
References: <1624034232-7952-1-git-send-email-min.li.xe@renesas.com>
 <OS3PR01MB659309124542B0D712FC9DEBBA069@OS3PR01MB6593.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3PR01MB659309124542B0D712FC9DEBBA069@OS3PR01MB6593.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021, Min Li wrote:

> Hi Lee
> 
> This is Min. I am wondering if you have had a chance to review my latest patch?

Please don't nag.

You should provide at least 2 weeks for someone to review.

After 2 weeks has elapsed, you may consider a [RESEND].

As it happens, your patch is in the queue and will be reviewed
shortly.  Although this time has now been extended since you just
pushed it to the back of the queue (patches are reviewed in
chronological order by the date they were last updated).

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
