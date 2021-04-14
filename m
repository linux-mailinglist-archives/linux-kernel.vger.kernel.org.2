Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0623A35EF4E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349983AbhDNIOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349976AbhDNIO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:14:29 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA72C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:14:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z1so22593834edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=60MgZkgdupIaq4FjE6yGCb3EuEbMNyi/9UEBc0w0nvM=;
        b=H96J3fXR0tGnZfOtZM2BuIKNda6VczXUgKYfOdRvfQe+lEge5tZpP2SaCBEuqxA3rT
         R0uIfxI6va1nia/Zv5/8OmjRzApNQY+7AdGpjdLMDe+SBbUdKu6sysOf008B6PBfA6Ua
         Zv500YeaTJ+onlB8bARq+fRHM5UZ5VTr9M+7u0gmR+J+SumG7sgJqgAJ/09+Ezr02tYy
         35W6wvDG0z3KnuKQCxCWPd4abtj4CIJtmmAkJ7qP3RWa+mg5cMeFIkDlno/Vvg22SXoQ
         l+nYWsWZh79AwcyBRRD1aAnWRdsxBQP2bEWtnNFCsZGBE7kmS1la82AqsbN3s0rjZXO7
         VnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=60MgZkgdupIaq4FjE6yGCb3EuEbMNyi/9UEBc0w0nvM=;
        b=M53N+9y7hjJEXk/cQuiS0gmhb/dK1IJXC+grOug1uRuwqvheuRz55ECucpcFG4Zw/d
         TYEhYtoSdSX/ud3KdZy8Wl3GUM08pqMPEuPYQOl4kbOpKiA8VX/L3ttV+hMVXajGTmao
         VOQZGLNf3XkMi5PZqTZpOUWpYXvK+zFKBkyxv4YCXmz/alQgFrn+lU9N6YDBhkRyDihE
         NheVPD56k8vrS1631oJncz0A6kJkRrVn4QeLaCX6U3FPH1BnUSSq2Sk9HovE46FlmGat
         57kYF90d/ibeRV24CCKdhHW1e0g3aSUEebC5Vrr6z3ETm/Bbri+nzFEMryOHLj97RCCR
         lScQ==
X-Gm-Message-State: AOAM533F70NqRmf2qKPcXI/6hyYyghzXft+3Btjlg3Y/M1v2DxRECGDd
        QRgNGLip0PNBbVpzm2Vo5bhWfQ==
X-Google-Smtp-Source: ABdhPJz/W4uA9Mok7bPfdy6oPcWnQcZgojvLSJtHh2dDav1IjtMz1LGIHMZCfkf6m9sXzwtxHqJnLg==
X-Received: by 2002:a05:6402:94b:: with SMTP id h11mr33648969edz.180.1618388045582;
        Wed, 14 Apr 2021 01:14:05 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id e12sm11240556edv.11.2021.04.14.01.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 01:14:05 -0700 (PDT)
Date:   Wed, 14 Apr 2021 09:14:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 2/2] i2c: designware: Get rid of legacy platform data
Message-ID: <20210414081403.GD4869@dell>
References: <20210331154851.8456-1-andriy.shevchenko@linux.intel.com>
 <20210331154851.8456-3-andriy.shevchenko@linux.intel.com>
 <20210406104927.GA3532@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210406104927.GA3532@ninjato>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Apr 2021, Wolfram Sang wrote:

> On Wed, Mar 31, 2021 at 06:48:51PM +0300, Andy Shevchenko wrote:
> > Platform data is a legacy interface to supply device properties
> > to the driver. In this case we don't have anymore in-kernel users
> > for it. Just remove it for good.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Wolfram Sang <wsa@kernel.org>

Do you require an immutable branch?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
