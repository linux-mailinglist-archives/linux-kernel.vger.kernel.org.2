Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8F1359BA0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbhDIKOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbhDIKFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:05:21 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85434C061764
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 03:02:26 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso2678158wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 03:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=G9eMvQrl27t+iFKMB16TuF7FG9RYyrlLPL5Wz4e3qD0=;
        b=SOiT4z31F5hC0PJjPs6fYpuLDslnwJHtYZunNlGvPCm1IO9qfQklXfebfvmjCm0XKv
         CCPMjo5/m2rcFetYZxQcwDAPEEsL782qLq2kIar3KawX+6guQ6PPMB6kGKhdlYejRVwh
         PXCH3GrJQDZ87S9BZt4/8AjUd0hXACg8UanVwSr69Kq6k27NcDhEFwL7x5lihEe+LBjJ
         TWH6U/aWDS8BKJUVH83jZI1XDebR87d8iE9a/lEw/V4P5dC5q0s9wFl641q2OlZS9nkY
         eS//rvK/URL7vL++L4DYkTjG+OZ4ydeqEVlEGGO4jOM6KtmOow/NjXeBbLi3id1lrmOl
         91NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=G9eMvQrl27t+iFKMB16TuF7FG9RYyrlLPL5Wz4e3qD0=;
        b=Yo0j5oGh0TkGBzv4bKnIsdmRiO3RZGusj+3EqXXwnnbYKoCQr2mXWEbFi3a9sqQthf
         ng48iDSfS4WuApwspc9JnNkNH8RuWu7CTtIyt1VtuC7Tljl0lnuyfTrfTaQkYL0cHQLg
         T3RviT2ZoxRay1nD2ip+++hCwKds7MuUdz6s1Ryuld0byHTaVRm34FfLDcICdcXywn7/
         62J4vuG09qFIExmEYSzvrG/fIjpwA/vXsKeeuK+Pfq+eq06uj2IOXHdwPtgO8CSCBmQp
         HQd8XKPViaPrlrXdXwNFu+8nNz9NDhIBGKsxrvlgstkogpPx+ftbyK2bGrxUhF9Lm2Ik
         AV0A==
X-Gm-Message-State: AOAM532PJ6HCBq/Si4c7jlRW+xYDKR/Vq97ZxVoerJSUbQL8RHp0emfM
        VaycpcsCkcRmn9WoA7EYEBK4xE+xbdb0Og==
X-Google-Smtp-Source: ABdhPJyLdkucuQCX3N5lz65FPzPVqwQZFotB7I+WQB/emKt4djby7LMtVZMjaeDTCfwqrbc43tMhPA==
X-Received: by 2002:a7b:c202:: with SMTP id x2mr8514936wmi.33.1617962545286;
        Fri, 09 Apr 2021 03:02:25 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id c2sm3143693wmr.22.2021.04.09.03.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 03:02:24 -0700 (PDT)
Date:   Fri, 9 Apr 2021 11:02:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] mfd: Add Renesas Synchronization
 Management Unit (SMU) support
Message-ID: <20210409100220.GE2961413@dell>
References: <1617846650-10058-1-git-send-email-min.li.xe@renesas.com>
 <20210408070809.GD2961413@dell>
 <OSBPR01MB4773DF588214D8B9E613E074BA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSBPR01MB4773DF588214D8B9E613E074BA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Apr 2021, Min Li wrote:

> > 
> > If this is v3, there should be a changelog here.
> > 
> Hi Lee
> 
> There is no change in v3 for MFD part of code, v3 is only for misc part. 
> But I have to format 2 patches together and that is why mfd part got v3 as well.
> But it is actually identical to v2

Then you need to mention that in the change log.

What changed from v1 => v2?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
