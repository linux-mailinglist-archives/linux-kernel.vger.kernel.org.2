Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C835535DD18
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 13:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244711AbhDMLBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 07:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344362AbhDMLBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 07:01:11 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B860C06138F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 04:00:39 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t22so7679187ply.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 04:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=A2IPqO8My7+g2aQ2CPPds+GGz3tnCFkMYnx9rkmowbs=;
        b=IWXJy/3eCQ9wrYX4wDMDoBSXlvDioLUOwRwW7HXRuN1ud3h8dWb/emC2b40W9OXO3U
         OtZHUHJKchtl7d9x69X8CUtmtTNXIODznLcANtFZ9je3MAUKDZUecBxinXaYZ+HZZNK7
         PfOAcujMoMmuE4XK6v25mTbLBRgVmA/1xX50I62zyJzg08e3v6msgnCpzggX3slIdxA+
         P4YUrtCwlke6iGZonP+5QT61/P/4yzResTBBqY+y60b56y5jl+KP5E6h+jKjl84xIk3W
         fzAmRKwROABGsyR82AGOUKYengiTQSs4uChnIEasfpijnjhHI7P8u8OtYNtJkYNMI1eU
         pgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=A2IPqO8My7+g2aQ2CPPds+GGz3tnCFkMYnx9rkmowbs=;
        b=KmRLVnR1Ve3rfTYQkP0LSX3xlBy8lnWR1eeOap+9SMeDc+IBiX7sOcVKaZY583FCVy
         7VreT6Yrcml6IHmpP7Ao2RkAyYnWDvFNxEC+al/+59jnAcUbn1iqlNPmcO1s9xvsSjXT
         6l/+5WRhH1veGu+06bGL90d0hMmKtJFk4dQNnmZr8TOrYvv6LEqN7eK/6k33rk2WYByk
         u07Rclxr9RzyLioP05tObNgblzv2xkwEvw4wQk8lSos7sqfq9GMpqwmMYaeTYgME1mvT
         rh4FDy/2vfNNFtjo30Xz0UMkJTZk1cXQVVPoDeveOIGV9gbWaEc/+X2XfAOKpc+fD8Gb
         zFiQ==
X-Gm-Message-State: AOAM530BPz12DNyqMyuDGgMLqtTt0p68HaPXCMD3pL8QSexaKnn/irV1
        AxOYjz5q/IgsEruzx43w/q6zyu3DKKGgrg==
X-Google-Smtp-Source: ABdhPJwa3YAyS4HNh3it26S2hz0C3HLu6d8pMlgiT0mrr7RU8dAu2wVVZ2b6pOev0ymU96E7h3iKcg==
X-Received: by 2002:a17:902:b40e:b029:e6:837f:711 with SMTP id x14-20020a170902b40eb02900e6837f0711mr31093234plr.2.1618311638686;
        Tue, 13 Apr 2021 04:00:38 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id e1sm14299002pgl.25.2021.04.13.04.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 04:00:38 -0700 (PDT)
Date:   Tue, 13 Apr 2021 16:30:30 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        mitali_s@me.iitr.ac.in
Subject: Re: [PATCH 4/6] staging: rtl8192e: matched alignment with open
 parenthesis
Message-ID: <YHV5zikK8CUheULV@kali>
References: <YHEA2Te3Hik5J39t@kali>
 <f5fe04d62b22eb5e09c299e769d9b9d8917f119c.camel@perches.com>
 <YHEMrQdEFpXgmMh/@kali>
 <04fcc5ac37f750e335447aee57da5aad072e321d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04fcc5ac37f750e335447aee57da5aad072e321d.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 07:31:53PM -0700, Joe Perches wrote:
> On Sat, 2021-04-10 at 07:55 +0530, Mitali Borkar wrote:
> > On Fri, Apr 09, 2021 at 07:07:09PM -0700, Joe Perches wrote:
> > > On Sat, 2021-04-10 at 07:05 +0530, Mitali Borkar wrote:
> > > > Matched the alignment with open parenthesis to meet linux kernel coding
> > > > style.
> > > > Reported by checkpatch.
> > > []
> > > > diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> > > []
> > > > @@ -154,7 +154,7 @@ bool IsHTHalfNmodeAPs(struct rtllib_device *ieee)
> > > >  	    (net->ralink_cap_exist))
> > > >  		retValue = true;
> > > >  	else if (!memcmp(net->bssid, UNKNOWN_BORADCOM, 3) ||
> > > > -		!memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
> > > > +		 !memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
> > > >  		!memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ||
> > > >  		(net->broadcom_cap_exist))
> > > 
> > > checkpatch is a stupid script.
> > > Look further at the code not just at what checkpatch reports.
> > > Align all the contination lines, not just the first one.
> > > 
> > Sir, I have aligned them in last patch of this patchset.
> 
> This sort of change should not require an additional patch.
>
So now should I compile this as a patchset of 5, removing the last patch
of alignment?
> 
