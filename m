Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B7A354F9B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244793AbhDFJLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240715AbhDFJLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:11:38 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EEDC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 02:11:30 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k128so6981485wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 02:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dkstBULZQtDUbA+Mw8ppM5llptybXO1REdfMIsOsnrw=;
        b=V9DDoKVRspFTlUZZyd6nGrTgX1Ob+8MzUMVKcN7USCLNMd2T4SRiuhmptCiaxHmnzS
         aXwLHXWiRHq7TYEa3MaIwOHCMwJITMTXgc7aHpqOaN75wVbGZBRqSl8IYbycoOHd79CK
         7YVdsh5qUU4XsWvog8hZTD2zi2bVpgZxi/cBtC+KoxddyZY/b1zBxxTtZTqQeBtSllb4
         P15aq9tDBo3aBBcdrkq6+e0GyBCwWVoS2ceCE2gJpXhWN25hBbFQDHNGZo3YSHnlKhgn
         iHMm3CjKJAs6XDrs5HtBedf2OwtW6TjasPud2oyQcb4EnmAPjLIWnYKqBjM2y0tInYvY
         k2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dkstBULZQtDUbA+Mw8ppM5llptybXO1REdfMIsOsnrw=;
        b=gFkYY9cPlpVRLAAPbS1Ixodz9uFobm/YLs0UoiR/FtzbdbD58GRNC76YTQIHf7ee0y
         OrrsdqDHiByApkxeBmi5QwbHtcxtRtHHdYh7aVujHNtolFx+AgAWoTKZAnx6SL+P3tHN
         r4vT7oRIb1pbFtjQX84EgdPn82GqN9PgttnO3OX6N5zwkKxezOaWd0eXLVg8emrVLojy
         OCjgyte/jeuFeGsuHjNL32ZAcgoKyfD4k/kS+krf8xUyIEbXTxKApr8dd25d+QQ6Xjfb
         B8rAuF6JKwIJLW6ubImKYjeI/ScQE75i31nQQxrcGpaMgn1QuAJhpXfehfNdMgbirDRi
         iZfw==
X-Gm-Message-State: AOAM530CpVeSg8kRQm9xClGdue9CgFyerJsh6NRq99Fxo0l79uG3ysNw
        YZf1/DUzatxcoipw7rwgJlSHzhMB3Y7uHV3S
X-Google-Smtp-Source: ABdhPJz7ZvZHwz5g7uaqnq+HtHaLVth2jpVHSveDhM+2tFBS5D1VVPXeqyRZYdPnm4iITFPwbp6XJA==
X-Received: by 2002:a1c:9853:: with SMTP id a80mr1910144wme.44.1617700288552;
        Tue, 06 Apr 2021 02:11:28 -0700 (PDT)
Received: from dell ([91.110.221.193])
        by smtp.gmail.com with ESMTPSA id p17sm2052687wmg.5.2021.04.06.02.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 02:11:28 -0700 (PDT)
Date:   Tue, 6 Apr 2021 10:11:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com
Subject: Re: [PATCH 00/18] Rid W=1 warnings from GFS2
Message-ID: <20210406091126.GT2916463@dell>
References: <20210326091151.311647-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210326091151.311647-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2021, Lee Jones wrote:

> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> Lee Jones (18):
>   fs: gfs2: dir: Finish off mostly complete headers demote others
>   fs: gfs2: xattr: Help out some kernel-doc header demote non-conformant
>     ones
>   fs: gfs2: bmap: Demote half-complete kernel-doc headers fix others
>   fs: gfs2: glops: Fix a couple of kernel-doc misdemeanours demote
>     others
>   fs: gfs2: log: Fix a couple of param descriptions and demote
>     non-conformant headers
>   fs: gfs2: lops: Help out worthy kernel-doc headers and demote others
>   fs: gfs2: glock: Fix some deficient kernel-doc headers and demote
>     non-conformant ones
>   fs: gfs2: aops: Fix a little potential doc-rot
>   fs: gfs2: meta_io: Add missing description for 'rahead' param
>   fs: gfs2: inode: Fix worthy function headers demote others
>   fs: gfs2: file: Strip out superflouous param description and demote
>     kernel-doc abuse
>   fs: gfs2: ops_fstype: Fix a little doc-rot
>   fs: gfs2: quota: Fix incorrect param name in 'gfs2_quotad'
>   fs: gfs2: rgrp: Fix a few kernel-doc misdemeanours
>   fs: gfs2: recovery: Provide missing param descriptions and remove one
>     other
>   fs: gfs2: super: Fix kernel-doc issues where feasible demote one other
>   fs: gfs2: util: Fix one conformant kernel-doc header and demote a
>     bunch of abuses
>   fs: gfs2: lock_dlm: Demote incomplete kernel-doc header

These have been on the list for a couple of weeks now.
  
Is there anything I can do to help expedite their merge?
  
I'm concerned since -rc6 has just been released.

--
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
