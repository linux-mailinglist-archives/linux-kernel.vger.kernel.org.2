Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77ACD3DB947
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 15:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238968AbhG3NX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 09:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhG3NX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 09:23:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB4EC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:23:53 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id f13so13098817edq.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7yIqlbzzWHcgJJGINkVM9iOtv5KFT5YtfSXEjGM3zdQ=;
        b=GmIHoPg5GNxIFdKM8f2Hqavm9fNVDcoosF/FBxC/SJiZLraDSjVEYaEnfG41S1mHpn
         uRMvirFIqMppcZaaryKRA1jP4Ob4z5odoCv3LCYVvlgI8JK5oVZ1WQVjq+Qv+FuPmE6/
         9dnUM9bVsl0RqVydsOwrZ+dVchkeUfj7i95EdQnlrL+0k2ekxwxlhglOWWD76gugEuDJ
         drdCugUB5KS/9t60pz/GsSbq4FPaTKV4MSc9IwTndkUAxFkF1cjgeBarwo8nL7j5rlgt
         t4LnX8G/WUI/4uWsLj1hLXwk46NW8J8mDWfYAKL6XbxSH7804+nTl/tuQfj6pbmtHJ3h
         Vmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7yIqlbzzWHcgJJGINkVM9iOtv5KFT5YtfSXEjGM3zdQ=;
        b=YqCPBh8V7/xzHWBUhn4gKmB9B4EhCMY88Yl7viCQeNkJQH2q1/vBcUYJEpOrhMQ4zK
         /ZCxPjRuCS1YUTMwrA+4D3k+Y+4Flj9nN9cNVzlM32Q+fEhylrmBAfyhnSyGQKiW2OlM
         ZMKBz/yRlSsy2CNqIrXhTEnOfJClbzyftxAaWSyv+pWxHaN9Mr6O9c3/qiJywwghr5h+
         yPL68Pnp7psbaeRdikugBAKquXMU4HLw1lLVq6iZ1tayqkKxJUtxmY0UmmkSKHkTn9Hk
         Jedkoytygf7EQmMzW200Q9jcC8VvGLbdBcTO2UjU23pGBJoAvP4bopNkL1zeLH3vvyVJ
         UaRQ==
X-Gm-Message-State: AOAM530s0jC7Dzuf/rRqHjiokFWFyKbE2BMPhuvEm6xHJ8QC6OJpxavv
        wgfYxoklvi9f85V+fir7AM4=
X-Google-Smtp-Source: ABdhPJwgcbCr+6m8bxDY6aJiF8lJWF6BfdZsm7/9qHmLOlerJYp6qqUIu4IAmsSxKSZOvVpzKZZ1lw==
X-Received: by 2002:a50:fe07:: with SMTP id f7mr2889158edt.334.1627651432361;
        Fri, 30 Jul 2021 06:23:52 -0700 (PDT)
Received: from agape.jhs ([5.171.81.215])
        by smtp.gmail.com with ESMTPSA id lj20sm558144ejb.40.2021.07.30.06.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:23:52 -0700 (PDT)
Date:   Fri, 30 Jul 2021 15:23:49 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] staging: rtl8723bs: remove unused BIT macros definitions
Message-ID: <20210730132349.GD1433@agape.jhs>
References: <20210730131903.4846-1-fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730131903.4846-1-fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

sorry, I missed the To: field, ignore this one.

Thank you,

fabio
