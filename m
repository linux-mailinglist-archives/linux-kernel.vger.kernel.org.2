Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698DD3C6BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 10:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhGMIcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 04:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbhGMIcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:32:10 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C702EC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 01:29:19 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso985229wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 01:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xieffztHkV5e79jyylIUwqsO9VKzBiHxHox6Y9x+984=;
        b=LKxPwjk0zu9uRPyniQluW8WgC4JP5v2yH7NkBrvSlNrjZm62xbSpawwJ2Zf9z2ilLk
         tcdVSWjSvRMUp9E/xxNTgMmpLkq/Tm81vMkgfgufVRf8mJmtO3HxCuf4mb6s+cyzWRmB
         Wjo/v79w6rpbJ2nihr4uK0kL5JGkG96d1U5H+a3IRI2FTbLQh7DQoz3M/HIc/cWy+LBZ
         ZU7IFVN5uDS+397xdHk6DcawZBnB+2cAmpkQ3L8VvVB/ksbCiLoNSmrZYJWeOGmhkcXO
         c1YpQ1ntbf0D64+cW/fb8ZvYizlA7YRLxHJ3h3py3XrvGS0NMzienj0L4gWC358UCZfG
         XmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xieffztHkV5e79jyylIUwqsO9VKzBiHxHox6Y9x+984=;
        b=NgvRSVoYDUgKSwTm/N41oZR55mCcFn4w74VUySDQ9/6CE5FFBOAW33U0UohasAlFia
         oDuD2kwa2TaEilUN/jli8XQq9Fbc9c5xDvy6K8YzhxqZztRaInVr/KJLqAKyjTTOMfFx
         EURjj08NXoACP1hedCxWSRgcqlu6AVcrGIpjcRtx5zjqdT86WitflDcGGGFje93yQuxZ
         EdWhs5Ojl805n7UsUytpWSLX/bm0vFf/1ppcnKTTIxYtJYJNbz4I9fL5jIzYifEv9bWR
         iIt6lUyBqUWTr6IgDb58zD2E2yYJz6/r2eDYcbuK/xDJ34xE4Ebyp2DmkqQEYj26/O1C
         CL6g==
X-Gm-Message-State: AOAM532wkF6hW4opAksy6hX+EvkYWd4Uxt3ZFaa5K+MZjSexV2tkGNNL
        +3DpieisffGSu5uv01BaEoI4gg==
X-Google-Smtp-Source: ABdhPJwXg4CkCcReKee2rDJUj5zQPl/pOA2uxMoZTGzQ9CNjyHiAtuPdVrppU7LBUE47XjJC+TfIoA==
X-Received: by 2002:a05:600c:22d8:: with SMTP id 24mr1414998wmg.157.1626164958467;
        Tue, 13 Jul 2021 01:29:18 -0700 (PDT)
Received: from google.com ([109.180.115.218])
        by smtp.gmail.com with ESMTPSA id c2sm12962289wrn.28.2021.07.13.01.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 01:29:17 -0700 (PDT)
Date:   Tue, 13 Jul 2021 09:29:15 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Add Intel Cannon Lake ACPI IDs
Message-ID: <YO1O26AoI++63N7e@google.com>
References: <20210603165128.46586-1-andriy.shevchenko@linux.intel.com>
 <YOxFDhovXXO1Z1nl@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YOxFDhovXXO1Z1nl@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2021, Andy Shevchenko wrote:

> On Thu, Jun 03, 2021 at 07:51:28PM +0300, Andy Shevchenko wrote:
> > Some of the machines, like Dell Precision 3630,
> > may expose LPSS devices via ACPI.
> > 
> > Add their IDs to the list.
> 
> Lee, isn't this forgotten?

I am clearing my inbox today.  Please stand-by.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
