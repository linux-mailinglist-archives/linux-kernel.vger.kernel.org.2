Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9597840F640
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 12:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241553AbhIQKwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 06:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241640AbhIQKwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:52:15 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227B4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 03:50:54 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 72so4314779qkk.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 03:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lr/rxe0F4pP7z7/1Nek4bY/iz1JjEH11EDO8B9nTHfU=;
        b=fsLpa3dW9LHO7KjhUNgNE2SAnBDyCfbLO5DapWvDF8qq7DEA1gX+CGGOHJHHrrBsR8
         NnnHjsji5N3abSxNMbLhCHqQY9jbCQupaDalIuA68QgN0+Cr6z7M/J3oob//yVrl30NY
         BaVmXYsUPEB6HmzEphgaM8Ox66YZHim1IS0kScnokljDcIceyBn5zCitlmSe9hwZaHEz
         daNxGvo3jfgguSea8cowyxwogeyEwNXedMEZuf/uET54E6XVPQqOwHn7NBdWjoaxIyBK
         7bNCn6XGVmNRz8pTgOVkzqPWZaYF/oZq9Yml9yE9eNY0/c8VdNnt3t7H0B8U0g3U3h3S
         gFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lr/rxe0F4pP7z7/1Nek4bY/iz1JjEH11EDO8B9nTHfU=;
        b=UCIsco5HlOZYagIAClGKzVGWSqfqAm8oIhFoZGfBkTTq9j1Iz6nprFOiTonR0mDw18
         2MYNXHOrVeLgYAC2f/aMMkVBNtrjdodsEuaO3/kLefbXds+pLRqgSIOxnRyztkjGfcRU
         WpUwH9VLJsQCWNM0q9VSO613jEx4I/Kn/HABKyjar9ADi3hQB6mBEhk5NbJpsKcFD/dE
         jaXoJH8ha1FyvB8Qg+wJqhGOho4LR/72GWyVlvRokOR1BJMCDZLWIr5GgxEzHDHzhEcu
         aLuH5scmSTIL0Fj+aBWDqr8/K76BJNHO8jpT2fyjQtN58bXqzWmRYcNG0c9FzCrkXTVa
         y6Sw==
X-Gm-Message-State: AOAM531o6wTB9WyPsAVaUd6MUZ0VkF4zFW3BLa3MmaxudYJfRUOXNo0+
        xdXq/kBC4puPpYBFNfBnHjM=
X-Google-Smtp-Source: ABdhPJwImGd1QblVTK6YLe7DTUbEBnlgRTgZUMS89QTl704Xh+3B8SU6mZoipO0ozRfWMpI3nNM8TQ==
X-Received: by 2002:a05:620a:11ab:: with SMTP id c11mr9825812qkk.169.1631875853341;
        Fri, 17 Sep 2021 03:50:53 -0700 (PDT)
Received: from localhost.localdomain ([181.23.76.84])
        by smtp.gmail.com with ESMTPSA id x19sm4380072qkm.115.2021.09.17.03.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 03:50:52 -0700 (PDT)
Date:   Fri, 17 Sep 2021 07:50:33 -0300
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        nsaenz@kernel.org, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: Re: [PATCH 1/7] staging: vchiq_arm: cleanup code alignment issues
Message-ID: <YURy+YwGwAVola65@localhost.localdomain>
References: <20210915201824.413202-1-gascoar@gmail.com>
 <025d76f9-69ca-ee12-cc98-023a2ac2714d@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <025d76f9-69ca-ee12-cc98-023a2ac2714d@i2se.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Thu, Sep 16, 2021 at 12:54:20PM +0200, Stefan Wahren wrote:
> Hi Gaston,
> 
> Am 15.09.21 um 22:18 schrieb Gaston Gonzalez:
> > Fix code alignment issues.
> >
> > Reported by checkpatch.pl
> >
> > Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
> 
> please:
> 
> - use a version for your patch series
> - add a cover letter with version changes
> - try to give reviewers more time before sending a new version
> - try to avoid multiple patch series for the same driver at the same time
> 

Sure, will do. In fact, I was hesitant about some of the points you
listed.

Sorry for the noise.

Regards,

Gaston

> Regards
> 
> 
