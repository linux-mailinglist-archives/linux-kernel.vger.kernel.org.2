Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6ADD440AA4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 19:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhJ3Rgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 13:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhJ3Rgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 13:36:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 814AC60F58;
        Sat, 30 Oct 2021 17:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635615241;
        bh=rETsOY586mkHRn2jrZTu7Fl9LTxaOtLa/wBCHg1/Hx0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kbYEasq4U/rNSZwV00GO+qghPvUk/v5jDRTIWhr59cEJx7MksN5bgaAgutSw6Y3Td
         dqZoC4GLk8Gi7pmIMy6tUNIeTZoz2ui7yrkdqiMyrGR5nQJTcUFkQ1aZusL6sVMf/6
         lS5oyiUTLaWVwyA7e7eUfj+OGWohR/yYVkWaY1upkF7qGBi/nyQhxWJQxdTq+xD7KK
         zNoor0YfjeJjZPi2GAHypknVoo4yDeSqYgOex6A7rNWwDi3ANvpIDiASFOzv945kW0
         nTkz3zCaMn+XKfsK0zPrPyTiW6V0lzfZbxh26juVTSy13lAGAKoXU4AXgJ045hsf2p
         PEFrY9AQjF4qw==
Subject: Re: [PATCH] ARC: thread_info.h: correct two typos in a comment
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-snps-arc@lists.infradead.org
References: <20211030003134.20553-1-rdunlap@infradead.org>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <a21e45ea-ebd4-6a1a-4508-2e2914603f7e@kernel.org>
Date:   Sat, 30 Oct 2021 10:34:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211030003134.20553-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/29/21 5:31 PM, Randy Dunlap wrote:
> Fix typos of "separately" and "remains".
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Matthew Wilcox <willy@infradead.org> # "remains"
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: linux-snps-arc@lists.infradead.org

Thx for the fix. Added to for-curr.

-Vineet



