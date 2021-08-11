Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2AD3E8F31
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbhHKK6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhHKK6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:58:43 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A66C0613D3;
        Wed, 11 Aug 2021 03:58:19 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a7so3822065ljq.11;
        Wed, 11 Aug 2021 03:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+G5WzJsnAUkO3hEZ2NafsCG1K4h2+vmAKNaeHxYOxCA=;
        b=I4MBIIaj1E6qcZgsEjVQxhhLoP00bZQxawlUIsBb8wKztNWe70O/1UXJWeBg4qN2a/
         8vhTWNEUIGO9ecYzPOdzUFxtKxGkfbU4spNRQ/telBjt8L4Oz3W/1V3wG0z2/cdzA6ZF
         sbK+q11nu/hvQHuuZFf4t3FtrVBPZAW34lEnHjlnEjpq1M4ck1E12hoIdre7sYQKshAv
         k5ioFb9IM3h4rtT4MvZ0r6le8qnVlAKbitOCYaqVu4VYrZLeipV4GQRjVRtcB70VIMzq
         pwQD3Un3fjqHXPcvOsk8JBr1ibepJbge+o3V4pCzPl3mMc/EOQQGYwar5XnEtOK2T3fp
         pqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+G5WzJsnAUkO3hEZ2NafsCG1K4h2+vmAKNaeHxYOxCA=;
        b=uMOUEp5ywqLtbeBg0OCJdeRNwk8VK9LcS5wgU8Fs2qAKn902fj9avMA21dKZ3XVnzr
         R+GFAewy11AZvwyyDK+2ycnRp/EjD1bRUr+xwPoCCoHyALcw2gPskBvvluUeG4phwhVA
         jJ4hB8W1jP6gWbwNSzMPve+qzGyjXIozf/C3ASx/eOP03SZxCkhiquz5PBf+KWjpJvMX
         J7+pQIW947tRadu8BhUOJ0NFrFgT4Ls0naCc5QDEGI31c1aCZ8/dAD8b2IZl7CTagQwa
         zwc9DRuV06UVLG9YrORIjzX5DL2HlWNy7KydbiBcZp9Qgen/rVMLXQebl/uVW8h7FQW9
         WFMg==
X-Gm-Message-State: AOAM533HBScXrSGeel8qufnorKlvTApATRs0EyW/OyOCEoTkwgKwU36z
        eSVdaVrthGgXAwEhLDOscEGx3IxNz6E=
X-Google-Smtp-Source: ABdhPJz1AKIj/Stp2+6DMqhYoPlxPVQMAehWnlUiXh2i4FccQy96djpd2BbG8pnVQ18KR36Mqf4XcQ==
X-Received: by 2002:a2e:9a07:: with SMTP id o7mr22074258lji.441.1628679497303;
        Wed, 11 Aug 2021 03:58:17 -0700 (PDT)
Received: from [192.168.1.100] ([178.176.76.150])
        by smtp.gmail.com with ESMTPSA id h1sm1948581ljc.50.2021.08.11.03.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 03:58:17 -0700 (PDT)
Subject: Re: [PATCH] [v2,1/1] This aims to support Foxconn SDX55
To:     Slark Xiao <slark_xiao@163.com>, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210811085635.4699-1-slark_xiao@163.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <c62d60aa-2e2d-8465-b0d9-e2409ef4de5a@gmail.com>
Date:   Wed, 11 Aug 2021 13:58:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811085635.4699-1-slark_xiao@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11.08.2021 11:56, Slark Xiao wrote:

> Foxconn SDX55 T77W175 device is working in PCIe mode normally.
> You can find it in drivers/bus/mhi/pci_geneirc.c file.

    pci_generic? :-)

> But in some scenario, we need to capture the memory dump once it crashed.
> So a diag port driver is needed.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
[...]

MBR, Sergei
