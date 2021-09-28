Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC8041B94F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 23:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242890AbhI1Vdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:33:45 -0400
Received: from novek.ru ([213.148.174.62]:33418 "EHLO novek.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232003AbhI1Vdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:33:44 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Sep 2021 17:33:44 EDT
Received: from [192.168.0.18] (unknown [37.228.234.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by novek.ru (Postfix) with ESMTPSA id 1455F503C31;
        Wed, 29 Sep 2021 00:21:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 novek.ru 1455F503C31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novek.ru; s=mail;
        t=1632864064; bh=dMDBA38/uSXkbxTsH/bk7zHUowoegagawy/x+WXzhDI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=S4KOd7zhhRoVWuK9SFxV5Doqcdkl1IQNqAGuM5nVznKr+6OKHwhJ9BdDoJgSeHmNU
         1BKvsj23z7lNdr/MhiYGPmXnyEp6fnkm4OWWZMAqKPjtsS43Y6EW2hN+2emut14JSC
         KuUJm259NlPxMD6zvEX2VeDmPF4V6a46q1AorKG4=
Subject: Re: [PATCH] net/tls: support SM4 CCM algorithm
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210928062843.75283-1-tianjia.zhang@linux.alibaba.com>
From:   Vadim Fedorenko <vfedorenko@novek.ru>
Message-ID: <1761d06d-0958-7872-04de-cde6ddf8a948@novek.ru>
Date:   Tue, 28 Sep 2021 22:24:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210928062843.75283-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,NICE_REPLY_A
        autolearn=ham autolearn_force=no version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on gate.novek.ru
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.09.2021 07:28, Tianjia Zhang wrote:
> The IV of CCM mode has special requirements, this patch supports CCM
> mode of SM4 algorithm.
>
Have you tried to connect this implementation to application with
user-space implementation of CCM mode? I wonder just because I have an
issue with AES-CCM Kernel TLS implementation when it's connected to
OpenSSL-driven server, but still have no time to fix it correctly.

