Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEFA3EB65D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 15:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240751AbhHMNz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 09:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240733AbhHMNzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 09:55:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CC6C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 06:54:56 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so16104872pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 06:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oQC/n+C5wkFlClIPjHrqQ3kOoEWEq/Nw32k6usYG8aM=;
        b=Q8JyhdOIIC+vHiSG0UUYTJzmCspHV1ym1fFrXKyoFsMdhOXCGSkKDZPXXWsXhE4tBF
         uHz0Hq8WZWOlSI1vx6Y26CDoSptb7tu+7iqh9uVryYolTwc/LIE5fONzrY3u7HNbN27O
         o3hVSSLMA8D1dsgEcHVmKA+QIytfTYiLAhV1ylrpuGmR9iF5qwF8k+p28xtEc4mAThRt
         7PlOrioxGTfkWnDsPoM2g4IFhDbM6xtZ3UFU0msk3G/b7iF8pBo8REac006S32AgtoV5
         W+BSQ7BVImreNCkD6OVlHkj6vbfAfwjcKyJRuNqdRGRNsYcQGZTYL59JNkxYUIPVjHcV
         LxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oQC/n+C5wkFlClIPjHrqQ3kOoEWEq/Nw32k6usYG8aM=;
        b=UU9mpoMtfGDvVGQNmLzNED5rhRUdGwxhcucm5Ho3nKd2Z1TCHOHTqjzNtNxhzecC9P
         +4q7Y/YFr90A7+vs+jnOjVoKCIhB9rvhDjTUYcxD6A8XeGajXeVBJ1gSrA18Qc9pFVzZ
         s1qD/ZINu5Pl0e2F5B9BC9pcmdEOKMdUc/+jwceNseITsUcN6CP8VzNn00qDz7sEkeyt
         ejU7/lsjEwnFsTgnp4DMiso3ObCPI61USX/dpN5q4bw1h853Bh/LSGMmUTvUUnOBsTPk
         kqcU9pwWYfnZcT9tl1c75WqdETJDmkZbrDk8iGCVZHHUrQCwW/58cu42XVNgotvlexWm
         tbZA==
X-Gm-Message-State: AOAM533Cp90nP+4HgaU/PBTb5sLO78wSA1nyF4El50wLu2bkJxuzNJUv
        rWlNWdIMNZpGd1Ve+daP6AG24Q==
X-Google-Smtp-Source: ABdhPJzemwI9mYnJQDtqzhrX2LcxCiDY/8WOBCEpJgn4EHMB1KhKMDIJxfaep7LxosNv0MIIuX7IlQ==
X-Received: by 2002:a62:878a:0:b029:3e0:7810:ec36 with SMTP id i132-20020a62878a0000b02903e07810ec36mr2610733pfe.4.1628862895920;
        Fri, 13 Aug 2021 06:54:55 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id bo14sm1991744pjb.1.2021.08.13.06.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 06:54:55 -0700 (PDT)
Subject: Re: linux-next: build warning after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210813194116.3a0297d6@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b2492209-732c-9871-6085-6a17659f6429@kernel.dk>
Date:   Fri, 13 Aug 2021 07:54:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210813194116.3a0297d6@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/21 3:41 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> block/bio.c:1689: warning: Function parameter or member 'nr_vecs' not described in 'bio_alloc_kiocb'
> 
> Introduced by commit
> 
>   1cbbd31c4ada ("bio: add allocation cache abstraction")

Thanks, fixed up.

-- 
Jens Axboe

