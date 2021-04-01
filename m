Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0088350D41
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhDADqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:46:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34850 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232565AbhDADps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617248747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jjaNSeBgfzgkuyEsWxYZoYBCpAjOIOQn7I8YDCkmDGo=;
        b=dFHb1v5tJNBcDuwHgD30UxS24ns1JuxChuII8XEY/ruQIlyJwSz/9pbrgM2pfhXjAoQXjn
        LibCuizmf5XqI/ZohoHsC2RJYba1YeqDpUuL30Uyb7DwCAtFuU+vs0YM8FgntjJznHJrwh
        a7yVy1YWASBzb9idwFNhNPv25kchlVw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-tm8bY0-5NgW4yVjfIOMZyA-1; Wed, 31 Mar 2021 23:45:45 -0400
X-MC-Unique: tm8bY0-5NgW4yVjfIOMZyA-1
Received: by mail-pf1-f197.google.com with SMTP id u126so2583654pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 20:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jjaNSeBgfzgkuyEsWxYZoYBCpAjOIOQn7I8YDCkmDGo=;
        b=bV+wusjf0f7gq7WrtO+7OcJ1ZIPJsfXV4SMblEL+CwIV8zPdy9MlaLmrK0pfFUBIiK
         2ypk+PEbdIAI4ksHnF59TGwl4EQnoECasDW9Xq9gMAZUFsyLHG3zBzuFKrqB5aoDf5+5
         Kzgz/BmxKOHvhlSH+ISJGPgBmGx93Xni11zO8TuLZeN4MlijBgyxC4QWDscoCciBX4uZ
         qWHS+EFIdl2YflvW8whIbUmqLwcGwu3y9ptDToF3lKATgPJqOgtdhWjo+7Y6o6t5AR9z
         d+fHhh9Jurf7tr/6CFrn1tKiMe1/BqM4CLZdhlf2nkcRsGk8LnbPPfWEO4ZUKvIKNzS9
         4Qtw==
X-Gm-Message-State: AOAM532v1fFXaI0cvFT7Ljah8kSeIomBGjTsvuR9sAsrSwkjjsHXlrEG
        gEQO/oRGXcw/JXwt4OhAN3lx84QL9d8fKeni7lQKufG0arNTLQtFaUHj9FkV/02PA6vDO2z1FTY
        c1U8LKTZAAf0PJqg2IxqBMHV4
X-Received: by 2002:a17:90a:6343:: with SMTP id v3mr6637659pjs.153.1617248744354;
        Wed, 31 Mar 2021 20:45:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhbkMW5A2oZJnz4u017su9Wobd1uajyGrVAtazuw1W7uQMfatgbwuglcftS+X0YMAajTJhSw==
X-Received: by 2002:a17:90a:6343:: with SMTP id v3mr6637644pjs.153.1617248744148;
        Wed, 31 Mar 2021 20:45:44 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k11sm3553600pjs.1.2021.03.31.20.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 20:45:43 -0700 (PDT)
Date:   Thu, 1 Apr 2021 11:45:33 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Ruiqi Gong <gongruiqi1@huawei.com>
Cc:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] erofs: Clean up spelling mistakes found in fs/erofs
Message-ID: <20210401034533.GA3803200@xiangao.remote.csb>
References: <20210331093920.31923-1-gongruiqi1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210331093920.31923-1-gongruiqi1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 05:39:20AM -0400, Ruiqi Gong wrote:
> zmap.c:  s/correspoinding/corresponding
> zdata.c: s/endding/ending
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ruiqi Gong <gongruiqi1@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Thanks,
Gao Xiang

