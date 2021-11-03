Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E05844442B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 16:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhKCPFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 11:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhKCPFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 11:05:21 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37DEC061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 08:02:44 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id s24so2748242plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2skVWyVpmkbERUsvfy2J7WTVhYtKb188XJDQUdHINz4=;
        b=GxT/8w0KRn5dD7naLgVl4pAgP/7zkEhmBrEeqxhcPPnk/buEzQZHQX6hXSfqisdkEW
         Yco2wbIyHxfVnfCnJdEQVcQhaaJ6NfNfAVRLmIYDy0Agrh3HfmSwBjvrsGPgLmRQLq6G
         fiE+R4x3MVNGP0Xb69mJyDKtC8tVvm7r0xa6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2skVWyVpmkbERUsvfy2J7WTVhYtKb188XJDQUdHINz4=;
        b=Zv/+48OJH4fQ5fb8PDzFlGW9lF5im6HapnaW18COy3q7jhNapcgtovOTQC/vXcqw0y
         AnleTJKv/M9J8Ywba/G5cu+r5Q8Zgw7B56zcdJZI6iIitD+jfW7sKTxHU8FPqDJUH+Fd
         cLWqrnLJDBfsrHtlg/0Qz6r4C2ovuvKEkiHvd7zEUvaShsMU4WOQAVA37OVTmF0rFLig
         0BGLjDNQTQ006GJPtSC8m+y+/w9riAbU0T051KLQTf/OVRs7g9vqTZdPZprGB8ezU3ku
         ZDhegce4h6nc+UkB1w2l030Cu1qfMS9F1HUgXMqtLnS2c/tvikR9cclF4nVTcH9aJGCZ
         hPZA==
X-Gm-Message-State: AOAM532WCAQ+6tt0khumSzXpHjHlbCP64oPo+UoGQEUyG3eiPclYAdHE
        LL6Wp14BSLcqYTETiJnuMJdswCYmbJGTbA==
X-Google-Smtp-Source: ABdhPJwX5+LrQqsIDLk31RUnlL+p6GFNCqwRL75YQ4UBT16Haz3Q17yK/pk+xR8gXjt5r5fZs5gqgg==
X-Received: by 2002:a17:90b:357:: with SMTP id fh23mr15253494pjb.238.1635951759413;
        Wed, 03 Nov 2021 08:02:39 -0700 (PDT)
Received: from benl-m5lvdt.local ([2600:6c50:4d00:d401:d8a:3314:9c20:7eff])
        by smtp.gmail.com with ESMTPSA id q19sm3130576pfu.147.2021.11.03.08.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 08:02:38 -0700 (PDT)
Subject: Re: [kvalo-ath:pending 53/53]
 drivers/net/wireless/ath/wcn36xx/txrx.c:275:42: error: variable 'sband' set
 but not used
To:     Kalle Valo <kvalo@codeaurora.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <202111022135.B8TpALyf-lkp@intel.com>
 <875yt9sm1o.fsf@codeaurora.org>
From:   Benjamin Li <benl@squareup.com>
Message-ID: <4a89c51c-cce3-1c19-d456-3761e8215600@squareup.com>
Date:   Wed, 3 Nov 2021 08:02:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <875yt9sm1o.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/21 1:03 AM, Kalle Valo wrote:
> 
> This is a warning in the pending branch. I'll drop this version,
> Benjamin please fix the warning in v2.
> 

Will do.

Ben
