Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C23A3E50DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 04:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbhHJCFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 22:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237315AbhHJCFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 22:05:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EDAC061798
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 19:05:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gz13-20020a17090b0ecdb0290178c0e0ce8bso1560745pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 19:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4obz9WkqAEaS3SU/Ft8ZVbZx29A5UvHIZHpNuPkmvSk=;
        b=kZGou/+ar6VkGad2l0SxaqeFt1SKZRIzP9scQKzNs4UWQkTcp9RFq2j7DzVxV5KgyK
         5TlRRQZiF84syxutswoRu9al2wgA6RIdYNPOBxcnTDzmobwr5KimozZFSDPrq4diHXeX
         ipKAui0LFbQLJxIpk5KS/wFGdunbQWFii1rXT4wS1I8XQZsesNjv4HPv3iAD3ea+upBS
         JSg6AlDBdu61OSsdQuXUhveKPb1AmEK5XcKA36O+/DwyPCvucbwUCa4b3wIe+ypj3GQo
         a62adTZ9xmyyPOvuM6rVkvObTb2FdTjAK6ijP2kom0N55yhlEBTjNlqSbSS+QSc+1saE
         805Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4obz9WkqAEaS3SU/Ft8ZVbZx29A5UvHIZHpNuPkmvSk=;
        b=le088yptw6OpQe+QUUz50b30Q69d1MAtP5jYoCpAjQS379w52ffQM1NEY7UacGw1wn
         oVnxKdJkX+lnlbBKGs2vw0biHl9Us5QgF6WnQYyDsPAbDd2Xer3Tq5BXTW/jUDIwos1h
         kMr1bI3wuybMKhWoWV2wS78a7Xp7VedU0sfjf277evEsOrzyw7a5gyJjRvsIebHojYlR
         YTnj4VNFBunPI3YOGfP6JQ3K5ejAqwv1EIM9z4nOVaQjL8AapmVMkOamZN+xdgLH31sW
         fDHEIieONPWWUgl6mzcdeQ2QdZKS1ByHjPmVW+Wig+4q44fJ6mmx+FDpaTDrr+G+x7ev
         a1MA==
X-Gm-Message-State: AOAM530abc4mLSALzzEmRYpPxJHC6JmT6uCIU9Hadb38fs28px3ErwEu
        KLY3/DKM9+MX+aOVd5/kD+7+hAYCDckgXHDN
X-Google-Smtp-Source: ABdhPJwMjMG5NuvlBdsJwiOAWKSMNKV4GrcOGftPPG58i6c5kNWYn1StXNhVEiq6b+QLIyTgFs/jww==
X-Received: by 2002:a17:90b:17c3:: with SMTP id me3mr2143130pjb.203.1628561132632;
        Mon, 09 Aug 2021 19:05:32 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id u3sm18289827pfn.76.2021.08.09.19.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 19:05:32 -0700 (PDT)
Subject: Re: [PATCH] xen-blkfront: Remove redundant assignment to variable err
To:     Colin King <colin.king@canonical.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210806110601.11386-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f87ecb57-12f7-71cd-29a7-9cecd6605c88@kernel.dk>
Date:   Mon, 9 Aug 2021 20:05:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210806110601.11386-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/21 5:06 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable err is being assigned a value that is never read, the
> assignment is redundant and can be removed.

Added for 5.15, thanks.

-- 
Jens Axboe

