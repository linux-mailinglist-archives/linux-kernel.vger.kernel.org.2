Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733DB416D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 09:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244468AbhIXHqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 03:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244458AbhIXHq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 03:46:29 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E49CC061574;
        Fri, 24 Sep 2021 00:44:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t10so36775330lfd.8;
        Fri, 24 Sep 2021 00:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SGdLlRItT9HMu96BAD8a7OY3ZGKubujAFhPYgAErkms=;
        b=d6GUSAJsbjJc/qbMbnUyizAd9nEk60s0QaDgmzrBsR282R6g9c57nRxdDw/rVCLKUx
         oneJH04MhOiYPj8WV4e28g1HzwFUE1aAr/GRR8iIMT6RqKCeidkfSRGFwR2iJr/ZTF7V
         0MjjtAOp73B1NnWFUmwWg6P42M2/fl4DDy5zOhYcqZ46lbQmHAcPCcqs+K+f2DOEKj2r
         R4I3scbwxKgYJmdwiOyhREF0gEODIDGzjmeBQvcZ/DB9SoE/8AadkbhaQaMSVmSHBi8x
         O5kLVniSt741WyefIAQ0iu2BJUrh1QIsqGPuGqyChsBhZr/+5/67JS6/e6+ZcDbSalZ4
         50+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SGdLlRItT9HMu96BAD8a7OY3ZGKubujAFhPYgAErkms=;
        b=qG310KneyZUR3U79fRC2ikwXwpoBWEB8Z+DrhswHEcIbYcsD6Hk9wDrhyRbAJom3sU
         T2Zw6Zxr4S0Q8LP7Un/ThwBWnhUAZ2L54W3bNgZCETMvajna89AefdL34PWXOpYt6wm4
         MehRAy82h8/tVYUDVNEBuaSnaX8jzsR0cPGyhLvu5KhYv9esuaX+Ij7+OBasZL0lELvi
         5+OcHAIRyaSGhfQwSMKVlBzqU0awKy9MTux940sEf6VTcMhU9AA6CAzOCVmatGXS/OtA
         LEZEA2WudBeQAFom1qZ/0rkrntR/+YeDCoiN+3UpKr6ZCqcwilJugAy1Je0TtOeuweeE
         g5ig==
X-Gm-Message-State: AOAM532JIq0RmcblLKKt9KTeli4GokyxpRoqDOBsbU6BX1lv1jzO+4mc
        LaHitkr/JyZY3gamel4lRX8dtyN760I=
X-Google-Smtp-Source: ABdhPJyuO54rgCfKAPBtpJfgCZE3pjnkn//1Lj3fDNG0b7QopNcC4OIjrN3XB1EKIqxtl+7LgGJ7KA==
X-Received: by 2002:a05:6512:114c:: with SMTP id m12mr8141692lfg.4.1632469494760;
        Fri, 24 Sep 2021 00:44:54 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id s4sm833782ljp.115.2021.09.24.00.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 00:44:53 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 18O7ipBE025738;
        Fri, 24 Sep 2021 10:44:52 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 18O7ioYt025737;
        Fri, 24 Sep 2021 10:44:50 +0300
Date:   Fri, 24 Sep 2021 10:44:50 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] hwmon: tmp421: handle I2C errors
Message-ID: <20210924074450.GU23326@home.paul.comp>
References: <20210922155323.GA3205709@roeck-us.net>
 <20210923094801.23332-1-fercerpav@gmail.com>
 <20210924022020.GA3032273@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924022020.GA3032273@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guenter,

On Thu, Sep 23, 2021 at 07:20:20PM -0700, Guenter Roeck wrote:
> > --- a/drivers/hwmon/tmp421.c
> > +++ b/drivers/hwmon/tmp421.c
> > @@ -93,7 +93,7 @@ struct tmp421_data {
> >  	struct hwmon_channel_info temp_info;
> >  	const struct hwmon_channel_info *info[2];
> >  	struct hwmon_chip_info chip;
> > -	char valid;
> > +	bool valid;
> 
> This is a cleanup, not a bug fix, and it isn't even mentioned
> in the patch description.

For the bug fix I needed to add a line setting data->valid to false
and was reluctant to assign 0 instead as it would be adding more wrong
(type-wise) code. But since you say that's the way to go, sure, will
do.

Regarding the cleanup, I see hwmon has many examples of "char valid"
and so it might make sense to do them all at once. What would be the
procedure here, is that a desired change at all and if yes, how to
approach doing it? 

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
