Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707733581B2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhDHL0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 07:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhDHL0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:26:05 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD294C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 04:25:54 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ha17so960715pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 04:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=495/Mma5t8WtW6O0PDJ3WLF/I9NqnxGNvXlyNCulN+w=;
        b=ACrdyJbo9p9Oy+FoSw2p+jHGxGky5oXtxbT/LeLz4YstN8nXbc74xExdgcP645utV8
         iTGv3mwcQS8dZPmKApvOIqyWA9LwfgloBQKhsa2OIA5RztWW0tMLrD8Jmk86tFmQT3mT
         zLng3dCm+jy74lpnXbEtdCKsXInaLLqfacVx3C+Q+Q3OBTGpYQCigxY9P25E8wGbktVq
         qx3lQyOxhgNenWWf36zh1+BH8JVN+8AiXJhBUaQ9jojABXQKPH7RLc9+07q5PLvnchOA
         SUNwt3K5WoyRF91UNcKKo304TtMKiqOxYqWf7JcMSeqih2filHA7AJ/v6wZrFKc708wV
         AeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=495/Mma5t8WtW6O0PDJ3WLF/I9NqnxGNvXlyNCulN+w=;
        b=bBFLQNY9yO15jinilmLuEt8iMCRvFhEVcZ69/xcRMZcwqG8PCsW4CojyTjCEqEi0eN
         PnK2P1xB1PqceVTTeE/7M2IYCLAwyQOPgjoJEO/UF0anSvia1JgqYGTnoVlW8gn4sD6B
         eJSXH10kVDL2wFUFMAiOdZyShxPEuljOiCEmORvNSGapq3WfhF1xiNJh7Hx5GVbf7V4m
         rLsdF5rbqrdh2l0PjmRYboDyydQRBnqSgZR/wUxTjRNdg8Tw141i5y+qKXBFFXVxa2nQ
         +xMqwHqK2p47tOm0FOkYKJa+jtlx5NQaYwx7Xt3MdbWQTOCuZeqFzBflOuW/4HobQrkK
         ko4A==
X-Gm-Message-State: AOAM532+o5MynXoJvg5sm/7kKs1fBC6NNbNGxn+isdXxTHHphA7zVidP
        qnthUKTJKIDP1NvglpgHmVw=
X-Google-Smtp-Source: ABdhPJxvQ7metANC3n7diwoY46jlO4euSlcKCa1sstBxi92yy5mXjTs4Pa4wTKj3E2QZF0hYzHsRaA==
X-Received: by 2002:a17:902:7886:b029:e7:1052:adad with SMTP id q6-20020a1709027886b02900e71052adadmr7264350pll.75.1617881154077;
        Thu, 08 Apr 2021 04:25:54 -0700 (PDT)
Received: from kali ([152.57.46.75])
        by smtp.gmail.com with ESMTPSA id fv9sm9234517pjb.23.2021.04.08.04.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 04:25:53 -0700 (PDT)
Date:   Thu, 8 Apr 2021 16:55:45 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        mitali_s@me.iitr.ac.in
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8712: added spaces around
 '+'
Message-ID: <YG7oOezBpYsi3Fr8@kali>
References: <YG690ZIRdCEcjoM6@kali>
 <alpine.DEB.2.22.394.2104081027100.3155@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2104081027100.3155@hadrien>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 10:30:09AM +0200, Julia Lawall wrote:
> The subject line should be in the imperative, so "add" instead of "added".
> 
Ok Ma'am
> On Thu, 8 Apr 2021, Mitali Borkar wrote:
> 
> > Clean up Check:spaces preferred around that '+' (ctx:VxV)
> > Reported by checkpatch
> 
> Please try to rephrase to explain what you did and why.  "Clean up" kind
> of states what the goal is, but your opinion about what is a clean up
> might be different than someone else's.  It's also not necessary to cite
> the checkpatch warning exactly.
> 
OKay Ma'am, will rewrite the appopriate commit message. May I know while
resending this patch, what should I write in subject description, 
RESEND PATCH or PATCH v2

Thanks
Mitali

> julia
> 
> >
> > Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
> > ---
> >  drivers/staging/rtl8712/wlan_bssdef.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/rtl8712/wlan_bssdef.h b/drivers/staging/rtl8712/wlan_bssdef.h
> > index b54ccaacc527..ec3749813728 100644
> > --- a/drivers/staging/rtl8712/wlan_bssdef.h
> > +++ b/drivers/staging/rtl8712/wlan_bssdef.h
> > @@ -176,7 +176,7 @@ struct NDIS_802_11_WEP {
> >  #define MIC_CHECK_TIME	60000000
> >
> >  #ifndef Ndis802_11APMode
> > -#define Ndis802_11APMode (Ndis802_11InfrastructureMax+1)
> > +#define Ndis802_11APMode (Ndis802_11InfrastructureMax + 1)
> >  #endif
> >
> >  struct	wlan_network {
> > --
> > 2.30.2
> >
> > --
> > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/YG690ZIRdCEcjoM6%40kali.
> >
