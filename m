Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116D33E1567
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 15:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241637AbhHENLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 09:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbhHENLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 09:11:50 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1466BC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 06:11:36 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so3669484wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 06:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=q0Y9EJOlDnNb/+I39cpASpqd6Fuefl2cgQJXE7mywug=;
        b=DYr5glB8RCCFOi01femBA2bpOwEtgJWAOHgftx4YlFHK8+ruZM5GIl+deaDlfgIKLM
         ewKw+ODYhOaV8hJNtCeRukUNdWrtfPZOOmUEyLLyNzgAe1ppF5LqcmfZB1vbb5oy5YYO
         1BfhrS5rClYe3dqLaxmXTDX8dz+yeOUPwDENJ6PvMRFkCMwwy1MM8B4wW9AG+URRVnh4
         2v4zUqUxtoEd5kqI37PFEKnVh7IOZoaBiBNreP+Ug34BJGovWP3QR+pdOwATROVn1Ca1
         FW2Ub+lu/jIMFwOdONAb/u6M5EgpQFQ9XQil0V5QSvnetH78pXzXhmS4cilRDmijdMF/
         qdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=q0Y9EJOlDnNb/+I39cpASpqd6Fuefl2cgQJXE7mywug=;
        b=I30asyc0EbRvA0WH5+d5a5nTBEvLrNkENtaeOWz49z8YJctW56vR6oUG4R771qI8oO
         DR5iOFkwOmv1/1a7j+0eysuBA6NQLCihBhwr/8zENxX9+EFsUEfevrEe5wNFY80z6l94
         KwJXqiRIWlCbhVv+oB+YlRy+66QmpUoqMbMCTLNe8fb5SO2AT4Z5oa6m2Txk8GXGQb+/
         l1qT4eU7x+xMZFwrGl3v4yY3X3Owo7uf6nevMnFZpda9mXjhHy3MVa9UqJquIpp3rERi
         6mnZlhU2VgGEjh6nAJ7N9Qvn41iYRFA5qVD5kSaJLGDKUqHdp1lC9GPusWklqSZgzUjO
         n4zw==
X-Gm-Message-State: AOAM532xLSOXsMNBALsCtMi/SNLBU9w/DOn084qxJzXFKcjOkdJHXzps
        oI5GGrZYItsKxqKPjdYVpFeFqg==
X-Google-Smtp-Source: ABdhPJz65oYHYRNnnIeKu0HkFdOtB2lwysomHE1VVtDlpUi42R3sguTZkl0FwOR5s0ALMSyb3C+TRg==
X-Received: by 2002:a05:600c:293:: with SMTP id 19mr4885103wmk.179.1628169094747;
        Thu, 05 Aug 2021 06:11:34 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id p2sm6441721wrr.21.2021.08.05.06.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 06:11:34 -0700 (PDT)
Date:   Thu, 5 Aug 2021 14:11:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, C++ / GCC <cpp@gcc.lt>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: axp20x: Add supplied-from property to
 axp288_fuel_gauge cell
Message-ID: <YQvjhKmGU/HdPmgw@google.com>
References: <20210717162528.272797-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210717162528.272797-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jul 2021, Hans de Goede wrote:

> The power-supply framework has the notion of one power-supply device
> being supplied by another. A typical example of this is a charger
> charging a battery.
> 
> A tablet getting plugged in to charge (or plugged out) only results in
> events seen by the axp288_charger device / MFD cell. Which means that
> a change udev-event only gets send for the charger power-supply class
> device, not for the battery (the axp288_fuel_gauge device).
> 
> The axp288_fuel_gauge does have an external_power_change'd callback
> which will generate a change udev-event when called. But before this
> commit this never got called because the power-supply core only calls
> this when a power-supply class device's supplier changes and the
> supplier link from axp288_charger to axp288_fuel_gauge was missing.
> 
> Add a "supplied-from" property to axp288_fuel_gauge cell, pointing
> to the "axp288_charger" power-supply class device, so that the
> axp288_fuel_gauge's external_power_change'd callback gets called on
> axp288_charger state changes.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/axp20x.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
