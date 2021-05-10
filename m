Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C296D379016
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhEJODF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:03:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45875 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347621AbhEJOAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:00:52 -0400
Received: from mobile-user-c1d2e5-142.dhcp.inet.fi ([193.210.229.142] helo=[192.168.1.190])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <tjaalton@ubuntu.com>)
        id 1lg6Rl-00030u-8B; Mon, 10 May 2021 13:59:45 +0000
Subject: Re: [Intel-gfx] [PATCH RFC] Revert "drm/i915: Try to use fast+narrow
 link on eDP again and fall back to the old max strategy on failure"
To:     Paul Zimmerman <pauldzim@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210509044330.4655-1-pauldzim@gmail.com>
From:   Timo Aaltonen <tjaalton@ubuntu.com>
Message-ID: <02957632-b050-f9eb-fcd8-75db9c92b8e0@ubuntu.com>
Date:   Mon, 10 May 2021 16:59:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210509044330.4655-1-pauldzim@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.5.2021 7.43, Paul Zimmerman wrote:
> This reverts commit 2bbd6dba84d44219387df051a1c799b7bac46099.
> 
> Since 5.12-rc2, my Dell XPS-15 laptop has had a blank screen on boot.
> The system seems to run fine other than having no display, I am able
> to ssh into the machine. I don't see anything interesting in the dmesg
> log. I bisected the problem down to this commit, and reverting it fixes
> the problem.

Have you tried with drm-tip? It has acca7762eb71bc0 which hopefully 
helps here.


-- 
t
