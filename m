Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61954414A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhIVNEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhIVNEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:04:31 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4690C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:03:01 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 72so9212849qkk.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=Mzti7OcQhNV5Y7jNBpCwNPoM5QFEKkHFwpOXiZ924fc=;
        b=kXJ70SnnTkMcZ3kA/YBszIZENe7dzrkdheh0c8M5ORy+56Hu38qdXncuv0FI9RAejb
         XQ0TWhSZbJEv0LBsxPk4s9yUfk8FtZYLYb/CllmXeqpKaBYJNoDi5zwTrcWKrI82+P2j
         6MOI1FXElrpMc1sxkqKdScJkUoPSIY3uDhToA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=Mzti7OcQhNV5Y7jNBpCwNPoM5QFEKkHFwpOXiZ924fc=;
        b=zs9ixzV2fzVax9ULrl/+apSAovvvXU1vZsxQC2mMK3Br2kwMDMZ78inG93y1wByboD
         uNnmaYY/t9f9d4+psqwDlcm0hwVuSyT6tCytOxOT3bAmTFE1kgdhwx+GUUZGFPZSunWH
         RjhEAjaSL7VhvGp2c2nZP+kjPv7dKY4xLDAsk0MzaFOCVXh3PZ90kZdo4MJOprK0PMPN
         v4pQ9cD16zWrqpdqN7toYomNeTgplw9ipd7//CZtoxHGFqNCUxIBZJrNTXe4IFC06DUb
         /41ncOfkc2EEpBG+XsQ3bif5G9pGn7c5u62kSGR3pPHNveJstAknXjmj8ep9rkEkSUBP
         etkQ==
X-Gm-Message-State: AOAM533myr75G2HKe4AMcpOGRR/68UoWMMK32fd/W+UNlSxB7fW1nPUg
        qsP9gy4Z83fBhS8E0+R946boXNSlzF+WqA==
X-Google-Smtp-Source: ABdhPJyLiBDotfHrhGzTOmGecvtOi21xcOHtpAybjkI6xzcfTjZ2UDI0x8MRc8PbCu1YM4sMiybqcQ==
X-Received: by 2002:a05:620a:5b7:: with SMTP id q23mr17001937qkq.59.1632315780497;
        Wed, 22 Sep 2021 06:03:00 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id a9sm1693583qko.27.2021.09.22.06.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 06:03:00 -0700 (PDT)
Message-ID: <d9b328d6-7e99-f0ba-2376-72829c28cff4@labbott.name>
Date:   Wed, 22 Sep 2021 09:02:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     ksummit@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>
Cc:     "tab-elections@lists.linuxfoundation.org" 
        <tab-elections@lists.linuxfoundation.org>
From:   Laura Abbott <laura@labbott.name>
Subject: Reminder: Technical Advisory Board elections end September 23rd 16:00
 GMT-4 (US/Eastern)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you everyone who has voted so far in the 2021 Technical Advisory
Board elections. Voting will run through September 23rd 16:00 GMT-4
(US/Eastern).

If you cannot find your ballot in your e-mail, please e-mail
tab-elections@lists.linuxfoundation.org.

If you thought you should have gotten a ballot but did not see one
please fill out the CIVS opt-in form
https://civs1.civs.us/cgi-bin/opt_in.pl
and e-mail tab-elections@lists.linuxfoundation.org

If you did not yet request a ballot but are eligible under the following
criteria please contact tab-elections@lists.linuxfoundation.org

There exist three kernel commits in a mainline or stable released
kernel that both
- Have a commit date in the year 2020 or 2021
- Contain an e-mail address in one of the following tags or merged
tags (e.g. Reviewed-and-tested-by)
-- Signed-off-by
-- Tested-by
-- Reported-by
-- Reviewed-by
-- Acked-by

If you have any other feedback, please e-mail
tab-elections@lists.linuxfoundation.org

Thanks,
Laura
