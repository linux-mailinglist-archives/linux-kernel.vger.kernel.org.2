Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FF131051F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 07:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhBEGr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 01:47:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48724 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhBEGqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 01:46:08 -0500
Received: from [222.129.39.10] (helo=[192.168.1.10])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <aaron.ma@canonical.com>)
        id 1l7uro-0005gf-Ls; Fri, 05 Feb 2021 06:45:21 +0000
Subject: Re: [PATCH] xhci-pci: Set AMD Renoir USB controller to D3 when
 shutdown
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>, lee.jones@linaro.org,
        peter.chen@nxp.com, USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210204051850.64857-1-aaron.ma@canonical.com>
 <CAAd53p4euFiw7pfDnD2H8oMVeeTqQ_c+wOFDLM2xPccn5MewiA@mail.gmail.com>
From:   Aaron Ma <aaron.ma@canonical.com>
Message-ID: <cd4595e6-67da-885c-1a67-6dfd71425b8c@canonical.com>
Date:   Fri, 5 Feb 2021 14:45:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAAd53p4euFiw7pfDnD2H8oMVeeTqQ_c+wOFDLM2xPccn5MewiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/5/21 12:27 PM, Kai-Heng Feng wrote:
> Can you please test the following patch, which should address the root cause:
> https://lore.kernel.org/linux-acpi/20201201213019.1558738-1-furquan@google.com/
> 
> It also helps another AMD laptop on S5:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1912935
> 

No, this patch doesn't help on ThinkPad AMD platform.

Aaron

> We don't need to put bandage on drivers one by one once the patch with
> alternative approach is in upstream.
> 
> Kai-Heng
