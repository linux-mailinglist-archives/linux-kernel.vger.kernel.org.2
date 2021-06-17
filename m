Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CDF3AB265
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhFQLYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhFQLYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:24:17 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70101C061574;
        Thu, 17 Jun 2021 04:22:09 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id a26so6111765oie.11;
        Thu, 17 Jun 2021 04:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+3INCVEV276y9PyA28A8dmPdbjmiUIA+NCZCOMh4VJU=;
        b=dxppriilotvgpOIvCBUwYvvBzHvCpCt6rbgIiMiMA1L/SUisF582YYswPTFmgfHmli
         jHqTRTFdHTl9+plwaGBtcbiYs8GaQu8Ix9Ah9oPZKDFOZPvi3d4tu6LTqj5qZQb5qZd6
         WDWz1+ON627eFCdgwKelu+0zWgTKUbUAx1Jq85WKczsbhQsdN7z5X6QwiTyeUQ+DquNH
         bSQ9uEgYRycIftJV1JoFQOTU5r8wuXOyWLImXZiUVDOMQxMKdJ1S6IGkOfSfGmSscbav
         3xUUWyAU1glVsLMvcqNZsuP5I41QbtiPFVtTF/6sCD/vDqrF1ZKotp9tSFeVAU3r1zq7
         RB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+3INCVEV276y9PyA28A8dmPdbjmiUIA+NCZCOMh4VJU=;
        b=Ox4CQrxMfg2IBEhSAWVTmqFOO49qV2RQdpmQfWyi4UFjaXzcrHyzpxkKsJp7vWrWpa
         k0rQ2LHk6cJr2/a/j5sLPU57ofsbcNWUEKdrbV9H33cY+LX23G2nl2uGdYKGSMfk6E0u
         7SIq61HBL1afBpLffTSyIkHocu0PO1UkMaNn9mhTOuCWCH8ZLTFslpwWPKJTZcx2EhSR
         Fh5B1F30s52v6RDKiGTAIjGgZgSXe3ggzMYLc8BT7OjhRPe62/LxWpu717jVI9yafLiN
         IebTY7UdXyo+w1RXyx1OYNKjvISj1+DfwhczYV5dasvz4IeXpFtjywDFzvqGz4oPo/lz
         53Kg==
X-Gm-Message-State: AOAM531uTda95QBI34DpFS7z1+oGJ8Vqyr/3BooiaPn/fXA2JRWONMJx
        9BntnLJDHSvihekgx29AnZgkuqO+Hms=
X-Google-Smtp-Source: ABdhPJyK3QYjvaCP1vsxfIQEMshEMcUMjDN+Duju+wGyTtIUciWBpC0u631zZd1dHoPjaRgdVM5+lw==
X-Received: by 2002:aca:a9c3:: with SMTP id s186mr2908200oie.103.1623928928873;
        Thu, 17 Jun 2021 04:22:08 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w17sm1038513oif.44.2021.06.17.04.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:22:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 17 Jun 2021 04:22:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus/bpa-rs600): Handle Vin readings >= 256V
Message-ID: <20210617112206.GA1579582@roeck-us.net>
References: <20210616034218.25821-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616034218.25821-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 03:42:18PM +1200, Chris Packham wrote:
> The BPA-RS600 doesn't follow the PMBus spec for linear data.
> Specifically it treats the mantissa as an unsigned 11-bit value instead
> of a two's complement 11-bit value. At this point it's unclear whether
> this only affects Vin or if Pin/Pout1 are affected as well. Erring on
> the side of caution only Vin is dealt with here.
> 
> Fixes: 15b2703e5e02 ("hwmon: (pmbus) Add driver for BluTek BPA-RS600")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied.

Thanks,
Guenter
