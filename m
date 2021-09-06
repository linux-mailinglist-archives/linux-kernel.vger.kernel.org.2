Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0082D401E9E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 18:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244236AbhIFQlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 12:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241972AbhIFQlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:41:14 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D839C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 09:40:09 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j1so4610728pjv.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 09:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Id4IX7WNAacgPXIphmc2k5gyC+m0hiqYBkdrE/MPtks=;
        b=kBCfkgdYuVEn/boyOC/8CVOCiHUy5PqQ0EddIOm/b2kYpY1vS6UxJrOeatra2KToIv
         sXuwihBL1wN0qexKUNEF7rHpdNl6IRu/6EWw+cLutG4aoOIfDARjB8fJYsDDY73vNqlO
         QV+rmJrXUvEY51I0erAEkkjCVLXG6IY7Ih0a7z28pT2hwthMQ3mPrWSk7NvUCeuQigUq
         rBDr0aAAAbCN09oMLNWLHsB/jW8DEMKt4i3y1ryx67yjzGcQhVzuiRomlKMABOKymhj3
         CImmTJcXKop9ODoNWBmf4UdHtDLzG+kqlctlGX/gb6msUXnJMzvP7jjkN1XkCxLQhURg
         jWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Id4IX7WNAacgPXIphmc2k5gyC+m0hiqYBkdrE/MPtks=;
        b=ETwevfdHkfV6ZP/jSPaF9JDnjHux+T13WDdORcuBanXd8Rh+rHh5b69Kw86iKgxhBj
         st+RtsqXsjeFrYselwtE0MQqeNVOhCWiZUNuO5P7CoI/R2Pss/7bq+tDADau3l9qgdFL
         I+9eueT5Oju9Y7xcDkZm05w4OCDaK4oLRQqJwRHoVuxE3sIrUx+PqWBeOlSzA8ZHOl0r
         MrklWZoS0UOXmNLohulKg63PMy03dyE1MzvfuzjRs7vOC2suZlo1swWdwefIdCpHyAoa
         nUa5lup+pN/hZYvJVHDpMbXbIMqDJN5sChuulORtCc20EB0821C7jj9QaJO5eFzhXrVZ
         5hBg==
X-Gm-Message-State: AOAM531iqFf2hLiJkeac1c8DYU/yTz7ObTyhsJmoqnAjuZi62XkbYf/U
        WgK3NuSm8qvtZ/Ma1Qa/DA15ljTL5eEfaQ==
X-Google-Smtp-Source: ABdhPJy9FY92iSOiLR5dF/Ju7R1WHruQJ2enjFHx1DshRbyipXCPqOomp/NfxJ5To0JHWI+o14qVcg==
X-Received: by 2002:a17:90a:9b13:: with SMTP id f19mr15375pjp.224.1630946408627;
        Mon, 06 Sep 2021 09:40:08 -0700 (PDT)
Received: from [192.168.1.6] ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id h16sm8008282pfn.215.2021.09.06.09.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 09:40:08 -0700 (PDT)
Cc:     saurav.girepunje@hotmail.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: core: remove duplicate structure.
To:     Greg KH <gregkh@linuxfoundation.org>
References: <YTSj7upqzTiccWH2@user> <YTYchKn/l3GboOsd@kroah.com>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
Message-ID: <4537b0fd-848e-5188-823b-3a3bb750391d@gmail.com>
Date:   Mon, 6 Sep 2021 22:10:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTYchKn/l3GboOsd@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/09/21 7:19 pm, Greg KH wrote:
> On Sun, Sep 05, 2021 at 04:33:10PM +0530, Saurav Girepunje wrote:
>> Remove duplicate structure mlme_handler and action_handler. Both
>> structure are having same member. Replace it with mlme_action_handler.
> 
> Why merge both names together?  Why not just pick one name and stick
> with that if they really do the same thing?
> 
> thanks,
> 
> greg k-h
> 

Yes, we can pick one name also . I think action_handler name will be better.

Thanks for review Greg,


Regards,
Saurav Girepunje
