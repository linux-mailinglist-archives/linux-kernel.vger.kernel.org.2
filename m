Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C2D3A833F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhFOOxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:53:37 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:45901 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhFOOxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:53:35 -0400
Received: by mail-ej1-f47.google.com with SMTP id k7so23035011ejv.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 07:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=3fn+EoZHIwxFcnEU2fMkCVcJCFgt7QmI9s0dJSCeYMs=;
        b=YRz+t3kebb+P04D7WP6Z9IIqfk6mjjMVRIddq/Kw/DmqVV51F05EkAiu1xzCFkEbbN
         Eu+Qxynrt/QEQf8rafe7etSzez1etR8VryhgdcSniSwwqUR6A7781AmG21y1z12b/HHa
         8EKIrglSsW74HVjdPnbkpWIZqyzT9yj7Psy/+YFAp04VSbzquxiyUHUG4SCq8c9l0q5N
         d7tzXL6Ez7EJMR+Yk+p/zb2WmiodK6jZ4AnxVkLkRLiors7cUNd/m2+a83xi5J6VbW8U
         e2VI6RIzZFfmd9DUa29nElVkH+hv2MoxV8poToRNQBHNBlVmuvaE79upQvCQ+0EdedcU
         9+Yg==
X-Gm-Message-State: AOAM533u8y33bE9obTYjHNVluQp56lggRzanxltMAsfQ7sCD+54SactM
        9KQjl/TGUDnjEZwF8V8qMtasNMh7x5pfAA==
X-Google-Smtp-Source: ABdhPJxho05C5AbjyAwFtb2orc84X0hdeRqPRjcA46b1J3SPcf8h7U1XMTC7uydlGcOTnputaGszKw==
X-Received: by 2002:a17:906:f6d7:: with SMTP id jo23mr21724428ejb.302.1623768689288;
        Tue, 15 Jun 2021 07:51:29 -0700 (PDT)
Received: from Johanness-MBP.fritz.box ([2001:a62:141b:f301:8cf9:fee5:82d3:c1ee])
        by smtp.gmail.com with ESMTPSA id kj1sm10304096ejc.10.2021.06.15.07.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 07:51:28 -0700 (PDT)
Subject: Re: [PATCH] mcb: Remove trailing semicolon in macros
To:     Huilong Deng <denghuilong@cdjrlc.com>
Cc:     linux-kernel@vger.kernel.org
References: <20210614082633.20770-1-denghuilong@cdjrlc.com>
From:   Johannes Thumshirn <jth@kernel.org>
Message-ID: <eb6656fa-c116-eeea-ffb3-c63758c4834e@kernel.org>
Date:   Tue, 15 Jun 2021 16:51:28 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614082633.20770-1-denghuilong@cdjrlc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.06.21 um 10:26 schrieb Huilong Deng:
> Macros should not use a trailing semicolon.
>
> Signed-off-by: Huilong Deng <denghuilong@cdjrlc.com>
> ---
>

Thanks applied.
