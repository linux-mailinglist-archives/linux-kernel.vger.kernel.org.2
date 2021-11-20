Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCA6457C0D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 08:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbhKTHLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 02:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbhKTHLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 02:11:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8474AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 23:08:40 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1moKUF-0004ad-GU; Sat, 20 Nov 2021 08:08:36 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH] Fixup: perf bench: Fix two memory leaks detected with
 ASan
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>, jolsa@redhat.com
Cc:     acme@kernel.org, irogers@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        songliubraving@fb.com
References: <YZev7KClb/ud43Lc@krava>
 <20211120040854.95169-1-sohaib.amhmd@gmail.com>
 <0c4189c4-3788-0fef-fce0-3527ec90b4b1@pengutronix.de>
Message-ID: <a760c03b-06bf-a7c0-d046-54619951761e@pengutronix.de>
Date:   Sat, 20 Nov 2021 08:08:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0c4189c4-3788-0fef-fce0-3527ec90b4b1@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.21 07:53, Ahmad Fatoum wrote:
>> +	snd_ctx_arr[total_counter] = snd_ctx;
> 
> You are storing at snd_ctx_arr[num_fd] each time, so you will leak
> all context, except for the last one.

Oh, it's more subtle than that. total_counter is of course incremented
every time in the previous loop, so you will have num_fd times NULL
(from static initialization) then a pointer to an allocation and so on.
That works by the looks of it, but looks quite strange.


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
