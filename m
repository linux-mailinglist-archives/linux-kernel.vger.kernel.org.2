Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F224318D16
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 15:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhBKOPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 09:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhBKN4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 08:56:52 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92E8C061756
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 05:55:55 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o15so3850111wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 05:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=y7BeZ+/BUSXUp6ZnHJ28TSsR2UmGZCVLb/+1NBYbAyw=;
        b=N8HcYVOxTxPMgLuiKxIBdk3DK0joq313BIUWl9490BokNBGRmsQgyrYNvtVGa2pEgD
         1XZZu4inu+vS25LtFGDfaqR/F5K1DRjqRPND1P6Udfiq0VhlxK/QJqFkHTXAVm4ZFjYT
         SKW4OgWdigbS1xz9WBWWmJPs4HeOG/fLr+JRzjNCePs2FHW2aomVR6IzkpM1wAtjNxu0
         Oy38fZS1fYTDw0SDvwq0f4tvdY6YRZzh7P7wtN2RE9FWM+erBHsPTvrT8Yq1QZ2mzrnX
         zRnoBseZYD8Me+O8pJaL4SpeZCn00YUrBVBOCtDMEhl3nqyLNLVLP2pLALn1QTalsuIa
         BtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=y7BeZ+/BUSXUp6ZnHJ28TSsR2UmGZCVLb/+1NBYbAyw=;
        b=pg5ZkvSmXCj8i4DvA5WIAI/q8eJO2my5ADhbBLw7UojxXcPWrAxoNQDcZfY0Y+cwN5
         pU01i/V+1nHiR67+BHDTfA/qmBOFZX06gorlQV3Du3q9QVKtRPc74nGf0AHFqtBUtr1r
         eSN5o5xG+y+aXOHY48sTTS8DTbWwoHP+yM0fFwtLkJQVwpuuM5MEX1sAoTs3aJ9a8iZq
         mkS6vBw/SIsQ8gJFq/LMCdsDxLoyb1DjknhJztRIMFO0KqgckWMIMZ7ZyzefeMy5Aq5t
         SfGIEZ6kUI1KrTXvoEWgLSlRvVYHNI8eS6BycMK6T+lHSuVNJTgXezWNFpTC+gP49VuM
         2spg==
X-Gm-Message-State: AOAM530HkNYmKdaKd1OaQneMYZXlEFn+uV9oO/M0aFGAQirX9+uRCCOy
        Ylr7gmkHqUC+dbJxPpCOTdBzNY1eMxNVSQ==
X-Google-Smtp-Source: ABdhPJwJMeSyjXEUpaFMgyDcAVMEN4qVEfSFh+iGLxXI8SrU1ayXcXKvXp8uO6xQOOx3NLKR6VGhTA==
X-Received: by 2002:a1c:f70c:: with SMTP id v12mr5300102wmh.77.1613051754466;
        Thu, 11 Feb 2021 05:55:54 -0800 (PST)
Received: from LEGION ([27.255.58.138])
        by smtp.gmail.com with ESMTPSA id l7sm5196595wrn.11.2021.02.11.05.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 05:55:54 -0800 (PST)
Message-ID: <4d1d23e7798fa339c7ccc1b6046130292a8beba1.camel@gmail.com>
Subject: Re: [PATCH] staging: wfx: avoid defining array of flexible struct
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 11 Feb 2021 18:55:50 +0500
In-Reply-To: <6775209.aHiZMU1OZ3@pc-42>
References: <20210211105026.GA45458@LEGION> <6775209.aHiZMU1OZ3@pc-42>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I think that "#include <linux/ieee80211.h>" is no more necessary.
Good catch. I'll send another patch.

Thanks,
Usama

