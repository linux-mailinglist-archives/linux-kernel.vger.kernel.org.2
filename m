Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE911348488
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbhCXWWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238799AbhCXWVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:21:39 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550AFC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:21:39 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id z25so634700lja.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SINr3Q2ZBRXcIzOjpKorPrVwoiUw9XUye7FF8Y4FvlM=;
        b=N4LaWQK/OA7Q9Mw85ki2knD0kW/T9ohimLSO/LccejAHG1kM0uONnBBX55aerIjTDh
         0CMCRTsbmh2gPp1lAEmooQtacZ4ETWJM6pFZizpDOt4U2icPIsS+UZp8+tbFoxSlbJis
         80pJznfzcjBnXmISlzaK4QrtoxMK0GQpAsVbBEYQ8Hk9Ny1Q8GwmQ3IJwRvNh9i1BqKy
         froDmQvn6fp9txhwPKzzATM+sypPdKR7rWEVWeNXYidlhc1FFJOSugDGmSmfYzSU2lue
         WFMAmdK4tRPwzG/7ggiGPBH4JNrxUMOuNjZ5b1WRZi6E7Nv0smy/lnK5azYPTGMF0NWe
         mG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SINr3Q2ZBRXcIzOjpKorPrVwoiUw9XUye7FF8Y4FvlM=;
        b=sU/G+Pb5GeVkJg3IEbLHzwUzZ3S+yMx25YTaoZ9mg7lmLYqWHSJ+CqfzQVYtZ9okan
         JVuG/xLoWSP7f+AQwci5yac2esa6G9svQwGFm5RlLmcb7rih/V7bcmWZOkDU+vlyevYD
         jbpwO0zLUnw/MMeZQ6ZLlZKlkJzHF+9J8SrjJFb5UnFQIR8M2dWfuRrk78WPyzlDSBHL
         /j0tSIg7nJ1Ig773HGtChk35TKzl+O+0XpPeh2qc5f+W99qeWDLSGH+WGCG+He0Urm7P
         Qc8XzDULx+pxlpHCVTJEKU+P4bbX2nIe0iToZZ2wRvIXkc7Mw8rE5KH65dEIrdCzHO27
         LPZA==
X-Gm-Message-State: AOAM5316ZJPDLa7Z+tV8G4xKkSlLu77aFe8BqBKKtB4Z/dV5xT28kYpn
        BGggJho23+fXQ4gKStOAgXqFriGpqu4=
X-Google-Smtp-Source: ABdhPJz9kmBa1g1oAIe5U/0Zt59sRzmaLNaockKDYMNldJsLVWuN+aRNWFtzZtTudWIZFRmsu2LFIg==
X-Received: by 2002:a05:651c:387:: with SMTP id e7mr3448558ljp.425.1616624497863;
        Wed, 24 Mar 2021 15:21:37 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-60.dynamic.spd-mgts.ru. [109.252.193.60])
        by smtp.googlemail.com with ESMTPSA id x21sm346967lfe.193.2021.03.24.15.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 15:21:37 -0700 (PDT)
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
Message-ID: <dc193069-2651-c911-fb83-cad985b19192@gmail.com>
Date:   Thu, 25 Mar 2021 01:21:36 +0300
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
>> The tags are incorrect, I haven't suggested this change.
> During the development, you have suggested many things
> to make it clean. That suggested-by couldn't represent
> all the detail but wanted to give credit for you, too
> since you spent the time to make it better.
> 
> Okay, since you didn't like it, I will remove it.
> 

That's what the r-b tag is for, the suggested-by is about suggesting the
patch in general.

Looking forward to the final v8, thank you for yours efforts!
