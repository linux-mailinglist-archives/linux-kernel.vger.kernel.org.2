Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED23D357E6E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhDHIwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhDHIw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:52:26 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6531FC0613D7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 01:52:12 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 18so1445690edx.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 01:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y+lmQ3hALiXCsKP1/n0DQLq9ue3zxpvU44J69w8dPHQ=;
        b=p5o/rilQ604m+8thfELohiipXeePoWLo5nBQfmpp4rI1LiULtovWi/QspuN0+DjAYt
         dPGEcLDOiWIC5JYU0H4oSBANRGEIQOlvH+EGnIUPZ9dq3GJxTJVvw4TmsI4VtZixE3dA
         Sr5mehOXU9MZy83U3gZUo1FbPUImu+rXDF4x0H5ht00WSKQOx3fAbqF+9/s9LUj5Zr59
         BrwQzQiXNVOairgFRhB3LHlWjKySfx6kt5OmYOJhe2iCRqhW8/DYFvzvfWQliRz0i8Vr
         nO+GZExjU4DzCWB4SluJZw8ZodYJpFSJgM1R2vxYdkw8O0FmNvajHT7mJ1a5FcHjXrYY
         yNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y+lmQ3hALiXCsKP1/n0DQLq9ue3zxpvU44J69w8dPHQ=;
        b=nT3ZZdTJQl56JW9xaF1p6LwNt8sDnKir9ynMbk4H72Dp6HRZoBY+1Cw1FI9BMOVrji
         cQ/O+MPidx6L7r9Umo1YJ2leu1Lhb6U70pddwxUk6dSQsimKlZlQbR9/VowtE2F7AUX0
         6oxS3Gltnv8LcJMIOkmzFtbyPyFeR52/mRtEyTkGGnKaZUDOzIv89imr4O3a5uV+dO2A
         26YIzLO4Z+7zJg5OP7k5eo4rijqWNjfoFLKVwd2ZDyQUjwqZ7xdzWma4P3mNtETk+s0Z
         VA2fNnlMeqbEsfEqQbiKjp5avPsCvcYzXePqWyWrNZH8wK0QWAijcWPaSl0VVIsrfKUd
         1gtQ==
X-Gm-Message-State: AOAM532/ZnYTZqiDoGsckQ6tzRzqhRFy9/Urm/sMrpp4kPxWiFKW/Hqg
        QXRf7ygR1+2QpfzMYgmodS4=
X-Google-Smtp-Source: ABdhPJyCRKZUq36x7IWYzPHdbS0e0nPFE0T22NNVQk7qdiYdoaepOIl6CLYOMctqwMeH0Jl3R3+7wQ==
X-Received: by 2002:a05:6402:270e:: with SMTP id y14mr9901298edd.283.1617871931160;
        Thu, 08 Apr 2021 01:52:11 -0700 (PDT)
Received: from localhost.localdomain (host-79-42-91-147.retail.telecomitalia.it. [79.42.91.147])
        by smtp.gmail.com with ESMTPSA id ly21sm6105983ejb.116.2021.04.08.01.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 01:52:10 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: Remove camelcase in several files
Date:   Thu, 08 Apr 2021 10:52:09 +0200
Message-ID: <2284292.R3b5UFg5HO@localhost.localdomain>
In-Reply-To: <YG7AkJjSThRbb/f5@kroah.com>
References: <20210408080714.29481-1-fmdefrancesco@gmail.com> <YG7AkJjSThRbb/f5@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April 8, 2021 10:36:32 AM CEST Greg KH wrote:
> On Thu, Apr 08, 2021 at 10:07:14AM +0200, Fabio M. De Francesco wrote:
> > Remove camelcase in a symbol that is used by several files.
> 
> What symbol?
> 

I'm not sure I understand what you are asking. You mean
that I have to specify the name of the variable that I changed?
Or you mean that I shouldn't use the term "symbol" but write
"variable", "function", "macro", and so on?

>
> > --- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> > +++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> > @@ -203,7 +203,7 @@ struct pwrctrl_priv {
> >  	u8 LpsIdleCount;
> >  	u8 power_mgnt;
> >  	u8 org_power_mgnt;
> > -	u8 bFwCurrentInPSMode;
> > +	u8 b_fw_current_in_ps_mode;
> 
> The "b" here means "byte" so you can drop the "b_" as that means
> nothing, we do not use this type of notation in the kernel as the
> compiler can check it for us.
>

OK, I didn't know what the 'b' meant in this context. I'll drop it.

Thanks,

Fabio
 
> thanks,
> 
> greg k-h
> 




