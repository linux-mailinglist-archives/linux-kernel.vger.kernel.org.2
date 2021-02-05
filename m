Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8524310F1C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbhBEQIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:08:23 -0500
Received: from mail.cybernetics.com ([173.71.130.66]:40446 "EHLO
        mail.cybernetics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbhBEQCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:02:07 -0500
X-Greylist: delayed 725 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Feb 2021 11:02:07 EST
X-ASG-Debug-ID: 1612546268-0fb3b014601af740001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id LjUxXFWAiKKmTNJg; Fri, 05 Feb 2021 12:31:08 -0500 (EST)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
Received: from [10.157.2.224] (account tonyb HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 5.1.14)
  with ESMTPSA id 10522515; Fri, 05 Feb 2021 12:31:05 -0500
Subject: Re: Kernel version numbers after 4.9.255 and 4.4.255
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-ASG-Orig-Subj: Re: Kernel version numbers after 4.9.255 and 4.4.255
References: <a85b7749-38b2-8ce9-c15a-8acb9a54c5b5@kernel.org>
From:   Tony Battersby <tonyb@cybernetics.com>
Cc:     linux-kernel@vger.kernel.org,
        Jari Ruusu <jariruusu@protonmail.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Message-ID: <0b12bac9-1b4e-ec4a-8a45-5eb3f1dbbeca@cybernetics.com>
Date:   Fri, 5 Feb 2021 12:31:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a85b7749-38b2-8ce9-c15a-8acb9a54c5b5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1612546268
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1445
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 6:00 AM, Jiri Slaby wrote:
> Agreed. But currently, sublevel won't "wrap", it will "overflow" to 
> patchlevel. And that might be a problem. So we might need to update the 
> header generation using e.g. "sublevel & 0xff" (wrap around) or 
> "sublevel > 255 : 255 : sublevel" (be monotonic and get stuck at 255).
>
> In both LINUX_VERSION_CODE generation and KERNEL_VERSION proper.

My preference would be to be monotonic and get stuck at 255 to avoid
breaking out-of-tree modules.  If needed, add another macro that
increases the number of bits that can be used to check for sublevels >
255, while keeping the old macros for compatibility reasons.  Since
sublevels > 255 have never existed before, any such checks must be
newly-added, so they can be required to use the new macros.

I do not run the 4.4/4.9 kernels usually, but I do sometimes test a wide
range of kernels from 3.18 (gasp!) up to the latest when bisecting,
benchmarking, or debugging problems.  And I use a number of out-of-tree
modules that rely on the KERNEL_VERSION to make everything work.  Some
out-of-tree modules like an updated igb network driver might be needed
to make it possible to test the old kernel on particular hardware.

In the worst case, I can patch LINUX_VERSION_CODE and KERNEL_VERSION
locally to make out-of-tree modules work.  Or else just not test kernels
with sublevel > 255.

Tony Battersby
Cybernetics


