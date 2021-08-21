Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7F83F3AF0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 16:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhHUOUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 10:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhHUOUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 10:20:31 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8A6C061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 07:19:51 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id i21so11248550pfd.8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 07:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4BEOSYks7kKTIJey8qCXq/FjaQ8h7AUNhWZJcjwIWNU=;
        b=s3mgcInIvBRJt3ELH3xZBXGzK/FWLP0b1agTD5IFB07W2zkrGVSwD6+s5KGtPPCcAH
         wfQ2XlLNwOp1AoD/FyOaGmxG2N/Vf/LyiQgFvFBKfm5SPcRbtK+5ItneaG1qMy0j1VIU
         yGK1xHngjTzKWUI09kNloMPdT0jA2QhwpGDsFlA89ciQJTMAcX9boHGWdfVKeTtlQ9ab
         iJObsOQw0woXiyVXDi+WMCAixC/6bItB/sizFmTeLsgkuTVqmf8Rbef3EmlEIXDgTtAZ
         g+NIkB1yPcxAHWJ4mz+nxNGI6tLmg9G+npu7SFaFc/WmOLFZjuvutELn849ztvd6vjIX
         lNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4BEOSYks7kKTIJey8qCXq/FjaQ8h7AUNhWZJcjwIWNU=;
        b=uOQZ/zjfdlrK5QmcIt995q/hzomifYm0sNVP5TjAAcRn/ZZCaxXKBPUsij5C5XNpWB
         MEXy6fH5ZplIYWwJLoyxTXiXO7PAGzHZgRV1LPIomzaEopa+2Rh+kaSlhBtkgTD6VmZl
         Q0tAp9wLsGuHyRmYGAnGkNbrZP7F/9jLArBo4ZksZB16tmOgelh8xwKc9481h3cs1cFP
         bqvZsdYzRjBGftGjtpX7aphSEeaqXP7GtNdn1A8ujY67o8o3LAwuMK5gWRwsv6EInjfr
         soA4/84oS3eD/L9wq3xNK5W0VLEIeefV7HbwDhhOQYbrbQqzKU79uBF7nmDPVjBR9Xjb
         sisw==
X-Gm-Message-State: AOAM5314Ff/Hz83OnjVJFetky7PYOOF2RjpIB5sR4i6raGWdjBSArxiq
        hzIkBTWrGkSlgiQFWpcKnEA=
X-Google-Smtp-Source: ABdhPJwjuaXP2lPOjBb/KDrb1Toq+PIpVlVKfOj2NxKzLN7RwywoHZDi30NsZBUBx8fzGGLmXqxQzQ==
X-Received: by 2002:a63:496:: with SMTP id 144mr23544336pge.353.1629555591510;
        Sat, 21 Aug 2021 07:19:51 -0700 (PDT)
Received: from localhost ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id r17sm12992641pgu.8.2021.08.21.07.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 07:19:51 -0700 (PDT)
Date:   Sat, 21 Aug 2021 19:49:49 +0530
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] staging: r8188eu: incorrect type in
 csum_ipv6_magic
Message-ID: <20210821141949.55l7zcjifbxv6pao@xps.yggdrasil>
References: <cover.1629360917.git.aakashhemadri123@gmail.com>
 <8bc15e51751c26fd19428f3b4976b7495feecd34.1629360917.git.aakashhemadri123@gmail.com>
 <58069e38-a457-9fcc-0a9a-6bfe8723a178@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58069e38-a457-9fcc-0a9a-6bfe8723a178@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/20 04:38PM, Larry Finger wrote:
> This patch is correct, but I prefer that you use be16_to_cpu() rather than
> ntohs(). I think it makes the code easier to read.

Sure Larry, Will use be16_to_cpu()

Thanks,
Aakash Hemadri
