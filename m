Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4784429551
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 19:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhJKRNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 13:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbhJKRNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 13:13:17 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D10C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 10:11:17 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ns7-20020a17090b250700b001a0937b87b7so314242pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 10:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:content-language:in-reply-to:content-transfer-encoding;
        bh=P4aNo86fMjB1KMvjzw8IEeEhKUvCd9T+22q7Tj97MmM=;
        b=FXxAQatKifnX4nNDqMF8tTVTtWzMm6uothRZr68n8AoezLTxYZ/5F+svzhy30HXVCK
         Qum4CyMOhuhRJN1NZup6h1Zl33CLQKOlsxVLZiCA2zksiNx9AewymLACIBbqAkrwprwK
         xzWZP+M8t2ahtS71d3z18TeUVgA+zNDPWoTVsnRcZCkwbFr5nXYThI0Zdu6zAt70qxHA
         w8kXEIwWlZK7vN5SxieRrhB840chHg4yslW7oU5tccUpR+QKAiuFJ3rHnaVRMMqsGXis
         2UW596Zcd4CgDa81Ks2SnSRVUkgBu30KpakrQ/iFnofEJJNk3122i34tRPKzFyiwXL6I
         SYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:content-language:in-reply-to
         :content-transfer-encoding;
        bh=P4aNo86fMjB1KMvjzw8IEeEhKUvCd9T+22q7Tj97MmM=;
        b=B9dFj3Kxo7dadi47mZlgeu+dBvXVkSXPaGmAOTJ1UlU4EciqiS2L0s5Qx9/8JI1ECE
         uS9MfqqE16kA0JSNe44nlrgBTySBsxXF2ICMjl8c9w1dqwUKl7SzbGY4gyRsiOI5aA2P
         CMrBSIn6I6zTcSDI7n3YK7uVtpg8HwyUFLf7C1fab/h1Ynk2vNfcQM13cbR14OBNy1oq
         hA4IDndfd49rz6VljjJNshlIjT43PvQ/Hld/C1uWEMsiHqfXSRn3r+z5rfcQ7q3uIeBH
         UAc4HDwLG5enquqxnbNHKEdruX4cGa+0bEd4yh6Z71escKe+09wACtyc0f6JU4tJ3NLX
         MDMg==
X-Gm-Message-State: AOAM531jd8+hDgmU8bT9ZeqCoDwgUKYdQIerbpXjo6a3aLuQhY8M/HOJ
        1zSrxAUiBogoFfRUXxeuWjhUv41IudI=
X-Google-Smtp-Source: ABdhPJyB9/tac+id4VCRZuGmj0tRUGHdpNA3WxC7VOk1rU/igTEQKFqK2r1v7I3LYIpoMAaU+ZAWcA==
X-Received: by 2002:a17:90b:3b8e:: with SMTP id pc14mr212531pjb.180.1633972277130;
        Mon, 11 Oct 2021 10:11:17 -0700 (PDT)
Received: from [192.168.1.14] ([223.230.99.151])
        by smtp.gmail.com with ESMTPSA id g17sm5685745pfu.22.2021.10.11.10.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 10:11:16 -0700 (PDT)
Message-ID: <bdc8c280-534d-5de0-050f-2dc3db2e41d0@gmail.com>
Date:   Mon, 11 Oct 2021 22:41:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH] staging: rtl8723bs: hal: remove if condition which is
 always false
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Fabio Aiuto <fabioaiuto83@gmail.com>, saurav.girepunje@hotmail.com,
        gregkh@linuxfoundation.org, marcocesati@gmail.com,
        lee.jones@linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <YWKXKGuA/Io9sEjf@user> <YWLFf1zPvK9gz+7+@agape.jhs>
 <9dca9f7e-f987-5be5-9523-7dd08c2b364e@gmail.com>
 <20211011104141.GP2083@kadam>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
Content-Language: en-GB
In-Reply-To: <20211011104141.GP2083@kadam>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/21 4:11 pm, Dan Carpenter wrote:
> Yep.  And please go through the function and clean up all the references
> to max_rf_path.  Change the "max_rf_path = 0" to 1 and delete the other
> assignment.  Delete the comments about "max_rf_path == 2".
> 
> regards,
> dan carpenter
> 

Yes, Is it good if I send 2 patches one to remove "if condition which is always 
false" and another one to "clean-up all the references to max_rf_path" on a single
patch series. 

Regards,
Saurav 
