Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DD93E98C5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhHKTae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhHKTac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:30:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C72B60F21;
        Wed, 11 Aug 2021 19:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628710208;
        bh=dN2zuhazA3CjAHrGk/MFOiUoZnvZGI65FgI3dtYlVec=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pJPKwZfF1m74I3LpREvFNeTJFMVKWShoFzBV9iYcOo6B504i5O+vOaFzdh+nkUiG6
         Owdo430sjHVxMBn9jN1kzDGDbwe8NvOslpYtUJc/toSlU9/77CHnPRLEja9BSD1Maz
         yU3OhWkelUXCOp/P+r9qcu2lfzmFgnPaCv31qBYwpu1d2j1X0ZDoZ/GR2fJlRVHWp5
         pFSFtcYyHN8jO71FN0DlL5sLj82TppVDmla54n9D+7XyGm9btmo1qUwaYGlf6cNBNR
         jEg3oOBZRNrDR4mkx3ME6v8+AftqxHcaQ8uumdO0nju7OY9G2+oVrgRGuOYi2Bm/fs
         FlvVegXChqr2w==
Subject: Re: [PATCH 11/18] ARC: mm: move MMU specific bits out of entry code
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Jose Abreu <joabreu@synopsys.com>
References: <20210811004258.138075-1-vgupta@kernel.org>
 <20210811004258.138075-12-vgupta@kernel.org> <YRO/VSMNi00X37xQ@kernel.org>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <3236255f-8031-8fb2-8ab0-9faea5fa82f3@kernel.org>
Date:   Wed, 11 Aug 2021 12:30:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRO/VSMNi00X37xQ@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 5:15 AM, Mike Rapoport wrote:
> I believe a few words here would be useful even for the future version of
> yourself ;-)

"Don't pollute common entry file with MMU versions specific bits (as new 
MMU doesn't have PID register)"

However Jose thankfully pointed me (off list) that this patch is broken 
(based on some internal emails).
Any Machine check disables MMU but we now we only re-enable for TLB 
faults related MC, so this will have to be redone.

Thx,
-Vineet
