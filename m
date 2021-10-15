Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA30F42F631
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbhJOOuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbhJOOt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:49:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1660C061762
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 07:47:49 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u18so27067552wrg.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 07:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=E01AI5APtyK2m0eSU6exeT54vrZKIKO/jub/6lEpXD8=;
        b=aBpZRZy9foy4RVCxq4Uw45cxrcpMxJLwguwopABXPo4pOZ3LVAo02bMyDjwJp6J2q9
         IXQeslNGFCp8mOY3iZmlWZfId5L4Y+6ocnpunDoUYkl8vtNHjwwHz2FJnrOvbNkFTAjE
         RfyvkWDBA4WUAJgxRdSSRve3xSgzOVcOe4aLWMkIT+1mwKp4SOO9Z0wVWYoSJm/aaKfd
         dVwRupUFOUWy8d2gNLteL84XjSMp4VjaiIWI5rzi8p5PHRWQYb11WoukC1LWsfJLdShr
         LF9Bi/62Ujtuk3gz5dYX6n3tfPBhzE1i8q2QZTe4MSGKjf5esx+ImAlSyjEw1T/Jf1iR
         rTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=E01AI5APtyK2m0eSU6exeT54vrZKIKO/jub/6lEpXD8=;
        b=UqFiaFTovzF4s8kpReVgf24OZIaljR2nwRms0YpwQnIeshbh0djZZ3pFXIQgx0jyiq
         aaHcKT6Icyk/+ww7XAmQhrrPPXQAbcmAfl8nWekWz270zxlpMjkr/QeMAc8rPBkSY4W8
         1pCaDDJOQi/CGoHNqwfKObAuLXmg6FIuI90IZG69BVnpLCbURsQvMCBpx1XX7AD1Mk9V
         2LCOr22gh1t0H5Cn35BTYD1ezQyPr4IbsCLmxqAgNyVYYZYGK3RSgLDagKxgQMle24Op
         rzo7oMz5qi3oTbCLKcuI0H9yCnE8X7cCVgvgKcNf/5wIt/sQ9B2h+iGlTrzepKim8Z5R
         mLiA==
X-Gm-Message-State: AOAM531am8nLQYrEgNNdN8CftPS6z+lppxOTbg8dtd4IFRTkIshRErNI
        36pZMiiO62nj8uVYmevmwNs=
X-Google-Smtp-Source: ABdhPJwZL3GWwgRnLJzE9GphyNya1Md7gDBS2tz2GZNzXJn15y6ritGU+TgSMv/KT3+T+KwnJTXmFw==
X-Received: by 2002:a5d:508b:: with SMTP id a11mr15364611wrt.417.1634309268218;
        Fri, 15 Oct 2021 07:47:48 -0700 (PDT)
Received: from ?IPv6:2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62? ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id i17sm5662312wru.18.2021.10.15.07.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:47:47 -0700 (PDT)
Message-ID: <85dfe2c18e7ec4bd5ae67f7a81ab6197a82e0d86.camel@gmail.com>
Subject: Re: [PATCH v2] staging: vt6655: Rename byPreambleType field
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Fri, 15 Oct 2021 15:47:46 +0100
In-Reply-To: <YWlj9x6kwYUT1jlQ@kroah.com>
References: <20211015102444.90753-1-karolinadrobnik@gmail.com>
         <YWlj9x6kwYUT1jlQ@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, 2021-10-15 at 13:20 +0200, Greg KH wrote:
> Do not do multiple different things in the same commit and especially
> when you do not describe them in the changelog text.

I wasn't aware that changing this preamble-related variable would be
counted as a different thing. It makes sense, my bad.

Would you like me to amend the message to say that I also changed
`bb_get_frame_time` parameter or just drop this change completely?

Is there anything else I should address in my v3 patch?


Thanks,
Karolina

