Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A48A320869
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 06:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhBUFWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 00:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhBUFWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 00:22:34 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E0BC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 21:21:54 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id c19so6128871pjq.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 21:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tdDDTC9i/6ye73xcvRlpFEFNsqugG4QfC+jRPvsYSVc=;
        b=p6XXoWknWAlsq+ddQq9GtUXiRZKlib/RN5qL7xAT3mLuw5moASxmLXxVOBpeS5REAZ
         qNZ5DOMfIsHARmZu0pVgMNbsYlOLOo/ppRN/NLmJIJh0ldhHyU9DMvgbuj3BI/zNyKD5
         wk3l0fwgCgv5j2CdoJ4jMgEBSeRfSo0M9P+KbXydiQ2/kHtyLS5xchSeDaJXRpho1M5v
         ouLDflhJbR154x9u2r2iGm+foDTeV1OusYMuUZDI8g6IyBFjLG3qc9kv0TVYrwneyHE1
         56/VDLSpnr6GbI7jxgRwrSttsGyEDHPlK336G1jSQGdGTKuaXZ9XqEeHqQfl4vLfP+Y3
         kkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tdDDTC9i/6ye73xcvRlpFEFNsqugG4QfC+jRPvsYSVc=;
        b=g+/xeBPnMJ41MbbqVdk97mXBPeRXmkE6I/SGWikGnCvjghrw6Cc0sAH+5GrksxsEzr
         7+SypJH7u0IOX/msADxO65ThDTcCwLaRbhyYlbwE5yIWRZcnS2EGAOMA15fi13mrpkxQ
         vwjC5GCC1paaMYLJ5SF2BR7lEJK0jqr+ArT4BAx9rIM+WYt3ymd1Jw0mM4Z0wgdN72rA
         ag4di6XZZZbb5E+xdS+dEpt7HmeVsD2CGjA9+pBr161zUngbUOyHB1/Bx12OUDTveBKr
         X35MFSof+pHhKhAf1AatVwnwfXgqcQjWfmCuj84krb5erk+5pWag3LuXR28fzEN69mRd
         argg==
X-Gm-Message-State: AOAM5305NVkbCTR5liQZcMVfEyrus/o+I3JBFKtBvaAJeQgrqZlZK/Xl
        8QlHWufPwH+dtKIWAQLmxSY=
X-Google-Smtp-Source: ABdhPJzDa83p1tU08hrXoP62X2+urlPl4aLkJM+23Kkbp/uud7LmSKliu8phWsqxdfaQoV+S9FqlXQ==
X-Received: by 2002:a17:902:b583:b029:e3:dc0b:d409 with SMTP id a3-20020a170902b583b02900e3dc0bd409mr4659696pls.9.1613884913506;
        Sat, 20 Feb 2021 21:21:53 -0800 (PST)
Received: from atulu-nitro ([2401:4900:332e:6b18:a11b:5153:f04:2d23])
        by smtp.gmail.com with ESMTPSA id t192sm14820098pgc.54.2021.02.20.21.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 21:21:52 -0800 (PST)
Date:   Sun, 21 Feb 2021 10:51:47 +0530
From:   Atul Gopinathan <atulgopinathan@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        gregkh@linuxfoundation.org
Cc:     tiwai@suse.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: rtl8192e: Pass array value to memcpy
 instead of struct pointer
Message-ID: <20210221052147.GA15671@atulu-nitro>
References: <20210220182154.9457-1-atulgopinathan@gmail.com>
 <674cd5b3-531f-e5a9-b596-f70ccc63d1ad@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674cd5b3-531f-e5a9-b596-f70ccc63d1ad@embeddedor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 12:34:15PM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 2/20/21 12:21, Atul Gopinathan wrote:
> > The variable "info_element" is of the following type:
> > struct rtllib_info_element *info_element
> > 
> > rtllib_info_element is a struct containing the following fields as
> > defined in drivers/staging/rtl8192e/rtllib.h:
> > 
> > struct rtllib_info_element {
> >         u8 id;
> >         u8 len;
> >         u8 data[];
> > } __packed;
> > 
> > The following code of interest (to which this patch applies) is
> > supposed to check if the "info_element->len" is greater than 4 and
> > equal to 6, if this is satisfied then, the last two bytes (the
> > 4th and 5th index of u8 "data" array) are copied into
> > "network->CcxRmState".
> > 
> > Currently the code uses "memcpy()" with the source as
> > "&info_element[4]" which would copy in wrong and unintended
> > information.
> > 
> > This patch rectifies this error by using "&info_element->data[4]" which
> > rightly copies the last two bytes as the required state information.
> 
> You should include a 'Fixes' tag for this.

Sure! Will resend the patches.
I have a doubt about the Fixes tag, the previous commit pertaining to the
lines I'm modifying is a checkpatch.pl fix (found using simple "git blame").
Should I write that as the Fixes <Commit ID>? Or should I write in the
commit id which created that file and hence, that specific line?

git blame -L1960,1980 -- rtllib_rx.c -> returns a single commit which
was a checkpatch fix (1970, is the line my patch-1 modifies)

git log -S'&info_element[4]' -- rtllib_rx.c -> returned the commit which
created the file (the file which my patch-1 modifies)

Which one should I write in the Fixes tag?

Thanks!
Atul
