Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731373557F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345763AbhDFPcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345714AbhDFPb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:31:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F64FC061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 08:31:50 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id a6so4380357pls.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j3dRVrLu7qIv3P8UBHPR313VlF+LiIc+YzexWIOo+jA=;
        b=xvfI3tMHBOUKWbT3HGs6k0QWo2mbJDk0YnfB0GtmnE170zRikaVpuA82WQtQRsJ+sC
         nDFbQI+3x397l82kInN1VXcbvmUdDwCG4281wbvzD1PWaiIGOWxBzhYA4lgANDq3Hv+o
         B/hyYNhC5/HVBqPpf1vb0F6mC5/yy3lp2fYHIhtEqksRiwGxBi02e0gNqDKbOSwDUd0t
         C48r53/pk3OqGAsLKxGFkz+RWlKcp4Ye79+/vjcS0Q1VlWxTzYMlPI7cSa9CUU9z+Lje
         CWw6I2I9cJyezy/a7+bWbzvgHQwvHYDNsxZy2PjUm4x5FWSHta+Z/kTl2Q8YZm3kbtti
         zj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j3dRVrLu7qIv3P8UBHPR313VlF+LiIc+YzexWIOo+jA=;
        b=cicP2oQJhquheLLWUvM2TG9BVCgOZWiGjsOJ2GWpys+sUfpZrkDbz+iyH8tYN5gc58
         Kn0Ly8oCiNWdmVbwVZsR7flfwaQsHR95vlkyozXjz7l542hyEyOQkzf+AW/ItfsEQ01O
         bWa2s7LrbUEkYuDoSPNYwvKNz7DHEpCXVZ1cNykFbHrE0BZhN9mmCIEa4AqttZRXrktJ
         xjGfQ5IH8qABDDD9hN9l+0f2dUHgCuWoIVaJ2FzVuz9q+/mEOt9YMktlPB9+juXK5Hk0
         1yDn3oAvBjvsGg7odguGvqcfWWeF7ztItgfC8oWeTB34heoFnEsalFcBlOnrtvzLQbwB
         XeQw==
X-Gm-Message-State: AOAM53063bBQG7ZCEWFsAD1u3TAaM07h+UdCPKyDnn5MBgQIQP5ctoWs
        OBP52/XNOWERuxUTVq6ULbx+ZO+BpzDXEQ==
X-Google-Smtp-Source: ABdhPJyttuu4g+gBCQFXDzvOY9EJF/stHkijoW0HxraDZFdEkkHPoaefvV+uh6P+eRaiQzLyAXpq3Q==
X-Received: by 2002:a17:90a:ff07:: with SMTP id ce7mr4768927pjb.0.1617723109587;
        Tue, 06 Apr 2021 08:31:49 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id e68sm2816213pfa.78.2021.04.06.08.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 08:31:49 -0700 (PDT)
Subject: Re: [PATCH -next] drbd: use DEFINE_SPINLOCK() for spinlock
To:     Huang Guobin <huangguobin4@huawei.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1617710988-49205-1-git-send-email-huangguobin4@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <55e93aa0-cf16-51b0-ae0a-c561fc36a550@kernel.dk>
Date:   Tue, 6 Apr 2021 09:31:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617710988-49205-1-git-send-email-huangguobin4@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/21 6:09 AM, Huang Guobin wrote:
> From: Guobin Huang <huangguobin4@huawei.com>
> 
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().

Applied, thanks.

-- 
Jens Axboe

