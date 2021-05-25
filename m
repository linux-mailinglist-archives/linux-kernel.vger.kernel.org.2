Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156D038F7BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 03:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhEYByo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 21:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhEYByn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 21:54:43 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537A0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 18:53:13 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id t193so21478760pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 18:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bM8JU76A0U5AEEg6fA9aBsbHBZR/+f5poGHys2W1glk=;
        b=SRPHgxiE0+aC7S9pApVDTr+tciXkKkc4jma71lNFhpqhNt9GsI1yuAI3eqlKQ0SE4d
         aZ1bYo/JIlASAp0tU5/q+XQLvi+pGDwbVxBoecXz7DLJPJMEezEWX6pObu1J4cFSYbEs
         96hZ2z3UvPPgVJ9iN1gLWVgcYAp5EntfxB0GzNbhbMmWTBtcqrWCDlYc6vvqneadIvQ+
         DumVEAKqYBKhPlWPHmF0DsKOjR4NvoH6pWdIKEEuUv0gZNYBKLRrNjKX5CCrl0WdSm3Q
         LAOMI7gUYfCbrHoPzzeF5Zdyp2d3hTboaOsEllbrV069kB7TKfFw6iuQZ36Da9uaIdig
         GtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bM8JU76A0U5AEEg6fA9aBsbHBZR/+f5poGHys2W1glk=;
        b=P7MvDgf/dZMbHOW6p31HaBsKlPjy1XmFZpdQqFWHMwJ+qU5O+6eenXmPtFdRzQHIW3
         K7/gqwZaA8iHRhFaCDdI0XWRCSzgrh/3TNGvipgqVaDnuDJrxesJDoKDUK0Q/H8eQS2q
         XfTU5kUQ1u5C5lETvEn2jCbrpQOF6+N0U9r+4T5R//+RtId3iK8cNoFVeoNki5A8WXK7
         vkR3AMKN09nOfyilDpEhUyTb2M28GiRIibMZD8Xl/dY4CINSbUGh8hleB+z+KYGepRBP
         H3NNE4UkOXQPT2nzQ8WjGPsuDtKAokzeP1SfEhD/gFkb0SZE3en3RDsfC3fGeg/FvVQj
         eRtg==
X-Gm-Message-State: AOAM532dncdo/ApNyca0MljgAIqsXy0H4230533y+Vo7pBZ6czmXjL0W
        Uff9IF9vJobsBREdAHJXet0=
X-Google-Smtp-Source: ABdhPJx6YCigKOkylDhhOtH0iblNTgHl9m9S0MDnvOBCGy4UM8rpII6OKVpMeY7vbgeKuTNxVtJIiw==
X-Received: by 2002:a05:6a00:13a5:b029:2db:85e0:8264 with SMTP id t37-20020a056a0013a5b02902db85e08264mr28518118pfg.10.1621907592732;
        Mon, 24 May 2021 18:53:12 -0700 (PDT)
Received: from ?IPv6:2600:1700:dfe0:49f0:10de:e230:3da4:cfce? ([2600:1700:dfe0:49f0:10de:e230:3da4:cfce])
        by smtp.gmail.com with ESMTPSA id y1sm12265580pfn.13.2021.05.24.18.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 18:53:12 -0700 (PDT)
Subject: Re: [PATCH 2/4] firmware: arm_scmi: Add support for type handling in
 common functions
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20210524231503.34924-1-cristian.marussi@arm.com>
 <20210524231503.34924-3-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <27ef39f9-1774-970b-66b4-66c15d02620e@gmail.com>
Date:   Mon, 24 May 2021 18:53:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210524231503.34924-3-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/24/2021 4:15 PM, Cristian Marussi wrote:
> Add SCMI type handling to pack/unpack_scmi_header common helper functions.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
