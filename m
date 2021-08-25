Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE223F7CBD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 21:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242485AbhHYTbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 15:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhHYTbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 15:31:49 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7503C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 12:31:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y34so1190522lfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 12:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ci8RsGCUHfQz7nmoHgVgYoNhxkkZ9gzkCCxPYWj1Kw=;
        b=YPTMaBTqCggdBkLCMMZEIi33gvKL6fqCAK93ss8pGeknbOaA/+JbrcCnkIU2jc8p5O
         1CrJaqe8upu7Ms5/ZcMGP2E3QnwD8aTf66I19j/5gDuuenCauWQcw7mgFBrRZqv+gReD
         CnLUQ9kwpMSGHaC0YgsmqiRhLhvUx8mGGn6yJXr8hC1FyoG8ntnT3WthyGorfBDHDwkA
         kV07G28ZaDjV4qGlS1j+/cb+yYtttoMRqVxCQdkQjnoSyCioffDgQDPuPpe67gY/sIn8
         GiCg+taD7mbDwEshYcwDLJwZCllOggYBq0f9jTkG6DSu8MCe5W0vT80L97po8wXGR9YT
         tk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ci8RsGCUHfQz7nmoHgVgYoNhxkkZ9gzkCCxPYWj1Kw=;
        b=BMPOyAx+axzQBbXn7qaTPIWkxhO+X10AXRZ61Nc2VrZUgaoddYRq2iH4HXVnPO6UEt
         YHNceMFKjlBGK3GE9CTQUXzRCqy6IL+HbDRIYCWsAswcwGP3RpPER/mCKVC2efxkurYw
         Ahy7ZLTzA1Wr9G6c3g0ujz41xQ3z/ZpyyEdaPG/jaOmSgukeuT1oneFWiET5edxSN1qb
         QyL0ate+LJ4aYN87Pf+UNOvZQW/mUUv1eCr4Mo0RXo5rX1zAxBv3NHaAs+OPy4WFJeoK
         9pzVK2e+EtwLFitTZrbs9T2OG6LOuyHR6YlJFrUvQBqLPvkdUpjzlzN7L6vVefaXdJ9g
         CiGQ==
X-Gm-Message-State: AOAM531Jcjen6LfT155UnjcjFwAD0R9E6IkHW5sWsHM2QAQG2IDdyecF
        H/rIgjKFiBbqDC1rT6QgwH0=
X-Google-Smtp-Source: ABdhPJwCTVJ7Pbr7mOv2KUJCeiKaehlnS7v7SEIiGOr6TmwoXcfdlPlRDgFsEWrl21KSsOdOYrr26A==
X-Received: by 2002:a05:6512:96f:: with SMTP id v15mr5698347lft.455.1629919862077;
        Wed, 25 Aug 2021 12:31:02 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id o20sm91400lfu.148.2021.08.25.12.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 12:31:01 -0700 (PDT)
Date:   Wed, 25 Aug 2021 22:31:00 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/ntfs3: Remove unnecessary condition checking from
 ntfs_file_read_iter
Message-ID: <20210825193100.fix4o2p7swifru5o@kari-VirtualBox>
References: <20210825182522.1367594-1-kari.argillander@gmail.com>
 <20210825191757.GW7722@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825191757.GW7722@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 10:17:57PM +0300, Dan Carpenter wrote:
> On Wed, Aug 25, 2021 at 09:25:22PM +0300, Kari Argillander wrote:
> > This check will be also performed in generic_file_read_iter() so we do
> > not want to check this two times in a row.
> > 
> > This was founded with Smatch
> > 	fs/ntfs3/file.c:803 ntfs_file_read_iter()
> > 	warn: unused return: count = iov_iter_count()
> > 
> > Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> > ---
> > I cc Dan also because I am happy that I finally managed to install
> > Smack and straight away I found something with it. Thank you for
> > this great tool.
> 
> Thanks!
> 
> You got a bit lucky, because you're using the --two-passes and the truth
> is I haven't looked at that in years so I'm worried it's probably not
> great.  You probably be better off not using the --two-passes option.  :/
> I should remove it.

Haha no I need it :D I was just testing what this tool can do. I also
notice that --two-passes seems quite bad to read. But hey I found
something! :D Good to know that you are not using it. I will not use it
then. Thanks.

> 
> regards,
> dan carpenter
> 
> 
