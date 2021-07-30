Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0BC3DB987
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 15:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbhG3Nmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 09:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhG3Nmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 09:42:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F66C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:42:43 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id qk33so16827175ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4mLRgm41sEwV+M8Z6i0AzGBmhntB7o9J7sCDyPkGJLQ=;
        b=JYSH94TaGr+ucvyYcPdbQZYuCyROUNDpOCakeX/np0ahBVWillGRvdlCIX/i7oY+Oq
         qYN5R7RfZhaseAhjaF2mUkWL2QHanjAHJcR3dZ9Yv4xea+R7LpeILHcNIawbgx5RCIes
         xwHn8a6xQBLX301HQRfHQiL5cWDD76r5l2l56ltnblEk7Z3uC7tkbWiyriAM/IHD3UQW
         Bf3YXaUOG9C8mZQmfpuoCgnQUeH8n7/w/MwjwjW7zz4j0zkYJE3eyU4jRULzzCPZAXOM
         WujWcL6bLRQRnDxkgyiMTBZ3vcHA5G25JlBqcgDrtnwTtgO3Y3LXC6FKnm11NoRAZwgS
         fVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4mLRgm41sEwV+M8Z6i0AzGBmhntB7o9J7sCDyPkGJLQ=;
        b=TCE7oCIgMw6gdXnQvZOH7agfB4DfM90p6ZrbNFudIhK3B2LNgc+7cN2eD4tWW1P2FD
         oDiotLBnqfH0MklEKRfCN7loMjl4A4dzssyUvTpXIjPDnvHL1zSQnKleJNkZX3rR03zj
         B9TA/9PW9TtDxCb+WbRdBVJRriO7pZOn4yinkAUXng4+bQBUKMWx73XncQn518VlSaG5
         bLQyUKI5XPeMGvrJ7hfNjYp6pfg1zbVpkVwkgMMyEzeAjDMntMpecNXmdzpxREsKR2VS
         5AMJsvlni9JRE6y8qO63ADTD9xmzT1g0oMVvWh6xDC1JcLkwkknxdykOzl/6NkAPjolB
         TFog==
X-Gm-Message-State: AOAM5321WYJ44A1AkyPTZA4GtTWJN5iMBLwIv5gHtaSmLNld4EQnUnTV
        B1wDPHQeeueJCW1+anGVrw8=
X-Google-Smtp-Source: ABdhPJyTCCqGqCaAYEuItSaV0fVQ/2Et/rGa2bahcW3mBCK/2G5vKda74wS0LTWnLG+prSFgO72W6Q==
X-Received: by 2002:a17:906:a08a:: with SMTP id q10mr2593710ejy.100.1627652562383;
        Fri, 30 Jul 2021 06:42:42 -0700 (PDT)
Received: from agape.jhs ([5.171.81.215])
        by smtp.gmail.com with ESMTPSA id gv7sm592776ejc.5.2021.07.30.06.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:42:42 -0700 (PDT)
Date:   Fri, 30 Jul 2021 15:42:39 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v2] staging: rtl8723bs: remove unused BIT macros
 definitions
Message-ID: <20210730134239.GF1433@agape.jhs>
References: <20210730133914.8625-1-fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730133914.8625-1-fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry again, please ignore this,

thank you,

fabio
