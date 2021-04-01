Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D66351166
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhDAJC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbhDAJBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:01:48 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C23C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:01:48 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id l18so1078303edc.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s/KI0MJgK9QofyThEgPplyvQu0DKV1gNDZdKcA9WQyI=;
        b=J/kl1FAlhHjoQasXIFGD7dlz77iXZ2V/vmGwj+NcHuXR0qjRBbigEisn2b6x8dz60j
         j7O7OuQI1/gyBctQrWamL8kVGuip7e28UQ1uS7Tfz3awhbhTNDwvOBxIBfJJguh3zQDv
         uzaMf953kXgPABN6GcLXxBUVYIO7ePGdrMoKueAJRAdITLMZkaXQZt7Wku5fKSDJhfaC
         5ZA35tUp5GRptmuS2q5hMFAdmqBu8jOHqLXkvDmgLjDCb16EqYISEm7OuTBScJ3HXWIN
         XJ4OVMP76IKN0cutJdcLUZEIu/wl95S1XcLz9DwliKqOd2PldLGYHbmScJy2djLmYhdC
         MvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s/KI0MJgK9QofyThEgPplyvQu0DKV1gNDZdKcA9WQyI=;
        b=aBVNMKq8usfBbPsMo8ucOfX8JoD/LsqqljuCUNr0++amHpgAwnJ/OPb1Ac0o6j7M2Q
         tJy9efBu5XWR97ktoiW1OJ3QpjLAKFZUTkq5lQSY2Wi6c3bZjNZIzhQvcAlW1/YwD/V3
         I6seIWlHfDsoU4ntc2IKWF7J/nyBwFfcTT/GTXuff7/TBBYDNk3KNcPrKuc3XOT7p+h/
         wvy2xQsq4tNHy/3mdk4QdUicATkswBtlfLZcgCx+iBxjTyCg/DWqivLUDhL0pQbTRlD2
         ahgVHFAnOpDwBVa0IJKntp/1j+1Iuh7OsNz3rjBpS0AI51xKrcee6TxhLSmrkKQNsDAN
         eCOA==
X-Gm-Message-State: AOAM531nsxoE38+8NdRHrMgezEiFIZpHtMwnCncaBfnT5bw54BggbJjt
        Bt1WZQ/J5sbOSYSKVbU7qRAs2rgIoJILgQ==
X-Google-Smtp-Source: ABdhPJw5CPPctarOql+rS2x1uLAr1a+Mp8+uwazHWoqo/j95L0cOZH6WvM0FAien2sFFgysAZTvJow==
X-Received: by 2002:a05:6402:5203:: with SMTP id s3mr8769668edd.79.1617267705931;
        Thu, 01 Apr 2021 02:01:45 -0700 (PDT)
Received: from agape.jhs ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id r24sm3118586edw.11.2021.04.01.02.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:01:45 -0700 (PDT)
Date:   Thu, 1 Apr 2021 11:01:42 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] staging: rtl8723bs: replace private macro with
 print_hex_dump_debug
Message-ID: <20210401090141.GA1442@agape.jhs>
References: <cover.1617183040.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617183040.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 11:34:05AM +0200, Fabio Aiuto wrote:
> this patchset replaces RT_PRINT_DATA private macro for dump hex values
> with the kernel helper used for this pourpose.
> 
> Fabio Aiuto (2):
>   staging: rtl8723bs: use print_hex_dump_debug instead of private
>     RT_PRINT_DATA
>   staging: rtl8723bs: remove unused macro RT_PRINT_DATA
> 
>  drivers/staging/rtl8723bs/hal/hal_com.c       | 13 ++++-------
>  drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  | 22 ++++++++++++++-----
>  .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  3 ++-
>  drivers/staging/rtl8723bs/include/rtw_debug.h | 19 ----------------
>  4 files changed, 22 insertions(+), 35 deletions(-)
> 
> -- 
> 2.20.1
> 

Hi Greg,

please drop this, I will send you a v2 soon.

Thank you,

fabio
