Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E8443762B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 13:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhJVLtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 07:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhJVLta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 07:49:30 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A359DC061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 04:47:12 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w19so528817edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 04:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t4Cy9ohriiGmBTdEfniJu/CEaDeRwPhyDAxiO98jLEo=;
        b=bKk533ufU6iiuuZpomfqR91e1+Gp1BeUkkXUORXj57pDqd6hhxJ/aWJkXl0uRAoHyy
         RYIUxI/fY2iEHj7tuwXjpqDdZSsOTv6mqUO8OvPzAxMB+HmJ1+aqhtv83AoTv6maQsg6
         FjShq1lezZLutpJKpasMt8lwVlFIdUPtNm+QoyNIly+BckKA7AzNFlMSLJXRKRljBzvm
         RMLS1gP39iLAlSbv0ZciN5VMu2XbzsPxk7C4QJRXRQIzqnExBtwmWQ61tt6f0JNokwZm
         6HmR1Xp4B4cAGdNQN/6oK1K1d9PIFmwYiERkoJ8MdltTo2r5LXT6nK8wqSrPQWgDlSuC
         q4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t4Cy9ohriiGmBTdEfniJu/CEaDeRwPhyDAxiO98jLEo=;
        b=M/VLm0NWHgUuTLpnL0dv3QxMGS8+O464Jrm8IpPxxnqHln6/e3fURuued7dEF3dD+G
         RgPXnTe5acACYTmS8S5NIWaVW+qjZGE+qLNhzJbn4N2P36vZDrJB0PtEwZn/B5M6esqE
         zq0ZJZqOf5Qdky383XQjEOBRbrZd0doCzI8HutAGZT6efvDyqywGuQ0+dRR272+Vbz24
         D/VnCVjMeL0SP1KPAEQP0ztl+yxzJusIf6ifJZ/BRDTFckiiZOq/ROO8rhLjRqjAR7Jf
         bkaTUWE420G86Un3Ucj0eChsrERCjlxyVMbTWgfN9S5tYFkx/KSSiZHCiT6BvqiQj4Nh
         4amg==
X-Gm-Message-State: AOAM532wWBfdE4bp9PKDbvsVU5tcnKhc6EIQSu/miygL/wwc6d0k1eH7
        PY8YcXlYmOAqSccUl1yq3OA=
X-Google-Smtp-Source: ABdhPJxXqYCxmAF1ZJaLSg70/DuAGAe+CDC7iMoyWchm/IymTi1yPXROGEOw003Q9tZBbsK2JLwcpA==
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr16462692edv.248.1634903231191;
        Fri, 22 Oct 2021 04:47:11 -0700 (PDT)
Received: from localhost.localdomain (host-80-181-148-119.retail.telecomitalia.it. [80.181.148.119])
        by smtp.gmail.com with ESMTPSA id j1sm4307029edk.53.2021.10.22.04.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 04:47:10 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org,
        Kushal Kothari <kushalkothari285@gmail.com>
Cc:     kushalkothari285@gmail.com, kush19992810@gmail.com,
        outreachy-kernel@googlegroups.com, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        straube.linux@gmail.com, philippesdixon@gmail.com,
        manuelpalenzuelamerino@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, mike.rapoport@gmail.com,
        kushalkotharitest@googlegroups.com
Subject: Re: [PATCH 0/4] v2 staging: rtl8723bs: core: Cleanup patchset for style issues in rtw_cmd.c
Date:   Fri, 22 Oct 2021 13:47:09 +0200
Message-ID: <7977747.61zFHCMloo@localhost.localdomain>
In-Reply-To: <cover.1634899405.git.kushalkothari285@gmail.com>
References: <cover.1634899405.git.kushalkothari285@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, October 22, 2021 1:37:34 PM CEST Kushal Kothari wrote:
> Kushal Kothari (4):
>   v2 staging: rtl8723bs: core: Remove true and false comparison
>   v2 staging: rtl8723bs: core: Remove unnecessary parentheses
>   v2 staging: rtl8723bs: core: Remove unnecessary space after a cast
>   v2 staging: rtl8723bs: core: Remove unnecessary blank lines
> 
> Changes from v1:
>   [PATCH 1/4]: Moved unnecessary parentheses change in PATCH 2/4
>   [PATCH 2/4]: Added the extra parentheses change from PATCH 1/4 here.
>   [PATCH 3/4]: No Changes
>   [PATCH 4/4]: Fix whitespace error.
> 
> 
> 
>  drivers/staging/rtl8723bs/core/rtw_cmd.c | 94 +++++++++---------------
>  1 file changed, 34 insertions(+), 60 deletions(-)
> 
> -- 
> 2.25.1
> 
Hi Kushal,

Version numbers ("v2" in this case) must be enclosed in square brackets, 
between "PATCH" and "n/N".

Thanks,

Fabio



