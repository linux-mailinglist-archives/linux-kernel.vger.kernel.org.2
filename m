Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A8E3212F6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhBVJWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhBVJV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:21:58 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85806C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:21:17 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id n4so18281216wrx.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Vb5b+CkV0wy9KJRTZwAevRcpVkwdWb7PHcO+BJh4EIs=;
        b=pbzfKEpYbWtiCY1GbLMNqqn6+IPgm3x7BxAqtU9PY6beWBfK7Dkv6vxLZlrTZOKlYU
         1v9Ia2oNDds8tHYwnhV5dgdfXLMyVxfxw7SxaDSjI4baRWu/cK/HNwqHVbxdEhqmnx3i
         VnjKLWjsSAJjj4eH88Pep89P7RNgFbSARyBDjy0VU7gESJy2Z+VHrQ436tB4eb1mUawN
         mn60yUbYzXjfutptek4dF/4tQbWS12QKjmuxUyaUACghfs94k0EnLAKIFWKqNBBPwz+z
         PppYQE4OcfAw1dqG+7p+1bmR/GHQMGoh5KNS9QgDTgKH9SESnD6DLudwhXiR1DXzBSXy
         bxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Vb5b+CkV0wy9KJRTZwAevRcpVkwdWb7PHcO+BJh4EIs=;
        b=OuXDNrD+lGvUxZOvZQKYqt5uJ32eKYmjQxbb5t9qJ4JnXlkUjFN8Fl56FXsHugUSlu
         s8yvvCsSQPXk8x2O8YdquglZtelxalQSp+oVfGGBA/Gf/HONxN2frU/FC4jVhlwpTJ+X
         hjyzpZXlqlFSTYCLN4VKSuK/UrXbJYEI9dYEKL1fBZFRtflCJsI5co/CMCRlZhZ9qu16
         e2/LYTo7ZOAgbOJ6vX1rTdqcu4AWQbEx16dueT6zikj45WXNHt1r891lWgFQZU9vRS68
         J/M4v141dCjyMv4ss84als2G3F81fRl04Y08IGo6nCdqDlTJE5FHufs/BxFXWoF3ephl
         NX0A==
X-Gm-Message-State: AOAM5304qfJVx0gHgc4hQMOtxNb8c0aOo2OIyDaHhfocpAUrT92lVHIZ
        VjbH21D40+06pHHRy143/jKBlw==
X-Google-Smtp-Source: ABdhPJxOxDC5j75cbFDb+qWQyxlbBD/HryvZ2mzxb6Jqj4w9IdAy6kpy9+09ctZ45O8lnxorA8JVSA==
X-Received: by 2002:adf:f192:: with SMTP id h18mr21068624wro.340.1613985676226;
        Mon, 22 Feb 2021 01:21:16 -0800 (PST)
Received: from dell ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id c133sm15966566wme.46.2021.02.22.01.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 01:21:15 -0800 (PST)
Date:   Mon, 22 Feb 2021 09:21:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     "Li, Meng" <Meng.Li@windriver.com>, linux-kernel@vger.kernel.org,
        arnd@arndb.de, "Hao, Kexin" <Kexin.Hao@windriver.com>
Subject: Re: [v2][PATCH] Revert "mfd: syscon: Don't free allocated name for
 regmap_config"
Message-ID: <20210222092114.GE376568@dell>
References: <20210115015050.26657-1-meng.li@windriver.com>
 <CO1PR11MB48497CB7B11EDA65A3941FDCF1819@CO1PR11MB4849.namprd11.prod.outlook.com>
 <36cc2d810d90237947ad953ebd6b9fb7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36cc2d810d90237947ad953ebd6b9fb7@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Feb 2021, Marc Zyngier wrote:

> Hi Limeng,
> 
> On 2021-02-22 03:45, Li, Meng wrote:
> > Hi Marc&Lee,
> > 
> > Is there any comment on this patch?
> > Could you please help to review this patch so that I can improve it if
> > it still has weakness?
> 
> If you are confident that the root issue has been fixed, no objection
> from me, but I'm not in a position to test it at the moment (the board
> I found the problem on is in a bit of a state).

I'm not keen on flip-flopping this patch in and out of the kernel.
Someone really needs to spend some time to map out the full life-cycle
and propose a (possibly cross-subsystem) solution.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
