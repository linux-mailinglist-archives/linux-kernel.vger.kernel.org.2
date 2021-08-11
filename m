Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55603E9807
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhHKSzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229947AbhHKSzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:55:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87E116105A;
        Wed, 11 Aug 2021 18:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628708094;
        bh=cL9/V/8y48DqMm0G8VqpaHkYQP93I7XMoZKL5XYZJIk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=t7eYs+MheagFnbayhOJoScPhNm1JfqpHSZhBq0rOce+BYN3DpclmvWRjLXW1gjnsB
         wy/knE/P6Tq5TqyYwPY6t4RqxTC461yti36XG2pGxYTDJHCxsWP3W0UYAmT5ix3Sdc
         Asx9+TGU0136x8yA2JtxxbscjtFc9HhJhcTHhHcTt+Z0O+x9bYchIg6nH3on+d/v71
         6j9GhRQetE+7v/YkkK50CBy+owff2OIYvBL+kp0b+MavFyStIi4nrp6NgKofkY0LhG
         /iyPSig9l4hANt3ZVxakxl4SIVGujK9Q2zI2+/xj+iEgALrelP2Z6f/U7QEoc1fxHb
         OtRD8htJnPZuA==
Subject: Re: [PATCH 04/18] ARC: mm: remove pgd_offset_fast
To:     Mike Rapoport <rppt@kernel.org>, Vineet Gupta <vgupta@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210811004258.138075-1-vgupta@kernel.org>
 <20210811004258.138075-5-vgupta@kernel.org> <YRNcJpyr76h5EK0k@kernel.org>
X-Priority: 1 (Highest)
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <c8170afd-2a9d-a8fd-3f4d-bbde4ff02e36@kernel.org>
Date:   Wed, 11 Aug 2021 11:54:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRNcJpyr76h5EK0k@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/21 10:12 PM, Mike Rapoport wrote:
> On Tue, Aug 10, 2021 at 05:42:44PM -0700, Vineet Gupta wrote:
>> Signed-off-by: Vineet Gupta <vgupta@kernel.org>
>> ---
>>   arch/arc/include/asm/pgtable.h | 23 -----------------------
>>   arch/arc/mm/fault.c            |  2 +-
>>   2 files changed, 1 insertion(+), 24 deletions(-)
> Shouldn't this be a part of the patch that removed usage of the scratch reg
> for pgd?

Yep, now folded in there. Also updated prev patch's terse commit log.

Thx,
-Vineet
