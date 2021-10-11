Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCF6428BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbhJKLZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbhJKLZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:25:56 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C7BC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 04:23:56 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x27so72231370lfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 04:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=oR6LB/YYCviOzRyS9rHfDCuLWfRpmReRbWc3k8+yM1g=;
        b=lgq9UUjXC03oWhJswAcwW8p/1VtyCst3H4y2N8KWKpt7t+rgzoxMFx7+G99NS+OL08
         fcnUUu4Ro5yXvX7w3fubcHddO5KTAZUsuytdm4ag2kcHik7I+bq1uOCYD+/izIgancts
         yTwS3ao0BcOE1yk3aU03wLfkOMuvvJpwRLBhVT9zi/sTP64EtZKmtAggHjybjzmjxW/O
         qfD4Dt+m3xyS1dvhpaG/wzF5deY7maUQMgefdGmk+54XJax7t1mVXvuEZfGI17ptk43B
         yCAA9oilXEorDs8bezTSWhxnM/70ysjiEkuq4cWc7+oWl7ZTIGIhoGyU6CGNguBp94qG
         XmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=oR6LB/YYCviOzRyS9rHfDCuLWfRpmReRbWc3k8+yM1g=;
        b=hiWRTqI5qysIpMJUOwE6hD+G2De4ohudfaLO0YoOg3kdRJBAre8z5Lo89HA4a5tk5H
         05PFo3RMF84PdihPSXKE9ZL40ObXK4kK/yzd3yTXcY33jv2gJmQWAGS5T0RgzhJgRhpQ
         9vZB/WvPXXpx29GgG6QLhDyhNi9JaDN+NTzjCrrPTWP1A4nM7pe9NL1UEN5urQ1MvtCJ
         +ZW7RNfhE0LLNWlc/LZNRjSXvnZWycP0mrpRQ3tP0n3kzr+8a+QlVRmBzkHE4GXoUe/f
         njl7COAOXTaGWjFqIy6vM4x2er+ZKbVQGrKR7ffGRCm5JbZzg6KRFWQVz9N+7OikArto
         YVeg==
X-Gm-Message-State: AOAM533q2Tq9+sbnOpV8Oqv8013F8aQC5sNSZXuao8TBNOLcZn/+qQQM
        a8ALYn06QDUeLesRl7gaxr5gqA==
X-Google-Smtp-Source: ABdhPJzg4xlbxhT3ai96z68gpdHWXCnSzZOt0nbEmYikHYetGKqDzfhXMDxeT/xj7psMlAUvOq6adQ==
X-Received: by 2002:a05:651c:88d:: with SMTP id d13mr21431439ljq.399.1633951434694;
        Mon, 11 Oct 2021 04:23:54 -0700 (PDT)
Received: from [192.168.1.102] (62-248-207-242.elisa-laajakaista.fi. [62.248.207.242])
        by smtp.gmail.com with ESMTPSA id x27sm707098lfn.226.2021.10.11.04.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 04:23:54 -0700 (PDT)
To:     Mike Rapoport <rppt@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: Panic on kmemleak scan
Message-ID: <8ade5174-b143-d621-8c8e-dc6a1898c6fb@linaro.org>
Date:   Mon, 11 Oct 2021 14:23:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike,

commit a7259df767 ("memblock: make memblock_find_in_range method private") [1]
invokes a kernel panic while running kmemleak on OF platforms with nomaped
regions, basically it's similar to an issue reported and fixed earlier by [2]:

   Unable to handle kernel paging request at virtual address ffff000021e00000
   [...]
     scan_block+0x64/0x170
     scan_gray_list+0xe8/0x17c
     kmemleak_scan+0x270/0x514
     kmemleak_write+0x34c/0x4ac

I believe it would be a trivial problem to correct for you, thank you in
advance!

[1] https://lore.kernel.org/all/20210816122622.30279-1-rppt@kernel.org/T/#u
[2] https://lore.kernel.org/lkml/20190119132832.GA29881@MBP.local/t/#m032124f36c07

--
Best wishes,
Vladimir
