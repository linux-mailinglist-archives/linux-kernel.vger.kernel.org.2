Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E623559B0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346655AbhDFQxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346633AbhDFQxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:53:18 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF62C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 09:53:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id s15so2441448edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 09:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SfccbbW2+MpYwGGhGg11TDLfugRMxSMOVQP6jp7h2U8=;
        b=pQ0ViWyzRs0o24zDGEqtCMMH69JRP424QVOZcXH/CCKrZ97GZiY0ULQcAHxkZ5/WAL
         yMnt8tDc66eO8JUcJ2MdsAfdurONW1iBpLxuNcXNtW9renL+asEb3f5y72g5N5dES0NF
         lF75oyb83LxmBGbU55xLsbM49rCpqTQgxnKIjtQ0rJ7iNmp98n10HH3BzzpXbfpucJyb
         7zRXWBGN4qjQkNuGKpmoEs9ix3Og3SOh0burWSTX1pMNWqiFPjcebb9wkpeEbjsiV2YS
         kNb2Fg9AFBvwWmGtAbYktIXCDG0lUP3n4ip4FsXmjHeVfKRCAJYEr2VdOg8bxi0O5hU9
         2AaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SfccbbW2+MpYwGGhGg11TDLfugRMxSMOVQP6jp7h2U8=;
        b=Dp6i6r/JYHUTlaa3Rv3Z091iBEOkUHlXsLHRN8cBy8GWgOrkF+VDg1Xb02B4AX4QxQ
         LXqrCPo5EyiPjzorDrOs++8xfGSw71zDZ9dbdNW4zJeH6H72Yxr7f5EPTuplnqg29ZHD
         IZElnDX2MAn8FI1thCkXMhycsdP/aY9LC76+CJC4sZoAmt18RIwqaloUhzl6xqdTh7IQ
         z1vkR0uYz7Qwdlhx4ZdeFdvbYnOTZPrx+wIhG1UZ9RAKjr4wzooyNuuK5NmGrwXDi8TF
         JsDzf+pAERAPxRmJHqeF5Szz6bLYRtvEHxvNJoQrzKZsz1Wq/EZ+pb1pArBD960vsgLi
         +Tug==
X-Gm-Message-State: AOAM531sN+Vkt44nBJv1VQdnJFX1UkdzmP1rLy/8+gmQZAk6yK3hKzgG
        SOP+PFDTuhp4hkdwLtLrioI=
X-Google-Smtp-Source: ABdhPJz3CBmGRxoEz52cTS6tYWt/J2du4S9Jag66vzWZ1bn8Cp+BVW37tN+UW+aoR8HGpgjf2ajkfA==
X-Received: by 2002:aa7:cb97:: with SMTP id r23mr38335517edt.106.1617727986971;
        Tue, 06 Apr 2021 09:53:06 -0700 (PDT)
Received: from localhost.localdomain (host-79-42-91-147.retail.telecomitalia.it. [79.42.91.147])
        by smtp.gmail.com with ESMTPSA id c19sm14255587edu.20.2021.04.06.09.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 09:53:06 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     gregkh@linuxfoundation.org, outreachy-kernel@googlegroups.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: hal: Add spaces around operator in HalBtc8723b1Ant.h
Date:   Tue, 06 Apr 2021 18:53:05 +0200
Message-ID: <6130008.QCNOj3hcS5@localhost.localdomain>
In-Reply-To: <alpine.DEB.2.22.394.2104061843260.16390@hadrien>
References: <20210406164001.13646-1-fmdefrancesco@gmail.com> <alpine.DEB.2.22.394.2104061843260.16390@hadrien>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 6, 2021 6:44:00 PM CEST Julia Lawall wrote:
> 
> On Tue, 6 Apr 2021, Fabio M. De Francesco wrote:
> 
> > Added spaces around operators in file HalBtc8723b1Ant.h. Issue detected
> > by checkpatch.pl. Spaces are preferred to improve readibility.
> >
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.h b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.h
> > index 59e8c68cdc20..719e19420a3b 100644
> > --- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.h
> > +++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.h
> > @@ -15,7 +15,7 @@
> >  #define	BT_INFO_8723B_1ANT_B_CONNECTION		BIT0
> >
> >  #define	BT_INFO_8723B_1ANT_A2DP_BASIC_RATE(_BT_INFO_EXT_)	\
> > -		(((_BT_INFO_EXT_&BIT0)) ? true : false)
> > +		(((_BT_INFO_EXT_ & BIT0)) ? true : false)
> 
> There seem to be a lot of parentheses in this code (( )).  Maybe you can
> make a series and fix that problem too.
> 
> julia

OK, good idea. Tomorrow I will also work on this problem.

Fabio

> 
> >
> >  #define	BTC_RSSI_COEX_THRESH_TOL_8723B_1ANT 2
> >
> > --
> > 2.30.2
> >
> > --
> > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20210406164001.13646-1-fmdefrancesco%40gmail.com.
> >
> 




