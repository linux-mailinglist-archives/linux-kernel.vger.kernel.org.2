Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895D936039F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhDOHpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhDOHpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:45:06 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D53C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 00:44:43 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i3so1177910edt.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 00:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mo8VcWChyiswYqXafOgPzC0rghxOGJeUf888xhDxB7A=;
        b=Djd1yu2ygNAB6AwkfDBSQM23UdPQgI7TRVwaPtaSVsOgZTsXMnEZf55dsV49AwyfqE
         2/COw0IOUs30bcMPL2xIijtqsFtCwG8xaSgDGHFaYP40hX9uG2ZQgm/QJeCFeXg7SUIW
         pP+Valr/YyuNLXEKM4zZ2tHWTNwZfXZ8BvDVv+hkeKYxeHDs5UqnX26mmGGAzClsHUsN
         +cnMY9Z32Oja7hCewZctIGbz1TTfSHo+SQ1xSerPw9GWBhcVTI7Mwtsx+o3RaEnItZ5p
         IOtllw0zzkMmaWZ1H88ziYgEuzUE/SzS0FDtsucdsP8ggYVaifte6MqK2hX9eJznRSjo
         sizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mo8VcWChyiswYqXafOgPzC0rghxOGJeUf888xhDxB7A=;
        b=Pix3VLn3joDKdkiEpI4iEx4Ei5q7g2dEPMu2UxzevUr6PEVR0p/OEYPK4wgIgL2kos
         lU0tCfhmseJNLwPQ29yYku2GuqGAKciQJKBPlfBmOpWjAINlwC2u6rzggM9nqaJgOnNL
         MMdbSdVs19xp91pWF0RTo8N127CLMfiVgDJbK9vaoYHW8RCVhVN7h5JC235kZjXd3ztG
         Rff9txcrJrMq69e1Sx4OIj1K4lllUOv+GlCyi9Az87KGRUbvck/5y5aR6FbJxjjIzbNP
         Vtm1x5nnlvFV0deKq9qIaR/VNkI+bRJ4VEG1lvkjvb7KvcpYYyDBqxtst+kgwWq7Aj2N
         jGQw==
X-Gm-Message-State: AOAM532TQpfqDIdd/7/rOvN8JK5OEx3ThMX9zXSFiX1AOPS7LiutdN9R
        dc3Z4hRN/zkfPD1Jd2Vuuds+ntSvGlEqUO3V
X-Google-Smtp-Source: ABdhPJyCH0gB2Jiuv8R9wCiM2zo6ImaqsPxioLiQTB7FtB9ufPsCdqOyvquO6WPTF6iqzJ5h5cAipA==
X-Received: by 2002:a05:6402:254a:: with SMTP id l10mr2543769edb.160.1618472682108;
        Thu, 15 Apr 2021 00:44:42 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id ca1sm1654269edb.76.2021.04.15.00.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 00:44:41 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Outreachy kernel] [PATCH v4] staging: rtl8723bs: Remove led_blink_hdl() and everything related
Date:   Thu, 15 Apr 2021 09:44:40 +0200
Message-ID: <50579851.vdsvJbu58s@linux.local>
In-Reply-To: <YHfrLoot3iJSpAHU@kroah.com>
References: <20210415071731.25725-1-fmdefrancesco@gmail.com> <YHfrLoot3iJSpAHU@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April 15, 2021 9:28:46 AM CEST Greg Kroah-Hartman wrote:
> On Thu, Apr 15, 2021 at 09:17:31AM +0200, Fabio M. De Francesco wrote:
> > Removed useless led_blink_hdl() prototype and definition.
> > Removed struct LedBlink_param. Removed LedBlink entries in
> > rtw_cmd_callback[] and in wlancmds[]. Everything related to LedBlink is
> > not anymore needed. Index of slots changed in arrays comments to
> > reflect
> > current positions.
> > 
> > Reported-by: Julia Lawall <julia.lawall@inria.fr>
> > Reported-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> > Changes from v3: Merged the series into one single patch for avoiding
> > unnecessary intermediate stages.
> 
> Much better, thanks for sticking with this.  
>
I think it was worth doing this job well and getting it done, despite the 
difficulties I had.

I really appreciate your message.

Thanks so much,

Fabio
>
> Now queued up, and I think
> this is going to be the last patch I take for 5.13-rc1.  The rest I'll
> store up for the next kernel release after that...
> 
> thanks,
> 
> greg k-h




