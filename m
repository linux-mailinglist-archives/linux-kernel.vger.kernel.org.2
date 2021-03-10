Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320C93336F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 09:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhCJIHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 03:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhCJIHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 03:07:17 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2096AC06174A;
        Wed, 10 Mar 2021 00:07:17 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u16so22028603wrt.1;
        Wed, 10 Mar 2021 00:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=989sLPeJVZywzoU599JKsQdN+6rLaFH4XsPDO0CSh+Y=;
        b=dSsrkbN/kdm9I0B7Q2F8jB42nsBNt2zQbLwlojLJ/rFY62edKBWnSs40BpTjydu0ow
         p+RT5vEPrfm9oNb0gSEw4IZxIiKqCRDL2sqMR/VyiWHYZn/KK8YPS8B2+mrPXHPhIF8X
         f5v009sK8oBgTW1wf6r/iEl+jGOovingtBOCRSbKZ6vVFleowQNqKEiuAeOoUsif/+Yr
         XOQCuwXOLEfIyQjpUBKz4x6sG9jrZIrgjcc5eat5ahg9h409pi1WB4SftIOXXFmX6wXc
         nBRaxoWo0Q1nwYXIccWDYfCvoYcpC1jhcIo1bfRd36K/eL/s+MCqdfdq5umWLps2PR7U
         5U3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=989sLPeJVZywzoU599JKsQdN+6rLaFH4XsPDO0CSh+Y=;
        b=MNsBF68oojUFbInacTcPYZPYblhNvc/SjJ+sD/q+r2B5QHwZAqLQMnlHISqRHN8xv7
         KJZHTwi2EDGKEFbkigbf8GGA2MosfpvS40TSGF0GgF60YhpDjCbjPvio4ZivHJG00GyN
         s+JJgLzAdYeVGmlczMunZO6W2VUUvMB77XwqTTeKogJl9OVY2eO5q3attw2T9Z/grcoO
         PVEG/gaUjbNoRKqVx5gvkxGPt0oyLvj97q8g2NLnY0GHUQQWRjIOVnJLARZuACWYirEL
         3LyRfnj7DtSzBkXj0H7GQNqEKDRbU96W+iOMxXgpptdfOhIzSWX9TqRZKcRU5DZ+aJ9I
         LPfQ==
X-Gm-Message-State: AOAM530xlj1t9VJhcXUyf7kHYD4nNOgEyEoI+JggVmgQbCOYMYrQ87bU
        JJPISgH+9vR1wO8kBtxIctOkDjdOC0lJog==
X-Google-Smtp-Source: ABdhPJx+xj81IHc/WELy34cryxBgohHFmsQ8DcskRufLh56vTPC5XZZLoOo7ZDKKxHpQNk/W8lZ70g==
X-Received: by 2002:a5d:570c:: with SMTP id a12mr2125346wrv.209.1615363635829;
        Wed, 10 Mar 2021 00:07:15 -0800 (PST)
Received: from [93.173.65.134] (93-173-65-134.bb.netvision.net.il. [93.173.65.134])
        by smtp.gmail.com with ESMTPSA id s16sm28119381wru.91.2021.03.10.00.07.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 10 Mar 2021 00:07:15 -0800 (PST)
Message-ID: <60487E21.4090700@gmail.com>
Date:   Wed, 10 Mar 2021 10:06:57 +0200
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     kbuild@lists.01.org, gregkh@linuxfoundation.org, arnd@arndb.de,
        lkp@intel.com, kbuild-all@lists.01.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [kbuild] Re: [PATCH v3 1/2] char: xillybus: Move class-related
 functions to new xillybus_class.c
References: <20210309160326.GD21246@kadam>
In-Reply-To: <20210309160326.GD21246@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/21 18:03, Dan Carpenter wrote:
> url:https://github.com/0day-ci/linux/commits/eli-billauer-gmail-com/Submission-of-XillyUSB-driver/20210309-193645
> base:https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git   080951f99de1e483a9a48f34c079b634f2912a54
> config: x86_64-randconfig-m001-20210309 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot<lkp@intel.com>
> Reported-by: Dan Carpenter<dan.carpenter@oracle.com>
>
> smatch warnings:
> drivers/char/xillybus/xillybus_class.c:86 xillybus_init_chrdev() warn: ignoring unreachable code.
> drivers/char/xillybus/xillybus_class.c:96 xillybus_init_chrdev() warn: missing error code 'rc'
>    
Thanks a lot. I guess there's a patch v4 coming up.

Regards,
    Eli
