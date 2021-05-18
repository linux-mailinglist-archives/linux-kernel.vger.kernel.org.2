Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18B8387F24
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 19:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351422AbhERSAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:00:47 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:43717 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345799AbhERSAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:00:39 -0400
Received: by mail-wm1-f54.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so1944705wmn.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 10:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=EpZO9P+k9X/0Sekw6kOsFYknqDsbx0UCc9g2GadF0KsrMzAB4EbsxM+yrb5KKpr3lq
         lY6+xvx0/sP3qCNXdQZ/qka+WdOWBVyTwDBdDy0tV878SWinzcRMosvKaHvkLwfBA0Zi
         Xt1Y8uGO//QB59rRVS7RpzJ7rlIjMpzXQgVGrcQKQ6fFsDCwdA1HXy9ef5Cj+Zi2lG1B
         2ELw+zLwrT0i6SMEVUFb5+vjGKBeH1Sv5jn/YBrBzKrU28zwihQh+2jys4zRrTj+nfev
         Ipd30YiCSKGj2Xw8VYuFbtpblAoC9NpkHX4Ok260uCBTe8Y8rmG0oJVqrzFTP/3AfgZV
         y3cQ==
X-Gm-Message-State: AOAM533yix3sV/ytMBHiTuDyaWiZLPdZgRTozyUeSjlkeXMfPF2YjcoA
        rEX+TBN19mTZwiwthBxa3cA=
X-Google-Smtp-Source: ABdhPJyCHy1Y6ONQuCnsRU/NA0aFJlrcBnYFsBnvRs+a2KUVrQgl9Di7mwlDPSi44RK0HLzFH8Ojow==
X-Received: by 2002:a1c:e487:: with SMTP id b129mr6748712wmh.137.1621360759887;
        Tue, 18 May 2021 10:59:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:f888:e3f1:214b:6edc? ([2601:647:4802:9070:f888:e3f1:214b:6edc])
        by smtp.gmail.com with ESMTPSA id s6sm3957505wms.0.2021.05.18.10.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 10:59:19 -0700 (PDT)
Subject: Re: [PATCH] nvmet: fix memory leak on nvmet_alloc_ctrl()
To:     Wu Bo <wubo40@huawei.com>, hch@lst.de, chaitanya.kulkarni@wdc.com,
        kbusch@kernel.org, amit.engel@dell.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linfeilong@huawei.com
References: <1621327598-542045-1-git-send-email-wubo40@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7b29210e-8d64-0fea-2cb4-3e96e85559bf@grimberg.me>
Date:   Tue, 18 May 2021 10:59:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1621327598-542045-1-git-send-email-wubo40@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
