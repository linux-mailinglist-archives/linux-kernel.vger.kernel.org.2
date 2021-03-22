Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1311345337
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 00:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhCVXt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 19:49:26 -0400
Received: from ozlabs.org ([203.11.71.1]:43655 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhCVXtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 19:49:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4F4B6K6sXJz9sVb;
        Tue, 23 Mar 2021 10:48:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1616456938;
        bh=3JBhxnjEwZI6EjQ3NYVUYFupetmCmjiqztYll/6iqTo=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=EnCk7XfRmIQquctVCbesCPi/NRh4AXtspTjwWeFj1Rh6t/G38dKLbk8z1S6Qt8RYR
         oB1qK7tPJLnRdD4qE+4WkkVeyQe2JgjWahVr2PtoNCyjdBFxAKWFwtkieeKX9JwKn9
         KBNKHrNZGf1nmaVaJjuKTvChahQ/dq3TebhDmFjMOO5OpdFD30a85pBtMaSMHUqjk3
         nG+HuWc+KExag1OBxab2FsBLK7+BKl86fX7IhfFWwoQ72yzPr1iOT7RMSp9lYmedMK
         kxt3ZMYIzQs2mZN60W75tgyUCLSlZkBDHtFnBi2c/SjlXBOwE3c9nbyV2VRqLRlQLx
         NVek6NSj2wYZQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/asm: Fix a typo
In-Reply-To: <96eda8ce-1d89-1491-51a2-92ba9883912b@infradead.org>
References: <20210322113254.2081445-1-unixbhaskar@gmail.com>
 <96eda8ce-1d89-1491-51a2-92ba9883912b@infradead.org>
Date:   Tue, 23 Mar 2021 10:48:55 +1100
Message-ID: <87sg4mhhqw.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:
> On 3/22/21 4:32 AM, Bhaskar Chowdhury wrote:
>> 
>> s/poiner/pointer/
>> 
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
> However, it would be a GOOD THING to collect multiple similar
> patches that are in e.g. arch/powerpc/ and send them as one patch
> instead of many little patches.

Yes.

Please send me one patch for all of the spelling issues you can
currently find in arch/powerpc.

cheers
