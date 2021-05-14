Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AAB38013F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 02:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhENAjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 20:39:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54293 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhENAjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 20:39:46 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14E0c7db3026741
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 13 May 2021 17:38:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14E0c7db3026741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620952688;
        bh=tiFWqHXSKNf8T3GK1jvsbQAtN+RbpKZCEkFdNfESs6o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=D8qCDot95FwhkGSe9LKFTJhYb8a3+mDaEAaGIaZwD9YKq8dAkUvqD9kYeMlHep0t1
         h+5smXI19UpJWcybV6z46KHG9RTLy/vBbvgeivmV6Sx+slleNOpoWtr7HyFpSdixwW
         KHT6rhdZDPLx2lPqzMGrYSUsbT7+Ixoc8Nk0yGCxdAeuYRRV8peuhsTk38ehvRLJc9
         uZrLl8pe0kIFBEp0CCpV/tpuMHEVNkKS9750CEBMnzX09T/3mwNn4b9mjDHcI5zSNg
         tC12AXIiFxG97rm4dOS+v+UO9qhJFfBY+2BEjpp04KiqgvfWL964BnLWPNG86C88bK
         +cTDEROKwqsZA==
Subject: Re: [RFC v2 PATCH 7/7] x86/entry: use int for syscall number; handle
 all invalid syscall nrs
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <871racf928.ffs@nanos.tec.linutronix.de>
 <60495dd3-ea68-4db3-47ad-b7b45796bf76@zytor.com>
 <87o8dfer7k.ffs@nanos.tec.linutronix.de>
 <b0ca952a-fd82-7833-ac82-ea8ecad48b53@zytor.com>
 <87mtsz619u.ffs@nanos.tec.linutronix.de>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <b6f47bd3-3e4c-7200-befe-5e14fecf3da7@zytor.com>
Date:   Thu, 13 May 2021 17:38:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87mtsz619u.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/21 3:22 PM, Thomas Gleixner wrote:
>>
>> As far as this being a user ABI change, this is actually a revert to the
>> original x86-64 ABI; see my message to Ingo.
> 
> I'm not against that change, but it has to be well justified and the
> reasoning wants to be in the changelog. You know the drill :)
> 

FYI:

So in the process of breaking up and better document this patch, I have 
looked at the syscall_numbering_64 (and have rewritten it to be more 
complete.)

I found that running it under strace fails, as strace (possibly ptrace, 
possibly the strace binary) causes %rax = 2^32 to be clobbered to zero 
already...

More motivation, I guess.

	-hpa

