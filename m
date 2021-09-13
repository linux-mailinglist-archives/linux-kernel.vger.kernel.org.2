Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8DF409D53
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243233AbhIMTnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:43:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49148 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbhIMTnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:43:32 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8D58B2005F;
        Mon, 13 Sep 2021 19:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631562135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tDilSzy60qWezbBdceRLf1j4kQ2B1WkoF6tr5VDBxQY=;
        b=sIbZ7Q8gdc+GtiXk3Ya04qbIukyysp41Q43nf+FvmJGjQRSghw6ENDkRqgz0/n9qQiOyK7
        K5SIhNOEGbKCnd2oGyJewB1RDRbhJdK5iHlIv9eCI9Dey1PA77MF+13PJu6mMXvnpCk5GI
        NLZ0ZkEM88qscQA7fDxVC69cl9zb1f0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631562135;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tDilSzy60qWezbBdceRLf1j4kQ2B1WkoF6tr5VDBxQY=;
        b=pBgWN8022mhrHHBpAQVyVAN/yMBh4GyLx1joc5mCmgYomklQtDKJWcs9IhWnkrh0pmwM6Y
        4G2oi+av4Z2tjTAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79D1013B67;
        Mon, 13 Sep 2021 19:42:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Vh+PHZepP2F7AQAAMHmgww
        (envelope-from <dbueso@suse.de>); Mon, 13 Sep 2021 19:42:15 +0000
MIME-Version: 1.0
Date:   Mon, 13 Sep 2021 12:42:15 -0700
From:   Davidlohr Bueso <dbueso@suse.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     CGEL <cgel.zte@gmail.com>, jamorris@linux.microsoft.com,
        keescook@chromium.org, ktkhai@virtuozzo.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn,
        varad.gautam@suse.com
Subject: Re: [PATCH V2] ipc: add set_ownership() and permissions() callbacks
 for posix mqueue sysctl
In-Reply-To: <20210913144047.4v5jquhyysnnlfvh@wittgenstein>
References: <20210824120523.s5qnzt643yvgugpv@wittgenstein>
 <20210827101206.5810-1-ran.xiaokai@zte.com.cn>
 <20210913144047.4v5jquhyysnnlfvh@wittgenstein>
User-Agent: Roundcube Webmail
Message-ID: <c74f33bde7d03d71343cc9251b298ff4@suse.de>
X-Sender: dbueso@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-13 07:40, Christian Brauner wrote:
> On Fri, Aug 27, 2021 at 03:12:06AM -0700, CGEL wrote:
>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> 
>> When a non-root user process creates a user namespace and ipc 
>> namespace
>> with command "unshare -Ur -i", and map the root user inside
>> the user namesapce to the global owner of user namespace.
>> The newly created user namespace OWNS the ipc namespace,
>> So the root user inside the user namespace should have full access
>> rights to the ipc namespace resources and should be writable to
>> the ipc mqueue sysctls.
>> 
>> v2:
>>   - update commit msg.
>>   - fix the coding style issue.
>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> ---
> 
> David,
> 
> are you happy with this too? If so I'd pick this up.

LGTM:

Acked-by: Davidlohr Bueso <dbueso@suse.de>
