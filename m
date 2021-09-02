Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CDF3FE7A6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 04:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242795AbhIBC3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 22:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhIBC3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 22:29:33 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260D4C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 19:28:36 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id u6so487398pfi.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 19:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ydBex6o6dWHHUMf/r9q2siCinDhH7TcT23iy9juoHGQ=;
        b=Ne5LEKcXWuVgVpaA0gqDLEXA5FKYGn4dDaVL1Q7v4WKejc+4Jhe7Yc7JSEN/wSf4fa
         wVB9GvxlnHe3GMcB1NqaD6o6xo8TVeTpWJ07+MyPxalBoAcgbhCd0j321y7keMkxUVRh
         86GrDkTA+HtsLxjYLdPTyMMN3r+aklmalILkURDG/pSvotb+X9yc6v0bNZyitmp7+neJ
         HbLelofTu0Fx1D5DeJzF5+Irz2jynDswSkEMR1lhJSqeBHkupbJsCSnENn5E7OmjwDZj
         uanb+UHTuSLrvI3abU1pq+useGKYvdOg22mpXK0ciMUGAmaUY7SjPd4GpEV8WhtHNI7S
         Fk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ydBex6o6dWHHUMf/r9q2siCinDhH7TcT23iy9juoHGQ=;
        b=kftoOFFTI85lhZfthEoLVbhb+Ymrw32FF94fAfIDG5C//qDmAU/uth1KIemU+44eS3
         j8gVQ7/i9U+klHNxlOSxWeZvcoZnZlaS4F6vHSW+fIGWyl/h7CeotjJ1opYrMQg5ODsK
         5RtDfif25XwgfVFHrcoy34CQQ68BKL4Mul7lMjCp1uTfWJTVcNuzRyuB4FP4cp7hPPtQ
         NuOq8ObJDKznm7+0nqCCioU6uQ43O8P9CI4RKJUEAjVarRNFhV/3kiY2oYIqNrD7t5HK
         jASqNtHsxiuoXUQm7Ckgpt6gAwxu3GUI1GfKcU3jGizgcIMiaCxbrgl59dzqKcLUbjh9
         SuJQ==
X-Gm-Message-State: AOAM5300gRC1mf9Fovmu2x/SmHh5abtnn+1V18E8u+BY64Ndk+xHIT46
        wrp85N1hGg2i80YYnZv2lUVEbBjOI6Q=
X-Google-Smtp-Source: ABdhPJwCXT534aCKvrEIvWxU4Tvtw4FJCrEa/7idUAgVUefjfO6uMEcTDCjHBadXJ55CL+wskG0vQg==
X-Received: by 2002:a63:4f54:: with SMTP id p20mr791768pgl.437.1630549715433;
        Wed, 01 Sep 2021 19:28:35 -0700 (PDT)
Received: from [192.168.86.235] (c-73-241-150-58.hsd1.ca.comcast.net. [73.241.150.58])
        by smtp.gmail.com with ESMTPSA id j9sm285825pgl.1.2021.09.01.19.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 19:28:35 -0700 (PDT)
Subject: Re: [PATCH 10/10] seqlock: Add do_read_seqcount_retry() in front of
 seqcount_lockdep_reader_access() in read_seqbegin()
To:     jiasheng <jiasheng@iscas.ac.cn>, linux-kernel@vger.kernel.org
References: <1630549000-3731606-1-git-send-email-jiasheng@iscas.ac.cn>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <54d7cad8-30fc-e96e-bf70-ca371b08b128@gmail.com>
Date:   Wed, 1 Sep 2021 19:28:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1630549000-3731606-1-git-send-email-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/21 7:16 PM, jiasheng wrote:
> We have found that in the complied files seqcount_lockdep_reader_access()
> appear more than 20 times, and under at least 90% circumstances
> that do_read_seqcount_retry() and seqcount_lockdep_reader_access()
> appear in pairs.
> For example, they appear together in the irqfd_wakeup()
> of the file complie from 'virt/kvm/eventfd.c'.
> But we have found that in the read_seqbegin(), there is only
> seqcount_lockdep_reader_access() instead of the pair.
> Therefore, we consider that the do_read_seqcount_retry()
> might be forgotten.
> 
> Signed-off-by: jiasheng <jiasheng@iscas.ac.cn>
> ---
>  include/linux/seqlock.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index f61e34f..14169ce 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -837,8 +837,10 @@ typedef struct {
>   */
>  static inline unsigned read_seqbegin(const seqlock_t *sl)
>  {
> -	unsigned ret = read_seqcount_begin(&sl->seqcount);
> -
> +	unsigned int ret;

ret contains garbage at this point.

Calling read_seqcount_retry() with garbage is not going to fly.

Have you really compiled and tested this patch ?

A sane compiler would have complained.

> +
> +	if (read_seqcount_retry(&sl->seqcount, ret))
> +		ret = read_seqcount_begin(&sl->seqcount);
>  	kcsan_atomic_next(0);  /* non-raw usage, assume closing read_seqretry() */
>  	kcsan_flat_atomic_begin();
>  	return ret;
> 


