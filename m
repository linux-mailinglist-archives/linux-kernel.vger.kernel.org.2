Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9179A336C47
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 07:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhCKGak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 01:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhCKGaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 01:30:09 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2601C061574;
        Wed, 10 Mar 2021 22:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=2O7VL2SJAKG2ihtffhPIE+KQYlSKoT0QMG1L+VYOBfs=; b=02jVzY9viHtS2bzzeXWFMWh3L7
        T7RobOQuytyuSwZgbe3AwhrlJKaJv6sVZDS7Hxj6E94oz/fG1qXgshMVl/Xfp2ffGOF46zeJfuLiw
        o8bpzwgsJStDSZ/2YS/VpSozn6JZYI7QU/ksBhtDXtFKSntNmIw6gr259uTDEP+YbYyvhxf+y9zC5
        G5qq5uy39zMhTbf8lqtpURc/08oiaAOx1a3SbKHVBf3ifhmB2dBt8BY/jkLrdxz+gtSAQ4qUW4oTl
        +TxxIM0ITikjb2GOKCn5OZP4VbwnXbgjjTv5nZFNQ4yJzE2eqxumdq/sk9VseGUOeAD7T814cAt6Z
        xvsfMFfg==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKEpi-000tfM-9k; Thu, 11 Mar 2021 06:30:06 +0000
Subject: Re: [PATCH] ia64: kernel: Few typos fixed in the file fsys.S
To:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210311061058.29492-1-unixbhaskar@gmail.com>
 <e26a1461-0d05-d79c-7688-de45d285e068@infradead.org>
 <YEm3ubX2Jqu49MwF@Gentoo>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <27e24dea-44de-32fc-9e32-f358aa4207e3@infradead.org>
Date:   Wed, 10 Mar 2021 22:30:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YEm3ubX2Jqu49MwF@Gentoo>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/21 10:24 PM, Bhaskar Chowdhury wrote:
> On 22:15 Wed 10 Mar 2021, Randy Dunlap wrote:
>> On 3/10/21 10:10 PM, Bhaskar Chowdhury wrote:
>>>
>>> Mundane spelling fixes.
>>>
>>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>>
>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>>
>> but no maintainer Cc:ed to pick it up...
>>
> I have seen "maintainer less" files and you have pointed out that too in the
> past...what do I do Randy??? Should run "git blame" to find out ,who touch the file and
> include those mail??? I don't think that would be good idea.
> 
> Bemused!! Throw some light.

Well, we know that ia64 is orphaned, so you need to find someone
to merge the patch. Andrew Morton is usually a good bet. :)

or use 'git log' <filename> to see who has been merging patches
to that file.

>>> ---
>>>  arch/ia64/kernel/fsys.S | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)

-- 
~Randy

