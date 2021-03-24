Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099D934846D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhCXWQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhCXWQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:16:25 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD3FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:16:22 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i26so18432200lfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4D/l2+6KHDLLWR4B5U/x02N6vRyCwEwFRlTNp/wGF4o=;
        b=hAFDLHj6fjyaz0CpQe/wXAhQdPZckXiCaly/4AYL3Dkx1KVFOPLy4FRdE1mDiYCTpF
         yfW0W9jRDl2zTI22o9I5dHPuagw96xyQp+zTVWkBTytBNS8TQNXNgUlwQkoceqeQILVR
         P5ClI8+EZkN5tviNLnEJ4lhm6jQUfYpmKdKEBHQcl//djc6qPej2uFNG+nDsFxYWBW01
         2fx5txdgB1E34M2U0XMCIk/Sc7BNqjD8OJXAaxkKlrp7ESUJTxAhgind5phCWk4veEow
         D3Syzgg0W914P2swEoOaKJ0LQ3DJABKOzBgG6sIXH+3575llrzivPjZTuK4sMTc6afgp
         XJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4D/l2+6KHDLLWR4B5U/x02N6vRyCwEwFRlTNp/wGF4o=;
        b=TU6huWZlR7GKyn/wXwYvWffJgQrKmdYxRBLIQcMfS7vhHjHS3E0OgMMeKNFWAOHZQE
         nAHLT1+6Y3l0vUcGw2O5faynk0egyARX95mNbGVvDK0HaNfdLilf0we6m0haNUCTnUUP
         hZ78W7bCdFmGu7GAfnoZaukFTg93DzI2jEAittWqHG1aOcQ+754lAf0pIFRWy35QJRkn
         HHlNAlm2oyBnLKHKDUBPbXjAWJdNA9Yu903LynlQFhxzW46MVOVuGJCJ+7ATxiTwrbYH
         JvQczyUDrvbGU8piv20iMOh5VOqshQ81Ekg1ARHzTEYs/thRXmeQ0cL1QCXVwJLTqezr
         W79A==
X-Gm-Message-State: AOAM533+9PoRb+tCTMb0Kh3tXB5HVqDlirnS51PzTCAp6TnMjCtI5B3/
        XiP+gkWov8Nlf9Cf5rMkc1Y=
X-Google-Smtp-Source: ABdhPJyLzK+FeyTdpQAmnRkTno5Ed66uyJHebfewgpXrtWAANvZx9jXP99UStgJ5fgD9ElQQlC36lA==
X-Received: by 2002:ac2:4ac1:: with SMTP id m1mr3192377lfp.446.1616624181470;
        Wed, 24 Mar 2021 15:16:21 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-60.dynamic.spd-mgts.ru. [109.252.193.60])
        by smtp.googlemail.com with ESMTPSA id t5sm421099ljc.78.2021.03.24.15.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 15:16:21 -0700 (PDT)
Subject: Re: [PATCH v7] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, jhubbard@nvidia.com,
        willy@infradead.org, Colin Ian King <colin.king@canonical.com>
References: <20210324205503.2132082-1-minchan@kernel.org>
 <65840bfd-4471-7c8d-ce71-c4705baf3bfe@gmail.com>
 <YFu1QoiPEnAOAvXS@google.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2f0ef658-9848-b655-f7c0-fee6aadb9846@gmail.com>
Date:   Thu, 25 Mar 2021 01:16:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFu1QoiPEnAOAvXS@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.03.2021 00:55, Minchan Kim пишет:
>>> +static ssize_t alloc_pages_success_show(struct kobject *kobj,
>>> +					struct kobj_attribute *attr, char *buf)
>>> +{
>>> +	struct cma *cma = cma_from_kobj(kobj);
>>> +
>>> +	return sysfs_emit(buf, "%llu\n",
>>> +			atomic64_read(&cma->nr_pages_succeeded));
>> nit: Algnment isn't right, should be better to write it as single line, IMO.
> Let me make it align rather than single line since I know someone
> who keep asking us to not overflow 80 columns unless it's special.
> 

I'm actually one of those guys who complains about 80 chars (where
necessary), but in this particular case it only hurts readability of the
code, IMO.
