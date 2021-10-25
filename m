Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C5A439862
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbhJYOXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbhJYOXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:23:38 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69788C061746
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:21:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 62-20020a1c0241000000b0032ca21cffeeso145750wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=M2t/ljyMrSuXJkPKEqRg6rIEcIkhDvv9y02qHL6/vSA=;
        b=HnJfizDONe/3Ah4LArAtk4rNpri4e/nd+R022uQwk6uOK/euQFILctLpRi0WoJC+Rv
         akNDcgmWu3b0WFc814xw9EFbPyGunTCw34CqooWBboOE2KGXGPEkaPE3dgHFnBQ37h9K
         CsB0DyUz4zdOv96Ah7h7TdpDr0RlVkMhLsXgPFVjeVsGIxEZ6qi8TcIDyp9lAIGdkoxQ
         ZpX9LrM5qHGPjLVL+U5nssVoJ24QfpGMJvvwp6UTAdyJwdAk/+cJ6hCLb9OR4SuoBIn4
         uBCjWggLsLNpLi/5rpTRH+vNBuE+Pl5d9gdVEo/RzOaxcjJLb8c80XcUofkTIQ6kjwwV
         BuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=M2t/ljyMrSuXJkPKEqRg6rIEcIkhDvv9y02qHL6/vSA=;
        b=ISfXgMrLtRXFq/fE4nuU5EBP+CBmvLwbjxUu2XlrJz9WFDaZHvkU0qG9exPEfsmbcK
         lrDX0iFyHe/OGJbISXR5OQ2S3hd+B8icX3i4/ZgINkKcScc2yDkm+ecc58+2peaGba7/
         4waOnyxUjWTZcmdRqG6dXQEzofzo+jqqQdzIolhYRYGEN279fBooqUIS1ZF4t4jEq9GL
         nyiw2XmX86c8sMHm11DNogyxegMfBFsK7cGJnHspXxojUcE6pTWoxQllN1TXZ6rssaox
         D4BSGs37mIGveNtOTe6neMq1K8bxKHW3oIZ3SMHCyvsnD5l8uNd7GpuCUPikDFOrenVU
         Qgjg==
X-Gm-Message-State: AOAM533P+4R9IWzz2bwMyI3bnXQiKE73E3kMkDfCllzBkT8QPsf0g4et
        MgVjYlFRCV9qf0tN9pBI2Em6UhgIEW2VtA==
X-Google-Smtp-Source: ABdhPJxZdvPCuvpV6tREqY0nQE+UB8Cnxc1p8PDS1uJcZgD/pQ7VS7MzXqg1nnKjYeohcPySiJe9iw==
X-Received: by 2002:a1c:4d08:: with SMTP id o8mr17787192wmh.35.1635171674960;
        Mon, 25 Oct 2021 07:21:14 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id u2sm15907155wrr.35.2021.10.25.07.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:21:14 -0700 (PDT)
Date:   Mon, 25 Oct 2021 16:21:12 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mjpeg-users@lists.sourceforge.net
Subject: Re: [PATCH v2 00/10] staging: media: zoran: fusion in one module
Message-ID: <YXa9WGs7ewyaHmI9@Red>
References: <20211013185812.590931-1-clabbe@baylibre.com>
 <da925d73-fdf0-3962-3841-a1dd53b5c5dd@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da925d73-fdf0-3962-3841-a1dd53b5c5dd@xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Oct 25, 2021 at 02:45:02PM +0200, Hans Verkuil a écrit :
> Hi Corentin,
> 
> On 13/10/2021 20:58, Corentin Labbe wrote:
> > Hello
> > 
> > The main change of this serie is to fusion all zoran related modules in
> > one.
> > This fixes the load order problem when everything is built-in.
> > 
> > Regards
> > 
> > Changes since v1:
> > - add missing debugfs cleaning
> > - clean some remaining module_get/put functions which made impossible to
> >   remove the zoran module
> > - added the two latest patchs
> 
> Something weird is wrong with this series. I have a DC30, but loading this with:
> 
> modprobe zr36067 card=3
> 
> results in this error message in the kernel log:
> 
> [   58.645557] zr36067: module is from the staging directory, the quality is unknown, you have been warned.
> [   58.646658] zr36067 0000:03:00.0: Zoran MJPEG board driver version 0.10.1
> [   58.646793] zr36067 0000:03:00.0: Zoran ZR36057 (rev 1), irq: 18, memory: 0xf4000000
> [   58.648821] zr36067 0000:03:00.0: Initializing i2c bus...
> [   58.662420] vpx3220 22-0047: vpx3216b found @ 0x8e (DC30[0])
> [   58.737445] zr36067 0000:03:00.0: Fail to get encoder
> 
> This works before, so why this is now failing is not clear to me.
> 
> It does work with 'card=0', but I really have a DC30.
> 
> If I test with 'card=0' then the rmmod issue is now solved.

Everything normal, since card 0 does not have encoder.
Could you check that adv7175 is compiled ?

I got the same problem with my DC10+ where saa7110 was not compiled.
This issue was reproduced randomly and I have no explanation. (kconfig problem ?)

Regards
